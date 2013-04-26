(*
 *
 * $Log: tactics.sml,v $
 * Revision 1.2  1998/08/05 17:37:52  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "ut1";
require "utils.sml";
require "term.sml";
require "pretty.sml";
require "type.sml";
require "unif.sml";
require "namespace.sml";
require "parser.sml";
require "synt.sml";
require "toplevel.sml";
(* tactics *)

(* Only one UNDO per IMMED *)
fun immed_tac n = 
    let fun it_rec (B::l) = 
              if sameRef B (hd (!GOAL_CTXT)) then ()
              else if SolveTacn n 0 (Ref_c(ref_nam B)) then () else it_rec l
          | it_rec []   = bug"immed_tac"
     in it_rec (!NSP) end;

fun immed l =
    ( message"Immediate";
      if l = [] then do_list (immed_tac o fst) (rev(fst(goals()))) (** ??? **)
      else do_list (fn (n,s) => RefineTac_c n 0 (Ref_c s) (!AutoTac)) l );

val Immed = smallAppTac immed;


(****  for course  *****)
fun andElim n v_c =
    ( RefineTac_c n 2 v_c
           (fn(l:substitution) => (ignore(IntrosTac (fst(hd l)) ["",""] true);()));
      message"and Elim" )
and andIntro n = (RefineTac_c n 4 (Ref_c "pair") nullTac; message"and Intro")
and orElim n v_c = (RefineTac_c n 2 v_c nullTac; message"or Elim")
and orIntroL n = (RefineTac_c n 3 (Ref_c "inl") nullTac; message"or Intro L")
and orIntroR n = (RefineTac_c n 3 (Ref_c "inr") nullTac; message"or Intro R")
and notElim n v_c = (RefineTac_c n 2 v_c nullTac; message"not Elim")
and notIntro n = (ignore(IntrosTac n [""] true); message"not Intro")
and exElim n v_c = (RefineTac_c n 2 v_c nullTac; message"Ex Elim")
and exIntro n P_c =
    (RefineTac_c n 2 (App_c(ShowNorm,Ref_c "ExIntro",P_c)) nullTac;
    message"Exist Intro")
and allIntro n = (ignore(IntrosTac n [""] true); message"imp/All Intro")
and allElim n v_c =
    ((RefineTac_c n 1 v_c nullTac
      handle Failure"doesn't solve goal"
          => RefineTac_c n 1 (App_c(ShowNorm,Ref_c "cut",
                                   (App_c(ShowNorm,v_c,NewVar_c)))) nullTac);
    message"imp/All Elim");

fun AndElim n = AppTac (andElim n);
val AndIntro = AppTac andIntro;
fun OrElim n = AppTac (orElim n);
val OrIntroL = AppTac orIntroL;
val OrIntroR = AppTac orIntroR;
fun NotElim n = AppTac (notElim n);
val NotIntro = AppTac notIntro;
fun ExElim n = AppTac (exElim n);
fun ExIntro n = AppTac (exIntro n);
val AllIntro = AppTac allIntro;
fun AllElim n = AppTac (allElim n);



(* a replace-by-equality tactic *)
local
  val leibniz = {typeName= Ref_c "Q",
		 substitution= Bot_c,
		 symmetry = Ref_c "Q_sym"}
  val params = ref leibniz
in
  val repl_debug = ref false
  fun Config_Qrepl (tn,subst,sym) =
    (params:= (if tn = "" then leibniz
	       else {typeName= Ref_c tn,
		     substitution= Ref_c subst,
		     symmetry= Ref_c sym});
     message"'Qrepl' configured")
  fun replace n v_c =
    let
 (* the conditional equation is the type of v_c *)
      val ((V,T),_) = EvalRefine type_of_Var (parser_var_pack()) v_c
      fun replErr msg = (message"Replace error:"; prnt_vt V T; failwith msg)
 (* split into conditions and equation.
  * Note the equation may not depend on the conditions,
  * but the conditions may depend on other conditions. *)
      val (nbr_conditions,equation) =
	let fun conds (n,Bind((Pi,_),_,S,U)) = conds(n+1,U)
	      | conds (n,eqn as (App _)) =
		 ((n, lift (~n) eqn)
		  handle Lift => replErr "equation depends on conditions")
	      | conds _ = replErr "not a conditional equation"
	in  conds (0,T)
	end
      val _ = if (!repl_debug)
		then message("*rpl-nbr_conds* "^int_to_string nbr_conditions)
	      else ()
 (* make a concrete template for the equation *)
      val tpl_c = App_c(ShowNorm,
			App_c(ShowNorm,
			      App_c(ShowForce,#typeName(!params),NewVar_c),
			      NewVar_c),
			NewVar_c)
 (* compute the abstract template *)
      val (mkVar,_,close) = manageVars()
      val ((tpl,_),_) =
	EvalRefine (fn n => bug("replaceER "^int_to_string n)) mkVar tpl_c
      val _ = close()
 (* unify equation with abstract template to verify
  * it is an equation, and get the types of the lhs and rhs *)
      val (b,bngs) = type_match_unif [] equation tpl
      val _ = if b then () else replErr "not the expected equality"
      val _ = if (!repl_debug)
		then do_list (fn (n,c) => (prs"*rpl* ";
					   pri n; prs" "; legoprint c))
		             bngs
	      else ()
      val (TT,lhs,rhs) =
	case bngs
	  of (_,TT)::(_,lhs)::(_,rhs)::_ => (TT,lhs,rhs)
	   | _ => bug"computing lhs and rhs of equation"
      val (nn,goal) = goaln n
      fun make_abstrn k goal =
	if type_match lhs goal then Rel k
	else case goal
	       of App b => mkApp (make_abstrn k) b
		| Bind b => mkBind make_abstrn k b
		| Tuple b => mkTuple (make_abstrn k) b
		| Proj c => mkProj (make_abstrn k) c
		| x => x
      val pre_abstrn = make_abstrn 1 goal
      val abstrn = Bind((Lda,Vis),"z",TT,pre_abstrn)
      val _ = if (!repl_debug) then legoprint abstrn else ()
      fun refine n v_c = (RefineTac_c n 1 v_c nullTac;
			  prs"Qrepl  "; legoprint V;
			  prnt lhs; prs" => "; legoprint rhs)
      fun substitution_operator u =
	let val subst = #substitution (!params)
	in  if subst = Bot_c then u else App_c(ShowNorm,subst,u)
	end
 (* make conditional equation into an equation by applying it to
  * the right number if unknowns *)
      val equation =
	let fun mk_equation 0 = v_c
	      | mk_equation n =
		if n>0
		  then App_c(ShowForce,mk_equation (n-1),NewVar_c)
		else bug"mk_equation"
	in  mk_equation nbr_conditions
	end
    in
      if not (var_occur pre_abstrn)         (* check lhs occurs in goal *)
	then (prs"Warning: LHS  "; prnt lhs;
	      message("  doesn't occur in goal "^int_to_string nn))
      else smallAppTac (refine n)
	               (App_c(ShowNorm,
			      substitution_operator
			        (App_c(ShowNorm,#symmetry (!params),equation)),
			      unEval abstrn))
    end
end;


(******************************************
(* a replace-by-equality tactic *)
local
  val leibniz = {typeName= "Q",
		 substitution= "",
		 symmetry = "Q_sym"}
  val params = ref leibniz
in
  val repl_debug = ref false
  fun Config_Qrepl (tn,subst,sym) =
    (params:= (if tn = "" then leibniz
	       else {typeName= tn,
		     substitution= subst,
		     symmetry= sym});
     message"'Qrepl' configured")
  fun replace n v_c =
    let
      val (mkVar,eraseNew,close) = manageVars()
      val tpl_c = App_c(ShowNorm,
			App_c(ShowNorm,
			      App_c(ShowForce,
				    Ref_c(#typeName (!params)),
				    NewVar_c),
			      NewVar_c),
			NewVar_c)
      val ((tpl,_),_) =
	EvalRefine (fn n => bug("replaceER "^makestring n)) mkVar tpl_c
      val _ = close()
      val ((V,T),_) = EvalRefine type_of_Var (parser_var_pack()) v_c
      val (b,bngs) = type_match_unif [] T tpl
      val _ = if b then ()
	      else  (message"Replace error:";
		     prnt_vt V T;
		     failwith("not the expected equality"))
      val _ = if (!repl_debug)
		then (prs"*rpl* "; prnt_vt V T;
		      do_list (fn (n,c) => (pri n; prs" "; legoprint c))
		              bngs)
	      else ()
      val (_,TT)::(_,lhs)::(_,rhs)::[] = bngs
      val (nn,goal) = goaln n
      fun make_abstrn k goal =
	if type_match lhs goal then Rel k
	else case goal
	       of App b => mkApp (make_abstrn k) b
		| Bind b => mkBind make_abstrn k b
		| Tuple b => mkTuple (make_abstrn k) b
		| Proj c => mkProj (make_abstrn k) c
		| x => x
      val pre_abstrn = make_abstrn 1 goal
      val abstrn = Bind((Lda,Vis),"z",TT,pre_abstrn)
      val _ = if (!repl_debug) then (prs"*rpl2* "; legoprint abstrn)
	      else ()
      fun substitution_operator u =
	let val subst = #substitution (!params)
	in  if subst = "" then u
	    else MkApp((Ref(search subst (!NSP)),[u]),[ShowNorm])
	end
      val refinTerm = MkApp((substitution_operator
			     (MkApp((Ref (search (#symmetry (!params))
					  (!NSP)),
				     [TT,lhs,rhs,V]),
				    [NoShow,NoShow,NoShow,ShowNorm])),
			     [TT,lhs,rhs,abstrn]),
			    [NoShow,NoShow,NoShow,ShowNorm])
      val _ = if (!repl_debug) then (prs"*rpl3* "; legoprint refinTerm)
	      else ()
      fun refine n v = (RefineTac_a n 0 v nullTac;
			prs"Qrepl  "; legoprint v;
			prnt lhs; prs" => "; legoprint rhs)
    in
      if not (var_occur pre_abstrn)
	then (prs"Warning: LHS  "; prnt lhs;
	      prs"  doesn't occur in goal ";
	      pri nn; line())
      else smallAppTac (refine n) refinTerm
    end
end;
************************************************)
