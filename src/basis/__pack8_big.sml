(*  ==== INITIAL BASIS :  PACK WORD 8 (BIG) ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
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
