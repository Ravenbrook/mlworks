(*  ==== FOREIGN INTERFACE : CORE INTERFACE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is the low-level foreign interface.
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: core.sml,v $
 *  Revision 1.3  1996/09/05 15:15:07  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.2  1996/05/20  20:39:50  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:39  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.4  1996/03/28  12:56:04  matthew
 * New sharing syntax etc.
 *
 * Revision 1.3  1995/04/19  21:57:45  brianm
 * General updating to reach prototype level for ML FI.
 *
 * Revision 1.2  1995/03/30  14:00:51  brianm
 * Added extra comment to list_content.
#
 * Revision 1.1  1995/03/27  15:30:09  brianm
 * new unit
 * Core Foreign interface (was foreign_interface.sml).
#
 *  Revision 1.2  1995/03/24  19:22:29  brianm
 *  Updated to use Word32.word values (instead of int * int) to
 *  encode addresses.
 * 
 *  Revision 1.1  1995/03/01  11:01:24  brianm
 *  new unit
 *  Foreign Interface signature
 * 
 *
 *)

require "types";

signature FOREIGN_CORE =
  sig

     structure FITypes : FOREIGN_TYPES

     type address = FITypes.address

     type foreign_object
     type foreign_value

     exception Unavailable

     datatype load_mode = LOAD_LATER | LOAD_NOW

     val load_object   : (string * load_mode) -> foreign_object
     val find_value    : (foreign_object * string) -> foreign_value

     val list_content  : foreign_object -> string list
         (* each string is space seperated - the first part is name of item *)

     val call_unit_fun : foreign_value -> unit
     val call_foreign_fun : (foreign_value * address * int * address) -> unit 

  end
