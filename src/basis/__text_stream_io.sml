(*  ==== INITIAL BASIS : TextStreamIO structure ====
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
 *  $Log: __text_stream_io.sml,v $
 *  Revision 1.2  1999/02/02 15:58:25  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/02/26  16:34:25  andreww
 *  new unit
 *  [Bug #1759]
 *  __stream_io.sml --> __{bin,text}_stream_io.sml
 *
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
 *)

require "text_stream_io";
require "_stream_io";
require "__char_vector";
require "__char_array";
require "__char";
require "__substring";
require "__text_prim_io";
require "__list";

structure TextStreamIO: TEXT_STREAM_IO =
struct
  local
    structure S = StreamIO(structure PrimIO = TextPrimIO
                           structure Vector = CharVector
                           structure Array = CharArray
                           val someElem = Char.chr 0);
  in

    fun inputLine (f: S.instream) =
      let
	  fun some (acc, g) = SOME (implode (List.revAppend (acc, [#"\n"])), g)
	  fun loop (g, acc) =
	    case S.input1 g of
		SOME(c, g') =>
		if c = Char.chr 10 then some (acc, g')
		else loop (g', c :: acc)
              | NONE => case acc of
			    [] => NONE
			  | _ => some (acc, g)
      in loop (f, []) end

     fun outputSubstr(f:S.outstream, ss:Substring.substring) =
       S.output(f,Substring.string ss)


     open S
  end

end

  



