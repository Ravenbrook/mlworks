(*  ==== INITIAL BASIS : BinStreamIO structure ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __bin_stream_io.sml,v $
 *  Revision 1.2  1999/02/02 15:57:02  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/02/26  16:34:57  andreww
 *  new unit
 *  [Bug #1759]
 *  __stream_io.sml --> __{bin,text}_stream_io.sml
 *
 *  Revision 1.5  1997/01/15  12:04:07  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/11/16  01:57:11  io
 *  [Bug #1757]
 *  renamed __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.3  1996/07/18  14:54:43  andreww
 *  [Bug #1453]
 *  Bringing up to date with naming conventions.
 *  (of filenames of modules).
 *
 *  Revision 1.2  1996/06/03  10:12:56  andreww
 *  altering require constraints.
 *
 *  Revision 1.1  1996/05/30  13:53:49  andreww
 *  new unit
 *  TextStreamIO and BinStreamIO structures.
 *
 *
 *)

require "_stream_io";
require "__word8_vector";
require "__word8_array";
require "__word8";
require "__bin_prim_io";


structure BinStreamIO = 
	     StreamIO(structure PrimIO = BinPrimIO
		      structure Vector = Word8Vector
		      structure Array = Word8Array
		      val someElem = 0w0: Word8.word)

