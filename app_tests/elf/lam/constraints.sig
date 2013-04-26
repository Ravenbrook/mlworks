(*
 *
 * $Log: constraints.sig,v $
 * Revision 1.2  1998/06/03 11:56:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991,1994 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Constraints, external and internal view *)
(* There is an ugly SourceGroup bug workaround in here
   -fp Tue Apr 28 10:03:28 1992 *)
(* Added unify_failure -er *)

signature CONSTRAINTS_DATATYPES =
sig

  structure Term : TERM

  datatype eqterm
   = Rigid of Term.term * (Term.term * Term.term list)
   | Gvar of Term.term * (Term.term * Term.term list)
   | Flex of Term.term * Term.term
   | Abstraction of Term.term
   | Quant of Term.term
   | Any of Term.term

   datatype dpair = Dpair of eqterm * eqterm

   datatype constraint = Con of dpair list

end

signature CONSTRAINTS =
sig

  include CONSTRAINTS_DATATYPES 

  datatype unify_failure
   = FailArgs 
   | FailOccursCheck of Term.term
   | FailFuntype of Term.occurs * Term.term
   | FailClash of Term.term * Term.term
   | FailDependency of Term.term * Term.term * Term.term list * Term.term list

  exception Nonunifiable of unify_failure

  val bare_term : eqterm -> Term.term

  val mkDpair : eqterm * eqterm -> dpair

  val empty_constraint : constraint
  val is_empty_constraint : constraint -> bool
  val makestring_constraint : constraint -> string

  val makestring_unify_failure : unify_failure -> string
  val makestring_dpair : dpair -> string
  val makestring_dset : dpair list -> string

  (* anno makes obvious annotations, reclassify tries hard *)
  val anno : Term.term -> eqterm
  val reclassify : Term.term -> eqterm

end  (* signature CONSTRAINTS *)


signature CONSTRAINTS_ABSTRACT =
sig

  structure Term : TERM

  datatype unify_failure
   = FailArgs 
   | FailOccursCheck of Term.term
   | FailFuntype of Term.occurs * Term.term
   | FailClash of Term.term * Term.term
   | FailDependency of Term.term * Term.term * Term.term list * Term.term list

  exception Nonunifiable of unify_failure

  type constraint
  val empty_constraint : constraint
  val is_empty_constraint : constraint -> bool
  val makestring_constraint : constraint -> string
  val makestring_unify_failure : unify_failure -> string

end  (* signature CONSTRAINTS_ABSTRACT *)
