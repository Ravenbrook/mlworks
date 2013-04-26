(*
 *
 * $Log: parser.sml,v $
 * Revision 1.2  1998/08/05 17:25:36  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
require "universe.sml";
require "term.sml";
require "pretty.sml";
require "type.sml";
require "toc.sml";
require "unif.sml";
require "namespace.sml";
require "machine.sml";
(* parser.ml *)

(* La syntaxe concrete *)
datatype cnstr_c =
  Prop_c
| Type_c of string
| TypeAbs_c of int
| Ref_c  of string
| App_c  of prntVisSort * cnstr_c * cnstr_c
| Bind_c of binder_c * cnstr_c
| Tuple_c of (cnstr_c list) * cnstr_c
| Proj_c of projSort * cnstr_c
| Ctxt_c of ctxt_c * cnstr_c
| Cast_c of cnstr_c * cnstr_c
| Red_c of ctxt_c * ((cnstr_c*cnstr_c) list)
| Var_c  of int  (* metavars for use in refinements *)
| NewVar_c       (* make a new metavar *)
| Normal_c of cnstr_c
| Hnf_c of cnstr_c
| Dnf_c of cnstr_c
| TypeOf_c of cnstr_c
| Gen_c of cnstr_c * string
| Bot_c
withtype binder_c =
  bindSort * visSort * LocGlob * string list * string list * cnstr_c
and ctxt_c =
  (bindSort * visSort * LocGlob * string list * string list * cnstr_c) list;

(********** for debugging *************************)
val rec pr_cc =
  fn Prop_c => prs"*"
   | Type_c(s) => prs("T("^s^")")
   | TypeAbs_c(n) => (prs"T";pri n)
   | Ref_c(nam) => prs nam
   | App_c(_,f,a) => (prs"(";pr_cc f;prs" ";pr_cc a;prs")")
   | Bind_c((bdr,vs,par_flg,deps,nams,c),d)
     => (prs"(B," ;prs(hd nams);prs":";pr_cc c;prs"'";pr_cc d;prs")")
   | _ => prs"(**)";
(**************************************************)

(* make concrete from abstract *)
(* 'visFlg' says whether to Force implicit args, or keep them hidden *)
val unEval =
  let
    fun psh_nam n nams =
      if (n = "") orelse (isNewName n (!NSP) andalso not (mem n nams))
	then (n,n::nams)
      else psh_nam (n^"$") nams
    fun uerec nams =
      fn Prop            => Prop_c
       | Type(n)         => (case n
			       of Uconst(m) => TypeAbs_c(m)
				| Uvar(Unnamed _,_) => Type_c ""
				| Uvar(Named s,_) => Type_c s )
       | Ref(br)         => Ref_c(ref_nam br)
       | Rel(n)          => Ref_c(nth nams n)
       | App((f,args),viss)
	 => let fun app f (arg,vis) = App_c(vis,f,uerec nams arg)
	    in  foldl app (uerec nams f) (zip (args,viss))
	    end
       | Bind((b,v),n,c,d)
	 => let val (n,nams') = psh_nam n nams
	    in  Bind_c((b,v,Local,[],[n],uerec nams c),uerec nams' d)
	    end
       | Tuple(T,ls)     => Tuple_c(map (uerec nams) ls,uerec nams T)
       | Proj(p,c)       => Proj_c(p,uerec nams c)
       | Var(n,c)        => Cast_c(Var_c n,uerec nams c)
       | Bot             => bug"uerec:Bot"
       | AbsKind         => bug"uerec:AbsKind"
  in
    uerec []
  end;

fun fEval_ Cxt type_of_var mkVar V_c =
  let
    fun binder (b,v,par_flg,_,nam,d) inner_op cxt sbst =
      let 
	val (VT,sbst) = Eval cxt sbst d
	val cxt = extendCxt b v par_flg [] nam VT cxt
	val (VTr,sbst) = inner_op cxt sbst
	val (VT,_,_) = dischCxt VTr cxt
      in  (VT,sbst)
      end
    and Ev_locs locs inner_op cxt sbst =
      case locs
	of (b,v,par_flg,deps,n::ns,d)
	  => binder (b,v,par_flg,deps,n,d)
	            (Ev_locs (b,v,par_flg,deps,ns,d) inner_op)
                    cxt sbst
	 | (_,_,_,_,[],_)    => inner_op cxt sbst
    and EvLocs locs inner_op cxt sbst =
      case locs
	of bnd::bnds => Ev_locs bnd (EvLocs bnds inner_op) cxt sbst
	 | []        => inner_op cxt sbst
    and Eval cxt sbst c =
      let val (VT,sbst) = eval cxt sbst c
      in (sub_pr sbst VT,sbst) end
    and Cval c cxt sbst = Eval cxt sbst c
    and eval cxt sbst = fn
      Prop_c           => (ConsiderProp(),sbst)
    | Type_c s         => (ConsiderType s,sbst)
    | TypeAbs_c(n)     =>
	if (n>=0) then (ConsiderTypen n,sbst)
	else failwith((string_of_num n)^" not a valid Type level")
    | Ref_c(nam)       => (Consider nam cxt unEval (fst o (Eval cxt sbst)),sbst)
    | App_c(pv,fnn,arg) => let val (VTfun,sbst) = Eval cxt sbst fnn
			       val (VTarg,sbst) = Eval_arg cxt sbst arg
			   in  Apply sbst mkVar pv VTfun VTarg end
    | Bind_c(bnd,r)    => Ev_locs bnd (Cval r) cxt sbst
    | Tuple_c(cs,t)    => let
			    val ((T,_),sbst) = if t = Bot_c
						 then ((Bot,Bot),sbst)
					       else Eval cxt sbst t
			    fun ev c (vts,sbst) = 
			      let val (vt,sbst) = Eval cxt sbst c
			      in  (vt::vts,sbst)
			      end
			    val (vts,sbst) = foldr ev ([],sbst) cs
			  in  tuplize sbst T vts
			  end
    | Proj_c(p,c)      => let val (VT,sbst) = Eval cxt sbst c
			  in  ((Projection p VT),sbst) end
    | Cast_c(c,Bot_c)  => Eval cxt sbst c
    | Cast_c(c,t)      => typecheck cxt sbst c t
    | Ctxt_c(locs,c)   => EvLocs locs (Cval c) cxt sbst
    | Red_c(red)       => EvRed red cxt
    | Var_c(n)         => ((ConsiderVar n (type_of_var n)),sbst)
    | NewVar_c         => failwith"new scheme vars not allowed here"
    | Bot_c            => bug"fEval_:Bot_c"
    | Normal_c(c)      => (case Eval cxt sbst c
			     of ((v,t),sbst) => ((normal v,normal t),sbst))
    | Hnf_c(c)         => (case Eval cxt sbst c
			     of ((v,t),sbst) => ((hnf v,hnf t),sbst))
    | Dnf_c(c)         => (case Eval cxt sbst c
			     of ((v,t),sbst) => ((dnf v,dnf t),sbst))
    | TypeOf_c(c)      => (case Eval cxt sbst c
			     of ((v,t),sbst) => ((t,type_of_constr t),sbst))
    | Gen_c(c,back)    => (case Eval cxt sbst c
			     of (vt,sbst) => (lclGen vt back,sbst))
    and Eval_arg cxt sbst =
      fn NewVar_c => ((Bot,Bot),sbst)   (* just a marker for Apply *)
       | x        => Eval cxt sbst x
    and chk_unresolved (VT as (V,T)) =
      if (semi_pure V) andalso (semi_pure T)
	then VT
      else (prnt_vt_expand V T; failwith "unresolved metavars")
    and fEv V_c cxt sbst = let val (VT,sbst) = Eval cxt sbst V_c
			   in  ((chk_unresolved VT),sbst) end
    and typecheck cxt sbst pr cnj =  (* concrete conjecture *)
      case pr
	of Tuple_c(cs,Bot_c) => typecheck cxt sbst (Tuple_c(cs,cnj)) cnj
	 | _ => let val ((Vcnj,_),sbst) = fEv cnj cxt sbst
		in  typchk cxt sbst pr Vcnj end
    and typchk cxt sbst pr cnj =     (* abstract conjecture *)
      case pr
	of NewVar_c => ((mkVar cnj,cnj),sbst)
	 | _        =>
	     let val ((VT as (V,T)),sbst) = fEv pr cxt sbst
	     in if cnj = Bot then (VT,sbst)
		else let val (b,s) = if (pure T) andalso (pure cnj)
				       then (type_match T cnj,sbst)
				     else type_match_unif sbst T cnj
		     in
		       if b then ((V,cnj),s)      
		       else (message"typechecking error.."; legoprint V;
			     message"has type.."; legoprint T;
			     message"which doesn't convert with..";
			     legoprint cnj;
			     failwith "term doesn't have purported type")
		     end
	     end
    and EvRed (locs,pairs) cxt =
      let
	fun er cxt sbst =
	  let
	    val lclCxt = first_n (length locs) cxt
	    val (b,s) = findDup "" (map ref_nam lclCxt)
	    val _ = if b then failwith("pattern match variable name \""^
				       s^"\" shadowed")
		    else ()
	    fun chkPr prs (lhs,rhs) =
	      let
		val ((vlhs,tlhs),_) = Eval cxt sbst lhs
		val ((vrhs,trhs),_) = Eval cxt sbst rhs
		val _ = if type_match tlhs trhs then ()
			else (message"reduction LHS has type ";legoprint tlhs;
			      message"reduction RHS has type ";legoprint trhs;
			      failwith"LHS and RHS types don't convert")
		fun chkVarLR (bs as (b,s)) br =
		  if not b then bs
		  else (not (depends br vrhs) orelse (depends br vlhs),ref_nam br)
		val (b,s) = foldl chkVarLR (true,"") lclCxt
		val _ = if b then ()
			else (message("reduction RHS mentions variable "^s);legoprint vrhs;
			      message"reduction LHS does not ";legoprint vlhs;
			      failwith"unbound variable in RHS")
	      in
		vlhs::vrhs::prs
	      end
	    val chkPrs = foldl chkPr []
	  in
	    ((Tuple(Bot,chkPrs pairs),Bot),[])    (** trick for discharge **)
	  end
	val ((dischTupPr),_) = EvLocs locs er cxt []
      in
	(dischTupPr,[])
      end
  in
    fEv V_c Cxt []
  end;


fun parser_var_pack() =
    let val NUN = ref(0)
    in  fn c => (NUN:= !NUN-1; Var(!NUN,c))
    end;

fun EvalRefine type_of_var mkVar = fEval_ (!NSP) type_of_var mkVar;


fun no_metavars n = 
  (failwith ("found metavar "^
	     (string_of_num n) ^"; metavars not allowed here")):cnstr
fun no_new_vars _ = failwith"`?` not allowed in here";

fun fEval V_c = fst (fEval_ (!NSP) no_metavars (parser_var_pack()) V_c);
