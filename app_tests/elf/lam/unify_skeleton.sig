(*
 *
 * $Log: unify_skeleton.sig,v $
 * Revision 1.2  1998/06/03 11:56:58  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1992 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Unification which employs term skeletons to avoid unnecessary  *)
(* occurs-checks for unifying clause head.  This will not work in *)
(* many circumstances: further optimizations are easily possible  *)
(* in a compiler *)

signature UNIFY_SKELETON =
sig

  structure Term : TERM
  structure Constraints : CONSTRAINTS_ABSTRACT
     sharing Constraints.Term = Term
  structure Skeleton : SKELETON
     sharing Skeleton.Term = Term

  (* the first argument must be the skeleton of the second argument *)
  val unify : Skeleton.skeleton -> Term.term -> Term.term
	       ->  Constraints.constraint
	       -> (Constraints.constraint -> unit)
	       -> unit

  val omit_occurs_check : bool ref

end  (* signature UNIFY_SKELETON *)
