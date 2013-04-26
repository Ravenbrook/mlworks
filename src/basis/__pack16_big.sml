(*  ==== INITIAL BASIS :  PACK WORD 16 (BIG) ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __pack16_big.sml,v $
 *  Revision 1.2  1999/02/02 15:57:48  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/01/15  11:49:11  io
 *  new unit
 *  [Bug #1892]
 *  rename __pack{8,16,32}{big,little} to __pack{8,16,32}_{big,little}
 *
 * Revision 1.2  1996/05/15  13:35:08  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:30:55  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  10:03:43  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.1  1995/03/22  20:12:52  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "pack_word";
require "_pack_words_big";
require "__word16";

structure Pack16Big : PACK_WORD =
   PackWordsBig(
     structure Word = Word16
);
