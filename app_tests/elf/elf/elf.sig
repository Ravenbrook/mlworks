(*
 *
 * $Log: elf.sig,v $
 * Revision 1.2  1998/06/03 12:29:47  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Top level for Elf. *)

signature ELF =
sig

  val version : string

  val help : 'a -> unit

  val initload : string list -> string list -> unit
  val top : unit -> unit
  val sload : string list -> unit
  val dload : string list -> unit
  val reload : string -> unit

  val toc : unit -> unit
  val show_prog : unit -> unit
  val print_sig : string -> unit
  val print_sig_full : string -> unit
  val reset : unit -> unit

  val cd : string -> unit
  val pwd : unit -> unit
  val ls : string -> unit

  val batch_top : string -> unit

  val trace : int -> unit
  val untrace : unit -> unit
  val chatter : int -> unit

  structure E : SWITCH

  structure U : SWITCH
  structure T : SWITCH
  structure S : SWITCH

  val save_elf : string -> unit

end  (* signature ELF *)
