(*  ==== INITIAL BASIS : BinStreamIO structure ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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

