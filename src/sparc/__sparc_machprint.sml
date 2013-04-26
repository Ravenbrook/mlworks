(* __machprint.sml the structure *)
(*
$Log: __sparc_machprint.sml,v $
Revision 1.1  1993/11/18 12:36:31  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__lists";
require "__sparc_assembly";
require "_machprint";

structure Sparc_MachPrint_ = MachPrint(
  structure Lists = Lists_
  structure Sparc_Assembly = Sparc_Assembly_
)
