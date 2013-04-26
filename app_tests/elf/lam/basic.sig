(*
 *
 * $Log: basic.sig,v $
 * Revision 1.2  1998/06/03 11:58:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Basic utilities, used pervasively *)

signature BASIC =
sig

  exception Illegal of string
  exception UnknownSwitch of string * string

end  (* signature BASIC *)
