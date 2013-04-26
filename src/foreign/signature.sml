(*  ==== FOREIGN INTERFACE : FOREIGN_SIGNATURE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: signature.sml,v $
 *  Revision 1.2  1996/10/25 12:36:17  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:18  brianm
 *  new unit
 *  New file.
 *
 *  Revision 1.1  1996/05/19  11:46:39  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.3  1996/04/18  16:59:00  jont
 * initbasis becomes basis
 *
 * Revision 1.2  1996/03/28  14:11:22  matthew
 * Sharing changes
 *
 * Revision 1.1  1995/09/07  22:47:52  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:42:33  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.1  1995/03/27  15:48:27  brianm
 * new unit
 * New file.
 *
 *)
signature FOREIGN_SIGNATURE =
   sig

     type 'a option = 'a option

     type ('entry) fSignature

     (* foreign signature operations *)

     val newSignature      : unit -> 'entry fSignature

     val lookupEntry : 'entry fSignature * string -> ('entry)option
     val defEntry    : 'entry fSignature * (string * 'entry) -> unit
     val removeEntry   : 'entry fSignature * string -> unit

     val showEntries : 'entry fSignature -> (string * 'entry) list

   end; (* signature FOREIGN_SIGNATURE *)
