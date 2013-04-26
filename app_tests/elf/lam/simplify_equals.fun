(*
 *
 * $Log: simplify_equals.fun,v $
 * Revision 1.2  1998/06/03 12:09:09  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Simplifies constraints by eliminating equal terms *)

functor SimplifyEquals
  (structure Basic       : BASIC
   structure Term        : TERM
   structure Sb		 : SB          sharing Sb.Term = Term
   structure UUtils	 : UUTILS      sharing UUtils.Term = Term
   structure Equal	 : EQUAL       sharing Equal.Term = Term
   structure Constraints : CONSTRAINTS sharing Constraints.Term = Term
   structure Unify	 : UNIFY       sharing Unify.Constraints = Constraints)
  : UNIFY =
struct

structure Term = Term
structure Constraints = Constraints

local open Term
      structure C = Constraints
in

   (* Fix next three lines !! *)
   structure Switch =
   struct
     exception UnknownSwitch = Basic.UnknownSwitch
     val control = Unify.Switch.control
     val warn = Unify.Switch.warn
     val trace = Unify.Switch.trace
   end  (* structure Switch *)
   open Switch

   (* This method of inheriting the switch is a hack *)
   val trace_simplify = trace "simplify"
   fun tprint traceref func = if (!traceref) then print(func():string) else ()

   fun same_anno (C.Rigid _ , C.Rigid _) = true
     | same_anno (C.Gvar _, C.Gvar _) = true
     | same_anno (C.Flex _, C.Flex _) = true
     | same_anno (C.Abstraction _, C.Abstraction _) = true
     | same_anno (C.Quant _, C.Quant _) = true
     | same_anno (C.Any _, C.Any _) = true
     | same_anno (_, _) = false

   fun reclassify_dset (C.Dpair(eqM,eqN)::rest) progress dset' =
       let val M = C.bare_term eqM
	   and N = C.bare_term eqN
	in if Equal.term_eq(M,N)
	   then reclassify_dset rest progress dset'
	   else let val eqM' = C.reclassify M
	            val eqN' = C.reclassify N
		in reclassify_dset rest
		    (progress orelse not (same_anno (eqM, eqM'))
		     orelse not (same_anno (eqN, eqN')))
		    (C.Dpair (eqM', eqN')::dset')
	       end
       end
     | reclassify_dset nil progress dset' = (progress,dset')

   (*
      Reclassification may result in simplification even if
      the nature of a dpair is not changed, since the quick_eoc
      in gvar_flex may fail but succeed after re-classification.
      Thus we always simplify at least once, since we have no reliable
      way of telling if progress was made.  This function is called
      only in non-critical places, so the effort can be justified.
      In the end, it may be better to change the unifier.
    *)

   fun simplify_constraint1' first_time (con as C.Con(dset)) =
       let val (progress, dset') = reclassify_dset dset first_time nil
       in 
	   if progress
	   then simplify_constraint1' false
	           (Unify.simplify_constraint1 (C.Con (dset')))
	   else C.Con (dset')
       end

   fun simplify_constraint1 (con) =
     if C.is_empty_constraint con
	then con
	else let val _ = tprint trace_simplify (fn () =>
			  "Simplifying " ^ C.makestring_constraint con ^ "\n")
		 val con' = simplify_constraint1' true con
		 val _ = tprint trace_simplify (fn () =>
			  "to " ^ C.makestring_constraint con' ^ "\n")
	     in con' end

   fun unify1 M N con =
     let val con' = Unify.unify1 M N con
      in simplify_constraint1 con' end

   fun simplify_constraint con sc =
     sc (simplify_constraint1 con)

   fun unify M N con sc =
     Unify.unify M N con (fn con' => simplify_constraint con' sc)

end  (* local ... *)
end  (* functor SimplifyEquals *)
