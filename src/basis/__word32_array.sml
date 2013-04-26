(*  ==== INITIAL BASIS : WORD 32 ARRAY ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Word 32 arrays are instances of generic MonoArrays
 *
 *  Revision Log
 *  ------------
 *  $Log: __word32_array.sml,v $
 *  Revision 1.1  1997/01/15 11:42:16  io
 *  new unit
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.3  1996/05/21  11:20:37  matthew
 * Array and vector changes
 *
 * Revision 1.2  1996/05/15  13:15:40  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:36:28  jont
 * new unit
 *
 *  Revision 1.1  1995/03/22  20:20:53  brianm
 *  new unit
 *  New file.
 *
 *
 *)


require "_mono_array";

structure Word32Array = MonoArray (type elem = MLWorks.Internal.Types.word32);
