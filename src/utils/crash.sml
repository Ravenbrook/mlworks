(* crash.sml the signature *)
(*
$Log: crash.sml,v $
Revision 1.4  1992/09/30 14:50:38  clive
Type of impossible did not need to be imperative

Revision 1.3  1991/11/21  17:03:40  jont
Added copyright message

Revision 1.2  91/11/19  12:20:39  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:38  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  15:58:11  colin
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

(* This module provides two functions for the compiler to call when it
gets into trouble. `impossible' is used when the compiler gets into an
inconsistent state (for instance a function is called with a value of
the `correct type' but the incorrect value constructor (e.g.
cg_fun_type called with a Type which is not FUNTYPE _)).
`unimplemented' is used when an incomplete part of the compiler is
entered. Both functions print their arguments to stdout and exit the
compiler.

*)

signature CRASH =
  sig
    val impossible    : string -> 'a
    and unimplemented : string -> 'a
  end;



             
