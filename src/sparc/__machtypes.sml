(* __machtypes.sml the structure *)
(*
$Log: __machtypes.sml,v $
Revision 1.5  1991/11/20 16:15:32  jont
Changed name in header to __machtypes

Revision 1.4  91/10/24  13:27:28  jont
Added Crash parameter to functor application

Revision 1.3  91/10/07  11:47:05  richard
Removed redundant dependencies.

Revision 1.2  91/09/06  13:01:11  jont
Added set parameter

Revision 1.1  91/08/09  17:22:56  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "_machtypes";

structure MachTypes_ = MachTypes(
  structure Crash = Crash_
)
