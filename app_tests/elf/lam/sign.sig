(*
 *
 * $Log: sign.sig,v $
 * Revision 1.2  1998/06/03 12:06:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Signatures *)

signature SIGN =
sig

  structure Term : TERM
  type sign

  val empty_sig : sign
  val add_sig : Term.sign_entry * sign -> sign
  val sig_append : sign -> sign -> sign

  val sig_print : sign -> unit
  val sig_print_full : sign -> unit

  val sig_item : sign -> (Term.sign_entry * sign) option
  val sig_to_list : sign -> Term.sign_entry list

end  (* signature SIGN *)
