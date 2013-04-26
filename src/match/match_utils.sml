(* match_utils.sml the signature *)
(*
$Log: match_utils.sml,v $
Revision 1.4  1991/11/27 12:55:46  jont
Removed all unused functions from signature

Revision 1.3  91/11/21  16:34:20  jont
Added copyright message

Revision 1.2  91/11/19  12:16:39  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:24  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:06:35  colin
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

(* This module provides a set of utility functions to the match
compiler. They are all straightforward set operations, and this module
could be removed and replaced by a good set library. Implementations
of all these functions are straightforward textbook. *)

signature MATCH_UTILS =
  sig
(*
    val remove_if : ('a -> bool) -> 'a list -> 'a list
    val every : ('a -> bool) -> 'a list -> bool
    val any : ('a -> bool) -> 'a list -> bool
    val remove : ''a -> ''a list -> ''a list
    val memberp : ''a -> ''a list -> bool
*)
    val union_lists : ''a list -> ''a list -> ''a list
(*
    val remove_duplicates : ''a list -> ''a list
    val Qsort : ('a * 'a -> bool) -> 'a list -> 'a list
    val power : 'a list -> 'a list list
    val power_size : int -> 'a list -> 'a list list
*)
  end
