(*
 *
 * $Log: unify.sig,v $
 * Revision 1.2  1998/06/03 11:57:55  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Unification *)

signature UNIFY =
sig

  structure Term : TERM
  structure Constraints : CONSTRAINTS_ABSTRACT
     sharing Constraints.Term = Term

  val unify : Term.term -> Term.term
	       ->  Constraints.constraint
	       -> (Constraints.constraint -> unit)
	       -> unit

  val simplify_constraint :
         Constraints.constraint -> (Constraints.constraint -> unit) -> unit

  (* Versions which do not backtrack *)
  (* They raise the exception Nonunifiable *)

  val unify1 : Term.term -> Term.term -> Constraints.constraint
	          -> Constraints.constraint
  val simplify_constraint1 : Constraints.constraint -> Constraints.constraint

  structure Switch : SWITCH

end  (* signature UNIFY *)
