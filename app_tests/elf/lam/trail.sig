(*
 *
 * $Log: trail.sig,v $
 * Revision 1.2  1998/06/03 11:52:57  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Trailing for binding and unbinding variables *)

signature TRAIL =
sig

  structure Term : TERM

  val trail : (unit -> unit) -> unit
  val instantiate_evar : Term.term -> Term.term -> unit
  val erase_trail : unit -> unit

end  (* signature TRAIL *)
