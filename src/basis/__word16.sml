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
 *  $Log: __word16.sml,v $
 *  Revision 1.5  1996/10/03 15:06:38  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 * Revision 1.4  1996/05/20  09:57:41  matthew
 * Changed type of shift amount
 *
 * Revision 1.3  1996/05/10  10:52:12  matthew
 * Fixing blunder with last change
 *
 * Revision 1.2  1996/05/08  16:13:38  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:35:50  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  16:07:24  daveb
 *  Updated to use overloaded built-in type.
 *
 *  Revision 1.1  1995/03/22  20:17:54  brianm
 *  new unit
 *  New file.
 *
 *
 *)
require "word";
require "__word";

structure Word16: WORD =
struct
  type word = MLWorks.Internal.Types.word16
  val wordSize = 16

  val cast = MLWorks.Internal.Value.cast
  val castFromWord : Word.word -> word = cast
  fun toWord (w : word) : Word.word = cast w
  (* I suppose sometimes we know we can cast directly *)
  fun fromWord (w: Word.word): word =
    cast (Word.andb (cast 0xffff, w))
  val castFromWord : Word.word -> word = cast

  val maxW = (Word.<< (0w1,0w16) - 0w1)

  fun extend (w : word) : Word.word =
    Word.~>> (Word.<< (toWord w,0w14),0w14)
    
  fun toInt w = Word.toInt (toWord w)
  fun toIntX w = Word.toIntX (extend w)

  fun fromInt x = fromWord (Word.fromInt x)
  fun toLargeWord x = Word.toLargeWord (toWord x)
  fun toLargeInt x = Word.toLargeInt (toWord x)
  fun toLargeWordX x = Word.toLargeWordX (extend x)
  fun toLargeIntX x = Word.toLargeIntX (extend x)
  fun fromLargeWord x = fromWord (Word.fromLargeWord x)
  fun fromLargeInt x = fromWord (Word.fromLargeInt x)

  val orb = cast Word.orb : word * word -> word
  val xorb = cast Word.xorb : word * word -> word
  val andb = cast Word.andb : word * word -> word

  fun notb (w: word) = fromWord (Word.notb (toWord w))

  fun << (w, n) = fromWord (Word.<< (toWord w, n))
  fun >> (w, n) = fromWord (Word.>> (toWord w, n))
  fun ~>> (w, n) =
    let
      val w' = Word.<< (toWord w, 0w14)
    in
      fromWord (Word.~>> (w', Word.+ (n, 0w14)))
    end

  fun toString w = Word.toString (toWord w)
  fun fmt radix w = Word.fmt radix (toWord w)
  fun fromString s = 
    case Word.fromString s of
      SOME w => if w < 0wx10000 then SOME (castFromWord w) else raise Overflow
    | _ => NONE
  fun scan radix getc src =
    case Word.scan radix getc src of
      SOME (w,src') => if w < 0wx10000 then SOME (castFromWord w,src')
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

  fun max (a,b) = if a > b then a else b
  fun min (a,b) = if a < b then a else b

end;

