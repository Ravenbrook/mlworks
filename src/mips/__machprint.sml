(* 
 Copyright (c) 1993 Harlequin Ltd.

 based on ???
 Revision Log
 ------------
 $Log: __machprint.sml,v $
 Revision 1.2  1993/11/17 14:01:09  io
 Deleted old SPARC comments and fixed type errors

 *)
require "../utils/__lists";
require "__mips_assembly";
require "_machprint";

structure MachPrint_ = MachPrint(
  structure Lists = Lists_
  structure Mips_Assembly = Mips_Assembly_
)
