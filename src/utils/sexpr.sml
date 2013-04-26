(* sexpr.sml the signature *)
(*
$Log: sexpr.sml,v $
Revision 1.4  1996/08/09 13:15:11  io
add toList for MIPS mach_cg

 * Revision 1.3  1991/11/21  17:05:26  jont
 * Added copyright message
 *
Revision 1.2  91/11/19  12:20:56  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:45  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  15:59:18  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* For Lisp lovers. pprint pretty-prints SExprs, with chevrons at the
left to denote long lines. used in basics/absynprint and ten15print.
*)

signature SEXPR =
  sig
    
    datatype 'a Sexpr = NIL | ATOM of 'a | CONS of 'a Sexpr * 'a Sexpr

    val list : ('a Sexpr) list -> 'a Sexpr

    exception Append
    val append : 'a Sexpr * 'a Sexpr -> 'a Sexpr

    val printSexpr : ('a -> string) -> 'a Sexpr -> string
    val pprintSexpr : ('a -> string) -> 'a Sexpr -> string

    val toList : 'a list Sexpr -> 'a list

  end
