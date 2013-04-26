(*
 *
 * $Log: elf_parse.sig,v $
 * Revision 1.2  1998/06/03 12:27:40  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Hooking together parser and abstract syntax *)

signature ELF_PARSE =
sig

  structure ElfAbsyn : ELF_ABSYN
  structure Parse : PARSE
      sharing type Parse.Parser.result = ElfAbsyn.parse_result

end  (* signature ELF_PARSE *)
where type Parse.Parser.arg = unit
