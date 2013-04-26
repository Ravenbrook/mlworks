(*  ==== FOREIGN INTERFACE : LIBML C/ML INTERFACE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: __libml.sml,v $
 *  Revision 1.4  1996/09/05 14:41:07  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 * Revision 1.3  1996/03/20  15:17:40  matthew
 * Language revision
 *
 * Revision 1.2  1995/07/07  10:54:03  brianm
 * Adding dependencies ...
 *
 *  Revision 1.1  1995/07/07  10:45:56  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "libml";

structure LibML_ : LIB_ML =
   struct

   (* Mapping *)

     val env  = MLWorks.Internal.Runtime.environment;

     val registerExternalValue   :  string * 'a -> unit =
         fn x => env "add external ml value" x

     val deleteExternalValue   :  string -> unit =
         env "delete external ml value"

     val externalValues   :  unit -> string list =
         env "external ml value names"

     val clearExternalValues   :  unit -> unit =
         env "clear external ml values"
   end;

