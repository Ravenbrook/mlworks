(*  ==== INITIAL BASIS : BIN_IO ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: bin_io.sml,v $
 *  Revision 1.5  1999/02/02 15:58:44  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.4  1998/02/19  14:57:12  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.3  1997/01/15  12:06:25  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.2  1996/05/31  14:49:31  andreww
 *  adjusting require files.
 *
 *  Revision 1.1  1996/05/20  10:57:21  jont
 *  new unit
 *
 *
 *)

require "imperative_io";
require "__word8";
require "__word8_vector";
require "__bin_prim_io";

signature BIN_IO =
  sig

    include IMPERATIVE_IO
      sharing type vector =StreamIO.vector
      sharing type elem =  StreamIO.elem

    val openIn : string -> instream
    val openOut : string -> outstream

    val openAppend : string -> outstream

  end
  where type vector = Word8Vector.vector
  where type elem = Word8.word 
  where type StreamIO.reader = BinPrimIO.reader
  where type StreamIO.writer = BinPrimIO.writer
