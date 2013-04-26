(* set.sml the signature *)
(*
$Log: set.sml,v $
Revision 1.8  1997/01/30 16:42:19  matthew
Adding intersect function

 * Revision 1.7  1992/08/04  18:39:38  davidt
 * Added fold function.
 *
Revision 1.6  1992/04/22  12:23:26  jont
Added a disjoint union function for efficiency

Revision 1.5  1991/11/21  17:05:17  jont
Added copyright message

Revision 1.4  91/11/19  12:41:23  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.3  91/10/09  14:56:35  richard
Added map.

Revision 1.2.1.1  91/11/19  11:13:44  jont
Added comments for DRA on functions

Revision 1.2  91/07/17  11:18:48  davida
Added seteq and altered list_to_set to remove duplicate elements.

Revision 1.1  91/06/07  15:59:13  colin
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

(* A few basic well-known set functions, using lists as the internal
representation *)


signature SET =
  sig
    type ''a Set

    val add_member   : ''a * ''a Set -> ''a Set
    val singleton    : ''a -> ''a Set
    val empty_set    : ''a Set
    val empty_setp   : ''a Set -> bool
    val is_member    : ''a * ''a Set -> bool
    val intersect    : ''a Set * ''a Set -> bool
    val union        : ''a Set * ''a Set -> ''a Set
    val disjoin      : ''a Set * ''a Set -> ''a Set
    (* Use with care, this doesn't check for duplicates *)
    val intersection : ''a Set * ''a Set -> ''a Set
    val subset       : ''a Set * ''a Set -> bool
    val setdiff      : ''a Set * ''a Set -> ''a Set
    val seteq        : ''a Set * ''a Set -> bool
    val set_to_list  : ''a Set -> ''a list
    val list_to_set  : ''a list -> ''a Set
    val map	     : (''a -> ''b) -> ''a Set -> ''b Set
    val fold	     : ('b * ''a -> 'b) -> ('b * ''a Set) -> 'b
    val set_print    : ''a Set * (''a -> string) -> string
  end
