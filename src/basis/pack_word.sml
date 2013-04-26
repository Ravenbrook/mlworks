(*  ==== INITIAL BASIS :  PACK WORDS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  Packing/unpacking of words in arrays of bytes.
 *
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: pack_word.sml,v $
 *  Revision 1.4  1997/05/27 13:14:51  jkbrook
 *  [Bug #01749]
 *  Changed to use __large_word for synonym structure LargeWord
 *
 *  Revision 1.3  1997/01/15  12:06:40  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.2  1996/05/17  12:01:24  jont
 *  Revise to latest signature
 *
 *  Revision 1.1  1996/04/18  11:44:46  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:44:46  jont
 * new unit
 *
 *  Revision 1.4  1996/03/28  12:42:52  matthew
 *  New language definition
 *
 *  Revision 1.3  1995/09/12  11:48:34  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.2  1995/03/18  19:03:47  brianm
 *  Added require statements and Word structure dependency.
 *
 * Revision 1.1  1995/03/08  17:08:10  brianm
 * new unit
 * New file.
 *
 *)

require "__large_word"; 
require "__word8_vector";
require "__word8_array";

signature PACK_WORD =
   sig

     val bytesPerElem : int
     val isBigEndian : bool

     val subVec : (Word8Vector.vector * int) -> LargeWord.word
     val subVecX : (Word8Vector.vector * int) -> LargeWord.word
     val subArr : (Word8Array.array * int) -> LargeWord.word
     val subArrX : (Word8Array.array * int) -> LargeWord.word

     val update : (Word8Array.array * int * LargeWord.word) -> unit
   end
