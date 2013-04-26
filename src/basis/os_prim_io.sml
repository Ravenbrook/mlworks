(*  ==== INITIAL BASIS : OS_PRIM_IO ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: os_prim_io.sml,v $
 *  Revision 1.2  1999/02/02 15:58:46  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1996/07/18  13:13:41  andreww
 *  new unit
 *  [Bug 1453] updated and renamed version of osprimio.sml
 *
 * Revision 1.6  1996/07/11  17:30:52  andreww
 * altering standard in, out and err.
 *
 * Revision 1.5  1996/07/02  15:20:05  andreww
 * return in, out and error streams for both the gui and the terminal.
 * Standard In, Out and Error can be constructed from these in TextIO.
 *
 * Revision 1.4  1996/05/24  10:53:01  andreww
 * exposing BinPrimIO and TextBinIO.
 *
 * Revision 1.3  1996/05/20  12:31:45  jont
 * signature changes
 *
 * Revision 1.2  1996/05/15  12:48:01  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:44:31  jont
 * new unit
 *
 *  Revision 1.3  1996/03/28  12:44:42  matthew
 *  New language definition
 *
 *  Revision 1.2  1996/02/29  15:34:52  jont
 *  Removing mkReader, shouldn't be in the interface.
 *
 *  Revision 1.1  1995/04/13  14:04:15  jont
 *  new unit
 *  No reason given
 *
 *
 *)

signature OS_PRIM_IO =
sig
   type file_desc
   type bin_reader
   type text_reader
   type bin_writer
   type text_writer
   val openRd : string -> bin_reader
   val openWr : string -> bin_writer
   val openApp: string -> bin_writer
   val openString: string -> text_reader
   val stdIn : bin_reader
   val stdOut: bin_writer
   val stdErr: bin_writer
   val translateIn : bin_reader-> text_reader
   val translateOut : bin_writer-> text_writer
end

