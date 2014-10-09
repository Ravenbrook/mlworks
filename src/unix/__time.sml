(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Unix implementation of basis Time structure.
 *
 * Any alterations to this file should be done in sync. with alterations
 * to rts/src/Unix/basis_time.c
 *
 * Revision Log
 * ------------
 *
 * $Log: __time.sml,v $
 * Revision 1.9  1998/10/02 14:22:22  jont
 * [Bug #30487]
 * Modify functions using seconds and fractions of seconds
 * to use LargeInt.int
 *
 *  Revision 1.8  1997/11/08  18:24:41  jont
 *  [Bug #30089]
 *  Replace time with MLWorks.Internal.Types.time
 *
 *  Revision 1.7  1996/11/06  11:31:32  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.6  1996/10/02  08:32:25  stephenb
 *  Fix Time.> -- should have done this at the same time as Time.<
 *
 *  Revision 1.5  1996/10/01  12:36:55  stephenb
 *  [Bug #1627]
 *  Fix broken Time.<
 *
 *  Revision 1.4  1996/06/04  16:08:15  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.3  1996/05/29  10:23:30  stephenb
 *  Implement fmt, toString, fromString and scan.
 *
 *  Revision 1.2  1996/05/23  14:21:25  stephenb
 *  Bring the signature up to date with the latest basis revision.
 *
 *  Revision 1.1  1996/05/07  14:11:10  stephenb
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
    val timeRef = (env "Time.Time"):exn ref
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


    fun compare (TIME (aHi, aLo, aSec), TIME (bHi, bLo, bSec)) =
      if aHi < bHi then
        LESS
      else if aHi > bHi then
        GREATER
      else if aLo < bLo then
        LESS
      else if aLo > bLo then
        GREATER
      else if aSec < bSec then
        LESS
      else if aSec > bSec then
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


    fun leq  (TIME (aHi, aLo, aSec), TIME (bHi, bLo, bSec)) =
      if aHi < bHi then
        true
      else if aHi > bHi then
        false
      else if aLo < bLo then
        true
      else if aLo > bLo then
        false
      else
        aSec <= bSec


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
