(* Copyright (C) 1995 Harlequin Ltd.
 *
 * Revision Log
 * ------------
 *
 *  $Log: time.sml,v $
 *  Revision 1.7  1998/10/02 14:21:51  jont
 *  [Bug #30487]
 *  Modify functions converting to and from seconds/parts of seconds
 *  to use LargeInt.int instead of int
 *
 * Revision 1.6  1996/10/03  15:27:19  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.5  1996/06/04  16:01:16  io
 * stringcvt -> string_cvt
 *
 * Revision 1.4  1996/05/29  09:40:53  stephenb
 * Fix the scan signature so that it matches that defined
 * in the basis document.
 *
 * Revision 1.3  1996/05/23  14:27:15  stephenb
 * Bring the signature up to date with the latest basis revision.
 *
 * Revision 1.2  1996/05/07  14:10:30  stephenb
 * Update wrt latest basis definition.
 *
 * Revision 1.1  1996/04/18  11:46:16  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  14:14:15  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "__string_cvt";
require "__large_int";
require "__large_real";

signature TIME =
  sig
    eqtype time

    exception Time

    val zeroTime : time

    val fromReal: LargeReal.real -> time

    val toReal : time -> LargeReal.real

    val toSeconds : time -> LargeInt.int

    val toMilliseconds : time -> LargeInt.int

    val toMicroseconds : time -> LargeInt.int

    val fromSeconds : LargeInt.int -> time

    val fromMilliseconds : LargeInt.int -> time

    val fromMicroseconds : LargeInt.int -> time

    val compare : (time * time) -> order

    val + : time * time -> time
    val - : time * time -> time
    val < : time * time -> bool
    val <= : time * time -> bool
    val > : time * time -> bool
    val >= : time * time -> bool

    val now : unit -> time

    val fmt : int -> time -> string

    val toString : time -> string

    val fromString : string -> time option

    val scan : (char, 'a) StringCvt.reader -> 'a -> (time * 'a) option

  end
