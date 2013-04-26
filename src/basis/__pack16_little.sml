(*  ==== INITIAL BASIS :  PACK WORD 16 (LITTLE) ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __pack16_little.sml,v $
 *  Revision 1.2  1999/02/02 15:57:50  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/01/15  11:49:19  io
 *  new unit
 *  [Bug #1892]
 *  rename __pack{8,16,32}{big,little} to __pack{8,16,32}_{big,little}
 *
 * Revision 1.2  1996/05/15  13:35:30  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:31:02  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  10:03:47  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.1  1995/03/22  20:14:53  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "pack_word";
require "_pack_words_little";
require "__word16";

structure Pack16Little : PACK_WORD =
   PackWordsLittle(
     structure Word = Word16
);
