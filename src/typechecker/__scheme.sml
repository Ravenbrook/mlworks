(* __scheme.sml the structure *)
(*
$Log: __scheme.sml,v $
Revision 1.10  1995/12/18 11:47:50  matthew
Adding Info

Revision 1.9  1995/01/30  12:00:01  matthew
Removing redundant debugger structures.

Revision 1.8  1993/12/03  15:50:28  nickh
Removed dead code, removed colons in an error message.

Revision 1.7  1993/05/18  18:12:37  jont
Removed integer parameter

Revision 1.6  1993/02/22  10:52:45  matthew
Added Completion structure

Revision 1.5  1992/08/04  15:46:50  davidt
Took out redundant Array argument and require.

Revision 1.4  1992/07/16  18:59:22  jont
added btree parameter

Revision 1.3  1992/01/27  18:12:30  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:40:33  jont
Added copyright message

Revision 1.1  91/06/07  11:21:20  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__set";
require "../utils/__print";
require "../utils/__crash";
require "../utils/__lists";
require "../basics/__identprint";
require "../main/__info";
require "__datatypes";
require "__types";
require "__completion";
require "_scheme";

structure Scheme_ = Scheme(
  structure Set        = Set_
  structure Crash      = Crash_
  structure Print      = Print_
  structure Lists      = Lists_
  structure Info       = Info_
  structure IdentPrint = IdentPrint_
  structure Datatypes  = Datatypes_
  structure Types      = Types_
  structure Completion = Completion_
);

