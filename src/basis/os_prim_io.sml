(*  ==== INITIAL BASIS : OS_PRIM_IO ====
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

