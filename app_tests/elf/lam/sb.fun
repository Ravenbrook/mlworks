(*
 *
 * $Log: sb.fun,v $
 * Revision 1.2  1998/06/03 12:10:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Substitution primitives and utilities *)

functor Sb (structure Basic : BASIC
	    structure Term : TERM
	    structure Naming : NAMING
	       sharing Naming.Term = Term) : SB =
struct

structure Term = Term

local open Term
in

  type sb = (varbind * term) list
  exception LooseBvar of term

  fun shadow (Varbind(x,_)) (Varbind(y,_)) = (x = y)

  fun free_in (xofA as Varbind(x,_)) M =
      let fun fin (Bvar(y)) = (x = y)
	    | fin (Appl(M1,M2)) = fin M1 orelse fin M2
	    | fin (Abst(yofB as Varbind(y,B),M)) =
		 (fin B) orelse (if shadow yofB xofA then false else fin M)
	    | fin (Pi((yofB as Varbind(y,B),C),occ)) =
		 (fin B) orelse (if (occ = Maybe) andalso shadow yofB xofA
				    then false
				    else fin C)
	    | fin (HasType(M,A)) = fin M orelse fin A
	    | fin (Mark(_,M)) = fin M
	    | fin _ = false  (* Evar , Uvar, Fvar , Const, Type *)
       in fin M end

  (* does the variable Evar, Uvar, or Fvar x occur in M? *)
  fun occurs_in x M =
      let fun oin (M as Evar _) = eq_var(x,M)
	    | oin (M as Uvar _) = eq_var(x,M)
	    | oin (Appl(M1,M2)) = oin M1 orelse oin M2
	    | oin (Abst(Varbind(y,B),M)) = oin B orelse oin M
	    | oin (Pi((Varbind(y,B),C),_)) = oin B orelse oin C
	    | oin (HasType(M,A)) = oin M orelse oin A
	    | oin (Mark(_,M)) = oin M
	    | oin (M as Fvar _) = eq_var(x,M)
	    | oin _ = false (* Bvar , Const , Type *)
       in oin M end

  val id_sb = nil

  (* M must not contain any loose Bvar's which could lead to a name clash! *)
  fun term_sb xofA M = (xofA,M)::nil

  fun add_sb xofA M sb = (xofA,M)::sb

  fun free_in_rhs xofA sb = exists (fn (_,M) => free_in xofA M) sb

  fun conflict_func sb M x =
       let val xofW = Varbind(x,Wild)
	in free_in_rhs xofW sb orelse free_in xofW M end

  fun shadow_sb (xofA as Varbind(x,_)) sb = ((xofA,Bvar(x))::sb)

  fun rename_sb (xofA as Varbind(x,A), M) sb =
       let val x' = Naming.rename_varbind (conflict_func sb M) xofA
	in (Varbind(x',A),(xofA,Bvar(x'))::sb) end

  fun lookup_vbind x sb =
      let fun lk ((Varbind(y,_),M) :: rest) =
		 if x = y then M else lk rest
	    | lk nil = raise LooseBvar(Bvar(x))
       in lk sb end

  (* M must be closed with respect to sb, that is, 
     1. all free Bvars in M are bound in sb, and
     2. the substitution terms in sb are closed *)
  (* apply_sb does not need to derefence Evar's, since the binding of
     an Evar can never contain a Bvar *)
  fun apply_sb sb M =
      let fun asb (Bvar(x)) = lookup_vbind x sb
	    | asb (Appl(M1,M2)) = Appl((asb M1),(asb M2))
	    | asb (Abst(xofA,M)) =
		 let val xofA' = vsb xofA
		  in Abst(xofA', apply_sb (shadow_sb xofA' sb) M) end
	    | asb (Pi((xofA,B),occ)) =
		 let val xofA' = vsb xofA
		  in if (occ = Maybe)
			then (Pi((xofA', apply_sb (shadow_sb xofA' sb) B),occ))
			else (Pi((xofA', asb B),occ))
		 end
	    | asb (HasType(M,A)) = HasType(asb M,asb A)
	    | asb (Mark(lrpos,M)) = Mark(lrpos,asb M)
	    | asb M = M		(* Evar, Uvar, Fvar, Const, Type *)
	  and vsb (Varbind(x,A)) = Varbind(x,asb A)
       in asb M end
  and varbind_sb sb (Varbind(x,A)) = Varbind(x,apply_sb sb A)

  (* renaming_apply_sb is like apply_sb, but invariants 1., 2. are not
     required *)
  fun renaming_apply_sb sb M =
      let fun rasb (M as Bvar(x)) = (lookup_vbind x sb
				     handle LooseBvar _ => M)
	    | rasb (Appl(M1,M2)) = Appl((rasb M1),(rasb M2))
	    | rasb (Abst(xofA,M)) = 
		let val xofA' = ravb xofA
		    val (xofA'',new_sb) =
			    if free_in_rhs xofA' sb
			       then rename_sb (xofA',M) sb
			       else (xofA',shadow_sb xofA' sb)
		 in Abst(xofA'', renaming_apply_sb new_sb M) end
	    | rasb (Pi((xofA,B),occ)) = 
		let val xofA' = ravb xofA
		    val (xofA'',new_sb) =
			    if (occ = Vacuous) then (xofA', sb)
			    else if (occ = Maybe) andalso (free_in_rhs xofA' sb)
			       then rename_sb (xofA',B) sb
			       else (xofA',shadow_sb xofA' sb)
		 in Pi((xofA'', renaming_apply_sb new_sb B),occ) end
	    | rasb (HasType(M,A)) = HasType(rasb M,rasb A)
	    | rasb (Mark(lrpos,M)) = Mark(lrpos,rasb M)
	    | rasb M = M		(* Evar, Uvar, Fvar, Const, Type *)
	  and ravb (Varbind(x,A)) = Varbind(x,rasb A)
       in rasb M end
  and renaming_varbind_sb sb (Varbind(x,A)) =
	 Varbind(x,renaming_apply_sb sb A)

  val generic_type = Varbind(anonymous,Type)

  local val varcount = ref 0
  in
   fun new_evar xofA uvars =
     ( varcount := !varcount + 1;
       Evar(xofA,!varcount,uvars,ref NONE) )

   fun new_uvar xofA =
     ( varcount := !varcount + 1;
       Uvar(xofA,!varcount) )
  end  (* val varcount *)

  (* Note complications because of possible dependencies *)
  fun new_evar_sb Gamma uvars =
	 fold (fn (Varbind(x,A), sb) =>
		    let val xofA' = Varbind(x,apply_sb sb A)
		     in ((xofA', new_evar xofA' uvars)::sb) end)
	      Gamma
	      id_sb

  (* New named Evars are introduced for free variables in a query *)
  (* and their names must be established to avoid future conflicts *)
  fun new_named_evar_sb Gamma uvars =
	 fold (fn (Varbind(x,A), sb) =>
		    let val xofA' = Varbind(x,apply_sb sb A)
			val ev = new_evar xofA' uvars
			val _ = Naming.name_var (fn s => false) ev
		     in ((xofA', ev)::sb) end)
	      Gamma
	      id_sb

  (* New Fvars are entered into the variable list to avoid future *)
  (* conflicts with Evar and Uvar names *)
  fun new_fvar_sb bvars =
         fold (fn (x, sb) =>
	            let val xofA = Varbind(x, new_evar generic_type nil)
			val fv = Fvar(xofA)
			val _ = Naming.name_var (fn s => false) fv
		     in ((xofA, Fvar(xofA))::sb) end)
              bvars
	      id_sb

  (* Should be made tail-recursive *)
  fun app_to_evars M sb =
    let fun ate nil = M
	  | ate ((_,evar)::sb') = Appl(ate sb', evar)
     in ate sb end

  fun eq_uvar stamp1 (Uvar(_,stamp2)) = (stamp1 = stamp2)
    | eq_uvar _ M = raise Basic.Illegal("eq_uvar: argument is not a Uvar.")

  (* rename a list of vbds such that the variable names are all distinct *)
  fun rename_vbds Gamma =
     let fun rvbds nil sb = nil
	   | rvbds (xofA::Gamma) sb =
		let val xofA' = renaming_varbind_sb sb xofA
		    val (xofA'',new_sb) =
			   if free_in_rhs xofA' sb
			      then rename_sb (xofA',Type) sb  (* dummy type *)
			      else (xofA',shadow_sb xofA' sb)
		     in xofA''::(rvbds Gamma new_sb) end
      in rvbds Gamma id_sb end

end  (* local ... *)

end  (* functor Sb *)
