(*
 *
 * $Log: namespace.sml,v $
 * Revision 1.2  1998/08/05 17:23:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
require "universe.sml";
require "term.sml";
require "pretty.sml";
require "pattern.sml";
require "type.sml";
require "toc.sml";
require "unif.sml";
(* namespace.ml *)

type context = binding list

val NSP = ref([]: context)

(*
fun curnt_bndng_ref() = hd (!NSP)
*)


local              (* timestamp used for equality of bindings *)
  val ts = ref 0
in
  fun timestamp() = (ts:= succ (!ts); !ts)
end


fun init_namespace() = NSP:=[Bd{ts=timestamp(),
				frz=(ref false),
				param=Global,
				deps=[],
				kind=Bnd,
				bd=((Pi,Vis),"** Start of Context **",
				    Prop,Type (uconst 0))}]

(* interrogate the namespace *)
fun search nam =
    let
      fun sn v = ref_nam v = nam
      fun srec (v::l)= if (*sameNam(v, nam)*) sn v then v else srec l
	| srec []    = failwith("search: undefined or out of context: "^nam)
    in
      srec
    end

fun defined nam = exists (fn v => sameNam(v, nam))


(* freezing and unfreezing *)
fun Freeze ns =
  let fun freeze n = let val br = search n (!NSP)
		     in  (ref_frz br):= true
		     end
  in  map freeze ns
  end
fun Unfreeze ns =
  let
    fun unf br = (ref_frz br):= false
    fun unfreeze n = let val br = search n (!NSP)
		     in  unf br
		     end
  in  if ns = [] then map unf (!NSP)
      else map unfreeze ns
  end

(* expand namespace *)
fun isNewName s ctxt = not (defined s ctxt)
fun Pure nam c =
    if (pure c) then true
    else failwith ("namespace: attempt to bind "^nam^" to impure term")

fun Assume bv par_flg deps nam (t,k) cxt =
    let val K = hnf k
    in if kind k (***** andalso Pure nam t ***************************)
	 then (Bd{ts=timestamp(),frz=(ref false),
		  param=par_flg,deps=deps,kind=Bnd,
		  bd=(bv,nam,t,K)})::cxt
       else (prs("cannot assume "^nam^" : ");
	     prnt_vt_expand t K;
	     failwith "Only a Prop or a Type may be assumed")
    end
fun Define bv par_flg deps nam (vt1,vt2) cxt =
  (ignore(Pure nam vt1);
   let val vt2 = dnf vt2
   in
     (Bd{ts=timestamp(),frz=(ref false),param=par_flg,deps=deps,kind=Bnd,
       bd=(bv,nam,vt1,vt2)})::cxt
   end)

fun extendCxt b v = case (b,v) of
      bv as (Let,Def) => Define bv
    | (Let,_)         => bug"extendCxt:Let,_"
    | (_,Def)         => bug"extendCxt:_,Def"
    | bv              => Assume bv


fun autoInitUniv() =
  let fun allDefs (_::[]) = true  (* the dummy initial Decl *)
	| allDefs (x::xs) = ref_isDefn x andalso allDefs xs
	| allDefs [] = bug"autoInitUniv"
  in if !MacroMode andalso allDefs (!NSP) then Init_universes() else ()
  end

fun extendCxtGbl b v par_flg deps n tk = 
  if isNewName n (!NSP)
    then (NSP:= extendCxt b v par_flg deps n tk (!NSP); autoInitUniv(); !NSP)
  else failwith("\""^n^"\" already in namespace")

(* reductions in Contexts *)
fun SaveReductGbl VT =
  let fun saveReduct (v,t) cxt =
    (Bd{ts=timestamp(),frz=(ref false),param=Global,deps=[],kind=Red,
	    bd=((Sig,VBot),"",v,t)})::cxt
  in NSP:= saveReduct VT (!NSP)
  end
fun makeAllPats() =     (* where to put this? *)
  let fun addRed (Bd{bd=(_,_,v,_),kind=Red,...}) =
                              add_reductions (makePats normal v)
	| addRed _ = ()
  in (init_reductions(); do_list addRed (rev (!NSP)))
  end


(* make a name not occurring in the global context *)
fun mkNameGbl nam = 
    let fun mnrec m =
            let val nn = nam^string_of_num m
             in if isNewName nn (!NSP) then nn else mnrec (succ m) end
     in if isNewName nam (!NSP) then nam else mnrec 1 end

(* return the latest timestamp in the Global context *)
fun latestTsGbl() = ref_ts (hd (!NSP))


(** three forms of context printing **)
datatype dfnsPrnt = OmitDfns | ElideDfns | ShowDfns | Marks
fun prt_context_dpth n elideFlg = 
  let
    val lnsp = length (!NSP)
    val real_n = if n>lnsp then lnsp else n
    fun prt_ctxt br =
      if ref_isRed br then message"  ** reductions **"
      else if ref_isMrk br
	     then message("  ** Mark \""^(ref_mrk br)^"\" **")
	   else if elideFlg=Marks then ()
		else let
		       val nam = ref_nam br
		       val typ = ref_typ br
		       val param = ref_param br
		       val frz = !(ref_frz br)
	   in
	     if ref_isDefn br
	       then if elideFlg = OmitDfns then ()
		    else (prs ((if frz then "F" else " ")^
			       (if param=Local then "$" else " ")^
			       nam^" = ");
			  if elideFlg = ElideDfns then prs"... : "
			  else (legoprint (ref_val br);
				prs" : "); legoprint typ)
	     else (prs(" "^(if param=Global then "$" else " ")^nam^
		       (if ref_vis br = Hid then " | " else " : "));
		   legoprint typ)
	   end
  in
    if n <= 0 then () else do_list prt_ctxt (rev (first_n real_n (!NSP)))
  end

local
   fun depth f m = fn b::rest => if f b then m else depth f (m+1) rest
                    | []      => m
in fun prt_context_ref br elideFlg =
       prt_context_dpth (depth (fn b => sameRef b br) 0 (!NSP)) elideFlg
   fun prt_context_nam nam elideFlg =
       prt_context_dpth (depth (fn b => sameNam(b, nam)) 1 (!NSP)) elideFlg
end

(* expand all definitions (but no beta steps) *)
fun delta_normal c = 
    let fun dn c br =
      let
	val nam = ref_nam br
      in  
	if !(ref_frz br) then c else (prs (" "^nam); expand nam c)
      end
    in (prs"expanding defs: ";foldl dn c (!NSP))
    end

