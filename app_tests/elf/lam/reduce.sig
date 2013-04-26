(*
 *
 * $Log: reduce.sig,v $
 * Revision 1.2  1998/06/03 11:53:52  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Reduction *)

signature REDUCE =
sig

  structure Term : TERM

  val head_norm : Term.term -> Term.term
  val renaming_head_norm : Term.term -> Term.term

  val head_args_norm : Term.term -> Term.term

  val beta_norm : Term.term -> Term.term

  val pi_vbds : Term.term -> Term.varbind list * Term.term

  type head  sharing type head = Term.term

  val rigid_term_head : Term.term -> head	   (* term must be rigid *)
  (* term must be ah-normal *)
  val head_args : Term.term -> head * Term.term list
  val eq_head : head * head -> bool

end  (* signature REDUCE *)
