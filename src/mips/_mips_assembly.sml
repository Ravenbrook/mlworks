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
 $Log: _mips_assembly.sml,v $
 Revision 1.30  1997/09/19 09:38:48  brucem
 [Bug #30153]
 Remove references to Old.

 * Revision 1.29  1997/01/28  15:04:09  matthew
 * Adding trace_nop_code
 *
 * Revision 1.28  1997/01/13  12:10:24  matthew
 * Adding MULT operations for defines_and_uses etc.
 *
 * Revision 1.27  1996/11/11  13:20:47  matthew
 * Case for BEQZ & BNEZ in inverse_branch
 *
 * Revision 1.26  1996/11/06  11:11:15  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.25  1996/10/30  20:59:02  io
 * moving String from toplevel
 *
 * Revision 1.24  1996/05/01  12:03:27  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.23  1996/04/29  14:51:51  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.22  1995/12/22  13:17:22  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.21  1995/09/08  14:11:47  jont
Add a fixed branch type which can't be expanded beyond the 16 bit limit
This can be used to detect disastrous code generation in computed gotos
If this ever occurs, we can then fix the bug

Revision 1.20  1995/08/21  13:38:26  io
No reason?

Revision 1.19  1995/08/21  11:08:20  io
adding beqz

Revision 1.18  1995/08/09  18:09:57  io
add BNEZ and R4k branch likely instrs eg bnel bltzl blezl bgtzl bgezl beql

Revision 1.17  1995/06/19  12:31:06  matthew
Fixing problem with handler register

Revision 1.16  1995/03/07  16:15:56  matthew
Improving debugger annotations

Revision 1.15  1995/01/19  11:24:30  nickb
Make a SUBI turn into an ADDI, not an ADDIU.

Revision 1.14  1994/11/22  17:15:24  io
args to C.xx wrong way round
added new instrs: CFC1 & CTC1
changed C_DF_D to C_SF_D (misspelling)

Revision 1.13  1994/11/09  16:19:18  matthew
Completed defines_and_uses for float operations.
Semi-fixed  problem with stack references not always being through fp and sp.

Revision 1.12  1994/11/02  13:14:29  matthew
Started implementing defines_and_uses.
This is not complete for floats.
\nImproved printing a bit.

Revision 1.11  1994/10/21  13:58:50  matthew
Corrected label printing and improved code.
Print moves and lis as moves and lis.

Revision 1.10  1994/07/29  17:53:30  jont
Fix backwards encoding of register controlled shifts

Revision 1.9  1994/07/14  15:12:47  io
SRL wrong way round

Revision 1.8  1994/06/09  18:03:58  io
adding comment to nop code

Revision 1.7  1994/05/10  09:44:45  io
adding labels and other cleanups

Revision 1.6  1994/03/10  12:16:26  jont
Adding support for load offset

Revision 1.5  1994/03/08  13:57:39  jont
Add an offset opcode for jump tables

Revision 1.4  1994/03/04  16:21:47  jont
Fix reverse_branch to handle BGTZ etc

Revision 1.3  1994/03/04  15:49:32  nickh
Improve code printing readability

Revision 1.2  1993/11/16  17:02:25  io
Deleted old SPARC comments and fixed type errors

 *)

require "../basis/__int";
require "^.basis.__string_cvt";

require "../utils/crash";
require "../utils/lists";
require "../utils/intnewmap";

require "../mir/mirtypes";
require "mips_opcodes";
require "mips_assembly";


functor Mips_Assembly(
  structure Crash : CRASH
  structure Lists : LISTS		     
  structure Map : INTNEWMAP
  structure MirTypes : MIRTYPES
  structure Mips_Opcodes : MIPS_OPCODES
  ) : MIPS_ASSEMBLY =
struct
  structure MirTypes = MirTypes
  structure Set = MirTypes.Set
  structure Mips_Opcodes = Mips_Opcodes
  structure MachTypes = Mips_Opcodes.MachTypes
  structure Debugger_Types = MirTypes.Debugger_Types

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
    CTC1 |
    CFC1

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
    C_F_S   | 
    C_UN_S  | 
    C_EQ_S  | 
    C_UEQ_S | 
    C_OLT_S | 
    C_ULT_S | 
    C_OLE_S | 
    C_ULE_S |
    C_SF_S  | 
    C_NGLE_S | 
    C_SEQ_S | 
    C_NGL_S | 
    C_LT_S  | 
    C_NGE_S | 
    C_LE_S  | 
    C_NGT_S |
    C_F_D   | 
    C_UN_D  | 
    C_EQ_D  | 
    C_UEQ_D | 
    C_OLT_D | 
    C_ULT_D | 
    C_OLE_D | 
    C_ULE_D |
    C_SF_D  | 
    C_NGLE_D | 
    C_SEQ_D | 
    C_NGL_D | 
    C_LT_D  | 
    C_NGE_D | 
    C_LE_D  | 
    C_NGT_D

  datatype fbranch =
    BC1T |
    BC1F

(* have omitted, so far: SYSCALL BREAK *)

  datatype reg_or_imm =
    REG of MachTypes.Mips_Reg |
    IMM of int

  datatype opcode =
    LOAD_AND_STORE of 
    load_and_store * MachTypes.Mips_Reg * MachTypes.Mips_Reg * int
  | LOAD_AND_STORE_FLOAT of 
    load_and_store_float * MachTypes.Mips_Reg * MachTypes.Mips_Reg * reg_or_imm
  | ARITHMETIC_AND_LOGICAL of
    arithmetic_and_logical * MachTypes.Mips_Reg * MachTypes.Mips_Reg * reg_or_imm
  | SPECIAL_ARITHMETIC of
      special_arithmetic * MachTypes.Mips_Reg * reg_or_imm * MachTypes.Mips_Reg
  | MULT_AND_DIV of
    mult_and_div * MachTypes.Mips_Reg * MachTypes.Mips_Reg
  | MULT_AND_DIV_RESULT of
    mult_and_div_result * MachTypes.Mips_Reg
  | SETHI of sethi * MachTypes.Mips_Reg * int
  | BRANCH of branch * MachTypes.Mips_Reg * MachTypes.Mips_Reg * int
  | FIXED_BRANCH of branch * MachTypes.Mips_Reg * MachTypes.Mips_Reg * int
  | CALL of call * MachTypes.Mips_Reg * int *
    MirTypes.Debugger_Types.Backend_Annotation
  | JUMP of jump * reg_or_imm * MachTypes.Mips_Reg *
    MirTypes.Debugger_Types.Backend_Annotation
  | FBRANCH of fbranch * int
  | CONV_OP of conv_op * MachTypes.Mips_Reg * MachTypes.Mips_Reg
  | FUNARY of funary * MachTypes.Mips_Reg * MachTypes.Mips_Reg
  | FBINARY of fbinary * MachTypes.Mips_Reg * MachTypes.Mips_Reg *
    MachTypes.Mips_Reg
  | FCMP of fcmp * MachTypes.Mips_Reg * MachTypes.Mips_Reg
  | OFFSET of int
  | LOAD_OFFSET of load_offset * MachTypes.Mips_Reg * int
  | SPECIAL_LOAD_OFFSET of special_load_offset * MachTypes.Mips_Reg * MachTypes.Mips_Reg * int

  fun decode_load_and_store LB  = "lb     "
    | decode_load_and_store LBU = "lbu    "
    | decode_load_and_store LH  = "lh     "
    | decode_load_and_store LHU = "lhu    "
    | decode_load_and_store LW  = "lw     "
    | decode_load_and_store LWL = "lwl    "
    | decode_load_and_store LWR = "lwr    "
    | decode_load_and_store SB  = "sb     "
    | decode_load_and_store SH  = "sh     "
    | decode_load_and_store SW  = "sw     "
    | decode_load_and_store SWL = "swl    "
    | decode_load_and_store SWR = "swr    "

  fun decode_load_and_store_float LWC1 = "lwc1   "
    | decode_load_and_store_float SWC1 = "swc1   "
    | decode_load_and_store_float MTC1 = "mtc1   "
    | decode_load_and_store_float MFC1 = "mfc1   "
    | decode_load_and_store_float CTC1 = "ctc1   "
    | decode_load_and_store_float CFC1 = "cfc1   "

  fun decode_arithmetic_and_logical ADD   = "add    "
    | decode_arithmetic_and_logical ADDI  = "addi   "
    | decode_arithmetic_and_logical ADDIU = "addiu  "
    | decode_arithmetic_and_logical ADDU  = "addu   "
    | decode_arithmetic_and_logical SUB   = "sub    "
    | decode_arithmetic_and_logical SUBU  = "subu   "
    | decode_arithmetic_and_logical AND   = "and    "
    | decode_arithmetic_and_logical ANDI  = "andi   "
    | decode_arithmetic_and_logical OR    = "or     "
    | decode_arithmetic_and_logical ORI   = "ori    "
    | decode_arithmetic_and_logical XOR   = "xor    "
    | decode_arithmetic_and_logical XORI  = "xori   "
    | decode_arithmetic_and_logical NOR   = "nor    "
    | decode_arithmetic_and_logical SLT   = "slt    "
    | decode_arithmetic_and_logical SLTU  = "sltu   "
    | decode_arithmetic_and_logical SLTI  = "slti   "
    | decode_arithmetic_and_logical SLTIU = "sltiu  "
    | decode_arithmetic_and_logical SLL   = "sll    "
    | decode_arithmetic_and_logical SRL   = "srl    "
    | decode_arithmetic_and_logical SRA   = "sra    "
    | decode_arithmetic_and_logical SLLV  = "sllv   "
    | decode_arithmetic_and_logical SRLV  = "srlv   "
    | decode_arithmetic_and_logical SRAV  = "srav   "

  fun decode_mult_and_div MULT  = "mult   "
    | decode_mult_and_div MULTU = "multu  "
    | decode_mult_and_div DIV   = "div    "
    | decode_mult_and_div DIVU  = "divu   "

  fun decode_mult_and_div_result MFHI = "mfhi   "
    | decode_mult_and_div_result MFLO = "mflo   "
    | decode_mult_and_div_result MTHI = "mthi   "
    | decode_mult_and_div_result MTLO = "mtlo   "

  fun decode_sethi LUI = "lui    "

  fun decode_branch BA   = "ba     "
    | decode_branch BEQ  = "beq    "
    | decode_branch BNE  = "bne    "
    | decode_branch BEQZ = "beqz   "
    | decode_branch BNEZ = "bnez   "
    | decode_branch BLEZ = "blez   "
    | decode_branch BGTZ = "bgtz   "
    | decode_branch BLTZ = "bltz   "
    | decode_branch BGEZ = "bgez   "
    | decode_branch BNEL = "bnel   "
    | decode_branch BLTZL= "bltzl  "
    | decode_branch BLEZL= "blezl  "
    | decode_branch BGTZL= "bgtzl  "
    | decode_branch BGEZL= "bgezl  "
    | decode_branch BEQL = "beql   "


  fun decode_call BLTZAL = "bltzal "
    | decode_call BGEZAL = "bgezal "

  fun decode_jump JAL  = "jal    "
    | decode_jump JALR = "jalr   "
    | decode_jump J    = "j      "
    | decode_jump JR   = "jr     "

  fun decode_conv_op CVT_S_D = "cvt.s.d "
    | decode_conv_op CVT_S_W = "cvt.s.w "
    | decode_conv_op CVT_D_W = "cvt.d.w "
    | decode_conv_op CVT_D_S = "cvt.d.s "
    | decode_conv_op CVT_W_D = "cvt.w.d "
    | decode_conv_op CVT_W_S = "cvt.w.s "

  fun decode_funary MOV_S = "mov.s  "
    | decode_funary MOV_D = "mov.d  "
    | decode_funary NEG_S = "neg.s  "
    | decode_funary NEG_D = "neg.d  "
    | decode_funary ABS_S = "abs.s  "
    | decode_funary ABS_D = "abs.d  "

  fun decode_fbinary ADD_D = "add.d  "
    | decode_fbinary ADD_S = "add.s  "
    | decode_fbinary DIV_D = "div.d  "
    | decode_fbinary DIV_S = "div.s  "
    | decode_fbinary MUL_D = "mul.d  "
    | decode_fbinary MUL_S = "mul.s  "
    | decode_fbinary SUB_D = "sub.d  "
    | decode_fbinary SUB_S = "sub.s  "

  fun decode_fbranch BC1T = "bc1t   "
    | decode_fbranch BC1F = "bc1f   "

  fun decode_fcmp C_F_S   = "c.s.f  "
    | decode_fcmp C_UN_S  = "c.un.s "
    | decode_fcmp C_EQ_S  = "c.eq.s "
    | decode_fcmp C_UEQ_S = "c.ueq.s "
    | decode_fcmp C_OLT_S = "c.olt.s "
    | decode_fcmp C_ULT_S = "c.ult.s "
    | decode_fcmp C_OLE_S = "c.ole.s "
    | decode_fcmp C_ULE_S = "c.ule.s "
    | decode_fcmp C_SF_S  = "c.sf.s "
    | decode_fcmp C_NGLE_S= "c.ngle.s "
    | decode_fcmp C_SEQ_S = "c.seq.s "
    | decode_fcmp C_NGL_S = "c.ngl.s "
    | decode_fcmp C_LT_S  = "c.lt.s "
    | decode_fcmp C_NGE_S = "c.nge.s "
    | decode_fcmp C_LE_S  = "c.le.s "
    | decode_fcmp C_NGT_S = "c.ngt.s "
    | decode_fcmp C_F_D   = "c.f.d  "
    | decode_fcmp C_UN_D  = "c.un.d "
    | decode_fcmp C_EQ_D  = "c.eq.d "
    | decode_fcmp C_UEQ_D = "c.ueq.d "
    | decode_fcmp C_OLT_D = "c.olt.d "
    | decode_fcmp C_ULT_D = "c.ult.d "
    | decode_fcmp C_OLE_D = "c.ole.d "
    | decode_fcmp C_ULE_D = "c.ule.d "
    | decode_fcmp C_SF_D  = "c.sf.d "
    | decode_fcmp C_NGLE_D= "c.ngle.d "
    | decode_fcmp C_SEQ_D = "c.seq.d "
    | decode_fcmp C_NGL_D = "c.ngl.d "
    | decode_fcmp C_LT_D  = "c.lt.d "
    | decode_fcmp C_NGE_D = "c.nge.d "
    | decode_fcmp C_LE_D  = "c.le.d "
    | decode_fcmp C_NGT_D= "c.ngt.d "

  fun decode offset = "OFFSET"

  fun assemble(LOAD_AND_STORE(load_and_store, rt, base, imm)) =
    let val op2 = case load_and_store of
      LB  => 32
    | LBU => 36
    | LH  => 33
    | LHU => 37
    | LW  => 35
    | LWL => 34
    | LWR => 38 
    | SB  => 40
    | SH  => 41
    | SW  => 43
    | SWL => 42
    | SWR => 46
    in
      Mips_Opcodes.FORMATI(op2, base, rt, imm) 
    end
    | assemble(LOAD_AND_STORE_FLOAT(load_and_store_float, rt, base, reg_or_imm )) =
      ( case reg_or_imm of
	REG reg => 
	  let val op2 = case load_and_store_float of
	    MTC1 => 4
	  | MFC1 => 0
	  | CFC1 => 2
	  | CTC1 => 6
	  | _ => Crash.impossible "assemble load_and_store_float reg"
	  in
	    Mips_Opcodes.FORMATR2(17, op2, Mips_Opcodes.register_val rt, 
				  Mips_Opcodes.register_val base, 0, 0)
	  end
      | IMM imm =>
	  let val op2 = case load_and_store_float of
	    LWC1 => 49
	  | SWC1 => 57
	  | _    => Crash.impossible "assemble load_and_store_float imm" 
	  in
	    Mips_Opcodes.FORMATI(op2, base, rt, imm)
	  end)
    | assemble(ARITHMETIC_AND_LOGICAL(arithmetic_and_logical, rd, rs, reg_or_imm)) =
      (case reg_or_imm of
	 REG reg =>
	   let
	     val (op2, reg, rs) = case arithmetic_and_logical of
	     ADD  => (32, reg, rs)
	   | ADDU => (33, reg, rs)
	   | SUB  => (34, reg, rs)
	   | SUBU => (35, reg, rs)
	   | AND  => (36, reg, rs)
	   | OR   => (37, reg, rs)
	   | XOR  => (38, reg, rs)
	   | NOR  => (39, reg, rs)
	   | SLT  => (42, reg, rs)
	   | SLTU => (43, reg, rs)
	   | SLLV =>  (4, rs, reg)
	   | SLL  =>  (4 (* really an SLLV *), rs, reg)
	   | SRAV =>  (7, rs, reg)
	   | SRA  =>  (7 (* really an SRAV *), rs, reg)
	   | SRLV =>  (6, rs, reg)
	   | SRL  =>  (6 (* really an SRLV *), rs, reg)
	   | _    => Crash.impossible ("assemble arith1 " ^ decode_arithmetic_and_logical arithmetic_and_logical)
	   in
	     Mips_Opcodes.FORMATR(0, rs, reg, rd, 0, op2)
	   end
       | IMM imm =>
	   (case arithmetic_and_logical of
	      SRL  => Mips_Opcodes.FORMATR(0, MachTypes.R0, rs, rd, imm, 2)
	    | SRA  => Mips_Opcodes.FORMATR(0, MachTypes.R0, rs, rd, imm, 3)
	    | SLL  => Mips_Opcodes.FORMATR(0, MachTypes.R0, rs, rd, imm, 0)
	    | SLTIU=> Mips_Opcodes.FORMATI(11, rs, rd, imm)
	    | SLTU => Mips_Opcodes.FORMATI(11, rs, rd, imm) (* aka SLTIU *)
	    | SLTI => Mips_Opcodes.FORMATI(10, rs, rd, imm)
	    | SLT  => Mips_Opcodes.FORMATI(10, rs, rd, imm) (* aka SLTI *)
		
(*
	      SRL  => Mips_Opcodes.FORMATR(0, MachTypes.R0, rd, rs, imm, 2)
	    | SRA  => Mips_Opcodes.FORMATR(0, MachTypes.R0, rd, rs, imm, 3)
	    | SLL  => Mips_Opcodes.FORMATR(0, MachTypes.R0, rd, rs, imm, 0)
	    | SLTIU=> Mips_Opcodes.FORMATI(11, rs, rd, imm)
	    | SLTI => Mips_Opcodes.FORMATI(10, rs, rd, imm)
*)
	    | XORI => Mips_Opcodes.FORMATI(14, rs, rd, imm)
	    | XOR  => Mips_Opcodes.FORMATI(14, rs, rd, imm) (* really an XORI *)
	    | ORI  => Mips_Opcodes.FORMATI(13, rs, rd, imm)
	    | OR   => Mips_Opcodes.FORMATI(13, rs, rd, imm) (* really an ORI *)
	    | ANDI => Mips_Opcodes.FORMATI(12, rs, rd, imm)
	    | AND  => Mips_Opcodes.FORMATI(12, rs, rd, imm) (* really an ANDI *)
	    | ADDI => Mips_Opcodes.FORMATI( 8, rs, rd, imm)
	    | ADD  => Mips_Opcodes.FORMATI( 8, rs, rd, imm) (* really an ADDI *)
	    | ADDIU=> Mips_Opcodes.FORMATI( 9, rs, rd, imm)
	    | ADDU => Mips_Opcodes.FORMATI( 9, rs, rd, imm) (* really an ADDIU *)
	    | SUB  => Mips_Opcodes.FORMATI( 8, rs, rd, 65536-imm) (* really an ADDIU *)
	    | SUBU => Mips_Opcodes.FORMATI( 9, rs, rd, 65536-imm) (* really an ADDIU *)
	    | _    => Crash.impossible ("assemble arith2 " ^ decode_arithmetic_and_logical arithmetic_and_logical)))
    | assemble(MULT_AND_DIV(mult_and_div, rs, rt)) =
      let val op2 = case mult_and_div of
	MULT  => 24
      | MULTU => 25
      | DIV   => 26
      | DIVU  => 27
      in
	Mips_Opcodes.FORMATI(0, rs, rt, op2) (* really R-type with 2 zero fields *)
      end
    | assemble(MULT_AND_DIV_RESULT(mult_and_div_result, rd)) =
      let val op2 = case mult_and_div_result of
	MFHI => 16
      | MTHI => 17
      | MFLO => 18
      | MTLO => 19
      in
	Mips_Opcodes.FORMATR2(0, 0, 0, Mips_Opcodes.register_val rd, 0, op2)
      end
    | assemble(SETHI(sethi, rt, imm)) =
       Mips_Opcodes.FORMATI2(15, 0, Mips_Opcodes.register_val rt, imm)
    | assemble(BRANCH(branch, rs, rt, imm)) = let
        val rVal = Mips_Opcodes.register_val
        val (branch', rs', rt') = case branch of
	  BA  => (4,       0,       0)
	| BEQ => (4, rVal rs, rVal rt)
        | BEQZ =>(4, rVal rs,      0) (* beq lhs zero *)
	| BNE => (5, rVal rs, rVal rt)
	| BNEZ =>(5, rVal rs,       0) (* bne lhs zero *) 
	| BLEZ=> (6, rVal rs,       0)
	| BGTZ=> (7, rVal rs,       0)
	| BLTZ=> (1, rVal rs,       0)
	| BGEZ=> (1, rVal rs,       1) 
	| BNEL=> (21,rVal rs, rVal rt) (* r4k *)
	| BLTZL=>(1, rVal rs,       2) (* r4k *)
	| BLEZL=>(22,rVal rs,       0) (* r4k *)
	| BGTZL=>(23,rVal rs,       0) (* r4k *)
	| BGEZL=>(1, rVal rs,       3) (* r4k *)
	| BEQL=> (20,rVal rs, rVal rt) (* r4k *)
      in
	Mips_Opcodes.FORMATI2(branch', rs', rt', imm)
      end
    | assemble(FIXED_BRANCH(branch, rs, rt, imm)) = let
        val rVal = Mips_Opcodes.register_val
        val (branch', rs', rt') = case branch of
	  BA  => (4,       0,       0)
	| BEQ => (4, rVal rs, rVal rt)
        | BEQZ =>(4, rVal rs,      0) (* beq lhs zero *)
	| BNE => (5, rVal rs, rVal rt)
	| BNEZ =>(5, rVal rs,       0) (* bne lhs zero *) 
	| BLEZ=> (6, rVal rs,       0)
	| BGTZ=> (7, rVal rs,       0)
	| BLTZ=> (1, rVal rs,       0)
	| BGEZ=> (1, rVal rs,       1) 
	| BNEL=> (21,rVal rs, rVal rt) (* r4k *)
	| BLTZL=>(1, rVal rs,       2) (* r4k *)
	| BLEZL=>(22,rVal rs,       0) (* r4k *)
	| BGTZL=>(23,rVal rs,       0) (* r4k *)
	| BGEZL=>(1, rVal rs,       3) (* r4k *)
	| BEQL=> (20,rVal rs, rVal rt) (* r4k *)
      in
	Mips_Opcodes.FORMATI2(branch', rs', rt', imm)
      end
    | assemble(CALL(call, rs, imm,_)) =
      let val op1 = case call of
	BLTZAL => 16
      | BGEZAL => 17
      in
	Mips_Opcodes.FORMATI2(1, Mips_Opcodes.register_val rs, op1, imm)
      end
    | assemble(JUMP(jump, reg_or_imm, rs, _)) =
      (case reg_or_imm of
	 REG reg =>
	   (case jump of
              (* reg_or_imm is reg to jump to *)
              (* rs is irrelevant *)
	      JR => Mips_Opcodes.FORMATR2(0, Mips_Opcodes.register_val reg, 
					  0, 0, 0, 8)
            (* rs is reg to jump to *)
            (* reg_or_imm is the link register *)
	    | JALR => Mips_Opcodes.FORMATR2(0, Mips_Opcodes.register_val rs, 
					    0, Mips_Opcodes.register_val reg, 0, 9)
	    | _ => Crash.impossible "assemble JUMP reg")
       | IMM imm =>
	   (case jump of 
	      JAL => Mips_Opcodes.FORMATJ(3, imm)
	    | J => Mips_Opcodes.FORMATJ(2, imm)
	    | _ => Crash.impossible "assemble JUMP imm"))
    | assemble(FBRANCH(BC1T, imm)) = Mips_Opcodes.FORMATI2(17, 8, 1, imm)
    | assemble(FBRANCH(BC1F, imm)) = Mips_Opcodes.FORMATI2(17, 8, 0, imm)
    | assemble(CONV_OP(conv_op, fd, fs)) =
      let val (op1, fmt) = case conv_op of
	CVT_S_D => (32, 1)
      | CVT_S_W => (32, 4)
      | CVT_D_S => (33, 0)
      | CVT_D_W => (33, 4)
      | CVT_W_S => (36, 0)
      | CVT_W_D => (36, 1)
      in
	Mips_Opcodes.FORMATR2(17, 16 + fmt, 0, Mips_Opcodes.register_val fs, 
			      Mips_Opcodes.register_val fd, op1)
      end
    | assemble(FUNARY(funary, fd, fs)) =
      let val (op1, fmt) = case funary of
	MOV_S => (6, 0)
      | MOV_D => (6, 1)
      | NEG_S => (7, 0)
      | NEG_D => (7, 1)
      | ABS_S => (5, 0)
      | ABS_D => (5, 1)
      in
	Mips_Opcodes.FORMATR2(17, 16 + fmt, 0, Mips_Opcodes.register_val fs, 
			      Mips_Opcodes.register_val fd, op1)
      end
    | assemble(FBINARY(fbinary, fd, fs, ft)) =
      let val (op1, fmt) = case fbinary of
	ADD_S => (0, 0)
      | ADD_D => (0, 1)
      | SUB_S => (1, 0)
      | SUB_D => (1, 1)
      | MUL_S => (2, 0)
      | MUL_D => (2, 1)
      | DIV_S => (3, 0)
      | DIV_D => (3, 1)
      in
	Mips_Opcodes.FORMATR2(17, 16 + fmt, Mips_Opcodes.register_val ft, 
			      Mips_Opcodes.register_val fs, Mips_Opcodes.register_val fd, op1)
      end
    | assemble(FCMP(fcmp, fs, ft)) =
      let val (fmt, cond) = case fcmp of
	C_F_S    => (0, 48)
      | C_UN_S   => (0, 49)
      | C_EQ_S   => (0, 50)
      | C_UEQ_S  => (0, 51)
      | C_OLT_S  => (0, 52)
      | C_ULT_S  => (0, 53)
      | C_OLE_S  => (0, 54)
      | C_ULE_S  => (0, 55)
      | C_SF_S   => (0, 56)
      | C_NGLE_S => (0, 57)
      | C_SEQ_S  => (0, 58)
      | C_NGL_S  => (0, 59)
      | C_LT_S   => (0, 60)
      | C_NGE_S  => (0, 61)
      | C_LE_S   => (0, 62)
      | C_NGT_S  => (0, 63)
      | C_F_D    => (1, 48)
      | C_UN_D   => (1, 49)
      | C_EQ_D   => (1, 50)
      | C_UEQ_D  => (1, 51)
      | C_OLT_D  => (1, 52)
      | C_ULT_D  => (1, 53)
      | C_OLE_D  => (1, 54)
      | C_ULE_D  => (1, 55)
      | C_SF_D   => (1, 56)
      | C_NGLE_D => (1, 57)
      | C_SEQ_D  => (1, 58)
      | C_NGL_D  => (1, 59)
      | C_LT_D   => (1, 60)
      | C_NGE_D  => (1, 61)
      | C_LE_D   => (1, 62)
      | C_NGT_D  => (1, 63)
      in
	Mips_Opcodes.FORMATR2(17, 16 + fmt, Mips_Opcodes.register_val ft,
			      Mips_Opcodes.register_val fs, 0, cond)
      end
    | assemble(OFFSET i) = Mips_Opcodes.OFFSET i
    | assemble(SPECIAL_ARITHMETIC _) = Crash.impossible"assemble SPECIAL_ARITHMETIC"
    | assemble(LOAD_OFFSET _) = Crash.impossible"assemble LOAD_OFFSET"
    | assemble(SPECIAL_LOAD_OFFSET _) = Crash.impossible"assemble SPECIAL_LOAD_OFFSET"

  fun pad columns x = 
    if size x < columns then
      StringCvt.padRight #" " columns x
    else
      x ^ " "
  local val opwidth = 9 in
			  val padit = pad opwidth
  end

  fun decode_reg_or_imm(REG reg) = MachTypes.reg_to_string reg
    | decode_reg_or_imm(IMM i) = "#" ^ Int.toString i

  fun decode_reg_or_imm_nohash(REG reg) = MachTypes.reg_to_string reg
    | decode_reg_or_imm_nohash(IMM i) = Int.toString i

  type LabMap = string Map.T

  (* Unordered list of jump destinations to a map from destinations to labels *)
  fun make_labmap_from_list (destination_list) = 
    let
      (* This should be in Lists structure *)
      fun remove_duplicates ([], acc) = rev acc
        | remove_duplicates ([a], acc) = rev (a::acc)
        | remove_duplicates (a::(rest as (b :: c)), acc) = 
          if a = b then
            remove_duplicates (a::c,acc)
          else remove_duplicates (rest, a::acc)
      val sorted = remove_duplicates (Lists.qsort (op <) destination_list, [])
      fun print_label i = "L" ^ Int.toString i
      (* And generate unique ordered label strings *)
      val (labmap,_) = Lists.reducel 
        (fn ((map,n),m) => (Map.define (map,m,print_label n),n+1))
        ((Map.empty, 0), sorted)
    in 
      labmap
    end

  local

    (* i is position of current instruction *)
    (* offset is branch offset *)
    (* +1 because offsets are from the next instruction *)

    fun get_destination ((i,destinations),opcode) =
      let
        fun add_branch (i,destinations,offset) = (offset+i+1) :: destinations
        val destinations' =
          case opcode of
            BRANCH (_, _, _, offset) => add_branch (i,destinations,offset)
	  | FIXED_BRANCH (_, _, _, offset) => add_branch (i,destinations,offset)
          | FBRANCH (_, offset) => add_branch (i,destinations,offset)
          | CALL (_, _,offset,_) => add_branch (i,destinations,offset)
          | _ => destinations
      in
        (i+1,destinations')
      end

    fun align i = if i mod 2 = 0 then i else i+1

  in
    (* The diddling with +- 2 is to cope with backptr slots *)
    fun make_labmap (codelistlist) = 
      let
        val (_,destinations) = 
          Lists.reducel 
          (fn ((i,acc),codelist) => 
           (Lists.reducel
            (fn ((i,acc),code) => 
             (* Double word align just in case *)
             (* Add 2 here for the back pointer and annotation *)
             Lists.reducel get_destination ((align i + 2, acc),code))
            ((align i,acc),codelist)))
          ((0,[]),codelistlist)
      in
        make_labmap_from_list destinations
      end (* make_labmap *)

  end (* local *)

  fun print_label (labmap, current, index) = 
    Map.apply' (labmap, current+index+1) 
    handle Map.Undefined => "<Undefined:" ^ Int.toString index ^ ">"
	
  fun opcode_text (opcode,n,labmap) = 
    case opcode of
      LOAD_AND_STORE(load_and_store, reg1, reg2, imm) => 
	concat [
		 decode_load_and_store load_and_store,
		 MachTypes.reg_to_string reg1, ", ", 
		 Int.toString imm,
		 "(",
		 MachTypes.reg_to_string reg2,
		 ")"]

    | LOAD_AND_STORE_FLOAT(load_and_store_float, reg1, reg2, reg_or_imm) =>
	if (Lists.member(load_and_store_float, [MTC1, MFC1, CFC1, CTC1])) then
	  concat [
		  decode_load_and_store_float load_and_store_float,
		  MachTypes.reg_to_string reg1, ", ",
		  MachTypes.fp_reg_to_string reg2]
       else concat [
                     decode_load_and_store_float load_and_store_float,
		     MachTypes.fp_reg_to_string reg1, ", ",
		     decode_reg_or_imm_nohash reg_or_imm, "(",
		     MachTypes.reg_to_string reg2, ")"]
    | ARITHMETIC_AND_LOGICAL(SLL, MachTypes.R0, MachTypes.R0, IMM 0) => padit "nop"
    | ARITHMETIC_AND_LOGICAL(OR, reg1, reg2, REG MachTypes.R0) => 
        concat ["move   ",
                 MachTypes.reg_to_string reg1, ", ",
                 MachTypes.reg_to_string reg2]
    | ARITHMETIC_AND_LOGICAL(ADDIU, reg1, MachTypes.R0, imm) => 
        concat ["li     ",
                 MachTypes.reg_to_string reg1, ", ",
                 decode_reg_or_imm imm]

    | ARITHMETIC_AND_LOGICAL(arithmetic_and_logical, reg1, reg2, reg_or_imm) =>
	concat [
		 decode_arithmetic_and_logical arithmetic_and_logical,
		 MachTypes.reg_to_string reg1, ", ",
		 MachTypes.reg_to_string reg2, ", ",
		 decode_reg_or_imm reg_or_imm ]
    | MULT_AND_DIV(mult_and_div, reg1, reg2) =>
	concat [
		 decode_mult_and_div mult_and_div,
		 MachTypes.reg_to_string reg1, ", ",
		 MachTypes.reg_to_string reg2 ]
    | MULT_AND_DIV_RESULT(mult_and_div_result, reg) =>
	concat [
		 decode_mult_and_div_result mult_and_div_result,
		 MachTypes.reg_to_string reg ]

    | SETHI(sethi, reg, imm) =>
	concat [
		 decode_sethi sethi,
		 MachTypes.reg_to_string reg, ", #",
		 Int.toString (if imm < 0 then imm+65536 else imm) ]
    | BRANCH(BA, _, _, imm) =>
	concat [
		 decode_branch BA,
		 print_label (labmap, n, imm) ]

    | BRANCH(branch, reg1, reg2, imm) =>
	concat [
		 decode_branch branch,
		 MachTypes.reg_to_string reg1, ", ",
		 case branch of
		   BLTZ => ""
		 | BLEZ => ""
		 | BGEZ => ""
		 | BGTZ => ""
		 | _    => MachTypes.reg_to_string reg2 ^ ", ",
		 print_label (labmap, n, imm) ]

    | FIXED_BRANCH(BA, _, _, imm) =>
	concat [
		 decode_branch BA,
		 print_label (labmap, n, imm) ]

    | FIXED_BRANCH(branch, reg1, reg2, imm) =>
	concat [
		 decode_branch branch,
		 MachTypes.reg_to_string reg1, ", ",
		 case branch of
		   BLTZ => ""
		 | BLEZ => ""
		 | BGEZ => ""
		 | BGTZ => ""
		 | _    => MachTypes.reg_to_string reg2 ^ ", ",
		 print_label (labmap, n, imm) ]

    | CALL(call, reg, imm,_) =>
	concat [
		 decode_call call,
		 MachTypes.reg_to_string reg,", ",
		 print_label (labmap, n, imm) ]

    | JUMP(JR, REG rd, rs, Annotation) =>
	concat [
		 decode_jump JR,
		 MachTypes.reg_to_string rd ]
    | JUMP(JALR, REG rd, rs, Annotation) =>
	concat [
		 decode_jump JALR,
		 MachTypes.reg_to_string rd, ", ",
		 MachTypes.reg_to_string rs ]
    | JUMP(jump, IMM imm, rs, Annotation) =>
	concat [
		 decode_jump jump,
		 print_label (labmap, n, imm) ]
    | JUMP(_,_,_,_) => Crash.impossible "assemble.print JUMP has illegal mode"
    | FBRANCH(fbranch, imm) =>
	concat [
		 decode_fbranch fbranch,
		 print_label (labmap, n, imm) ]
    | CONV_OP(conv_op, reg1, reg2) =>
	concat [
		 decode_conv_op conv_op,
		 MachTypes.fp_reg_to_string reg1, ", ",
		 MachTypes.fp_reg_to_string reg2 ]
    | FUNARY(funary, reg1, reg2) =>
	concat [
		 decode_funary funary,
		 MachTypes.fp_reg_to_string reg1, ", ",
		 MachTypes.fp_reg_to_string reg2 ]
    | FBINARY(fbinary, reg1, reg2, reg3) =>
	concat [
		 decode_fbinary fbinary,
		 MachTypes.fp_reg_to_string reg1, ", ",
		 MachTypes.fp_reg_to_string reg2, ", ",
		 MachTypes.fp_reg_to_string reg3 ]
    | FCMP(fcmp, reg1, reg2) =>
	concat [
		 decode_fcmp fcmp,
		 MachTypes.fp_reg_to_string reg1, ", ",
		 MachTypes.fp_reg_to_string reg2 ]
    | OFFSET i => "OFFSET " ^ Int.toString i
    | LOAD_OFFSET(_, rd, i) =>
	concat [
		 "load_offset ",
		 MachTypes.reg_to_string rd,
		 " plus ",
		 Int.toString i ]
    | SPECIAL_ARITHMETIC _ => Crash.impossible "opcode_text SPECIAL_ARITHMETIC"
    | SPECIAL_LOAD_OFFSET _ => Crash.impossible"opcode_text SPECIAL_LOAD_OFFSET"

  (* labprint: prettyprints output with assembler labels *)
  fun labprint (opcode, i, labmap) = 
    let
      val line = opcode_text (opcode, i, labmap)
    in
      case Map.tryApply' (labmap, i) of
        SOME labelstring => (labelstring ^ ":", line)
      | _ => ("", line)
    end

(*
 Mips_Assembly.print has been bypassed by the definition MachPrint.print
*)
  local
    fun hexchar a = chr (if a < 10 then a + ord #"0" else a + ord #"a" - 10);
    fun char2_2hex ch = (str (hexchar ((ord ch) div 16))) ^ (str (hexchar ((ord ch) mod 16)))
    fun string2hex s = concat (map char2_2hex (explode s))
  in
    fun print instr =
        string2hex (Mips_Opcodes.output_opcode (assemble instr))
	^ " " ^ opcode_text (instr,0,Map.empty)

  end (* local *)

  fun reverse_branch BEQ  = BEQ (*to compare arithmetic quantities in reversed order*)
    | reverse_branch BEQZ = BEQZ (* unary instr *)
    | reverse_branch BNE  = BNE
    | reverse_branch BNEZ = BNEZ 
    | reverse_branch BA   = BA
    | reverse_branch BLEZ = BGEZ 
    | reverse_branch BGTZ = BLTZ 
    | reverse_branch BLTZ = BGTZ 
    | reverse_branch BGEZ = BLEZ
    | reverse_branch BNEL = BNEL
    | reverse_branch BLTZL= BGTZL
    | reverse_branch BLEZL= BGEZL
    | reverse_branch BGTZL= BLTZL
    | reverse_branch BGEZL= BLEZL
    | reverse_branch BEQL = BEQL


  fun inverse_branch BEQ  = BNE (*to handle control flow alterations*)
    | inverse_branch BEQZ = BNEZ
    | inverse_branch BNE  = BEQ
    | inverse_branch BNEZ = BEQZ
    | inverse_branch BLEZ = BGTZ
    | inverse_branch BGTZ = BLEZ
    | inverse_branch BLTZ = BGEZ
    | inverse_branch BGEZ = BLTZ
    | inverse_branch BNEL = BEQL
    | inverse_branch BLTZL= BGEZL
    | inverse_branch BLEZL= BGTZL
    | inverse_branch BGTZL= BLEZL
    | inverse_branch BGEZL= BLTZL
    | inverse_branch BEQL = BNEL
    | inverse_branch BA = Crash.impossible "inverse_branch BA"

  val all_windowed_regs =
    Set.list_to_set []

  val null_result = (Set.empty_set,Set.empty_set,Set.empty_set,Set.empty_set)

  fun double_funary funary =
    case funary of
      MOV_D => true
    | NEG_D => true
    | ABS_D => true
    | _ => false

  fun double_fbinary fbinary =
    case fbinary of
      ADD_D => true
    | DIV_D => true
    | MUL_D => true
    | SUB_D => true
    | _ => false

  fun double_fcmp fcmp =
    case fcmp of
      C_F_D => true
    | C_UN_D => true
    | C_EQ_D => true
    | C_UEQ_D => true
    | C_OLT_D => true
    | C_ULT_D => true
    | C_OLE_D => true
    | C_ULE_D => true
    | C_SF_D  => true
    | C_NGLE_D => true
    | C_SEQ_D => true
    | C_NGL_D => true
    | C_LT_D  => true
    | C_NGE_D => true
    | C_LE_D  => true
    | C_NGT_D => true
    | _ => false

  fun float_reg (double,reg) =
    if double then [reg,MachTypes.next_reg reg]
    else [reg]

  (* This is currently incomplete -- needs more for float operations *)

  fun defines_and_uses(LOAD_AND_STORE(operation, rd, rs1, imm)) =
    let
      val is_nil = rs1 = MachTypes.implicit
      val is_stack = rs1 = MachTypes.fp orelse rs1 = MachTypes.sp
      val is_load = 
        case operation of
          SB => false
        | SH => false
        | SW => false
        | SWL => false
        | SWR => false
        | _ => true
      val main_uses = [rs1]
      (* Which component of the store is being modified? *)
      val store =
	if is_nil then MachTypes.nil_v
	else if is_stack then MachTypes.stack
        else MachTypes.heap
      val int_defines = Set.singleton (if is_load then rd else store)
      val int_uses = Set.list_to_set (if is_load then store :: main_uses else rd :: main_uses)
      val fp_defines = if is_load then Set.empty_set else Set.singleton store
      val fp_uses = if is_load then Set.singleton store else Set.empty_set
    in
      (int_defines, int_uses, fp_defines, fp_uses)
    end

  (* Reminder:
   (MTC1, rd, rs, REG _) => MTC1 rd,rs  (* rd processor, rs coprocessor *)
   (MFC1, rd, rs, REG _) => MFC1 rd,rs  (* rd processor, rs coprocessor *)
   (CFC1, rt, rd, REG _) => CFC1 rt,rd  (* rt processor, rd coprocessor *)
   (CTC1, rt, rd, REG _) => CTC1 rt,rd  (* rt processor, rd coprocessor *)
   (LWC1, rd, rs, IMM i) => LWC1 rd,i(rs)
   (SWC1, rd, rs, IMM i) => SWC1 rd,i(rs)
   *)

  | defines_and_uses(LOAD_AND_STORE_FLOAT(operation, rd, rs, reg_or_imm)) =
    (case reg_or_imm of
       REG _ =>
         (case operation of
            MTC1 => (Set.empty_set, Set.singleton rd, Set.singleton rs, Set.empty_set)
          | MFC1 => (Set.singleton rd, Set.empty_set, Set.empty_set, Set.singleton rs)
	  | CFC1 => (Set.singleton rd, Set.empty_set, Set.empty_set, Set.singleton rs)
	  | CTC1 => (Set.empty_set, Set.singleton rd, Set.singleton rs, Set.empty_set)
          | _ => Crash.impossible "defines_and_uses LOAD_AND_STORE_FLOAT reg")
     | IMM _ =>
         let
           val is_nil = rs = MachTypes.implicit
           val is_stack = rs = MachTypes.fp orelse rs = MachTypes.sp
           val store =
             if is_nil then MachTypes.nil_v
             else if is_stack then MachTypes.stack
             else MachTypes.heap
         in
           case operation of
             LWC1 => (Set.empty_set,
                      Set.list_to_set [rs,store],
                      Set.singleton rd,
                      Set.singleton store)
           | SWC1 => (Set.singleton store,
                      Set.singleton rs,
                      Set.singleton store,
                      Set.singleton rd)
           | _ => Crash.impossible "defines_and_uses LOAD_AND_STORE_FLOAT imm"
         end)
  | defines_and_uses(ARITHMETIC_AND_LOGICAL(opcode, rd, rs1, reg_or_imm)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
     (* If either stack register used then treat this as updating the stack *)
     (* This prevents stack stores and loads being moved across *)
      (* This is a gross hack and should be done properly sometime *)
      val stack_used = 
        rs1 = MachTypes.fp orelse rs2 = MachTypes.fp orelse
        rs1 = MachTypes.sp orelse rs2 = MachTypes.sp
      (* The exception raising operations use the handler register *)
      val handler_regs = 
        case opcode of
          ADD => [Mips_Opcodes.MachTypes.handler]
        | ADDI => [Mips_Opcodes.MachTypes.handler]
        | SUB => [Mips_Opcodes.MachTypes.handler]
        | _ => []
    in
      (if stack_used then Set.list_to_set [rd,MachTypes.stack] else Set.singleton rd,
       Set.list_to_set(handler_regs @ [rs1, rs2]),
       Set.empty_set,
       Set.empty_set)
    end
  | defines_and_uses(SPECIAL_ARITHMETIC (opcode, rd, reg_or_imm,rs1)) = 
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
      (* Just in case *)
      val stack_used = 
        rs1 = MachTypes.fp orelse rs2 = MachTypes.fp orelse
        rs1 = MachTypes.sp orelse rs2 = MachTypes.sp
    in
      (if stack_used then Set.list_to_set [rd,MachTypes.stack] else Set.singleton rd,
       Set.list_to_set[rs1, rs2],
       Set.empty_set,
       Set.empty_set)
    end
  | defines_and_uses(MULT_AND_DIV (_,r1,r2)) = 
    (Set.singleton MachTypes.mult_result,
     Set.list_to_set [r1,r2],
     Set.empty_set,
     Set.empty_set)
  | defines_and_uses(MULT_AND_DIV_RESULT (_,r)) = 
     (Set.singleton r,
      Set.singleton MachTypes.mult_result,
      Set.empty_set,
      Set.empty_set)
  | defines_and_uses(SETHI(_, rd, i)) =
    (Set.singleton rd, Set.empty_set,Set.empty_set, Set.empty_set)
  | defines_and_uses(BRANCH(branch,rs1,rs2,i)) =
    (Set.empty_set,
     Set.list_to_set [rs1,rs2],
     Set.empty_set, Set.empty_set)
  | defines_and_uses(FIXED_BRANCH(branch,rs1,rs2,i)) =
    (Set.empty_set,
     Set.list_to_set [rs1,rs2],
     Set.empty_set, Set.empty_set)
  | defines_and_uses(CALL (_,reg,_,_)) =
    (Set.singleton MachTypes.lr, Set.singleton reg,
     Set.empty_set, Set.empty_set)
  | defines_and_uses(JUMP(jump,reg_or_imm, rs1,_)) =
    (case reg_or_imm of
       REG reg =>
         (case jump of
            JR => (Set.empty_set,Set.singleton reg,Set.empty_set,Set.empty_set)
          | JALR => (Set.singleton reg,Set.singleton rs1,Set.empty_set,Set.empty_set)
          | _ => Crash.impossible "defines_and_uses JUMP reg")
     | IMM imm =>
         (case jump of
            JAL => (Set.singleton MachTypes.lr,Set.empty_set,Set.empty_set,Set.empty_set)
          | J => (Set.empty_set,Set.empty_set,Set.empty_set,Set.empty_set)
          | _ => Crash.impossible "defines_and_uses JUMP imm"))

  | defines_and_uses(FBRANCH(fbranch,imm)) =
    (Set.empty_set,Set.empty_set,Set.empty_set,Set.singleton MachTypes.cond)

  (* CVT_fmt1_fmt2 converts _from_ fmt2 _to_ fmt1 *)
  | defines_and_uses(CONV_OP(conv_op, rd, rs)) =
    (case conv_op of
       CVT_S_D => (Set.empty_set,Set.empty_set,Set.singleton rd,Set.list_to_set (float_reg (true,rs)))
     | CVT_S_W => (Set.empty_set,Set.empty_set,Set.singleton rd,Set.singleton rs)
     | CVT_D_W => (Set.empty_set,Set.empty_set,Set.list_to_set (float_reg (true,rd)),Set.singleton rs)
     | CVT_D_S => (Set.empty_set,Set.empty_set,Set.list_to_set (float_reg (true,rd)),Set.singleton rs)
     | CVT_W_D => (Set.empty_set,Set.empty_set,Set.singleton rd,Set.list_to_set (float_reg (true,rs)))
     | CVT_W_S => (Set.empty_set,Set.empty_set,Set.singleton rd,Set.singleton rs))

  | defines_and_uses(FUNARY(funary, rd, rs2)) = 
    let
      val double = double_funary funary
    in
      (Set.empty_set,
       Set.empty_set,
       Set.list_to_set (float_reg (double,rd)),
       Set.list_to_set (float_reg (double,rs2)))
    end

  | defines_and_uses(FBINARY(fbinary, rd, rs1, rs2)) = 
    let
      val double = double_fbinary fbinary
    in
      (Set.empty_set,
       Set.empty_set,
       Set.list_to_set (float_reg (double,rd)),
       Set.list_to_set (float_reg (double,rs1) @ float_reg (double,rs2)))
    end

  | defines_and_uses(FCMP (fcmp,rs1,rs2)) =
    let
      val double = double_fcmp fcmp
    in
      (Set.empty_set,
       Set.empty_set,
       Set.singleton MachTypes.cond,
       Set.list_to_set (float_reg (double,rs1) @ float_reg (double,rs2)))
    end

  | defines_and_uses(OFFSET _) = null_result

  | defines_and_uses (LOAD_OFFSET (_,reg,_)) =
    (Set.singleton reg,Set.empty_set,Set.empty_set,Set.empty_set)

  | defines_and_uses (SPECIAL_LOAD_OFFSET (_,rd,rs,_)) =
    (Set.singleton rd,Set.singleton rs,Set.empty_set,Set.empty_set)

  (* A hack to remove references to the zero register *)
  val defines_and_uses =
    fn opcode =>
    let 
      val (int_defines,int_uses,fp_defines,fp_uses) = defines_and_uses opcode
    in
      (Set.setdiff (int_defines,Set.singleton MachTypes.R0),
       Set.setdiff (int_uses,Set.singleton MachTypes.R0),
       fp_defines,
       fp_uses)
    end
    
  val nop_code = ARITHMETIC_AND_LOGICAL(SLL, MachTypes.R0, MachTypes.R0, IMM 0)
  (* Used for tracing *)
  val trace_nop_code = ARITHMETIC_AND_LOGICAL(SRL, MachTypes.R0, MachTypes.R0, IMM 0)
  (* Used for nops we don't want rescheduled *)
  val other_nop_code = ARITHMETIC_AND_LOGICAL(SRA, MachTypes.R0, MachTypes.R0, IMM 0)

  val nop = (nop_code, NONE, "")
  fun nopc comment = (nop_code, NONE, comment)
   
end
