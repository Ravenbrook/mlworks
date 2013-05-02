(*  ==== INITIAL BASIS : Byte structure ====
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
 *  Revision Log
 *  ------------
 *  $Log: __byte.sml,v $
 *  Revision 1.7  1997/05/27 14:21:00  matthew
 *  Changing type of pack_string
 *
 *  Revision 1.6  1997/01/15  12:03:43  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.5  1996/08/09  13:57:17  daveb
 *  [Bug #1536]
 *  [Bug #1536]
 *  Word8Vector.vector and string no longer share.
 *  Replaced implementations of stringToBytes and bytesToString by casts.
 *  Removed redundant requires.
 *
 *  Revision 1.4  1996/05/23  20:58:24  io
 *  revising
 *  ..
 *  ..
 *
 *  Revision 1.3  1996/05/17  14:26:12  matthew
 *  Vector and array changes
 *
 *  Revision 1.2  1996/05/17  09:37:37  matthew
 *  Moved Bits to MLWorks.Internal.Bits
 *
 *  Revision 1.1  1996/05/15  12:58:07  jont
 *  new unit
 *
 * Revision 1.2  1996/04/23  16:01:54  matthew
 * Defining char properly
 *
 * Revision 1.1  1996/04/18  11:23:53  jont
 * new unit
 *
 *  Revision 1.2  1995/05/10  15:01:54  daveb
 *  Type of char changed from int to Word8.word.
 *
 * Revision 1.1  1995/04/13  13:13:05  jont
 * new unit
 * No reason given
 *
 *
 *)

require "byte";
require "__word8";
require "__word8_vector";
require "__word8_array";
require "__substring";

structure Byte : BYTE =
  struct
    fun byteToChar (w:Word8.word) : char = MLWorks.Internal.Value.cast w
    fun charToByte (c:char) : Word8.word = MLWorks.Internal.Value.cast c

    fun bytesToString (v:Word8Vector.vector) : string = 
      MLWorks.Internal.Value.cast v

    fun stringToBytes (s:string) : Word8Vector.vector = 
      MLWorks.Internal.Value.cast s

    val unpackStringVec =
      bytesToString o Word8Vector.extract
	
    val unpackString =
      bytesToString o Word8Array.extract

    fun packString (a, i, ss) = 
      let
        val length = Word8Array.length a

        fun copyFrom i = 
          if i < length then
            (Word8Array.update(a, i, charToByte (Substring.sub(ss, i)));
             copyFrom (i+1))
          else
            ()
      in
        copyFrom i
      end
        
  end (* Byte *)
