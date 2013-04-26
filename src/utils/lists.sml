(* lists.sml the signature *)
(*
$Log: lists.sml,v $
Revision 1.20  1997/11/25 18:34:16  jont
[Bug #30328]
Add early exit fold function findOption

 * Revision 1.19  1995/03/29  16:31:31  brianm
 * Minor correction ... adding nthtail to signature.
 *
Revision 1.18  1995/03/29  16:11:24  brianm
Added adjoin, rev_append, nthtail.  Changed signature entry for `last'
so that it doesn't use equality types.  Noted that `filter' is actually
a `reverse and remove duplicates' function - so added `rev_remove_dups'.
Incidentally, the new Initial Basis uses `filter' for what we have
named `filterp'.

Revision 1.17  1994/05/26  13:55:27  jont
Added msort and check_order

Revision 1.16  1994/03/10  12:02:05  io
adding last

Revision 1.15  1993/10/28  15:34:21  nickh
Merging fixes.

Revision 1.14.1.2  1993/10/27  16:18:48  nickh
Removed function number_with_size, which was (a) difficult to figure out,
(b) inefficient, and (c) only used in particular places in the lambda
optimiser.

Revision 1.14.1.1  1992/08/13  16:39:25  jont
Fork for bug fixing

Revision 1.14  1992/08/13  16:39:25  davidt
Removed foldl and foldr functions (use reducel and reducer
instead, they are much faster).

Revision 1.13  1992/06/25  08:58:48  davida
Added filter_outp - it's more elegant and efficient
than filterp (not o P).

Revision 1.12  1992/04/16  12:12:28  jont
Added subset function

Revision 1.11  1992/02/03  12:28:26  clive
Added a new version of assoc

Revision 1.10  1991/11/21  17:04:33  jont
Added copyright message

Revision 1.9  91/11/19  12:40:56  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.8  91/10/09  10:54:50  davidt

Put in the functions unzip, iterate, filter_length and
number_with_size

Revision 1.7  91/10/08  10:56:47  jont
Added number_from and number_from_by_one

Revision 1.6  91/09/30  11:41:02  richard
Added list printing function.

Revision 1.6  91/09/30  10:37:23  richard
Added list print function.

Revision 1.5  91/09/20  16:40:43  davida
Added qsort

Revision 1.4  91/09/17  13:49:06  richard
Added findp function.

Revision 1.3  91/09/05  11:51:33  davida
Added new functions, improved length

Revision 1.2.1.1  91/11/19  11:13:40  jont
Added comments for DRA on functions

Revision 1.2  91/06/13  19:38:00  jont
Added zip function for joining two lists of equal length
Also exception Tl for tl([])

Revision 1.1  91/06/07  15:58:58  colin
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

(* A few well-known basic (but non-pervasive) functions connected with
lists. *)

signature LISTS =
  sig
    exception Assoc
    exception Find
    exception Nth
    exception Last

    exception Hd and Tl
    val hd : 'a list -> 'a
    val tl : 'a list -> 'a list
    val length : 'a list -> int

    val last   : 'a list -> 'a

    val rev_append : 'a list * 'a list -> 'a list

    val member : (''a * ''a list) -> bool
    val difference : (''a list * ''a list) -> ''a list
    val sublist : (''a list * ''a list) -> bool

    val adjoin : (''a * ''a list) -> ''a list
    val filter : ''a list -> ''a list
    val rev_remove_dups : ''a list -> ''a list
    

    exception Zip
    val zip   : 'a list * 'b list -> ('a * 'b) list
    val unzip : ('a * 'b) list -> 'a list * 'b list

    val nth       : (int * 'a list) -> 'a
    val nthtail   : (int * 'a list) -> 'a list

    val find      : (''a * ''a list) -> int
    val findp	  : ('a -> bool) -> 'a list -> 'a
    val filterp   : ('a -> bool) -> 'a list -> 'a list
    val filter_outp   : ('a -> bool) -> 'a list -> 'a list
    val filter_length : ('a -> bool) -> 'a list -> int
    val partition : ('a -> bool) -> 'a list -> ('a list * 'a list)
    val number_from :
      'a list * int * int * (int -> 'b) -> ('a * 'b) list * int
    val number_from_by_one :
      'a list * int * (int -> 'b) -> ('a * 'b) list * int
    val forall : ('a -> bool) -> 'a list -> bool
    val exists : ('a -> bool) -> 'a list -> bool
    val assoc  : ''a * (''a * 'b) list -> 'b
    val assoc_returning_others : ''a * (''a * 'b) list -> (''a * 'b) list * 'b
    val reducel : ('a * 'b -> 'a) -> ('a * 'b list) -> 'a
    val reducer : ('a * 'b -> 'b) -> ('a list * 'b) -> 'b
    val findOption : ('a -> 'b option) -> 'a list -> 'b option
    val iterate : ('a -> 'b) -> 'a list -> unit
    val qsort   : ('a * 'a -> bool) -> 'a list -> 'a list  (* unstable! *)
    val msort   : ('a * 'a -> bool) -> 'a list -> 'a list  (* stable! *)
    val check_order : ('a * 'a -> bool) -> 'a list -> bool

    val to_string : ('a -> string) -> 'a list -> string
  end;



             
