(*
 *
 * $Log: pretty.sml,v $
 * Revision 1.2  1998/08/05 17:17:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "ut1";
require "utils";
require "universe";
require "term";
(* pretty.sml    un programme d'impression *)

structure Pretty : sig
		     val prnt_expand : cnstr -> unit
		     val prnt : cnstr -> unit
                     val prnt_names : string list -> cnstr -> unit
		     val legoprint : cnstr -> unit
		     val print_expand : cnstr -> unit
		     val prl : (int * cnstr) list -> unit
		     val prnt_vt : cnstr -> cnstr -> unit
		     val prnt_vt_expand : cnstr -> cnstr -> unit
		     val infixSym : bindSort -> string
		   end =
struct         
(* A concrete syntax for pretty-printing *)
datatype prCnstr =
    PrProp
  | PrType  of node
  | PrRef   of string
  | PrRel   of int
  | PrApp   of prCnstr * ((prCnstr * prntVisSort) list)
  | PrBind  of string list * bindSort * visSort * prCnstr * prCnstr
  | PrVar   of int * prCnstr
  | PrTuple of prCnstr * (prCnstr list)
  | PrProj  of projSort * prCnstr
  | PrCast  of prCnstr * prCnstr
  | PrBot

(* format for printing *)
fun ffp exp_flg = 
    let fun ffpef (Var(n,c))       
              = PrVar(n,(if exp_flg then ffpef c else PrBot))
          | ffpef Prop             = PrProp
          | ffpef (Type(i))        = PrType(i)
          | ffpef (Ref(br))        = PrRef(ref_nam br)
          | ffpef (Rel(n))         = PrRel(n)
          | ffpef (App((c,gs),vs)) 
              = let
		  val vs = if exp_flg orelse for_all (fn v => v=NoShow) vs
			     then map (fn NoShow => ShowForce | v => v) vs
			   else vs
		  fun ap (c,NoShow) gvs = gvs
		    | ap (c,pv) gvs     = (ffpef c,pv)::gvs
		in PrApp(ffpef c,foldr ap [] (zip (gs,vs)))
		end
          | ffpef (Bind((b,v),s,c,d)) = ffp_binder b v s c d
          | ffpef (Tuple(T,ls))       = ffp_tuple T ls
          | ffpef (Proj(p,c))         = PrProj(p,ffpef c)
          | ffpef AbsKind             = PrBot
          | ffpef Bot                 = PrBot


        and ffp_binder bind vis s c1 c2 =
            let val voc2 = var_occur c2 
                val s = if voc2 then s else "_" in
            case ((voc2 orelse (bind=Lda) orelse (bind=Let)),ffpef c2) of
              (false,x)      => PrBind([],bind,vis,ffpef c1,x)
            | (true,(inner as PrBind((ls as(_::_)),b,v,c,x) ))
                             => if b = bind andalso v = vis 
                                andalso c = (ffpef (lift (length ls) c1))
                                then PrBind(s::ls,b,v,c,x)
                                else PrBind([s],bind,vis,ffpef c1,inner)
            | (true,x)       => PrBind([s],bind,vis,ffpef c1,x)
            end

        and ffp_tuple T ls =
	  let 
	    fun isDepTpl T = (** Warning: depends on T being in SigNF **)
	      case T
		of Bind((Sig,_),_,_,tr) => (var_occur tr) orelse (isDepTpl tr)
		 | _ => false;
	    val T = if isDepTpl T then ffpef T else PrBot
	    val ls = map ffpef ls
	  in PrTuple(T,ls) end

     in ffpef end


fun PrRef_occ nam = 
    let fun pro (PrRef(nam'))       = nam = nam'
          | pro PrProp              = false
          | pro (PrType(_))         = false
          | pro (PrVar(_,t))        = pro t
          | pro (PrRel(_))          = false
          | pro (PrApp(c,l))        = (pro c) orelse (exists (pro o fst) l)
          | pro (PrBind(_,_,_,c,d)) = (pro c) orelse (pro d)
          | pro (PrTuple(T,ls))     = (pro T) orelse (exists pro ls)
          | pro (PrProj(_,c))       = pro c
          | pro (PrCast(c,T))       = (pro c) orelse (pro T)
          | pro PrBot               = false
     in pro end

fun bb l r f a = (prs l; let val fa = f a in (prs r; fa) end)

val parens = fn x => bb "(" ")" x
val square = fn x => bb "[" "]" x
val curly = fn x => bb "{" "}" x
val pointed = fn x => bb "<" ">" x
val expBr = fn x => bb "<*" "*>" x  (* show expansion *)

val bracket = fn Pi => curly
               | Lda => square
	       | Sig => pointed
	       | Let => square

val bindSym = fn Vis => ":"
               | Hid => "|"
               | Def => "="
	       | VBot => bug"bindSym"
val infixSym = fn Pi => "->"
                | Lda => "\\"
		| Sig => "#"
		| Let => bug"infixSym: Let"
val projSym = fn Fst => ".1" | Snd => ".2" | Psn n => "@"^(int_to_string n)


fun prt_match_var n = (prs "?"; pri n)


(* put a numeric extension on a print-name if the current binder is in the
 * scope of another binder with the same print-name, or there is a reference
 * to global with the same print name in the scope of the current binder *)
fun add_name s nams prc =
    let val s = if (s<>"") andalso (s<>"_") 
                andalso ((mem s nams) orelse (PrRef_occ s prc))
                then s^"'"^(int_to_string ((length nams)+1)) else s
     in  (prs s; s::nams) end


fun prnt_ exp_flg nams c = 
    let val ffp = ffp exp_flg in
    let fun pr_rec names =
  fn PrRef(nam)  => prs nam
   | PrProp      => (case theory() 
		       of lf => prs "Type"
			| _  => prs "Prop" )
   | PrType(nod) => (case theory()
		       of lf => prs "Kind"
			| _  => prs ("Type"^(print_univ_levl nod)) )
   | PrVar(n,t)  => if exp_flg then expBr (pr_exp_Var names n) t
                               else prt_match_var n
   | PrRel(n)    => ((prs (nth names n))   (** in case of open subterm **)
                     handle _ =>  (expBr (fn n => (prs"Rel ";pri n)) n))
   | PrApp(b)    => parens (pr_apps names) b
   | PrBind(l,c1,c2,c3,c4) => parens (pr_binder names (c1,c2,c3,c4)) l
   | PrTuple(b)   => parens (pr_tuple names) b
   | PrProj(s,c) => ((case c of  PrRef(_)  => pr_rec names c
                              | PrRel(_)  => pr_rec names c
                              | PrProj(_) => pr_rec names c
                              | _         => parens (pr_rec names) c);
                     prs (projSym s))
   | PrCast(b)   => parens (pr_cast names) b
   | PrBot       => prs "_"
and pr_outer_rec names = fn  (* some outermost parens not needed *)
     PrBind(l,c1,c2,c3,c4)    => pr_binder names (c1,c2,c3,c4) l
   | PrApp(l)       => pr_apps names l
   | x              => pr_rec names x
and pr_apps names (c,args) =
    let val prarg = fn (c,ShowNorm)  => (prs" "; pr_rec names c)
                     | (c,ShowForce) => (prs"|"; pr_rec names c)
                     | _             => bug"pr_apps"
    in  (pr_rec names c; do_list prarg args) end
and pr_binder names (b,v,c,d) =
  fn [] => (pr_rec names c; prs(infixSym b);
            pr_outer_rec (add_name "" names PrBot) d)
   | ls =>
       let fun pbr nams =
	 fn (l::ls) => let val nams' = add_name l nams d
		       in 
			 if ls=[]
			   then (prs(bindSym v); pr_outer_rec nams c; nams')
			 else (prs","; pbr nams' ls)
		       end
	  | []    => bug"pr_binder"
       in  pr_outer_rec (bracket b (pbr names) ls) d
       end
and pr_exp_Var names n t = (prt_match_var n; prs":"; pr_rec names t)
and pr_tuple names (T,ls) =
  (do_list_funny (fn l => pr_outer_rec names l) (fn () => prs",") ls;
   if T=PrBot then () else (prs":"; pr_outer_rec names T))
and pr_cast names (c,T) = (pr_outer_rec names c; prs":"; pr_outer_rec names T)
     in pr_outer_rec nams (ffp c) end end

val prnt_expand = prnt_ true []
val prnt = prnt_ false []
fun prnt_names nams = prnt_ false nams

fun legoprint c = (prnt c; line())
fun print_expand c = (prnt_expand c; line())


fun prl []          = ()
  | prl ((n,c)::l1) = (prs"  ";prt_match_var n;prs" : ";legoprint c;prl l1)


fun prnt_vt v t = (prnt v; prs" : "; prnt t; line())
fun prnt_vt_expand v t = (prnt_expand v; prs" : "; prnt_expand t; line())

end

open Pretty
