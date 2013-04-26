(* __type_utils.sml the structure *)
(*
$Log: __type_utils.sml,v $
Revision 1.4  1995/03/17 19:28:47  daveb
Removed unused parameters.

Revision 1.3  1995/02/07  14:15:17  matthew
Renaming Type_Utils

Revision 1.2  1992/01/24  23:32:39  jont
Added Ident_ parameter

Revision 1.1  1992/01/23  13:08:14  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "../utils/__crash";
require "../utils/__lists";
require "../typechecker/__types";
require "_type_utils";

structure TypeUtils_ = TypeUtils(
  structure Crash = Crash_
  structure Lists = Lists_
  structure Types = Types_
)
