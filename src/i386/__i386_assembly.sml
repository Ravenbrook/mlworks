(* i386_assembly.sml the structure *)
(*
$Log: __i386_assembly.sml,v $
Revision 1.2  1995/03/17 20:20:03  daveb
Removed unused parameters.

Revision 1.1  1994/09/01  10:54:45  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__intbtree";
require "../mir/__mirtypes";
require "__i386_opcodes";
require "_i386_assembly";

structure I386_Assembly_ = I386_Assembly(
  structure Crash = Crash_
  structure Lists = Lists_
  structure Map = IntBTree_
  structure MirTypes = MirTypes_
  structure I386_Opcodes = I386_Opcodes_
)
