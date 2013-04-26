(*  ==== INITIAL BASIS : WORD 32 VECTOR ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Word 32 vectors are instances of generic MonoVectors.
 *
 *  Revision Log
 *  ------------
 *  $Log: __word32_vector.sml,v $
 *  Revision 1.1  1997/01/15 11:42:16  io
 *  new unit
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.3  1996/05/21  11:20:01  matthew
 * Simplifying
 * ,
 *
 * Revision 1.2  1996/05/15  13:15:58  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:36:40  jont
 * new unit
 *
 *  Revision 1.2  1995/09/12  10:16:45  daveb
 *  words.sml replaced with word.sml.
 *
 *  Revision 1.1  1995/03/22  20:21:18  brianm
 *  new unit
 *  New file.
 *
 *)


require "_mono_vector";

structure Word32Vector = MonoVector(type elem = MLWorks.Internal.Types.word32);
   
