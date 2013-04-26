(* 
 * Unsigned words.
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * $Log: word.sml,v $
 * Revision 1.8  1999/02/17 14:42:33  mitchell
 * [Bug #190507]
 * Modify to satisfy CM constraints.
 *
 * Revision 1.7  1997/05/27  13:15:18  jkbrook
 * [Bug #01749]
 * Changed to use __large_int for synonym structure LargeInt
 *
 * Revision 1.6  1997/01/14  17:49:01  io
 * [Bug #1757]
 * rename __preword{,32} to __pre_word{,32}
 *        __pre{integer,int32} to __pre_int{,32}
 *
 * Revision 1.5  1996/10/03  15:28:18  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.4  1996/06/04  15:59:42  io
 * stringcvt -> string_cvt
 *
 * Revision 1.3  1996/05/20  09:54:37  matthew
 * Wrong type for shift quantity
 *
 * Revision 1.2  1996/05/08  14:41:27  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:47:26  jont
 * new unit
 *
 * Revision 1.3  1996/03/28  12:00:44  matthew
 * Fixing rigid type sharing problem
 *
 * Revision 1.2  1995/09/14  13:34:15  daveb
 * Added some rather crucial sharing constraints.
 *
 * Revision 1.1  1995/09/13  14:03:07  daveb
 * new unit
 * New version of word signature.
 *
 *
 *)

require "__pre_word32";
require "__pre_word";
require "__large_int";
require "__pre_int";
require "__string_cvt";

signature WORD = 
  sig
    eqtype word

    val wordSize : int

    val toLargeWord : word -> PreLargeWord.word
    val toLargeWordX : word -> PreLargeWord.word
    val fromLargeWord : PreLargeWord.word -> word

    val toLargeInt : word -> LargeInt.int
    val toLargeIntX : word -> LargeInt.int
    val fromLargeInt : LargeInt.int -> word

    val toInt : word -> PreInt.int
    val toIntX : word -> PreInt.int
    val fromInt : PreInt.int -> word

    val orb  : word * word -> word
    val xorb : word * word -> word
    val andb : word * word -> word
    val notb : word -> word

    val <<  : word * PreWord.word -> word
    val >>  : word * PreWord.word -> word
    val ~>> : word * PreWord.word -> word

    val + : word * word -> word
    val - : word * word -> word
    val * : word * word -> word
    val div : word * word -> word
    val mod : word * word -> word

    val compare : word * word -> order

    val >  : word * word -> bool
    val >= : word * word -> bool
    val <  : word * word -> bool
    val <= : word * word -> bool

    val min : word * word -> word
    val max : word * word -> word

    val fmt : StringCvt.radix -> word -> string
    val toString : word -> string
    val fromString : string -> word option
    val scan : StringCvt.radix -> (char, 'a) StringCvt.reader -> 'a -> (word * 'a) option
  end
