(*  ==== FOREIGN INTERFACE : LIBML C/ML INTERFACE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  Contains code to register external ML values for access from C via
 *  the libML protocol.
 *
 *  Revision Log
 *  ------------
 *  $Log: libml.sml,v $
 *  Revision 1.2  1996/09/03 14:19:07  io
 *  [Bug #1547]
 *  updating to current naming conventions
 *
 * Revision 1.1  1995/07/07  10:44:48  brianm
 * new unit
 * New file.
 *
 *
 *)


signature LIB_ML =
   sig

     val registerExternalValue   :  string * 'a -> unit
     val   deleteExternalValue   :  string -> unit

     val         externalValues   :  unit -> string list
     val   clearExternalValues   :  unit -> unit

   end
