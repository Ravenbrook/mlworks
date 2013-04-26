(*
 Copyright (c) 1993 Harlequin Ltd.
 
 based on ???
 
 Revision Log
 ------------
 $Log: mips_opcodes.sml,v $
 Revision 1.3  1994/03/08 13:58:03  jont
 Add OFFSET type for straight integers

Revision 1.2  1993/11/17  14:12:51  io
Deleted old SPARC comments and fixed type errors

 *)

require "machtypes";

signature MIPS_OPCODES = sig
  structure MachTypes : MACHTYPES
    
  exception not_done_yet

  datatype opcode =
    FORMATI of int (*op*) * MachTypes.Mips_Reg (*rs*) * MachTypes.Mips_Reg (*rt*) * 
    int (*imm16*)
  | FORMATI2 of int (*op*) * int (*rs*) * int (*rt*) * int (*imm16*)
  | FORMATJ of int (*op*) * int (*target26*)
  | FORMATR of int (*op*) * MachTypes.Mips_Reg (*rs*) * MachTypes.Mips_Reg (*rt*) * 
    MachTypes.Mips_Reg (*rd*) * int (*shamt*) * int (*funct*)
  | FORMATR2 of int * int * int * int * int * int
  | OFFSET of int

  val register_val : MachTypes.Mips_Reg -> int;
  val output_opcode : opcode -> string
end
