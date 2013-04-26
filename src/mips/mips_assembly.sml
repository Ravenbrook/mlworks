(*
 Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 based on ???
 
 Revision Log
 ------------
 $Log: mips_assembly.sml,v $
 Revision 1.15  1997/05/01 12:47:49  jont
 [Bug #30088]
 Get rid of MLWorks.Option

 * Revision 1.14  1997/01/28  15:16:06  matthew
 * Adding trace_nop_code
 *
 * Revision 1.13  1995/12/22  13:18:12  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.12  1995/09/08  13:35:22  jont
Add a fixed branch type which can't be expanded beyond the 16 bit limit
This can be used to detect disastrous code generation in computed gotos
If this ever occurs, we can then fix the bug

Revision 1.11  1995/08/21  11:01:55  io
adding beqz

Revision 1.10  1995/08/09  18:02:19  io
add BNEZ and R4k branch likely instrs eg bnel bltzl blezl bgtzl bgezl beql

Revision 1.9  1995/03/07  16:15:56  matthew
Improving debugger annotations

Revision 1.8  1994/11/22  17:11:37  io
added new instructions: CFC1 & CTC1
changed C_DF_D to C_SF_D (misspelling)

Revision 1.7  1994/06/09  18:05:20  io
adding comment to nop code

Revision 1.6  1994/04/21  15:32:01  io
adding labels and other misc spelling stuff

Revision 1.5  1994/03/10  12:03:45  jont
Adding support for load offset

Revision 1.4  1994/03/08  13:50:51  jont
Add an offset opcode for jump tables

Revision 1.3  1994/03/08  12:06:28  jont
Add inverse_branch to signature

Revision 1.2  1993/11/17  14:12:04  io
Deleted old SPARC comments and fixed type errors

 *)
 
require "../mir/mirtypes";
require "mips_opcodes";

signature MIPS_ASSEMBLY = sig
  structure MirTypes : MIRTYPES
  structure Mips_Opcodes : MIPS_OPCODES

  datatype load_and_store =
    LB |
    LBU |
    LH |
    LHU |
    LW |
    LWL |
    LWR |
    SB |
    SH |
    SW |
    SWL |
    SWR

  datatype load_and_store_float =
    LWC1 |
    SWC1 |
    MTC1 |
    MFC1 |
    CFC1 |
    CTC1

  datatype arithmetic_and_logical =
    ADD |
    ADDI |
    ADDIU |
    ADDU |
    SUB |
    SUBU |
    AND |
    ANDI |
    OR |
    ORI |
    XOR |
    XORI |
    NOR |
    SLT |
    SLTU |
    SLTI |
    SLTIU |
    SLL |
    SRL |
    SRA |
    SLLV |
    SRLV |
    SRAV

  datatype load_offset = LEO

  datatype special_arithmetic = ADD_AND_MASK

  datatype special_load_offset =
    LOAD_OFFSET_AND_MASK |
    LOAD_OFFSET_HIGH

  datatype mult_and_div =
    MULT |
    MULTU |
    DIV |
    DIVU

  datatype mult_and_div_result =
    MFHI |
    MFLO |
    MTHI |
    MTLO

  datatype sethi = LUI

  datatype branch =
    BA |
    BEQ |
    BNE |
    BEQZ |
    BNEZ |
    BLEZ |
    BGTZ |
    BLTZ |
    BGEZ |
    (* r4k *)
    BNEL |
    BLTZL |
    BLEZL |
    BGTZL |
    BGEZL |
    BEQL

  datatype call = 
    BLTZAL |
    BGEZAL

  datatype jump = 
    JAL |
    JALR |
    J |
    JR

  datatype conv_op =
    CVT_S_D |
    CVT_S_W |
    CVT_D_W |
    CVT_D_S |
    CVT_W_D |
    CVT_W_S

  datatype funary =
    MOV_S |
    MOV_D |
    NEG_S |
    NEG_D |
    ABS_S |
    ABS_D

  datatype fbinary =
    ADD_D |
    ADD_S |
    DIV_D |
    DIV_S |
    MUL_D |
    MUL_S |
    SUB_D |
    SUB_S

  datatype fcmp =
    C_F_S | C_UN_S | C_EQ_S | C_UEQ_S | C_OLT_S | C_ULT_S | C_OLE_S | C_ULE_S |
    C_SF_S | C_NGLE_S | C_SEQ_S | C_NGL_S | C_LT_S | C_NGE_S | C_LE_S | C_NGT_S |
    C_F_D | C_UN_D | C_EQ_D | C_UEQ_D | C_OLT_D | C_ULT_D | C_OLE_D | C_ULE_D |
    C_SF_D | C_NGLE_D | C_SEQ_D | C_NGL_D | C_LT_D | C_NGE_D | C_LE_D | C_NGT_D

  datatype fbranch =
    BC1T |
    BC1F

  datatype reg_or_imm =
    REG of Mips_Opcodes.MachTypes.Mips_Reg |
    IMM of int

  datatype opcode =
    LOAD_AND_STORE of
    load_and_store * Mips_Opcodes.MachTypes.Mips_Reg 
    * Mips_Opcodes.MachTypes.Mips_Reg * int
  | LOAD_AND_STORE_FLOAT of
    load_and_store_float * Mips_Opcodes.MachTypes.Mips_Reg 
    * Mips_Opcodes.MachTypes.Mips_Reg * reg_or_imm
  | ARITHMETIC_AND_LOGICAL of
    arithmetic_and_logical * Mips_Opcodes.MachTypes.Mips_Reg
    * Mips_Opcodes.MachTypes.Mips_Reg * reg_or_imm
  | SPECIAL_ARITHMETIC of special_arithmetic * Mips_Opcodes.MachTypes.Mips_Reg 
    * reg_or_imm * Mips_Opcodes.MachTypes.Mips_Reg
  | MULT_AND_DIV of
    mult_and_div * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg
  | MULT_AND_DIV_RESULT of
    mult_and_div_result * Mips_Opcodes.MachTypes.Mips_Reg
  | SETHI of sethi * Mips_Opcodes.MachTypes.Mips_Reg * int
  | BRANCH of branch * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg * int
  | FIXED_BRANCH of branch * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg * int
  | CALL of call * Mips_Opcodes.MachTypes.Mips_Reg * int *
    MirTypes.Debugger_Types.Backend_Annotation
  | JUMP of jump * reg_or_imm * Mips_Opcodes.MachTypes.Mips_Reg * 
    MirTypes.Debugger_Types.Backend_Annotation
  | FBRANCH of fbranch * int
  | CONV_OP of conv_op * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg
  | FUNARY of funary * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg
  | FBINARY of fbinary * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg *
    Mips_Opcodes.MachTypes.Mips_Reg
  | FCMP of fcmp * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg
  | OFFSET of int
  | LOAD_OFFSET of load_offset * Mips_Opcodes.MachTypes.Mips_Reg * int
  | SPECIAL_LOAD_OFFSET of special_load_offset * Mips_Opcodes.MachTypes.Mips_Reg * Mips_Opcodes.MachTypes.Mips_Reg * int

  val assemble : opcode -> Mips_Opcodes.opcode

  type LabMap

  val make_labmap : opcode list list list -> LabMap

  val print : opcode -> string
  val labprint : opcode * int * LabMap -> string * string

  val reverse_branch : branch -> branch
  val inverse_branch : branch -> branch
  val defines_and_uses :
    opcode ->
    Mips_Opcodes.MachTypes.Mips_Reg MirTypes.Set.Set * Mips_Opcodes.MachTypes.Mips_Reg MirTypes.Set.Set *
    Mips_Opcodes.MachTypes.Mips_Reg MirTypes.Set.Set * Mips_Opcodes.MachTypes.Mips_Reg MirTypes.Set.Set
  val nop_code : opcode
  val other_nop_code : opcode
  val trace_nop_code : opcode
  val nop : opcode * MirTypes.tag option * string
  val nopc : string -> (opcode * MirTypes.tag option * string)
end
