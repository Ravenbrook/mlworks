(*
 *
 * $Log: elf_absyn.sig,v $
 * Revision 1.2  1998/06/03 12:26:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Abstract syntax, Elf specific part *)

signature ELF_ABSYN =
sig

  structure Term : TERM

  datatype parse_result
    = ParsedSigentry of (string list * Term.varbind) * (int * int)
    | ParsedQuery of string list * Term.term
    | ParsedFixity of (Term.fixity * int) * Term.sign_entry list
    | ParsedNamePref of Term.sign_entry * string list

end  (* signature ELF_ABSYN *)
