(*  ==== PERVASIVE BITS SIGNATURE ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: bits.sml,v $
 *  Revision 1.1  1992/08/25 08:09:51  richard
 *  Initial revision
 *
 *)

signature BITS =
  sig
    val andb    : int * int -> int
    val orb     : int * int -> int
    val xorb    : int * int -> int
    val lshift  : int * int -> int
    val rshift  : int * int -> int
    val arshift : int * int -> int
    val notb    : int -> int
  end;
