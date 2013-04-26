(* __machprint.sml the structure *)
(*
$Log: __machprint.sml,v $
Revision 1.1  1994/09/01 10:53:16  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/__lists";
require "__i386_assembly";
require "_i386print";

structure MachPrint_ = I386Print(
  structure Lists = Lists_
  structure I386_Assembly = I386_Assembly_
)
