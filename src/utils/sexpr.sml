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

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
