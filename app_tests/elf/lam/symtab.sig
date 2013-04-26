(*
 *
 * $Log: symtab.sig,v $
 * Revision 1.2  1998/06/03 12:05:35  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Spiro Michaylov <spiro@cs.cmu.edu>       *)
(* Modified: Amy Felty                              *)

(* Symbol table *)
(* Handles multiple symbol tables (one for each module) *)

signature SYMTAB =
sig

  type entry

  exception Symtab of string

  val new_symtab : string -> unit
  val use_symtabs : string list -> unit
  val unuse_symtabs : string list -> unit

  val find_entry : string -> entry option
  val delete_sym : string -> unit
  val delete_sym_from : string -> string -> unit
  val add_entry  : string -> entry -> unit
  val add_entry_to : string -> string -> entry -> unit
  val add_entry' : string -> entry -> (entry -> unit) -> unit
  val add_entry_to' : string -> string -> entry -> (entry -> unit) -> unit

  val clean : unit -> unit
  val checkpoint : unit -> unit
  val rollback : unit -> unit
  val commit : unit -> unit

end  (* signature SYMTAB *)
