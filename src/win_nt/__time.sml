(* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Win32 implementation of basis Time structure.
 *
 * Any alterations to this file should be done in sync. with alterations
 * to rts/src/Win32/basis_time.c
 *
 * Revision Log
 * ------------
 *
 * $Log: __time.sml,v $
 * Revision 1.8  1998/10/02 14:25:18  jont
 * [Bug #30487]
 * Modify functions converting to and from seconds/parts of seconds
 * to use LargeInt.int instead of int
 *
 *  Revision 1.7  1997/11/08  18:26:18  jont
 *  [Bug #30089]
 *  Replace time with MLWorks.Internal.Types.time
 *
 *  Revision 1.6  1996/11/06  11:34:37  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.5  1996/10/02  08:32:14  stephenb
 *  Fix Time.> -- should have done this at the same time as Time.<
 *
 *  Revision 1.4  1996/10/01  12:41:24  stephenb
 *  [Bug #1627]
 *  Fix broken Time.<
 *
 *  Revision 1.3  1996/06/12  09:26:35  stephenb
 *  Implement ftm, toString, fromString and scan.
 *
 *  Revision 1.2  1996/05/23  14:20:09  stephenb
 *  Bring the signature up to date with the latest basis revision.
 *
 *  Revision 1.1  1996/05/07  14:11:35  stephenb
 *  new unit
 *
 *)

require "^.basis.__char";
require "^.basis.__int";
require "^.basis.__large_int";
require "^.basis.__real";
require "^.basis.__large_real";
require "^.basis.__string_cvt";
require "^.basis.time";

structure Time : TIME =
  struct
    val env = MLWorks.Internal.Runtime.environment

    datatype time = datatype MLWorks.Internal.Types.time

    exception Time
    val timeRef = env "Time.Time"
    val _ = timeRef := Time

    val zeroTime = TIME (0, 0, 0)

    val fromReal : LargeReal.real -> time = env "Time.fromReal"
    val toReal :   time -> LargeReal.real = env "Time.toReal"

    val toSeconds :      time -> LargeInt.int = env "Time.toSeconds"
    val toMilliseconds : time -> LargeInt.int = env "Time.toMilliseconds"
    val toMicroseconds : time -> LargeInt.int = env "Time.toMicroseconds"

    val fromSeconds :      LargeInt.int -> time = env "Time.fromSeconds"
    val fromMilliseconds : LargeInt.int -> time = env "Time.fromMilliseconds"
    val fromMicroseconds : LargeInt.int -> time = env "Time.fromMicroseconds"

    val op + : time * time -> time = env "Time.+"
    val op - : time * time -> time = env "Time.-"

    fun compare (TIME (aHi, aMid, aLo), TIME (bHi, bMid, bLo)) =
      if aHi < bHi then
        LESS
      else if aHi > bHi then
        GREATER
      else if aMid < bMid then
        LESS
      else if aMid > bMid then
        GREATER
      else if aLo < bLo then
        LESS
      else if aLo > bLo then
        GREATER
      else
        EQUAL

    (* The actual definition used should be semantically equivalent to,
     * but hopefully easier to maintain/follow than the following :-
     * 
     *   aHi < bHi
     * orelse
     *   (aHi = bHi andalso (aLo < bLo orelse (aLo = bLo andalso aSec < bSec)))
     *)

    fun lt (TIME (aHi, aLo, aSec), TIME (bHi, bLo, bSec)) =
      if aHi < bHi then
        true
      else if aHi = bHi then
        if aLo < bLo then
          true
        else if aLo = bLo then
          aSec < bSec
        else
          false
      else
        false

    fun leq  (TIME (aHi, aMid, aLo), TIME (bHi, bMid, bLo)) =
      if aHi < bHi then
        true
      else if aHi > bHi then
        false
      else if aMid < bMid then
        true
      else if aMid > bMid then
        false
      else
        aLo <= bLo

    fun gt (a, b) = lt (b, a)

    fun geq (a, b) = leq (b, a)

    val op<  = lt
    val op<= = leq
    val op>  = gt
    val op>= = geq

    val now : unit -> time = env "Time.now"

    fun fmt n = 
      let 
        val n' = Int.max (n, 0)
      in
        Real.fmt (StringCvt.FIX (SOME n')) o toReal
      end

    val toString = fmt 3

    local
      fun readInt getc src =
        let
          val (strInt, src') = StringCvt.splitl Char.isDigit getc src
        in
          case strInt of
            "" => NONE
          | _  => SOME (strInt, src')
        end

      fun fromString str src =
        case Real.fromString str of
          NONE => NONE
        | SOME r => SOME (fromReal r, src)

    in
      fun scan getc src = 
        let 
          val src' = StringCvt.skipWS getc src
        in
          case readInt getc src' of
            NONE => NONE
          | SOME (secs, src'') =>
            case getc src'' of
              NONE => fromString secs src''
            | SOME (ch, src''') =>
              if ch = #"." then
                case readInt getc src''' of
                  NONE => fromString secs src''
                | SOME (fractions, src'''') =>
                  fromString (secs ^ "." ^ fractions) src''''
              else
                fromString secs src''
        end
    end

    val fromString = StringCvt.scanString scan

  end
