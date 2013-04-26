(* __sparc_schedule.sml the structure *)
(*
$Log: __sparc_schedule.sml,v $
Revision 1.8  1995/12/27 15:55:51  jont
Remove __option

Revision 1.7  1993/08/24  11:53:57  jont
Changed $Log to $Log: __sparc_schedule.sml,v $
Changed $Log to Revision 1.8  1995/12/27 15:55:51  jont
Changed $Log to Remove __option
Changed $Log to to get the change log

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__btree";
require "../utils/__crash";
require "../utils/__set";
require "../utils/__lists";
require "../mir/__mirtypes";
require "__machtypes";
require "__sparc_assembly";
require "_sparc_schedule";

structure Sparc_Schedule_ = Sparc_Schedule(
  structure NewMap = BTree_
  structure Crash = Crash_
  structure Set = Set_
  structure Lists = Lists_
  structure MirTypes = MirTypes_
  structure MachTypes = MachTypes_
  structure Sparc_Assembly = Sparc_Assembly_
)
