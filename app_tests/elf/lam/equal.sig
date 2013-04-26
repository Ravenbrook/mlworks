(*
 *
 * $Log: equal.sig,v $
 * Revision 1.2  1998/06/03 12:03:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

signature EQUAL =
sig

  structure Term : TERM

  val term_eq : Term.term * Term.term -> bool

end  (* signature EQUAL *)
