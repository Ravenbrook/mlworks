(* __types.sml the structure *)
(*
$Log: __types.sml,v $
Revision 1.11  1995/03/24 14:50:22  matthew
Adding Stamp structure

Revision 1.10  1995/02/02  13:59:52  matthew
Removing debug stuff

Revision 1.9  1993/05/18  18:20:54  jont
Removed integer parameter

Revision 1.8  1992/09/25  12:30:54  jont
Removed simpletypes and its structures, they're in datatypes

Revision 1.7  1992/08/11  13:04:19  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/08/04  15:47:20  davidt
Took out redundant Array argument and require.

Revision 1.5  1992/07/16  18:45:41  jont
added btree parameter

Revision 1.4  1992/02/14  12:19:57  jont
Changed requires to __ident and __identprint. Added require for __ty_debug

Revision 1.3  1992/01/27  18:44:21  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:42:25  jont
Added copyright message

Revision 1.1  91/06/07  11:29:38  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__print";
require "../utils/__crash";
require "../basics/__identprint";
require "__datatypes";
require "__stamp";

require "_types";

structure Types_ = Types(
  structure Lists     = Lists_
  structure Print     = Print_
  structure Crash     = Crash_
  structure IdentPrint = IdentPrint_
  structure Datatypes  = Datatypes_
  structure Stamp  = Stamp_
);
