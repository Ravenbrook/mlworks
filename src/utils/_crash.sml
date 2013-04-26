(* _crash.sml the functor *)
(*
$Log: _crash.sml,v $
Revision 1.6  1996/03/15 14:38:27  daveb
Fixed use of Info.default_options.

 * Revision 1.5  1992/11/25  20:12:08  daveb
 * Changes to make show_id_class and show_eq_info part of Info structure
 * instead of references.
 *
Revision 1.4  1992/11/17  16:52:20  matthew
Changed Error structure to Info

Revision 1.3  1992/09/04  08:33:49  richard
Installed central error reporting mechanism.

Revision 1.2  1991/11/21  17:00:38  jont
Added copyright message

Revision 1.1  91/06/07  15:56:34  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../main/info";
require "crash";

functor Crash (structure Info : INFO) : CRASH =
  struct
    exception Impossible of string      (* shouldn't ever be reached *)

    fun impossible message =
      Info.default_error'
        (Info.FAULT, Info.Location.UNKNOWN, message)

    fun unimplemented message =
      Info.default_error'
	( Info.FAULT,
	  Info.Location.UNKNOWN,
	  "Unimplemented facility: " ^ message
	)
  end;
