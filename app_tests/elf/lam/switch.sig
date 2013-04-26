(*
 *
 * $Log: switch.sig,v $
 * Revision 1.2  1998/06/03 11:57:25  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* A string interface to switches *)

signature SWITCH =
sig

  exception UnknownSwitch of string * string

  val control : string -> bool ref
  val warn    : string -> bool ref
  val trace   : string -> bool ref

end  (* signature SWITCH *)
