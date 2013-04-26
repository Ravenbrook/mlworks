(* __i386_opcodes.sml the structure *)
(*
$Log: __i386_opcodes.sml,v $
Revision 1.1  1994/09/01 10:55:15  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/__crash";
require "__i386types";
require "_i386_opcodes";

structure I386_Opcodes_ = I386_Opcodes(
  structure Crash = Crash_
  structure I386Types = I386Types_
)
