(* __sparc_opcodes.sml the structure *)
(*
$Log: __sparc_opcodes.sml,v $
Revision 1.2  1991/10/24 13:30:33  jont
Added Crash parameter to functor application

Revision 1.1  91/09/23  10:06:08  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "__machtypes";
require "_sparc_opcodes";

structure Sparc_Opcodes_ = Sparc_Opcodes(
  structure Crash = Crash_
  structure MachTypes = MachTypes_
)
