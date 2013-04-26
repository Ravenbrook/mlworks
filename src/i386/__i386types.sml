(* __i386types.sml the structure *)
(*
$Log: __i386types.sml,v $
Revision 1.1  1994/09/01 10:56:07  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/__crash";
require "_i386types";

structure I386Types_ = I386Types(
  structure Crash = Crash_
)
