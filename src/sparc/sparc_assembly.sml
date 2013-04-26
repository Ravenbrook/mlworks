(* sparc_assembly.sml the signature *)
(*
$Log: sparc_assembly.sml,v $
Revision 1.22  1997/05/01 12:53:08  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.21  1997/01/17  13:56:03  matthew
 * Adding multiply instructions
 *
 * Revision 1.20  1995/12/22  12:57:30  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.19  1995/07/28  09:08:45  matthew
Putting sources registers for various instructions in correct order

Revision 1.18  1995/02/10  10:14:44  matthew
Adding debug information to Call instructions

Revision 1.17  1994/03/21  15:51:42  matthew
Added functions for labels in printout

Revision 1.16  1994/03/09  17:10:26  jont
Adding load offset isntructions

Revision 1.15  1993/08/24  11:53:44  jont
Changed $Log to $Log: sparc_assembly.sml,v $
Changed $Log to Revision 1.22  1997/05/01 12:53:08  jont
Changed $Log to [Bug #30088]
Changed $Log to Get rid of MLWorks.Option
Changed $Log to
 * Revision 1.21  1997/01/17  13:56:03  matthew
 * Adding multiply instructions
 *
 * Revision 1.20  1995/12/22  12:57:30  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.19  1995/07/28  09:08:45  matthew
Putting sources registers for various instructions in correct order

Revision 1.18  1995/02/10  10:14:44  matthew
Adding debug information to Call instructions

Revision 1.17  1994/03/21  15:51:42  matthew
Added functions for labels in printout

Revision 1.16  1994/03/09  17:10:26  jont
Adding load offset isntructions
 to get the change log

Copyright (c) 1991 Harlequin Ltd.
*)

require "../mir/mirtypes";
require "sparc_opcodes";

signature SPARC_ASSEMBLY = sig
  structure MirTypes : MIRTYPES
  structure Sparc_Opcodes : SPARC_OPCODES

  datatype load_and_store =
    LDSB |
    LDSH |
    LDUB |
    LDUH |
    LD |
    LDD |
    STB |
    STH |
    ST |
    STD

  datatype load_and_store_float =
    LDF |
    LDDF |
    STF |
    STDF

  datatype arithmetic_and_logical =
    ADD |
    ADDCC |
    ADDX |
    ADDXCC |
    SUB |
    SUBCC |
    SUBX |
    SUBXCC |
    AND |
    ANDCC |
    ANDN |
    ANDNCC |
    OR |
    ORCC |
    ORN |
    ORNCC |
    XOR |
    XORCC |
    XORN |
    XORNCC |
    SLL |
    SRL |
    SRA |
    UMUL |
    SMUL |
    UMULCC |
    SMULCC |
    UDIV |
    SDIV |
    UDIVCC |
    SDIVCC

  datatype load_offset = LEO

  datatype special_arithmetic = ADD_AND_MASK

  datatype special_load_offset =
    LOAD_OFFSET_AND_MASK |
    LOAD_OFFSET_HIGH

  datatype tagged_arithmetic =
    TADDCC |
    TADDCCTV |
    TSUBCC |
    TSUBCCTV

  datatype sethi = SETHI

  datatype save_and_restore =
    SAVE |
    RESTORE

  datatype branch =
    BA |
    BN |
    BNE |
    BE |
    BG |
    BLE |
    BGE |
    BL |
    BGU |
    BLEU |
    BCC |
    BCS |
    BPOS |
    BNEG |
    BVC |
    BVS

  datatype call = CALL

  datatype jump_and_link = JMPL

  datatype conv_op =
    FITOS |
    FITOD |
    FITOX |
    FSTOI |
    FDTOI |
    FXTOI

  datatype funary =
    FMOV |
    FNEG |
    FABS |
    FSQRTS |
    FSQRTD |
    FSQRTX |
    FCMPS |
    FCMPD |
    FCMPX

  datatype fbinary =
    FADDS |
    FADDD |
    FADDX |
    FSUBS |
    FSUBD |
    FSUBX |
    FMULS |
    FMULD |
    FMULX |
    FDIVS |
    FDIVD |
    FDIVX

  datatype fbranch =
    FBA |
    FBN |
    FBU |
    FBG |
    FBUG |
    FBL |
    FBUL |
    FBLG |
    FBNE |
    FBE |
    FBUE |
    FBGE |
    FBUGE |
    FBLE |
    FBULE |
    FBO

  datatype reg_or_imm =
    REG of Sparc_Opcodes.MachTypes.Sparc_Reg |
    IMM of int

  datatype read_state = RDY
  datatype write_state = WRY

  datatype opcode =
    LOAD_AND_STORE of
      load_and_store * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm |
    LOAD_AND_STORE_FLOAT of
      load_and_store_float * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm |
    ARITHMETIC_AND_LOGICAL of
      arithmetic_and_logical * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm |
    SPECIAL_ARITHMETIC of
      special_arithmetic * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm |
    TAGGED_ARITHMETIC of
      tagged_arithmetic * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm |
    SetHI of sethi * Sparc_Opcodes.MachTypes.Sparc_Reg * int |
    SAVE_AND_RESTORE of save_and_restore * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm |
    BRANCH of branch * int |
    BRANCH_ANNUL of branch * int |
    Call of call * int * MirTypes.Debugger_Types.Backend_Annotation |
    JUMP_AND_LINK of jump_and_link * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm * 
    MirTypes.Debugger_Types.Backend_Annotation |
    FBRANCH of fbranch * int |
    FBRANCH_ANNUL of fbranch * int |
    CONV_OP of conv_op * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg |
    FUNARY of funary * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg |
    FBINARY of fbinary * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg *
    Sparc_Opcodes.MachTypes.Sparc_Reg |
    LOAD_OFFSET of load_offset * Sparc_Opcodes.MachTypes.Sparc_Reg * int |
    SPECIAL_LOAD_OFFSET of special_load_offset * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * int |
    READ_STATE of read_state * Sparc_Opcodes.MachTypes.Sparc_Reg |
    WRITE_STATE of write_state * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm

  val assemble : opcode -> Sparc_Opcodes.opcode

  type LabMap

  val make_labmap : opcode list list list -> LabMap

  val print : opcode -> string
  val labprint : opcode * int * LabMap -> string * string
  val reverse_branch : branch -> branch

  (* Produce rel' where a rel b == b rel' a *)

  val inverse_branch : branch -> branch
  (* Produce rel' where a rel b == not(a rel' b) *)
  val defines_and_uses :
    opcode ->
    Sparc_Opcodes.MachTypes.Sparc_Reg MirTypes.Set.Set * Sparc_Opcodes.MachTypes.Sparc_Reg MirTypes.Set.Set *
    Sparc_Opcodes.MachTypes.Sparc_Reg MirTypes.Set.Set * Sparc_Opcodes.MachTypes.Sparc_Reg MirTypes.Set.Set
  val nop_code : opcode
  val other_nop_code : opcode
  val nop : opcode * MirTypes.tag option * string
end
