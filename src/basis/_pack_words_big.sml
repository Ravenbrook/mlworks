(*  ==== INITIAL BASIS :  PACK WORDS (BIG) ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: _pack_words_big.sml,v $
 *  Revision 1.5  1999/02/02 15:58:26  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.4  1997/05/16  15:41:47  jont
 *  [Bug #30090]
 *  Translate output std_out to print
 *
 *  Revision 1.3  1997/01/23  13:39:02  io
 *  new unit
 *  rename _pack_word_{big,little} to _pack_words_{big,little}
 *         __pack{8,16,32}{big,little} to __pack{8,16,32}_{big,little}
 *
 *  Revision 1.3  1996/11/06  10:48:00  matthew
 *  Renamed __integer to __int
 *
 *  Revision 1.2  1996/05/17  14:24:20  jont
 *  Revise to latest signature
 *
 *  Revision 1.1  1996/05/15  13:32:46  jont
 *  new unit
 *
 * Revision 1.2  1996/04/29  15:40:00  matthew
 * Removed MLWorks.Integer
 *
 * Revision 1.1  1996/04/18  11:38:22  jont
 * new unit
 *
 *  Revision 1.3  1996/03/20  14:55:00  matthew
 *  Changes for new language definition
 *
 *  Revision 1.2  1995/09/12  11:48:18  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.1  1995/03/22  20:24:17  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "__int";
require "__word8_vector";
require "__word8_array";
require "pack_word";
require "word";


functor PackWordsBig(
  structure Word : WORD
) : PACK_WORD =
   struct

     val wordSize = Word.wordSize

     val wordTag = " word" ^ Int.toString(wordSize)

     val MLWenvironment  = MLWorks.Internal.Runtime.environment;

     fun env s = MLWenvironment(s ^ wordTag);

     val bytesPerElem : int = (wordSize div 8)

     val isBigEndian : bool = true

     val subVec  : (Word8Vector.vector * int) -> Word.word      = env "subV"
     val subArr  : (Word8Array.array * int) -> Word.word        = env "subA"
     val update  : (Word8Array.array * int * Word.word) -> unit = env "update"

     val subVecX = Word.toLargeWordX o subVec
     val subVec = Word.toLargeWord o subVec
     val subArrX = Word.toLargeWordX o subArr
     val subArr = Word.toLargeWord o subArr
     val update =
       fn (array, i, word) => update(array, i, Word.fromLargeWord word)
   end
