(* __machspec.sml the structure *)
(*   ==== MACHINE SPECIFICATION ====
 *              STRUCTURE
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *  $Log: __machspec.sml,v $
 *  Revision 1.2  1995/12/27 15:52:07  jont
 *  Remove __option
 *
Revision 1.1  1994/09/01  10:53:46  jont
new file

 *)


require "../utils/__crash";
require "../utils/__set";
require "__i386types";
require "_i386spec";


structure MachSpec_ = I386Spec(
  structure I386Types = I386Types_
  structure Set = Set_
  structure Crash = Crash_
)
