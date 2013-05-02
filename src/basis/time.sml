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
