(*
 *
 * $Log: sys.sig,v $
 * Revision 1.2  1998/06/03 11:47:36  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* System dependencies.  Currently not used pervasively *)

signature SYS =
sig

  val handle_interrupt : (unit -> unit) -> unit
  val output_immediately : outstream * string -> unit
  val input_one_line : instream -> string
  val exception_name : exn -> string
  val sml_version : string
  val save_file : string * string -> unit

  val date : unit -> string
  val cd : string -> unit
  val cwd : unit -> string
  val ls : string -> unit
  val exit : unit -> 'a

end  (* signature SYS *)
