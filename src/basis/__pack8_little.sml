(*  ==== INITIAL BASIS :  PACK WORD 8 (LITTLE) ====
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
 *  $Log: __pack8_little.sml,v $
 *  Revision 1.2  1999/02/02 15:58:00  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/01/15  11:50:17  io
 *  new unit
 *  [Bug #1892]
 *  rename __pack{8,16,32}{big,little} to __pack{8,16,32}_{big,little}
 *
 * Revision 1.4  1996/10/09  13:57:36  jont
 * Change structure name to be Pack8Little
 *
 * Revision 1.3  1996/05/17  12:41:33  jont
 * Revise to latest signature
 *
 * Revision 1.2  1996/05/15  13:44:21  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:32:46  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  16:11:45  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.1  1995/03/22  20:17:28  brianm
 *  new unit
 *  New file.
 *
 *)

require "__word8";
require "__word8_vector";
require "__word8_array";
require "pack_word";

structure Pack8Little : PACK_WORD =
   struct
     val bytesPerElem : int = 1
     val isBigEndian : bool = false

     val subVec = Word8.toLargeWord o Word8Vector.sub
     val subArr = Word8.toLargeWord o Word8Array.sub
     val subVecX = Word8.toLargeWordX o Word8Vector.sub
     val subArrX = Word8.toLargeWordX o Word8Array.sub
     fun update(array, i, word) =
       Word8Array.update(array, i, Word8.fromLargeWord word)
   end;
