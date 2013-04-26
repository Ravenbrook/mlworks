(*
 *
 * $Log: interface.sig,v $
 * Revision 1.2  1998/06/03 12:16:26  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Interface to the ml-yacc generated parser *)

signature INTERFACE =
sig

  type pos
  datatype region = Region of {from : int * int, to : int * int}

  val init_line : int -> unit
  val next_line : pos -> unit
  val last_newline : unit -> pos
  val dummy_pos : pos
  val region : pos * pos -> region
  val makestring_region : region -> string

  val error : string * (pos * pos) -> unit

end  (* signature INTERFACE *)
