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
Result: OK

 *
 * This should just print a barrage of trues
 *
 * Revision Log
 * ------------
 *
 * $Log: words.sml,v $
 * Revision 1.10  1998/02/18 11:56:02  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.9  1997/11/21  10:51:53  daveb
 *  [Bug #30323]
 *
 *  Revision 1.8  1997/08/05  10:01:47  brucem
 *  [Bug #30004]
 *  Remove references to General.valOf.
 *
 *  Revision 1.7  1997/05/27  13:27:18  jkbrook
 *  [Bug #1749]
 *  Use separate file __large_int for synonym structure LargeInt
 *
 *  Revision 1.6  1996/10/22  13:23:53  jont
 *  Remove references to toplevel
 *
 *  Revision 1.5  1996/06/04  19:51:27  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.4  1996/05/23  11:41:37  matthew
 *  Some problem with using File.loadSource
 *
 *  Revision 1.3  1996/05/21  16:04:18  matthew
 *  Updating
 *
 *  Revision 1.2  1996/05/20  10:08:51  jont
 *  maxint becomes maxInt
 *
 *  Revision 1.1  1996/05/13  13:49:42  matthew
 *  new unit
 *  Tests for word operations
 *
 *
 *)


(* Tests for 30-bit words *)

local 
open Word
val max : word = 0wx3fffffff
val maxstring = "3FFFFFFF"
val ones = "FFFFFFFF"
val t1 = wordSize = 30
in
val t2 = fromLargeWord (toLargeWord 0w0) = 0w0
val t3 = fromLargeWord (toLargeWord max) = max
val t4 = Word32.+ (toLargeWordX max,0w1) = 0w0
val t5 = (ignore(toLargeInt max); true) handle Overflow => false
val t6 = (ignore(toInt max); false) handle Overflow => true
val t7 = toLargeIntX max = ~1
val t8 = fromLargeInt (valOf LargeInt.maxInt) = max

val t9 = map (fn (a,b) => a (0w0,max) = b)
  [(orb,max),
   (xorb,max),
   (andb,0w0)]

val t10 = 0w0 = notb max

val t11 = max = ~>> (<< (0w1,0w29),0w29)
val t12 = 0w1 = >> (<< (0w1,0w29),0w29)
val t13 = 0w0 = >> (<< (0w1,0w30),0w30)
val t14 = max - 0w1 = max + max
val t15 = compare (0w0,max) = LESS
val t16 = 0w0 < max andalso max > 0w0 andalso 0w0 < 0w255

val t17 = fmt StringCvt.HEX max = maxstring
val t18 = fmt StringCvt.HEX 0w0 = "0"
val t19 = fmt StringCvt.DEC 0w0 = "0"
val t20 = valOf (fromString maxstring) = max
val t21 = (ignore(valOf (fromString ones) = max); false) handle Overflow => true
end;

(* 32 bits *)
local 
open Word32
val max : word = 0wxffffffff
val maxstring = "FFFFFFFF"
val ones = "FFFFFFFF"
in
val t1 = wordSize = 32
val t2 = fromLargeWord (toLargeWord 0w0) = 0w0
val t3 = fromLargeWord (toLargeWord max) = max
val t4 = Word32.+ (toLargeWordX max,0w1) = 0w0
val t5 = (ignore(toLargeInt max); false) handle Overflow => true
val t6 = (ignore(toInt max); false) handle Overflow => true
val t7 = toLargeIntX max = ~1

val t9 = map (fn (a,b) => a (0w0,max) = b)
  [(orb,max),
   (xorb,max),
   (andb,0w0)]

val t11 = max = ~>> (<< (0w1,0w31),0w31)
val t12 = 0w1 = >> (<< (0w1,0w31),0w31)
val t13 = 0w0 = >> (<< (0w1,0w32),0w32)
val t14 = max - 0w1 = max + max
val t15 = compare (0w0,max) = LESS
val t16 = 0w0 < max andalso max > 0w0 andalso 0w0 < 0w255

val t17 = fmt StringCvt.HEX max = maxstring
val t18 = fmt StringCvt.HEX 0w0 = "0"
val t19 = fmt StringCvt.DEC 0w0 = "0"
val t20 = valOf (fromString maxstring) = max
val t21 = valOf (fromString ones) = max
end;

(* 8 bit words *)
local 
open Word8
val max : word = 0wxff
val maxstring = "FF"
val ones = "FFFFFFFF"
val wwsize = Word.fromInt (wordSize)
in
val t1 = wordSize = 8
val t2 = fromLargeWord (toLargeWord 0w0) = 0w0
val t3 = fromLargeWord (toLargeWord max) = max
val t4 = Word32.+ (toLargeWordX max,0w1) = 0w0
val t5 = (ignore(toLargeInt max); true) handle Overflow => false
val t6 = toInt max = 255
val t7 = toLargeIntX max = ~1
val t8 = fromLargeInt (valOf LargeInt.maxInt) = max

val t9 = map (fn (a,b) => a (0w0,max) = b)
  [(orb,max),
   (xorb,max),
   (andb,0w0)]

val t10 = 0w0 = notb max

val t11 = max = ~>> (<< (0w1,Word.- (wwsize,0w1)),Word.- (wwsize,0w1))
val t12 = 0w1 = >> (<< (0w1,Word.- (wwsize,0w1)),Word.- (wwsize,0w1))
val t13 = 0w0 = >> (<< (0w1,wwsize),wwsize)
val t14 = max - 0w1 = max + max
val t15 = compare (0w0,max) = LESS
val t16 = 0w0 < max andalso max > 0w0 andalso 0w0 < 0w255

val t17 = fmt StringCvt.HEX max = maxstring
val t18 = fmt StringCvt.HEX 0w0 = "0"
val t19 = fmt StringCvt.DEC 0w0 = "0"
val t20 = valOf (fromString maxstring) = max
val t21 = (ignore(valOf (fromString ones) = max); false) handle Overflow => true
end;

