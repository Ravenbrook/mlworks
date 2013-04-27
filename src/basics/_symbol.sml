(* _symbol.sml the functor *)
(*
$Log: _symbol.sml,v $
Revision 1.8  1996/10/09 12:36:34  io
moving String from toplevel

 * Revision 1.7  1992/09/15  17:07:18  jont
 * Added strict less than functions for all the symbol types
 *
Revision 1.6  1992/08/10  12:44:23  davidt
Structure String is now pervasive.

Revision 1.5  1992/02/27  12:26:35  jont
Changed symbol_eq so it knows that it's working on strings. This
should improve efficiency

Revision 1.4  1992/02/20  13:12:09  jont
Fixed symbol order to use String.<= rather than String.<, as required
by maps in order to get shadowing correct. Otherwise, you end up with
old objects shadowing newer ones, instead of the reverse

Revision 1.3  1992/02/18  14:00:24  richard
Changed symbol_order to use String.< rather than exploding and
comparing.

Revision 1.2  1991/11/21  15:57:05  jont
Added copyright message

Revision 1.1  91/06/07  10:55:42  colin
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

require "symbol";

functor Symbol () : SYMBOL =
  struct
    type Symbol = string

    fun symbol_name s = s

    fun find_symbol s = s

    val eq_symbol = (op=) : string * string -> bool

    val symbol_lt :string * string -> bool = (op<)

    val symbol_order : string * string -> bool = (op<=)
  end;
