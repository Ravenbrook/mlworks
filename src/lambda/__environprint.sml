(* __environprint.sml the structure *)
(*
$Log: __environprint.sml,v $
Revision 1.8  1995/03/22 13:54:40  daveb
Removed unused parameters.

Revision 1.7  1992/06/10  14:12:41  jont
Changed to use newmap

Revision 1.6  1992/02/11  10:30:36  clive
New pervasive library

Revision 1.5  1991/11/21  16:23:47  jont
Added copyright message

Copyright (c) 1991 Harlequin Ltd.
*)

require "_environprint";
require "../basics/__identprint";
require "__pretty";
require "__environ";

structure EnvironPrint_ = EnvironPrint (
  structure Pretty = Pretty_
  structure IdentPrint = IdentPrint_
  structure Environ = Environ_);
