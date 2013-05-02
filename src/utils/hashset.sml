(* hashset.sml the signature *)
(*
$Log: hashset.sml,v $
Revision 1.6  1993/05/20 12:52:14  jont
Added a rehash function to deal with sets where the hash value changes
due to update (eg Namesets)

Revision 1.5  1993/02/25  13:59:03  jont
Modified to accept a size parameter to empty_set

Revision 1.4  1992/12/01  18:34:17  jont
Improved to avoid parameter recopying in numerous places

Revision 1.3  1992/08/13  16:16:16  davidt
Added iterate function.

Revision 1.2  1992/08/04  19:07:48  davidt
Added fold function.

Revision 1.1  1992/04/22  11:01:57  jont
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

(* A few basic well-known set functions, using a hashtable internally *)
(* Note that this is an imperative implementation *)

signature HASHSET =
  sig
    type HashSet
    type element

    val max_size : int
    val add_member   : (HashSet * element) -> HashSet
    val add_list     : (HashSet * element list) -> HashSet
    val remove_member : (HashSet * element) -> HashSet
    val empty_set     : int -> HashSet
    val empty_setp    : HashSet -> bool
    val is_member     :  (HashSet * element) -> bool
    val union         : HashSet * HashSet -> HashSet
    val intersection  : HashSet * HashSet -> HashSet
    val subset        : HashSet * HashSet -> bool
    val setdiff       : HashSet * HashSet -> HashSet
    val seteq         : HashSet * HashSet -> bool
    val set_to_list   : HashSet -> element list
    val fold          : ('a * element -> 'a) -> ('a * HashSet) -> 'a
    val iterate       : (element -> unit) -> HashSet -> unit
    val list_to_set   : element list -> HashSet
    val set_print     : HashSet * (element -> string) -> string
    val set_size      : HashSet -> int
    val rehash	      : HashSet -> unit
  (* For sets where the hash value goes out of date *)
  end
