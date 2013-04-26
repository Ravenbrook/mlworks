(*  ==== INITIAL BASIS : WORD 16 ARRAY ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Word 16 arrays are instances of generic MonoArrays
 *
 *  Revision Log
 *  ------------
 *  $Log: __word16_array.sml,v $
 *  Revision 1.1  1997/01/15 11:42:16  io
 *  new unit
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.3  1996/05/21  11:18:14  matthew
 * Array and Vector changes
 *
 * Revision 1.2  1996/05/15  13:14:09  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:36:01  jont
 * new unit
 *
 * Revision 1.1  1995/03/22  20:18:19  brianm
 * new unit
 * New file.
 *
 *
 *)

require "_mono_array";

structure Word16Array = MonoArray (type elem = MLWorks.Internal.Types.word16)
