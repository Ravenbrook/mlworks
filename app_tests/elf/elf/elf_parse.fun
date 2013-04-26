(*
 *
 * $Log: elf_parse.fun,v $
 * Revision 1.2  1998/06/03 12:28:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Hooking together parser and abstract syntax *)

functor ElfParse
    (include sig
      structure ElfAbsyn : ELF_ABSYN
      structure Parse : PARSE
	sharing type Parse.Parser.result = ElfAbsyn.parse_result
      structure Tokens : Elf_TOKENS
	sharing type Tokens.token = Parse.Parser.Token.token
	sharing type Tokens.svalue = Parse.Parser.svalue
     end where type Parse.Parser.arg = unit) : ELF_PARSE =
struct

structure ElfAbsyn = ElfAbsyn
structure Parse = Parse

end  (* functor ElfParse *)
