(*  ==== INITIAL BASIS : TEXT_STREAM_IO ====
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
 *  $Log: text_stream_io.sml,v $
 *  Revision 1.3  1999/02/02 15:58:50  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.2  1998/02/19  14:30:30  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.1  1997/02/26  16:33:18  andreww
 *  new unit
 *  [Bug #1759]
 *  new sig.
 *
 *
 *
 *)

require "stream_io.sml";
require "__char";
require "__char_vector";
require "__text_prim_io";
require "__substring";

signature TEXT_STREAM_IO =
  sig

    include STREAM_IO

    val inputLine : instream -> (string * instream) option

    val outputSubstr : (outstream * Substring.substring) -> unit

  end
  where type vector = CharVector.vector
  where type elem = Char.char
  where type reader = TextPrimIO.reader
  where type writer = TextPrimIO.writer
  where type pos = TextPrimIO.pos
