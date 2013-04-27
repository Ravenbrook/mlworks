(*  ==== INITIAL BASIS : INTEGER ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: integer.sml,v $
 *  Revision 1.9  1999/02/17 14:42:07  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.8  1997/05/01  16:35:22  jont
 * [Bug #30096]
 * Change type of precision
 *
 * Revision 1.7  1997/01/14  17:47:15  io
 * [Bug #1757]
 * rename __pre{integer,int32} to __pre_int{,32}
 *
 * Revision 1.6  1996/10/03  15:21:42  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.5  1996/06/04  15:38:42  io
 * stringcvt -> string_cvt
 *
 * Revision 1.4  1996/05/17  11:04:46  jont
 * Update to latest signature
 *
 * Revision 1.3  1996/05/07  15:33:27  matthew
 * Adding fmt and scan
 *
 * Revision 1.2  1996/04/30  12:57:14  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:43:02  jont
 * new unit
 *
 *  Revision 1.3  1995/09/15  11:29:53  daveb
 *  Added makestring, removed require of prereal.
 *
 *  Revision 1.1  1995/04/13  13:56:49  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "__pre_int";
require "__pre_int32";
require "__string_cvt";

signature INTEGER =
  sig
    eqtype int

    val toLarge : int -> PreLargeInt.int
    val fromLarge : PreLargeInt.int -> int

    val toInt : int -> PreInt.int
    val fromInt : PreInt.int -> int

    val precision : PreInt.int option
    val minInt : int option
    val maxInt : int option

    val ~ : int -> int
    val * : int * int -> int
    val div : int * int -> int
    val mod : int * int -> int
    val quot : int * int -> int
    val rem : int * int -> int
    val + : int * int -> int
    val - : int * int -> int

    val compare : (int * int) -> order

    val > : int * int -> bool
    val >= : int * int -> bool
    val < : int * int -> bool
    val <= : int * int -> bool
    val abs : int -> int

    val min : int * int -> int
    val max : int * int -> int
    val sign : int -> PreInt.int
    val sameSign : int * int -> bool

    val fmt : StringCvt.radix -> int -> string

    val toString : int -> string

    val fromString : string -> int option

    val scan : StringCvt.radix -> (char, 'a) StringCvt.reader -> 'a -> (int * 'a) option
  end;


