(*  ==== INITIAL BASIS : WORD 16 VECTOR ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Word 16 vectors are instances of generic MonoVectors
 *
 *  Revision Log
 *  ------------
 *  $Log: __word16_vector.sml,v $
 *  Revision 1.1  1997/01/15 11:42:16  io
 *  new unit
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.3  1996/05/21  11:17:57  matthew
 * Simplifying
 *
 * Revision 1.2  1996/05/15  13:12:41  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:36:09  jont
 * new unit
 *
 * Revision 1.2  1995/09/12  10:16:37  daveb
 * words.sml replaced with word.sml.
 *
 * Revision 1.1  1995/03/22  20:18:45  brianm
 * new unit
 * New file.
 *
 *
 *)


require "_mono_vector";

structure Word16Vector = MonoVector (type elem = MLWorks.Internal.Types.word16);
