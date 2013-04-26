(* __strnames.sml the structure *)
(*
$Log: __strnames.sml,v $
Revision 1.8  1995/03/24 15:04:18  matthew
Adding structure Stamp

Revision 1.7  1995/02/02  14:01:17  matthew
Removing debug stuff

Revision 1.6  1993/05/18  19:08:22  jont
Removed integer parameter

Revision 1.5  1992/08/27  18:54:29  davidt
Removed some redundant structure arguments.

Revision 1.4  1992/07/17  10:11:41  jont
added btree parameter

Revision 1.3  1992/01/27  18:29:53  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:41:50  jont
Added copyright message

Revision 1.1  91/06/07  11:26:09  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__print";
require "__datatypes";
require "__stamp";
require "_strnames";

structure Strnames_ = Strnames(
  structure Crash      = Crash_
  structure Print      = Print_
  structure Datatypes  = Datatypes_
  structure Stamp = Stamp_
);
