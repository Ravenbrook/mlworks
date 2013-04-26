(*
 *
 * $Log: unify_llambda.fun,v $
 * Revision 1.2  1998/06/03 11:59:10  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)
(*         - added unify_failure  -er               *)

(*
   This implements the generalized variable/term unification as described
   by Dale Miller and postpones all other kinds of unification 
   problems (solvable or not)
 *)

functor UnifyLlambda
  (structure Basic       : BASIC
   structure Term	 : TERM
   structure Sb		 : SB          sharing Sb.Term = Term
   structure Reduce	 : REDUCE      sharing Reduce.Term = Term
   structure Print	 : PRINT       sharing Print.Term = Term
   structure Trail       : TRAIL       sharing Trail.Term = Term
   structure UUtils      : UUTILS      sharing UUtils.Term = Term
   structure Constraints : CONSTRAINTS sharing Constraints.Term = Term
   val enable_tracing    : bool
   val allow_definitions : bool) : UNIFY =
struct

structure Term = Term
structure Constraints = Constraints

local open Term
      structure C = Constraints
      structure U = UUtils
in

  structure Switch =
  struct

    exception UnknownSwitch = Basic.UnknownSwitch

    (* Control *)
    val unsafe_omit_occurs_check = ref false
    val use_redundancy_info = ref true
    fun control "unsafe_omit_occurs_check" = unsafe_omit_occurs_check
      | control "use_redundancy_info" = use_redundancy_info
      | control s = raise Basic.UnknownSwitch("UnifyLlambda.control",s)

    (* Warning *)
    val warn_raising = ref true

    fun warn "raising" = warn_raising
      | warn s = raise Basic.UnknownSwitch("UnifyLlambda.warn",s)

    fun wprint warnref func = if (!warnref) then print(func():string) else ()

    (* Tracing *)

    val trace_instantiate = ref false
    val trace_dset = ref false
    val trace_simplify = ref false
    val trace_failure = ref false
    val trace_unify = ref false

    fun trace "instantiate" = trace_instantiate
      | trace "dset" = trace_dset
      | trace "simplify" = trace_simplify
      | trace "failure" = trace_failure
      | trace "unify" = trace_unify
      | trace s = raise Basic.UnknownSwitch("UnifyLlambda.trace",s)

    fun tprint traceref func = if (!traceref) then print(func():string) else ()

  end  (* structure Switch *)

  open Switch

  fun nonunif (reason) =
         ( if (!trace_failure) then print(C.makestring_unify_failure(reason)) else () ;
	   raise C.Nonunifiable(reason) )

  val instantiate_evar =
      if (not enable_tracing)
      then Trail.instantiate_evar
      else fn ev => fn M =>
	     ( tprint trace_instantiate (fn () =>
		"Instantiate " ^ Print.makestring_term ev
		^ " to " ^ Print.makestring_term M ^ ".\n") ;
	       Trail.instantiate_evar ev M )

  (* This version of the unifier does not backtrack.  Thus, we can
     identify reasons for failure of unification *)

  (* Generalized variables *)

  (* Q: in the next two functions, if a variable is not shared, can it appear
     in the type?  If not, optimize.  -fp Sun Sep  9 10:38:30 1990 *)

  fun intersect_args uvars B args uvars2 =
     let fun ia (nil,B) = (nil,B)
	   | ia (((a as Uvar(_,stamp))::rest),pixAB) =
		if exists (Sb.eq_uvar stamp) args
		     orelse exists (Sb.eq_uvar stamp) uvars2
	      then let val (xofA,B) = U.dest_pi_error pixAB
		       val (args',B') = ia (rest,B)
		    in (a::args',make_pi(xofA,B')) end
	      else let val (xofA,B) = U.dest_pi_error pixAB
		       val (args',B') = ia (rest,
			      (Sb.renaming_apply_sb (Sb.term_sb xofA a) B))
		    in (args',B') end
	   | ia ((M::_),_) = raise Print.subtype("ia",M,"is not a Uvar.")
      in ia (uvars,B) end

  fun intersect_position_args (nil,B) nil = ((nil,B),false)
    | intersect_position_args (((a1 as Uvar(_,stamp1))::rest1),pixAB)
			      ((a2 as Uvar(_,stamp2))::rest2) =
	 if (stamp1 = stamp2)
	    then let val (xofA,B) = U.dest_pi_error pixAB
		     val ((args',B'),restrict) =
			    intersect_position_args (rest1,B) rest2
	      in (((a1::args'),make_pi(xofA,B')),restrict) end
	    else let val (xofA,B) = U.dest_pi_error pixAB
		     val ((args',B'),_) = intersect_position_args (rest1,
			    (Sb.renaming_apply_sb (Sb.term_sb xofA a1) B)) rest2
		  in ((args',B'),true) end
    | intersect_position_args _ _ = raise Basic.Illegal("intersect_positions_args: different length lists, or not all Uvar's.")

  fun gvar_gvar_diff ((ev1 as Evar(Varbind(x1,A1),_,uvars1,_),args1),
		      (ev2 as Evar(Varbind(x2,A2),_,uvars2,_),args2)) =
	 let val dominates1 = U.init_seg uvars1 uvars2
	     val (args',A') = if dominates1 
				 then intersect_args args1 A1 args2 uvars2
				 else intersect_args args2 A2 args1 uvars1
	     val ev' = if dominates1
			  then Sb.new_evar (Varbind(x1,A')) uvars1
			  else Sb.new_evar (Varbind(x2,A')) uvars2
	     val body = revfold (fn (M1,M2) => Appl(M2,M1)) args' ev'
	     val inst1 = fold U.abst_over_uv args1 body
	     val inst2 = fold U.abst_over_uv args2 body
	  in ( instantiate_evar ev1 inst1 ;
	       instantiate_evar ev2 inst2 )
	 end
    | gvar_gvar_diff _ = raise Basic.Illegal("gvar_gvar_diff: some argument is not an Evar.")

  fun gvar_gvar_same ((ev as Evar(Varbind(x,A),_,uvars,_),args1),
		      (_,args2)) =
	 let val (same_args,restrict) = intersect_position_args (args1,A) args2
	     fun inst (_,false) = ()
	       | inst ((args',A'),true) =
		    let val ev' = Sb.new_evar (Varbind(x,A')) uvars
			val body = revfold (fn (M1,M2) => Appl(M2,M1)) args' ev'
			val inst = fold U.abst_over_uv args1 body
		     in instantiate_evar ev inst end
	  in inst (same_args,restrict) end
    | gvar_gvar_same ((M,_),(_,_)) = raise Print.subtype("gvar_gvar_same",M,"is not an Evar.")

  fun gvar_gvar (eva1 as (Evar(_,stamp1,_,_),_),
		 eva2 as (Evar(_,stamp2,_,_),_)) =
	 if stamp1 = stamp2
	    then gvar_gvar_same(eva1,eva2)
	    else gvar_gvar_diff(eva1,eva2)
    | gvar_gvar _ = raise Basic.Illegal("gvar_gvar: some arg is not a Gvar.")
  fun head_args_type (Evar(Varbind(x,A),_,_,_),args) =
	 let fun hat A nil = A
	       | hat A (N::rest) =
	       let val (xofA',B) = U.dest_pi_error A
		in hat (Sb.renaming_apply_sb (Sb.term_sb xofA' N) B) rest end
	  in hat A args end
    | head_args_type (M,_) = raise Print.subtype("head_args_type",M,"is not an Evar.")

  (* is uvars2 contained in uvars1 union uvars0 *)
  (* This does not take advantage of ordering invariants, could be optimized *)
  fun contained_in_union uvars2 uvars1 uvars0 =
      let fun ciu nil = true
	    | ciu (Uvar(_,stamp2)::uvars2') =
	      (exists (Sb.eq_uvar stamp2) uvars1  orelse  exists (Sb.eq_uvar stamp2) uvars0)
	      andalso ciu uvars2'
            | ciu (M::_) = raise Print.subtype("ciu",M,"is not a Uvar.")
      in ciu uvars2 end

  (* This quick occurs check avoids copying when possible *)

  fun quick_eoc (ev as Evar(xofA,stamp,uvars,_),args) M =
    let fun qeoc (Evar(_,_,_,ref(SOME(M0)))) = qeoc M0
	  | qeoc (Evar(_,stamp2,uvars2,_)) =
	       if U.init_seg uvars2 uvars
		  then (if stamp = stamp2 then false else true)
	          else (if contained_in_union uvars2 uvars args then true else false)
	  | qeoc (Uvar(_,stamp2)) =
	       if exists (Sb.eq_uvar stamp2) uvars
		    orelse exists (Sb.eq_uvar stamp2) args
		  then true
		  else false
	  | qeoc (Appl(M,N)) = qeoc M andalso qeoc N
	  | qeoc (Abst(Varbind(x,A),M)) = qeoc A andalso qeoc M
	  | qeoc (Bvar _) = true
	  | qeoc (Const _) = true
	  | qeoc (Pi((Varbind(x,A),B),_)) = qeoc A andalso qeoc B
	  | qeoc (Type) = true
	  | qeoc (Fvar _) = true  (* perhaps check the type? *)
	  | qeoc M = raise Print.subtype("qeoc",M,"unexpected term")
     in (!unsafe_omit_occurs_check) orelse qeoc M end
    | quick_eoc (M,_) _ = raise Print.subtype("quick_eoc",M,"is not an Evar")

  (* BUG: extended_occurs_check might need to expand non-strict definitions!!! *)

  fun extended_occurs_check (gev as (ev as Evar(xofA as Varbind(x,_),stamp,uvars,_),args)) M dset =
    let fun eoc ubvars (Evar(_,_,_,ref (SOME t0))) dset = eoc ubvars t0 dset
	  | eoc ubvars (M as Evar _) dset = eoc_flex ubvars M dset
	  | eoc ubvars (M as Appl _) dset =
	       if U.is_rigid M
		  then eoc_rigid ubvars M dset
		  else eoc_flex ubvars M dset
	  | eoc ubvars (Abst(xofA as Varbind(x,A),M)) dset =
	       let val (A',dset') = eoc_norm ubvars A dset
		   val a = Sb.new_uvar (Varbind(x,A'))
		   val (M',dset'') = eoc_norm (a::ubvars)
				       (Sb.apply_sb (Sb.term_sb xofA a) M) dset'
		in (Abst(U.abst_over_uvar (a,x) M'),dset'') end
	  | eoc ubvars (Pi((xofA as Varbind(x,A),B),occ)) dset =
		let val (A',dset') = eoc_norm ubvars A dset
		 in if (occ = Maybe)
		       then let val a = Sb.new_uvar (Varbind(x,A'))
				val (B',dset'') = eoc_norm (a::ubvars)
						    (Sb.apply_sb (Sb.term_sb xofA a)
								 B) dset'
			     in (Pi(U.abst_over_uvar (a,x) B',occ),dset'') end
		       else let val (B',dset'') = eoc_norm ubvars B dset'
			     in (Pi((Varbind(x,A'),B'),occ),dset'') end
		 end
	  | eoc ubvars (M as Uvar(_,stamp2)) dset =
	       if exists (Sb.eq_uvar stamp2) uvars
		    orelse exists (Sb.eq_uvar stamp2) args
		    orelse exists (Sb.eq_uvar stamp2) ubvars
		  then (M,dset)
		  else nonunif (C.FailDependency(ev,M,args,uvars))
	  | eoc _ M dset = (M,dset)  (* perhaps check the type for Fvar's? *)
	and eoc_norm ubvars M dset = eoc ubvars (Reduce.head_norm M) dset
	and eoc_flex ubvars M dset = 
       if quick_eoc gev M  (* quick check *)
	  then (M,dset)
	  else let fun qeoc_evar (ev as Evar(_,stamp2,_,_),args2) =
		   if stamp = stamp2
		      then nonunif (C.FailOccursCheck(ev))
		      (* Could say "Flex" here, except that it might be a Gvar *)
		      else (let val B = head_args_type (ev,args2)
			     in new_gvar B ubvars M dset end)
		     | qeoc_evar (M,_) = raise Print.subtype("qeoc_evar",M,"is not an Evar")
		in qeoc_evar (Reduce.head_args M) end
	and eoc_rigid ubvars (Appl(M1,M2)) dset =
	       let val (M1',dset') = eoc_rigid ubvars M1 dset
		   val (M2',dset'') = eoc_norm ubvars M2 dset'
		in (Appl(M1',M2'),dset'') end
	  | eoc_rigid ubvars M dset = eoc ubvars M dset (* Uvar, Fvar, Const *)
	and new_gvar B ubvars M dset =
	    let val B' = revfold U.pi_over_uv ubvars B
		val all_args = args @ rev ubvars
	     in if quick_eoc gev B'
		   then let val A' = fold U.pi_over_uv_raise args B'
			    val nevar = Sb.new_evar (Varbind(x,A')) uvars
			    val N = revfold (fn (M1,M2) => Appl(M2,M1)) all_args nevar
			 in (N,C.mkDpair(C.Gvar(N,(nevar,all_args)),C.Any(M))::dset)
			end
		   else let val K' = fold U.pi_over_uv args (revfold U.pi_over_uv ubvars Type)
			    val ntvar = Sb.new_evar (Varbind(anonymous,K')) uvars
			    val B' = revfold (fn (M1,M2) => Appl(M2,M1)) all_args ntvar
			    val A' = fold U.pi_over_uv args (revfold U.pi_over_uv ubvars B')
			    val nevar = Sb.new_evar (Varbind(x,A')) uvars
			    val N = revfold (fn (M1,M2) => Appl(M2,M1)) all_args nevar
			 in (N,C.mkDpair(C.Gvar(B',(ntvar,all_args)),C.Any(B))::C.mkDpair(C.Gvar(N, (nevar,all_args)),C.Any(M))::dset)
			end
	     end
     in eoc_norm nil M dset end
    | extended_occurs_check (M,_) _ _ =
	 raise Print.subtype("extended_occurs_check",M,"is not an Evar.")

  fun gvar_ngvar (gev as (ev,args),M) dset =
       if quick_eoc gev M
	  then let val inst = fold U.abst_over_uv_raise args M
		in ( instantiate_evar ev inst ; dset ) end
	  else let val (M',dset') = extended_occurs_check (ev,args) M dset
		   val inst = fold U.abst_over_uv_raise args M'
		in ( instantiate_evar ev inst ; dset' ) end

  (* Next, given a dpair containing at least one abstraction, we
     introduce uvars. *)

  fun abst_any (C.Dpair(C.Abstraction(Abst(xofA,M0)), C.Abstraction(Abst(yofA,N0)))) =
	let val a = Sb.new_uvar xofA in
	    C.mkDpair(C.Any(Sb.apply_sb (Sb.term_sb xofA a) M0),
		  C.Any(Sb.apply_sb (Sb.term_sb yofA a) N0))
	end
    | abst_any (C.Dpair(C.Abstraction(Abst(xofA,M0)), eqN)) =
	let val a = Sb.new_uvar xofA in
	   C.mkDpair(C.Any(Sb.apply_sb (Sb.term_sb xofA a) M0), C.Any(Appl(C.bare_term eqN,a)))
	end
    | abst_any (C.Dpair(eqM,C.Abstraction(Abst(yofA,N0)))) =
	let val a = Sb.new_uvar yofA in
	   C.mkDpair(C.Any(Appl(C.bare_term eqM,a)),C.Any(Sb.apply_sb (Sb.term_sb yofA a) N0))
	end
    | abst_any _ = raise Basic.Illegal("abst_any: Illegal call.")

  fun quant_quant (Pi((xofA as Varbind(x,A), B), Maybe))
		  (Pi((xofA' as Varbind(x',A'), B'), Maybe)) dset =
	let val a = Sb.new_uvar xofA
	 in C.mkDpair(C.Any(A),C.Any(A'))
	    ::(C.mkDpair(C.Any(Sb.apply_sb (Sb.term_sb xofA a) B),
		     C.Any(Sb.apply_sb (Sb.term_sb xofA' a) B')))
	    ::dset
	end
    | quant_quant (Pi((xofA as Varbind(x,A), B), Vacuous))
		  (Pi((xofA' as Varbind(x',A'), B'), Maybe)) dset =
	let val a' = Sb.new_uvar xofA'
	 in C.mkDpair(C.Any(A),C.Any(A'))
	    ::(C.mkDpair(C.Any(B),C.Any(Sb.apply_sb (Sb.term_sb xofA' a') B')))
	    ::dset
	end
    | quant_quant (Pi((xofA as Varbind(x,A), B), Maybe))
		  (Pi((xofA' as Varbind(x',A'), B'), Vacuous)) dset =
	let val a = Sb.new_uvar xofA
	 in C.mkDpair(C.Any(A),C.Any(A'))
	    ::(C.mkDpair(C.Any(Sb.apply_sb (Sb.term_sb xofA a) B), C.Any(B')))
	    ::dset
	end
    | quant_quant (Pi((xofA as Varbind(x,A), B), Vacuous))
		  (Pi((xofA' as Varbind(x',A'), B'), Vacuous)) dset =
	 C.mkDpair(C.Any(A),C.Any(A'))
	 ::(C.mkDpair(C.Any(B),C.Any(B')))
	 ::dset
   | quant_quant _ _ _ = raise Basic.Illegal("quant_quant: illegal call")

  fun quant_rigid (C.Dpair(C.Quant(Pi(_,occ)),C.Rigid(_,(headM,_)))) = 
         nonunif (C.FailFuntype(occ,headM))
    | quant_rigid (_) = raise Basic.Illegal("quant_rigid: illegal call")

  (* It is important the the disagreement pairs below are generated from
     left to right!  (Otherwise we might violate the "roughly the same type"
     invariant) *)

  fun rr_all (nil,nil) dset = dset
    | rr_all (M::rest1,N::rest2) dset = 
         (C.mkDpair(C.Any(M),C.Any(N))) :: (rr_all (rest1,rest2) dset)
    | rr_all _ _ = nonunif (C.FailArgs)

  (* version which takes redundancy into account *)
  fun rr (nil,nil) inh dset = dset
    | rr (M::rest1, N::rest2) (true::inh) dset = rr (rest1,rest2) inh dset
    | rr (M::rest1, N::rest2) (false::inh) dset =
        (C.mkDpair(C.Any(M),C.Any(N))) :: (rr (rest1,rest2) inh dset)
    | rr (M::rest1, N::rest2) nil dset =  (* no info available *)
        (C.mkDpair(C.Any(M),C.Any(N))) :: (rr (rest1,rest2) nil dset)
    | rr _ _ _ = nonunif (C.FailArgs)

  fun head_inh (Const(E(ref {Inh = inh, ...}))) = inh
    | head_inh _ = nil

  val rigid_rigid =
  if allow_definitions
  then
    (fn (dp as C.Dpair(eqM as C.Rigid(M,(headM,argsM)),
		     eqN as C.Rigid(N,(headN,argsN)))) => (fn dset =>
       ((if not(Reduce.eq_head(headM,headN))
	  then nonunif (C.FailClash(headM,headN))
	  else (if (!use_redundancy_info)
	          then rr (argsM,argsN) (head_inh headM) dset
	          else rr_all (argsM, argsN) dset))
	       handle C.Nonunifiable _ => 
		let val Mdef = U.is_defn headM
		    and Ndef = U.is_defn headN
		    fun expand (NONE,NONE) =
			   nonunif (C.FailClash(headM,headN))
		      | expand (NONE,SOME(H)) =
			   C.mkDpair(eqM,C.Any(U.replace_head N H))::dset
		      | expand (SOME(G),NONE) =
			   C.mkDpair(C.Any(U.replace_head M G),eqN)::dset
		      | expand (SOME(G),SOME(H)) =
			   C.mkDpair(C.Any(U.replace_head M G),C.Any(U.replace_head N H))::dset
		 in expand(Mdef,Ndef) end))
    | _  => (fn _ => raise Basic.Illegal("rigid_rigid: argument is not rigid/rigid.")))
  else
   (fn (dp as C.Dpair(eqM as C.Rigid(M,(headM,argsM)),
		    eqN as C.Rigid(N,(headN,argsN)))) => (fn dset =>
       if not(Reduce.eq_head(headM,headN))
	  then nonunif (C.FailClash(headM,headN))
	  else (if (!use_redundancy_info)
	          then rr (argsM,argsN) (head_inh headM) dset
	          else rr_all (argsM, argsN) dset))
     | _ => (fn _ => raise Basic.Illegal("rigid_rigid: argument is not rigid/rigid.")))

  fun rev_append nil k = k
    | rev_append (x::l) k = rev_append l (x::k)

  fun simplify_dset global_dset =

   let fun gvar_term_rew nil acc = rev acc
	 | gvar_term_rew (dp::dset) acc =
    let fun
	  (* dereferencing variables *)
	    gvpair (C.Dpair(C.Flex(M,Evar(_,_,_,ref(SOME(M0)))),eqN)) =
	       gvpair (C.mkDpair(C.anno M,eqN))
	  | gvpair (C.Dpair(eqM,C.Flex(N,Evar(_,_,_,ref(SOME(N0)))))) =
	       gvpair (C.mkDpair(eqM,C.anno N))

	  (* classify unknowns *)
	  | gvpair (C.Dpair(C.Any(M),eqN)) = gvpair (C.mkDpair(C.anno M,eqN))
	  | gvpair (C.Dpair(eqM,C.Any(N))) = gvpair (C.mkDpair(eqM,C.anno N))

	  (* rigid-rigid case *)
	  | gvpair (dp as C.Dpair(C.Rigid _, C.Rigid _)) =
	       gvar_term_rew (rigid_rigid dp dset) acc

	  (* dereferencing generalized variables *)
	  | gvpair (C.Dpair(C.Gvar(M,(Evar(_,_,_,ref(SOME(M0))),_)),eqN)) =
	       gvpair (C.mkDpair(C.anno M,eqN))
	  | gvpair (C.Dpair(eqM,C.Gvar(N,(Evar(_,_,_,ref(SOME(N0))),_)))) =
	       gvpair (C.mkDpair(eqM,C.anno N))

	  (* gvar-gvar case *)
	  | gvpair (C.Dpair(C.Gvar(_,ea1), C.Gvar(_,ea2))) =
	       ( gvar_gvar(ea1,ea2) ; simplify_dset (rev_append acc dset) )

	  (* gvar_flex below means that gvar_flex will be checked and re-checked
	     many times. *)
	  | gvpair (dp as C.Dpair(C.Gvar(_,ea), C.Flex(M,_))) =
	       gvar_flex (ea,M) dp
	  | gvpair (dp as C.Dpair(C.Flex(M,_), C.Gvar(_,ea))) =
	       gvar_flex (ea,M) dp

	  | gvpair (dp as C.Dpair(C.Gvar _, C.Abstraction _)) =
	       gvar_abst dp
	  | gvpair (C.Dpair(ab as C.Abstraction _, gv as C.Gvar _)) =
	       gvar_abst (C.mkDpair(gv,ab))

	  | gvpair (dp as C.Dpair(C.Gvar(_,ea), eqN)) =
	       simplify_dset (rev_append acc (gvar_ngvar(ea,C.bare_term eqN) dset))
	  | gvpair (dp as C.Dpair(eqM, C.Gvar(_,ea))) = 
	       simplify_dset (rev_append acc (gvar_ngvar(ea,C.bare_term eqM) dset))

	  | gvpair (dp as C.Dpair(C.Abstraction _, _)) =
	       gvpair (abst_any dp)
	  | gvpair (dp as C.Dpair(_, C.Abstraction _)) =
	       gvpair (abst_any dp)

	  | gvpair (C.Dpair(C.Quant A, C.Quant A')) =
	       gvar_term_rew (quant_quant A A' dset) acc
	  | gvpair (dp as C.Dpair(C.Quant A, C.Rigid _)) =
	       quant_rigid dp
	  | gvpair (dp as C.Dpair(r as C.Rigid _, q as C.Quant _)) =
	       quant_rigid (C.mkDpair(q,r))

	  | gvpair (dp as C.Dpair(C.Flex _, _)) = gvar_term_rew dset (dp::acc)
	  | gvpair (dp as C.Dpair(_,C.Flex _)) = gvar_term_rew dset (dp::acc)

	and gvar_flex (gev as (ev,args),M) dp =
	       if quick_eoc gev M
	       then let val inst = fold U.abst_over_uv_raise args M
		     in ( instantiate_evar ev inst ;
			  simplify_dset (rev_append acc dset) )
		    end
	       else gvar_term_rew dset (dp :: acc)

	and gvar_abst (dp as C.Dpair(C.Gvar(_,gev as (ev,args)),
				   C.Abstraction(M))) =
	       if quick_eoc gev M
		  then let val inst = fold U.abst_over_uv_raise args M
			in ( instantiate_evar ev inst ; 
			     simplify_dset (rev_append acc dset) )
		       end
		  else gvpair (abst_any dp)
	  | gvar_abst _ = raise Basic.Illegal("gvar_abst: argument is not Gvar/Abstraction")
     in gvpair dp end
   in gvar_term_rew global_dset nil end

  (* Now, we can construct the unifier: *)
  (* See above *)
  (* fun simplify_dset dset = rew_repeat gvar_term_rew dset *)

  fun simplify_constraint1 (C.Con(dset)) = C.Con(simplify_dset(dset))

  fun simplify_constraint con sc =
	(* First SIMPL.  This may raise exception Nonunifiable handled below. *)
	let val con' = simplify_constraint1 con
	 in sc con' end
	handle C.Nonunifiable _ => ()  (* Failure in SIMPL *)

  fun unify M N (C.Con(con)) sc = 
    simplify_constraint (C.Con(C.mkDpair(C.Any(M),C.Any(N)) :: con)) sc

  val unify =
    if (not enable_tracing)
    then unify
    else fn M => fn N => fn con => fn sc =>
     if not (!trace_unify)
     then unify M N con sc
     else let exception SucceededOnce
	   in ( tprint trace_unify (fn () =>
		 "Unifying " ^ Print.makestring_term M ^ "\n"
		 ^ "with " ^ Print.makestring_term N ^ "\n"
		 ^ "under constraint " ^ C.makestring_constraint con ^ "\n") ;
		unify M N con
		 (fn newcon =>
		     ( tprint trace_unify (fn () =>
			"Unification succeeded.  Constraint is "
			^ C.makestring_constraint newcon ^ "\n") ;
		       sc newcon ;
		       raise SucceededOnce )) ;
		tprint trace_unify (fn () =>
		 "Unification failed.\n") )
	   handle SucceededOnce => ()
	end

  (* unify1 is currently not tracable *)
  fun unify1 M N (C.Con(con)) =
    simplify_constraint1 (C.Con(C.mkDpair(C.Any(M),C.Any(N))::con))

end  (* local ... *)
end  (* functor UnifyLlambda *)
