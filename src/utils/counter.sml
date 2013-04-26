(* counter.sml the signature *)
(*
$Log: counter.sml,v $
Revision 1.5  1992/01/29 11:13:16  clive
Added code to compute the next value that a counter would take given
its existing value

Revision 1.4  1992/01/28  12:30:40  clive
Added a previous counter value function

Revision 1.3  1991/11/21  17:03:31  jont
Added copyright message

Revision 1.2  91/11/19  12:20:37  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:37  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  15:58:05  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* This module is an integer counter. counter () returns the current
value and increments it. reset_counter sets it to any value, and
read_counter returns the current value without incrementing. A new
instance of this module is required for each counter. *)

signature COUNTER =
    sig
	val counter : unit -> int
        val previous_count : int -> int
        val next_count : int -> int
	val reset_counter : int -> unit
	val read_counter : unit -> int
    end;
