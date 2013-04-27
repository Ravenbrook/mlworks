(*  ==== INITIAL BASIS : IMPERATIVE_IO ====
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
 *  $Log: imperative_io.sml,v $
 *  Revision 1.3  1996/10/03 15:20:26  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/07/17  15:38:09  andreww
 *  [Bug #1453]
 *  Updating to bring inline with the new basis document of May 30 '96
 *
 *  Revision 1.1  1996/05/21  09:48:06  jont
 *  new unit
 *
 *
 *)

require "stream_io";

signature IMPERATIVE_IO =
  sig

    type  vector
    type  elem

    type  instream

    type  outstream

    val input : instream -> vector

    val input1 : instream -> elem option

    val inputN : (instream * int) -> vector

    val inputAll : instream -> vector

    val canInput : (instream * int) -> bool

    val lookahead : instream -> elem option

    val closeIn : instream -> unit

    val endOfStream : instream -> bool

    val output : (outstream * vector) -> unit

    val output1 : (outstream * elem) -> unit

    val flushOut : outstream -> unit

    val closeOut : outstream -> unit

    structure StreamIO : STREAM_IO
      sharing type elem = StreamIO.elem
      sharing type vector = StreamIO.vector

    val getPosIn: instream -> StreamIO.in_pos

    val setPosIn: (instream * StreamIO.in_pos) -> unit


    val mkInstream : StreamIO.instream -> instream

    val getInstream : instream -> StreamIO.instream

    val setInstream : (instream * StreamIO.instream) -> unit

    val getPosOut : outstream -> StreamIO.out_pos

    val setPosOut : (outstream * StreamIO.out_pos) -> unit

    val mkOutstream : StreamIO.outstream -> outstream

    val getOutstream : outstream -> StreamIO.outstream

    val setOutstream : (outstream * StreamIO.outstream) -> unit

  end
