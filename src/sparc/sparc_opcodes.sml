(* sparc_opcodes.sml the signature *)
(*
$Log: sparc_opcodes.sml,v $
Revision 1.1  1991/09/25 08:35:36  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "machtypes";

signature SPARC_OPCODES = sig
  structure MachTypes : MACHTYPES
    
  exception not_done_yet

  datatype opcode =
    FORMAT1 of int (*disp30*)
  | FORMAT2A of MachTypes.Sparc_Reg (*rd*) * int (*op2*) * int (*imm22*)
  | FORMAT2B of bool (*a*) * int (*cond*) * int (*op2*) * int (*disp22*)
  | FORMAT3A of int (*op*) * MachTypes.Sparc_Reg (*rd*) * int (*op3*) *
    MachTypes.Sparc_Reg (*rs1*) * bool (*i*) * int (*asi*) *
    MachTypes.Sparc_Reg (*rs2*)
  | FORMAT3B of int (*op*) * MachTypes.Sparc_Reg (*rd*) * int (*op3*) *
    MachTypes.Sparc_Reg (*rs1*) * bool (*i*) * int (*simm13*)
  | FORMAT3C of int (*op*) * MachTypes.Sparc_Reg (*rd*) * int (*op3*) *
    MachTypes.Sparc_Reg (*rs1*) * int (*opf*) * MachTypes.Sparc_Reg (*rs2*)
  val output_opcode : opcode -> string
end
