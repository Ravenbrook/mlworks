(* __sparc_assembly.sml the structure *)
(*
$Log: __sparc_assembly.sml,v $
Revision 1.10  1995/12/27 15:54:55  jont
Remove __option

Revision 1.9  1994/03/21  15:39:39  matthew
Added IntBTree and Map structures.

Revision 1.8  1993/08/24  11:54:15  jont
Changed $Log to $Log: __sparc_assembly.sml,v $
Changed $Log to Revision 1.10  1995/12/27 15:54:55  jont
Changed $Log to Remove __option
Changed $Log to
Revision 1.9  1994/03/21  15:39:39  matthew
Added IntBTree and Map structures.
 to get the change log

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__intbtree";
require "../mir/__mirtypes";
require "../debugger/__debugger_types";
require "__machtypes";
require "__sparc_opcodes";
require "_sparc_assembly";

structure Sparc_Assembly_ = Sparc_Assembly(
  structure Crash = Crash_
  structure Lists = Lists_
  structure Map = IntBTree_
  structure MirTypes = MirTypes_
  structure MachTypes = MachTypes_
  structure Sparc_Opcodes = Sparc_Opcodes_
  structure Debugger_Types = Debugger_Types_
)
