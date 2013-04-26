(*  ==== INITIAL BASIS :  PACK WORD 8 (BIG) ====
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
 *  Implementation
 *  --------------
 * Immediate implementation in terms of Word8 vectors and arrays
 * (i.e. MLWorks bytearrays).
 *
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __pack8_big.sml,v $
 *  Revision 1.2  1999/02/02 15:57:57  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/01/15  11:50:11  io
 *  new unit
 *  [Bug #1892]
 *  rename __pack{8,16,32}{big,little} to __pack{8,16,32}_{big,little}
 *
 * Revision 1.3  1996/05/17  12:41:09  jont
 * Revise to latest signature
 *
 * Revision 1.2  1996/05/15  13:44:09  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:32:38  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  16:11:38  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.1  1995/03/22  20:17:00  brianm
 *  new unit
 *  New file.
 *
 *)

require "__word8";
require "__word8_vector";
require "__word8_array";
require "pack_word";

structure Pack8Big : PACK_WORD =
   struct
     val bytesPerElem : int = 1
     val isBigEndian : bool = true

     val subVec = Word8.toLargeWord o Word8Vector.sub
     val subArr = Word8.toLargeWord o Word8Array.sub
     val subVecX = Word8.toLargeWordX o Word8Vector.sub
     val subArrX = Word8.toLargeWordX o Word8Array.sub
     fun update(array, i, word) =
       Word8Array.update(array, i, Word8.fromLargeWord word)
   end;
