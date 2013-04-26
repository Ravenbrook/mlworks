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

Copyright (c) 1991 Harlequin Ltd.
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
