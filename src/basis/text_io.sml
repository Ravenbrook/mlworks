(*  ==== INITIAL BASIS : TEXT_IO ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: text_io.sml,v $
 *  Revision 1.8  1999/02/02 15:58:48  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.7  1998/02/19  14:32:48  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.6  1997/02/26  11:10:50  andreww
 *  [Bug #1759]
 *  take account of new TEXT_STREAM_IO signature.
 *
 *  Revision 1.5  1996/11/15  17:56:49  io
 *  [Bug #1757]
 *  renamed __charvector to __char_vector
 *
 *  Revision 1.4  1996/07/17  17:25:40  andreww
 *  [Bug #1453]
 *  Updating to meet the new basis definition (May 30 1996).
 *
 *  Revision 1.3  1996/06/04  09:49:38  jont
 *  Remove dependence on __stream_io
 *
 *  Revision 1.2  1996/06/03  13:07:52  andreww
 *  debugging.
 *
 *  Revision 1.1  1996/05/20  14:47:55  jont
 *  new unit
 *
 *
 *)

require "text_stream_io.sml";
require "__char";
require "__char_vector";
require "__substring";
require "__string_cvt";

signature TEXT_IO =
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

    structure StreamIO : TEXT_STREAM_IO

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


    val inputLine : instream -> string

    val outputSubstr : (outstream * Substring.substring) -> unit

    val print : string -> unit

    val openIn : string -> instream
    val openOut : string -> outstream
    val openAppend : string -> outstream

    val openString: string -> instream

    val stdIn : instream
    val stdOut : outstream
    val stdErr : outstream

    val scanStream: ((Char.char, StreamIO.instream) StringCvt.reader
                  -> ('a,StreamIO.instream) StringCvt.reader)
                  -> instream -> 'a option

  end
  where type vector = CharVector.vector
  where type elem = char
