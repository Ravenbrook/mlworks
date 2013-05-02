(*  ==== INITIAL BASIS : WORDS  ====
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
 *  Revision Log
 *  ------------
 *  $Log: __word8.sml,v $
 *  Revision 1.4  1996/10/03 15:07:04  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 * Revision 1.3  1996/05/21  09:31:15  matthew
 * Changed type of shift amount
 *
 * Revision 1.2  1996/05/08  16:23:12  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:37:05  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  14:25:05  daveb
 *  Updated to use overloaded built-in type.
 *
 *  Revision 1.1  1995/03/22  20:21:44  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "word";
require "__word";

structure Word8: WORD =
struct
  type word = MLWorks.Internal.Types.word8

  val wordSize = 8
  val wwordSize = 0w8 : Word.word

  val cast = MLWorks.Internal.Value.cast

  (* Here be magic numbers *)
  fun toWord (w : word) : Word.word = cast w
  fun castFromWord (w: Word.word): word = cast w
  fun maskFromWord (w: Word.word): word =
    cast (Word.andb (cast 0xff, w))
  fun checkFromWord (w:Word.word) : word =
    if w < 0w100 then castFromWord w
    else raise Overflow

  val maxW = (Word.<< (0w1,0w8) - 0w1)
  fun extend (w : word) : Word.word =
    Word.~>> (Word.<< (toWord w,0w22),0w22)
    
  fun toInt w = Word.toInt (toWord w)
  fun toIntX w = Word.toIntX (extend w)

  fun fromInt x = maskFromWord (Word.fromInt x)
  fun toLargeWord x = Word.toLargeWord (toWord x)
  fun toLargeInt x = Word.toLargeInt (toWord x)
  fun toLargeWordX x = Word.toLargeWordX (extend x)
  fun toLargeIntX x = Word.toLargeIntX (extend x)
  fun fromLargeWord x = maskFromWord (Word.fromLargeWord x)
  fun fromLargeInt x = maskFromWord (Word.fromLargeInt x)

  val orb = cast Word.orb : word * word -> word
  val xorb = cast Word.xorb : word * word -> word
  val andb = cast Word.andb : word * word -> word

  fun notb (w: word) = maskFromWord (Word.notb (toWord w))

  fun << (w, n) = maskFromWord (Word.<< (toWord w, n))

  fun >> (w, n) = maskFromWord (Word.>> (toWord w, n))

  fun ~>> (w, n) =
    if n >= wwordSize then
      if w >= 0wx80 then 0wxFF else 0w0
    else
      let
        val w' = Word.<< (toWord w, 0w22)
      in
        maskFromWord (Word.~>> (w', Word.+ (n, 0w22)))
      end

  fun toString w = Word.toString (toWord w)
  fun fmt radix w = Word.fmt radix (toWord w)

  fun fromString s = 
    case Word.fromString s of
      SOME w => if w < 0wx100 then SOME (castFromWord w) else raise Overflow
    | _ => NONE
  fun scan radix getc src =
    case Word.scan radix getc src of
      SOME (w,src') => if w < 0wx100 then SOME (castFromWord w,src')
                       else raise Overflow
    | _ => NONE

  val op+ = op+ : word * word -> word
  val op- = op- : word * word -> word
  val op* = op* : word * word -> word
  val op div = op div : word * word -> word
  val op mod = op mod : word * word -> word
  val op < = op < : word * word -> bool
  val op > = op > : word * word -> bool
  val op <= = op <= : word * word -> bool
  val op >= = op >= : word * word -> bool

  fun compare (w1,w2) =
    if w1 < w2 then LESS
    else if w1 = w2 then EQUAL
    else GREATER

  fun max (a : word, b) = if a > b then a else b
  fun min (a : word, b) = if a < b then a else b

end;

