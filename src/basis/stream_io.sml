(*  ==== INITIAL BASIS : STREAM_IO ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: stream_io.sml,v $
 *  Revision 1.3  1996/10/03 15:26:46  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/07/17  17:13:19  andreww
 *  [Bug #1453]
 *  updating to bring it into line with revised basis.
 *
 *  Revision 1.1  1996/05/20  13:09:05  jont
 *  new unit
 *
 *
 *)

require "__io";

signature STREAM_IO =
  sig

    type  elem
    type  vector

    type  reader
    type  writer

    type  instream

    type  outstream

    type in_pos
    type out_pos
    type pos

    val input : instream -> (vector * instream)

    val input1 : instream -> (elem * instream) option

    val inputN : (instream * int) -> (vector * instream)

    val inputAll : instream -> vector

    val canInput : (instream * int) -> int option

    val closeIn : instream -> unit

    val endOfStream : instream -> bool

    val mkInstream : (reader * vector) -> instream

    val getReader : instream -> (reader * vector)

    val getPosIn : instream -> in_pos

    val setPosIn : in_pos -> instream

    val filePosIn : in_pos -> pos

    val output : (outstream * vector) -> unit

    val output1 : (outstream * elem) -> unit

    val flushOut : outstream -> unit

    val closeOut : outstream -> unit

    val setBufferMode : (outstream * IO.buffer_mode) -> unit

    val getBufferMode : outstream -> IO.buffer_mode

    val mkOutstream : (writer * IO.buffer_mode) -> outstream

    val getWriter : outstream -> (writer * IO.buffer_mode)

    val getPosOut : outstream -> out_pos

    val setPosOut : out_pos -> outstream

    val filePosOut : out_pos -> pos
  end
