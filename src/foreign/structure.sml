(*  ==== FOREIGN INTERFACE : FOREIGN_STRUCTURE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: structure.sml,v $
 *  Revision 1.2  1996/09/05 16:13:38  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:18  brianm
 *  new unit
 *  New file.
 *
 *  Revision 1.1  1996/05/19  13:59:09  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.2  1996/03/28  12:58:55  matthew
 * New sharing syntax etc.
 *
 * Revision 1.1  1995/09/07  22:47:17  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 * Revision 1.2  1995/04/19  23:37:57  brianm
 * General updating to reach prototype level for ML FI.
#
 * Revision 1.1  1995/03/27  15:48:58  brianm
 * new unit
 * New file.
#
 *
 *)

require "types";

signature FOREIGN_STRUCTURE =
   sig

     structure FITypes : FOREIGN_TYPES

     type name = FITypes.name  
     type filename = FITypes.filename

     type foreign_module
     type fStructure

     datatype load_mode = IMMEDIATE_LOAD | DEFERRED_LOAD

     val load_object_file : filename * load_mode -> fStructure
     val file_info : fStructure -> (filename * load_mode)

     val filesLoaded : unit -> filename list
     val symbols      : fStructure -> name list

     datatype value_type = CODE_VALUE | VAR_VALUE | UNKNOWN_VALUE

     val symbol_info : fStructure * name -> value_type

     val module : fStructure -> foreign_module

   end;
