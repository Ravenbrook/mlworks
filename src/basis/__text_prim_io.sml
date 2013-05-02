(*  ==== INITIAL BASIS : unixtextbinio structures ====
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
 *  $Log: __text_prim_io.sml,v $
 *  Revision 1.6  1999/02/02 15:58:23  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.5  1998/02/19  14:28:23  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.4  1996/11/16  01:53:15  io
 *  [Bug #1757]
 *  renamed __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.3  1996/07/17  17:24:57  andreww
 *  [Bug #1453]
 *  Bringing up to date wrt May 30 edition of revised basis
 *
 *  Revision 1.2  1996/06/05  14:18:18  andreww
 *  pruning requirements.
 *
 *  Revision 1.1  1996/05/30  16:03:54  andreww
 *  new unit
 *  Revised basis TextPrimIO structure.
 *
 *
 *)

require "__char_vector";
require "__char_array";
require "__char";
require "prim_io";
require "_prim_io";
require "__position";

structure TextPrimIO : PRIM_IO
                       where type array = CharArray.array
		       where type vector = CharVector.vector
		       where type elem = Char.char

                    =  PrimIO (structure A = CharArray
                               structure V = CharVector
                               val someElem = Char.chr 0
                               type pos = Position.int
                               val compare =
                                 fn (x,y) =>
                                 if Position.<(x,y) then LESS
                                 else if x=y then EQUAL
                                      else GREATER)






