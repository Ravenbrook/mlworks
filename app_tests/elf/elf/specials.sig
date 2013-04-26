(*
 *
 * $Log: specials.sig,v $
 * Revision 1.2  1998/06/03 12:23:01  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Specially interpreted constants *)

signature SPECIALS =
sig

  structure Term : TERM
  val backquote : Term.term
  val bq : Term.term
  val sigma : Term.term
  val pr : Term.term

end  (* signature SPECIALS *)
