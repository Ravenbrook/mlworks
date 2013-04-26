(*
 *
 * $Log: elf_front_end.sig,v $
 * Revision 1.2  1998/06/03 12:22:11  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)
(* modified: exported exception FrontEnd -er 17Aug94 *)

(* Puts the pieces of the front end together *)

signature ELF_FRONT_END =
sig

  structure Term : TERM
  structure Sign : SIGN  sharing Sign.Term = Term
  structure Constraints : CONSTRAINTS  sharing Constraints.Term = Term

  exception FrontEnd of string

  val echo_declarations : bool ref
  val warn_redeclaration : bool ref
  val warn_implicit : bool ref

  val sig_clean : unit -> unit

  val handle_std_exceptions : string -> (unit -> 'a) -> 'a

  val file_read : string -> Sign.sign
  val interactive_read :
         unit -> (Term.term list * Term.term * Constraints.constraint) option

  type token_stream
  val stream_init : instream -> (string -> string) -> token_stream
  val stream_read :
         token_stream
	  -> ((Term.term list * Term.term * Constraints.constraint)
	      * token_stream) option

end  (* signature ELF_FRONT_END *)
