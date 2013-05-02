(* symbol.sml the signature *)
(*
$Log: symbol.sml,v $
Revision 1.4  1992/09/15 17:06:52  jont
Added strict less than functions for all the symbol types

Revision 1.3  1991/11/21  16:00:03  jont
Added copyright message

Revision 1.2  91/11/19  12:16:26  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:06:30  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  10:57:59  colin
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

(* 

This module defines a type Symbol and functions for manipulating them.
This conceals the string nature of symbols and would allow one to add
more information to the symbol type. The functions are all
self-explanatory.

Symbols are used throughout the compiler for identifiers, via the
basics/ident.sml module. N.B. qualified identifiers (foo.bar.baz) are
represented using lists of symbols.

*)


signature SYMBOL =
    sig
        eqtype Symbol
        val symbol_name : Symbol -> string
        val find_symbol : string -> Symbol
        val eq_symbol   : Symbol * Symbol -> bool
	val symbol_lt   : Symbol * Symbol -> bool
	val symbol_order: Symbol * Symbol -> bool
    end

