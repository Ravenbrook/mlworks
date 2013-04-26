(* __i386_schedule.sml the structure *)
(*
$Log: __i386_schedule.sml,v $
Revision 1.3  1995/12/27 15:51:51  jont
Remove __option

Revision 1.2  1995/03/17  20:24:07  daveb
Removed unused parameters.

Revision 1.1  1994/09/01  10:55:42  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../mir/__mirtypes";
require "__i386_assembly";
require "_i386_schedule";

structure I386_Schedule_ = I386_Schedule(
  structure Crash = Crash_
  structure Lists = Lists_
  structure MirTypes = MirTypes_
  structure I386_Assembly = I386_Assembly_
)
