(*
 *
 * $Log: type_recon.sig,v $
 * Revision 1.2  1998/06/03 11:59:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Type and object reconstruction *)

signature TYPE_RECON =
sig

  structure Term : TERM
  structure Sb : SB  sharing Sb.Term = Term
  structure Constraints : CONSTRAINTS  sharing Constraints.Term = Term 

  exception TypeCheckFail of (int * int) option * string

  type env

  val empty_env : env
  val abst_over_evars : string list -> env -> Term.term -> env * Term.term
  val env_to_pis : env -> Term.term -> Term.term -> (Term.term * Term.term)
  val env_to_absts : env -> Term.term -> Term.term

  val env_to_quant : Term.term -> env -> Term.term -> Term.term

  val type_recon : Term.term -> Term.term * Term.term * Constraints.constraint

  val type_recon_as :
         Term.term -> Term.term
	    -> Term.term * Term.term * Constraints.constraint

  structure Switch : SWITCH

end  (* signature TYPE_RECON *)
