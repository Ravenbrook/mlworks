(*
 *
 * $Log: unify_skeleton.fun,v $
 * Revision 1.2  1998/06/03 11:58:45  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1992 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)
(*         - added unify_failure -er *)

functor UnifySkeleton
  (structure Basic       : BASIC
   structure Term	 : TERM
   structure Sb		 : SB          sharing Sb.Term = Term
   structure Reduce	 : REDUCE      sharing Reduce.Term = Term
   structure Print	 : PRINT       sharing Print.Term = Term
   structure Trail       : TRAIL       sharing Trail.Term = Term
   structure UUtils      : UUTILS      sharing UUtils.Term = Term
   structure Constraints : CONSTRAINTS sharing Constraints.Term = Term
   structure Unify	 : UNIFY       sharing Unify.Term = Term
				       sharing Unify.Constraints = Constraints
   structure Skeleton    : SKELETON    sharing Skeleton.Term = Term
  ) : UNIFY_SKELETON =
struct

structure Term = Term
structure Constraints = Constraints
structure Skeleton = Skeleton

local open Term
      structure C = Constraints
      structure Sk = Skeleton
in

  val omit_occurs_check = ref true

  (* Share two flags with Unify structure *)
  val use_redundancy_info = Unify.Switch.control "use_redundancy_info"
  val trace_failure = Unify.Switch.trace "failure"
  val trace_unify = Unify.Switch.trace "unify"

  fun nonunif (reason) =
         ( if (!trace_failure) then print(C.makestring_unify_failure(reason)) else () ;
	   raise C.Nonunifiable(reason) )

  fun head_inh (Const(E(ref {Inh = inh, ...}))) = inh
    | head_inh _ = nil

  (* unification proceeds in lock-step through S and M, falling back *)
  (* on ordinary unification whenever necessary *)
  (* check for Evar(...,ref(NONE)) below should be redundant *)
  (* Need to account for inheritable arguments! *)

  fun deref (Evar(_,_,_,ref(SOME(M0)))) = deref M0
    | deref M = M

  fun smp (Sk.FirstVarOcc) (ev as Evar(_,_,_,ref(NONE))) N dset =
          ( Trail.instantiate_evar ev (deref N) ; dset )
    | smp (S as Sk.Rigid _) M N dset = rr S (C.anno M) (C.anno N) dset
    | smp _ M N dset = C.mkDpair(C.Any M, C.Any N)::dset

  and rr (Sk.Rigid(sk_head, sk_args))
         (C.Rigid(M,(hdM,Margs))) (C.Rigid(N,(hdN,Nargs))) dset =
        if Reduce.eq_head(hdM,hdN)
	   then if (!use_redundancy_info)
	           then rrlist sk_args (head_inh hdM) Margs Nargs dset
		   else rrlist_all sk_args Margs Nargs dset
	   else nonunif(C.FailClash(hdM,hdN))
    | rr _ eqM eqN dset = C.mkDpair(eqM, eqN)::dset

  and rrlist nil inh nil nil dset = dset
    | rrlist (S1::Sks) (true::inh) (M1::Ms) (N1::Ns) dset =
        rrlist Sks inh Ms Ns dset
    | rrlist (S1::Sks) (false::inh) (M1::Ms) (N1::Ns) dset =
        smp S1 M1 N1 (rrlist Sks inh Ms Ns dset)
    | rrlist (S1::Sks) nil (M1::Ms) (N1::Ns) dset =
        smp S1 M1 N1 (rrlist_all Sks Ms Ns dset)
    | rrlist _ _ _ _ _ = nonunif (C.FailArgs)

  and rrlist_all nil nil nil dset = dset
    | rrlist_all (S1::Sks) (M1::Ms) (N1::Ns) dset =
        smp S1 M1 N1 (rrlist_all Sks Ms Ns dset)
    | rrlist_all _ _ _ _ = nonunif (C.FailArgs)

  fun sk_unify S M N (C.Con(dset)) sc =
      let val (dset,success) = (smp S M N dset,true)
	                       handle C.Nonunifiable _ => (nil,false)
       in if success
	     then (case dset
		     of nil => sc (C.Con(dset))
		      | _ =>
                ( if (!trace_unify)
	             then print ("Simplifying " ^ C.makestring_constraint(C.Con(dset))
			      ^ "\n")
		     else () ;
		  Unify.simplify_constraint (C.Con(dset)) sc ))
	     else ()
       end

  (* Required invariant: only called with two rigid terms *)
  fun unify skeleton =
        if !omit_occurs_check
	    then sk_unify skeleton
	    else Unify.unify

end  (* local open *)

end  (* functor UnifySkeleton *)
