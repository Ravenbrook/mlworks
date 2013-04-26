(*  ==== FOREIGN INTERFACE : C_STRUCTURE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: c_structure.sml,v $
 *  Revision 1.2  1996/09/05 15:20:35  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:17  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.3  1996/03/28  14:15:41  matthew
 * Sharing changes
 *
 * Revision 1.2  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 * Revision 1.1  1995/09/07  22:45:02  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
#
 *  Revision 1.1  1995/04/25  11:48:25  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "types";

signature C_STRUCTURE =
   sig

     structure FITypes : FOREIGN_TYPES

     eqtype name       = FITypes.name  
     eqtype filename   = FITypes.filename

     type fStructure
     type c_structure

     val to_struct : c_structure -> fStructure

     datatype load_mode = IMMEDIATE_LOAD | DEFERRED_LOAD

     val loadObjectFile : filename * load_mode -> c_structure
     val fileInfo : c_structure -> (filename * load_mode)

     val filesLoaded : unit -> filename list
     val symbols      : c_structure -> name list

     datatype value_type = CODE_VALUE | VAR_VALUE | UNKNOWN_VALUE

     val symbolInfo : c_structure * name -> value_type

   end;
