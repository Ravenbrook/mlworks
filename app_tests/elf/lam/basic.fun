(*
 *
 * $Log: basic.fun,v $
 * Revision 1.2  1998/06/03 12:18:42  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Basic utilities, used pervasively *)

functor Basic () : BASIC =
struct

  exception Illegal of string
  exception UnknownSwitch of string * string

end  (* functor Basic *)
