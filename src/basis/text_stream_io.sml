(*  ==== INITIAL BASIS : TEXT_STREAM_IO ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
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

    val inputLine : instream -> (string * instream)

    val outputSubstr : (outstream * Substring.substring) -> unit

  end
  where type vector = CharVector.vector
  where type elem = Char.char
  where type reader = TextPrimIO.reader
  where type writer = TextPrimIO.writer
  where type pos = TextPrimIO.pos