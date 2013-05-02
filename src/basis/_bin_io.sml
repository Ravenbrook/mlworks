(*  ==== INITIAL BASIS : textbinio functor ====
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
 *  $Log: _bin_io.sml,v $
 *  Revision 1.11  1999/03/20 21:55:28  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.10  1998/02/19  14:59:54  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.9  1997/11/25  17:49:21  daveb
 *  [Bug #30329]
 *  Removed bogus Process argument from ImperativeIO functor.
 *
 *  Revision 1.8  1997/10/07  16:07:47  johnh
 *  [Bug #30226]
 *  Closing streams on exit.
 *
 *  Revision 1.7  1997/06/03  17:46:07  jont
 *  Make sure SysErr is handled around calls to openIn, oenOut and openAppend
 *
 *  Revision 1.6  1997/02/26  11:16:24  andreww
 *  [Bug #1759]
 *  __stream_io.sml -> __bin_stream_io.sml
 *
 *  Revision 1.5  1997/01/15  12:06:01  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/08/09  14:05:44  daveb
 *  [Bug #1536]
 *  [Bug #1536]
 *  Word8Vector.vector no longer shares with string.
 *
 *  Revision 1.3  1996/07/18  12:57:57  andreww
 *  [Bug #1453]
 *  Updating to meet the new revised basis definition of IO (May 96)
 *
 *  Revision 1.2  1996/07/02  15:55:07  andreww
 *  Removing the definitions of standard In, Standard Out and Standard Error
 *  streams:  they're not part of the BinIO structure anyway.
 *
 *  Revision 1.1  1996/06/03  14:16:19  andreww
 *  new unit
 *  Revised basis functor.
 *
 *
 *)

require "__word8_vector";
require "__word8_array";
require "__word8";
require "__position";
require "_imperative_io";
require "__bin_stream_io";
require "os_prim_io";
require "bin_io.sml";
require "__io";
require "prim_io";
require "^.system.__os";

functor BinIO(include sig
                structure BinPrimIO: PRIM_IO
                structure OSPrimIO: OS_PRIM_IO
                sharing type OSPrimIO.bin_reader = BinPrimIO.reader
                sharing type OSPrimIO.bin_writer = BinPrimIO.writer
              end where type BinPrimIO.reader = BinStreamIO.reader
	      where type BinPrimIO.writer = BinStreamIO.writer
	      where type BinPrimIO.elem = Word8.word
	      where type BinPrimIO.array = Word8Array.array
	      where type BinPrimIO.vector = Word8Array.vector
	      where type BinPrimIO.pos = int): BIN_IO =

  struct
    structure BinIO' = ImperativeIO(structure StreamIO = BinStreamIO
                                    structure Vector = Word8Vector
                                    structure Array = Word8Array)

    val openIn =
      fn x =>
      BinIO'.mkInstream
      (BinIO'.StreamIO.mkInstream
       (OSPrimIO.openRd x, Word8Vector.fromList []))
      handle MLWorks.Internal.Error.SysErr e =>
	raise IO.Io{name=x,function="openIn",cause=OS.SysErr e}

    val openOut =
      fn x =>
      BinIO'.mkOutstream(BinIO'.StreamIO.mkOutstream(OSPrimIO.openWr x,
                                                     IO.NO_BUF))
      handle MLWorks.Internal.Error.SysErr e =>
	raise IO.Io{name=x,function="openOut",cause=OS.SysErr e}

    val openAppend =
      fn x =>
      BinIO'.mkOutstream(BinIO'.StreamIO.mkOutstream(OSPrimIO.openApp x,
                                                     IO.NO_BUF))
      handle MLWorks.Internal.Error.SysErr e =>
	raise IO.Io{name=x,function="openAppend",cause=OS.SysErr e}

    open BinIO'
    structure Position = Position

  end
