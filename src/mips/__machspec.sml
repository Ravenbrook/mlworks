(*   ==== MACHINE SPECIFICATION ====
               STRUCTURE
 
 Copyright (C) 1993 Harlequin Ltd.
 
 Revision Log
 ------------
 based on Revision 1.5
 $Log: __machspec.sml,v $
 Revision 1.5  1996/12/04 14:08:59  matthew
 Removing Lists structure

 * Revision 1.4  1995/12/27  15:54:11  jont
 * Remove __option
 *
Revision 1.3  1994/10/17  13:51:09  matthew
Added Lists

Revision 1.2  1993/11/16  15:59:57  io
Deleted old SPARC comments and fixed type errors


 *)

require "../utils/__crash";
require "../utils/__set";
require "__machtypes";
require "_machspec";


structure MachSpec_ = MachSpec(
  structure MachTypes = MachTypes_
  structure Set = Set_
  structure Crash = Crash_
)
