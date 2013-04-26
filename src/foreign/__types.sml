(*  ==== FOREIGN INTERFACE : COMMON TYPES ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: __types.sml,v $
 *  Revision 1.5  1996/10/25 12:41:56  io
 *  current naming conventions
 *
 *  Revision 1.4  1996/09/20  14:48:52  io
 *  [Bug #1603]
 *  convert ByteArray to Internal.ByteArray
 *
 *  Revision 1.3  1996/05/29  08:35:18  daveb
 *  Removing use of MLWorks.RawIO.
 *
 *  Revision 1.2  1996/05/22  12:38:18  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:38  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.4  1996/04/18  16:57:29  jont
 * initbasis becomes basis
 *
 * Revision 1.3  1995/09/07  22:43:41  brianm
 * Modifications for reorganisation & documentation.
 *
 *  Revision 1.2  1995/07/18  12:38:46  brianm
 *  Changing names of deferred data-type operators (stream-edit)
 *
 *  Revision 1.1  1995/04/25  11:39:24  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__word8";
require "types";

structure ForeignTypes_: FOREIGN_TYPES =
   struct
     type 'a option = 'a option
     type word8 = Word8.word
     type word32 = Word32.word

     type address = word32
     type bytearray = MLWorks.Internal.ByteArray.bytearray

     type name = string
     type filename = string

     local
(* open MLWorks.Internal.Value
 * open MLWorks.IO 
 *)
     in
       fun debugP s v =
	 (
(*
 * print s;
 * MLWorks.IO.print (MLWorks.IO.DEFAULT, v);
 * print "\n";
 *)
	  v
	  )
	 
     end
   end (* structure ForeignTypes_ *)

