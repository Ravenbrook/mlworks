(*
 Copyright (c) 1993 Harlequin Ltd.

 based on ???
 Revision Log
 ------------
 $Log: __mips_assembly.sml,v $
 Revision 1.4  1995/12/27 15:54:26  jont
 Remove __option

Revision 1.3  1994/04/21  16:09:53  io
adding labels

Revision 1.2  1993/11/16  16:03:35  io
Deleted old SPARC comments and fixed type errors

 *)

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__intbtree";
require "../mir/__mirtypes";
require "../debugger/__debugger_types";
require "__machtypes";
require "__mips_opcodes";
require "_mips_assembly";

structure Mips_Assembly_ = Mips_Assembly(
  structure Crash = Crash_
  structure Lists = Lists_
  structure Map = IntBTree_
  structure MirTypes = MirTypes_
  structure MachTypes = MachTypes_
  structure Mips_Opcodes = Mips_Opcodes_
  structure Debugger_Types = Debugger_Types_
)
