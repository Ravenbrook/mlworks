(* 
 Copyright 1993 Harlequin Ltd.

 based on ???
 Revision Log
 ------------
 $Log: __mips_schedule.sml,v $
 Revision 1.3  1994/11/15 12:03:02  matthew
 Removing redundant structures

Revision 1.2  1993/11/16  16:06:50  io
Deleted old SPARC comments and fixed type errors

 *)

require "../utils/__crash";
require "../utils/__lists";
require "__mips_assembly";

require "_mips_schedule";

structure Mips_Schedule_ = 
  Mips_Schedule(structure Crash = Crash_
                structure Lists = Lists_
                structure Mips_Assembly = Mips_Assembly_
                  )
