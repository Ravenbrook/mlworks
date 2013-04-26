(*
 Copyright (c) 1993 Harlequin Ltd

 based on Revision 1.5
 Revision Log
 ------------
 $Log: __machtypes.sml,v $
 Revision 1.2  1993/11/17 14:01:41  io
 Deleted old SPARC comments and fixed type errors

 *)

require "../utils/__crash";
require "_machtypes";

structure MachTypes_ = MachTypes(
  structure Crash = Crash_
)
