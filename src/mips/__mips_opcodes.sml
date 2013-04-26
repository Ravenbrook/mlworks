(*
 Copyright (c) 1993 Harlequin Ltd.

 based on ???
 Revision Log
 ------------
 $Log: __mips_opcodes.sml,v $
 Revision 1.2  1993/11/16 16:05:28  io
 Deleted old SPARC comments and fixed type errors

 *)

require "../utils/__crash";
require "__machtypes";
require "_mips_opcodes";

structure Mips_Opcodes_ = Mips_Opcodes(
  structure Crash = Crash_
  structure MachTypes = MachTypes_
)
