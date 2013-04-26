(* _sparc_assembly.sml the functor *)
(*
$Log: _sparc_assembly.sml,v $
Revision 1.37  1997/01/17 16:18:31  matthew
Adding multiply instructions

 * Revision 1.36  1996/11/06  11:10:24  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.35  1996/10/29  18:09:42  io
 * moving String from toplevel
 *
 * Revision 1.34  1996/04/30  17:00:37  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.33  1996/04/29  15:31:46  matthew
 * removing MLWorks.Integer
 *
 * Revision 1.32  1995/12/22  13:00:22  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.31  1995/07/28  09:18:32  matthew
Putting sources registers for various instructions in correct order

Revision 1.30  1995/02/10  10:15:34  matthew
Adding debug information to Call instructions

Revision 1.29  1994/10/18  10:25:40  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.28  1994/06/27  15:32:29  jont
Fix reverse_branch to understand unsigned comparisons

Revision 1.27  1994/03/24  11:06:49  matthew
No reason?

Revision 1.26  1994/03/23  17:53:11  matthew
Improved printing:
  names for registers
  alignment of arguments
Fixed bug with mutually recursive functions

Revision 1.25  1994/03/21  18:11:39  matthew
Print opcodes etc. in lower case
Print moves as MOV.
Add labels to printed output

Revision 1.24  1994/03/10  12:18:32  jont
Adding load offset instructions

Revision 1.23  1993/08/23  16:54:30  jont
Added extra function inverse_branch to handle flow control alterations.
reverse_branch is for handling comparing arithmetic quantities in
reversed order. This fixes a long standing unobserved bug.

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basis/__int";

require "../utils/crash";
require "../utils/lists";
require "../utils/intnewmap";
require "../mir/mirtypes";
require "sparc_opcodes";
require "sparc_assembly";

functor Sparc_Assembly(
  structure Crash : CRASH
  structure Lists : LISTS
  structure Map : INTNEWMAP
  structure MirTypes : MIRTYPES
  structure Sparc_Opcodes : SPARC_OPCODES
  ) : SPARC_ASSEMBLY =
struct
  structure MirTypes = MirTypes
  structure Set = MirTypes.Set
  structure Sparc_Opcodes = Sparc_Opcodes
  structure MachTypes = Sparc_Opcodes.MachTypes
  structure Debugger_Types = MirTypes.Debugger_Types

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
    REG of MachTypes.Sparc_Reg |
    IMM of int

  datatype read_state = RDY
  datatype write_state = WRY

  datatype opcode =
    LOAD_AND_STORE of
      load_and_store * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm |
    LOAD_AND_STORE_FLOAT of
      load_and_store_float * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm |
    ARITHMETIC_AND_LOGICAL of
      arithmetic_and_logical * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm |
    SPECIAL_ARITHMETIC of
      special_arithmetic * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm |
    TAGGED_ARITHMETIC of
      tagged_arithmetic *  MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm |
    SetHI of sethi * MachTypes.Sparc_Reg * int |
    SAVE_AND_RESTORE of
      save_and_restore * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm |
    BRANCH of branch * int |
    BRANCH_ANNUL of branch * int |
    Call of call * int * MirTypes.Debugger_Types.Backend_Annotation |
    JUMP_AND_LINK of jump_and_link * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg * reg_or_imm * 
    Debugger_Types.Backend_Annotation |
    FBRANCH of fbranch * int |
    FBRANCH_ANNUL of fbranch * int |
    CONV_OP of conv_op * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg |
    FUNARY of funary * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg |
    FBINARY of fbinary * MachTypes.Sparc_Reg * MachTypes.Sparc_Reg *
    MachTypes.Sparc_Reg |
    LOAD_OFFSET of load_offset * Sparc_Opcodes.MachTypes.Sparc_Reg * int |
    SPECIAL_LOAD_OFFSET of special_load_offset * Sparc_Opcodes.MachTypes.Sparc_Reg * Sparc_Opcodes.MachTypes.Sparc_Reg * int |
    READ_STATE of read_state * Sparc_Opcodes.MachTypes.Sparc_Reg |
    WRITE_STATE of write_state * Sparc_Opcodes.MachTypes.Sparc_Reg * reg_or_imm

  fun assemble(LOAD_AND_STORE(load_and_store, rd, rs1, reg_or_imm)) =
    let
      val op3 = case load_and_store of
	LDSB => 9
      | LDSH => 10
      | LDUB => 1
      | LDUH => 2
      | LD => 0
      | LDD => 3
      | STB => 5
      | STH => 6
      | ST => 4
      | STD => 7
    in
      case reg_or_imm of
	REG reg =>
	  Sparc_Opcodes.FORMAT3A(3, rd, op3, rs1, false, 0, reg)
      | IMM simm13 =>
	  Sparc_Opcodes.FORMAT3B(3, rd, op3, rs1, true, simm13)
    end
  | assemble(LOAD_AND_STORE_FLOAT(load_and_store, rd, rs1, reg_or_imm)) =
    let
      val op3 = case load_and_store of
	LDF => 32
      | LDDF => 35
      | STF => 36
      | STDF => 39
    in
      case reg_or_imm of
	REG reg =>
	  Sparc_Opcodes.FORMAT3A(3, rd, op3, rs1, false, 0, reg)
      | IMM simm13 =>
	  Sparc_Opcodes.FORMAT3B(3, rd, op3, rs1, true, simm13)
    end
  | assemble(ARITHMETIC_AND_LOGICAL(arithmetic_and_logical, rd, rs1,reg_or_imm)) =
    let
      val op3 = case arithmetic_and_logical of
	ADD => 0
      | ADDCC => 16
      | ADDX => 8
      | ADDXCC => 24
      | SUB => 4
      | SUBCC => 20
      | SUBX => 12
      | SUBXCC => 28
      | AND => 1
      | ANDCC => 17
      | ANDN => 5
      | ANDNCC => 21
      | OR => 2
      | ORCC => 18
      | ORN => 6
      | ORNCC => 22
      | XOR => 3
      | XORCC => 19
      | XORN => 7
      | XORNCC => 23
      | SLL => 37
      | SRL => 38
      | SRA => 39
      | UMUL => 10
      | SMUL => 11
      | UMULCC => 26
      | SMULCC => 27
      | UDIV => 14
      | SDIV => 15
      | UDIVCC => 30
      | SDIVCC => 31
    in
      case reg_or_imm of
	REG rs2 => Sparc_Opcodes.FORMAT3A(2, rd, op3, rs1, false, 0, rs2)
      | IMM simm13 => Sparc_Opcodes.FORMAT3B(2, rd, op3, rs1, true, simm13)
    end
  | assemble(TAGGED_ARITHMETIC(tagged_arithmetic, rd, rs1, reg_or_imm)) =
    let
      val op3 = case tagged_arithmetic of
        TADDCC => 32
      | TADDCCTV => 34
      | TSUBCC => 33
      | TSUBCCTV => 35
    in
      case reg_or_imm of
	REG rs2 => Sparc_Opcodes.FORMAT3A(2, rd, op3, rs1, false, 0, rs2)
      | IMM simm13 => Sparc_Opcodes.FORMAT3B(2, rd, op3, rs1, true, simm13)
    end
  | assemble(SetHI(_, rd, imm22)) =
    Sparc_Opcodes.FORMAT2A(rd, 4, imm22)
  | assemble(SAVE_AND_RESTORE(save_and_restore, rd, rs1, reg_or_imm)) =
    let
      val op3 = case save_and_restore of
	SAVE => 60
      | RESTORE => 61
    in
      case reg_or_imm of
	REG rs2 => Sparc_Opcodes.FORMAT3A(2, rd, op3, rs1, false, 0, rs2)
      | IMM simm13 => Sparc_Opcodes.FORMAT3B(2, rd, op3, rs1, true, simm13)
    end
  | assemble(BRANCH(branch, disp22)) =
    let
      val cond = case branch of
        BA => 8
      | BN => 0
      | BNE => 9
      | BE => 1
      | BG => 10
      | BLE => 2
      | BGE => 11
      | BL => 3
      | BGU => 12
      | BLEU => 4
      | BCC => 13
      | BCS => 5
      | BPOS => 14
      | BNEG => 6
      | BVC => 15
      | BVS => 7
    in
      Sparc_Opcodes.FORMAT2B(false, cond, 2, disp22)
    end
  | assemble(BRANCH_ANNUL(branch, disp22)) =
    let
      val cond = case branch of
        BA => 8
      | BN => 0
      | BNE => 9
      | BE => 1
      | BG => 10
      | BLE => 2
      | BGE => 11
      | BL => 3
      | BGU => 12
      | BLEU => 4
      | BCC => 13
      | BCS => 5
      | BPOS => 14
      | BNEG => 6
      | BVC => 15
      | BVS => 7
    in
      Sparc_Opcodes.FORMAT2B(true, cond, 2, disp22)
    end
  | assemble(Call(call, disp30,_)) =
    Sparc_Opcodes.FORMAT1 disp30
  | assemble(JUMP_AND_LINK(jump_and_link, rd, rs1, reg_or_imm,_)) =
    let
      val op3 = 56
    in
      case reg_or_imm of
	REG rs2 => Sparc_Opcodes.FORMAT3A(2, rd, op3, rs1, false, 0, rs2)
      | IMM simm13 => Sparc_Opcodes.FORMAT3B(2, rd, op3, rs1, true, simm13)
    end
  | assemble(FBRANCH(fbranch, disp22)) =
    let
      val cond = case fbranch of
	FBA => 8
      | FBN => 0
      | FBU => 7
      | FBG => 6
      | FBUG => 5
      | FBL => 4
      | FBUL => 3
      | FBLG => 2
      | FBNE => 1
      | FBE => 9
      | FBUE => 10
      | FBGE => 11
      | FBUGE => 12
      | FBLE => 13
      | FBULE => 14
      | FBO => 15
    in
      Sparc_Opcodes.FORMAT2B(false, cond, 6, disp22)
    end
  | assemble(FBRANCH_ANNUL(fbranch, disp22)) =
    let
      val cond = case fbranch of
	FBA => 8
      | FBN => 0
      | FBU => 7
      | FBG => 6
      | FBUG => 5
      | FBL => 4
      | FBUL => 3
      | FBLG => 2
      | FBNE => 1
      | FBE => 9
      | FBUE => 10
      | FBGE => 11
      | FBUGE => 12
      | FBLE => 13
      | FBULE => 14
      | FBO => 15
    in
      Sparc_Opcodes.FORMAT2B(true, cond, 6, disp22)
    end
  | assemble(CONV_OP(conv_op, rd, rs2)) =
    let
      val opf = case conv_op of
	FITOS => 196
      | FITOD => 200
      | FITOX => 204
      | FSTOI => 209
      | FDTOI => 210
      | FXTOI => 211
    in
      Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0, opf, rs2)
    end
  | assemble(FUNARY(FMOV, rd, rs2))   = Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0,  1, rs2)
  | assemble(FUNARY(FNEG, rd, rs2))   = Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0,  5, rs2)
  | assemble(FUNARY(FABS, rd, rs2))   = Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0,  9, rs2)
  | assemble(FUNARY(FSQRTS, rd, rs2)) = Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0, 41, rs2)
  | assemble(FUNARY(FSQRTD, rd, rs2)) = Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0, 42, rs2)
  | assemble(FUNARY(FSQRTX, rd, rs2)) = Sparc_Opcodes.FORMAT3C(2, rd, 52, MachTypes.G0, 43, rs2)
  | assemble(FUNARY(FCMPS, rd, rs2))  = Sparc_Opcodes.FORMAT3C(2, MachTypes.G0, 53, rd, 81, rs2)
  | assemble(FUNARY(FCMPD, rd, rs2))  = Sparc_Opcodes.FORMAT3C(2, MachTypes.G0, 53, rd, 82, rs2)
  | assemble(FUNARY(FCMPX, rd, rs2))  = Sparc_Opcodes.FORMAT3C(2, MachTypes.G0, 53, rd, 83, rs2)
  | assemble(FBINARY(fbinary, rd, rs1, rs2)) =
    let
      val opf = case fbinary of
	FADDS => 65
      | FADDD => 66
      | FADDX => 67
      | FSUBS => 69
      | FSUBD => 70
      | FSUBX => 71
      | FMULS => 73
      | FMULD => 74
      | FMULX => 75
      | FDIVS => 77
      | FDIVD => 78
      | FDIVX => 79
    in
      Sparc_Opcodes.FORMAT3C(2, rd, 52, rs1, opf, rs2)
    end
  | assemble(READ_STATE (opcode,rd)) =
    let
      val (rs1,op3) = case opcode of
        RDY => (MachTypes.G0 (* For register value 0 *),
                40)
    in
      Sparc_Opcodes.FORMAT3A(2,rd, op3, rs1,false,0,MachTypes.G0)
    end
  | assemble(WRITE_STATE (opcode,rs1,reg_or_imm)) =
    let
      val (rd,op3) = case opcode of
        WRY => (MachTypes.G0 (* For register value 0 *),
                48)
    in
      case reg_or_imm of
        REG rs2 => Sparc_Opcodes.FORMAT3A(2,rd, op3, rs1,false,0,rs2)
      | IMM simm13 => Sparc_Opcodes.FORMAT3B(2,rd, op3, rs1,true,simm13)
    end
  | assemble(SPECIAL_ARITHMETIC _) = Crash.impossible"assemble SPECIAL_ARITHMETIC"
  | assemble(LOAD_OFFSET _) = Crash.impossible"assemble LOAD_OFFSET"
  | assemble(SPECIAL_LOAD_OFFSET _) = Crash.impossible"assemble SPECIAL_LOAD_OFFSET"

  val opwidth = 9

  fun make_spaces (string,n) =
    let
      fun mk (0,acc) = acc
        | mk (n,acc) = mk (n-1," " :: acc)
    in
      concat (string :: mk (n,[]))
    end

  fun pad columns x =
    if size x < columns
      then 
        make_spaces (x,columns-size x)
    (* ensure at least one space *)
    else x ^ " "

  val padit = pad opwidth

  fun decode_load_and_store' LDSB = "ldsb"
  | decode_load_and_store' LDSH = "ldsh"
  | decode_load_and_store' LDUB = "ldub"
  | decode_load_and_store' LDUH = "lduh"
  | decode_load_and_store' LD = "ld"
  | decode_load_and_store' LDD = "ldd"
  | decode_load_and_store' STB = "stb"
  | decode_load_and_store' STH = "sth"
  | decode_load_and_store' ST = "st"
  | decode_load_and_store' STD = "std"

  val decode_load_and_store = (padit o decode_load_and_store')

  fun decode_load_and_store_float' LDF = "ldf"
  | decode_load_and_store_float' LDDF = "lddf"
  | decode_load_and_store_float' STF = "stf"
  | decode_load_and_store_float' STDF = "stdf"

  val decode_load_and_store_float = padit o decode_load_and_store_float'

  fun decode_arith' ADD = "add"
  | decode_arith' ADDCC = "addcc"
  | decode_arith' ADDX = "addx"
  | decode_arith' ADDXCC = "addxcc"
  | decode_arith' SUB = "sub"
  | decode_arith' SUBCC = "subcc"
  | decode_arith' SUBX = "subx"
  | decode_arith' SUBXCC = "subxcc"
  | decode_arith' AND = "and"
  | decode_arith' ANDCC = "andcc"
  | decode_arith' ANDN = "andn"
  | decode_arith' ANDNCC = "andncc"
  | decode_arith' OR = "or"
  | decode_arith' ORCC = "orcc"
  | decode_arith' ORN = "orn"
  | decode_arith' ORNCC = "orncc"
  | decode_arith' XOR = "xor"
  | decode_arith' XORCC = "xorcc"
  | decode_arith' XORN = "xorn"
  | decode_arith' XORNCC = "xorncc"
  | decode_arith' SLL = "sll"
  | decode_arith' SRL = "srl"
  | decode_arith' SRA = "sra"
  | decode_arith' UMUL = "umul"
  | decode_arith' SMUL = "smul"
  | decode_arith' UMULCC = "umulcc"
  | decode_arith' SMULCC = "smulcc"
  | decode_arith' UDIV = "udiv"
  | decode_arith' SDIV = "sdiv"
  | decode_arith' UDIVCC = "udivcc"
  | decode_arith' SDIVCC = "sdivcc"

  val decode_arith = padit o decode_arith'

  fun decode_tagged_arithmetic' TADDCC = "taddcc"
  | decode_tagged_arithmetic' TADDCCTV = "taddcctv"
  | decode_tagged_arithmetic' TSUBCC = "tsubcc"
  | decode_tagged_arithmetic' TSUBCCTV = "tsubcctv"

  val decode_tagged_arithmetic = padit o decode_tagged_arithmetic'

  fun decode_save_and_restore' SAVE = "save"
  | decode_save_and_restore' RESTORE = "restore"

  val decode_save_and_restore = padit o decode_save_and_restore'

  fun decode_branch' BA = "ba"
  | decode_branch' BN = "bn"
  | decode_branch' BNE = "bne"
  | decode_branch' BE = "be"
  | decode_branch' BG = "bg"
  | decode_branch' BLE = "ble"
  | decode_branch' BGE = "bge"
  | decode_branch' BL = "bl"
  | decode_branch' BGU = "bgu"
  | decode_branch' BLEU = "bleu"
  | decode_branch' BCC = "bcc"
  | decode_branch' BCS = "bcs"
  | decode_branch' BPOS = "bpos"
  | decode_branch' BNEG = "bneg"
  | decode_branch' BVC = "bvc"
  | decode_branch' BVS = "bvs"

  fun decode_branch opcode = padit (decode_branch' opcode)
  fun decode_branch_annulled opcode = padit (decode_branch' opcode ^ " a")

  fun decode_fbranch' FBA = "fba"
  | decode_fbranch' FBN = "fbn"
  | decode_fbranch' FBU = "fbu"
  | decode_fbranch' FBG = "fbg"
  | decode_fbranch' FBUG = "fbug"
  | decode_fbranch' FBL = "fbl"
  | decode_fbranch' FBUL = "fbul"
  | decode_fbranch' FBLG = "fblg"
  | decode_fbranch' FBNE = "fbne"
  | decode_fbranch' FBE = "fbe"
  | decode_fbranch' FBUE = "fbue"
  | decode_fbranch' FBGE = "fbge"
  | decode_fbranch' FBUGE = "fbuge"
  | decode_fbranch' FBLE = "fble"
  | decode_fbranch' FBULE = "fbule"
  | decode_fbranch' FBO = "fbo"

  fun decode_fbranch opcode = pad opwidth (decode_fbranch' opcode)
  fun decode_fbranch_annulled opcode = pad opwidth (decode_fbranch' opcode ^ " a")

  fun decode_conv_op' FITOS = "fitos"
  | decode_conv_op' FITOD = "fitod"
  | decode_conv_op' FITOX = "fitox"
  | decode_conv_op' FSTOI = "fstoi"
  | decode_conv_op' FDTOI = "fdtoi"
  | decode_conv_op' FXTOI = "fxtoi"

  val decode_conv_op = padit o decode_conv_op'

  fun decode_funary' FMOV = "fmov"
  | decode_funary' FNEG = "fneg"
  | decode_funary' FABS = "fabs"
  | decode_funary' FSQRTS = "fsqrts"
  | decode_funary' FSQRTD = "fsqrtd"
  | decode_funary' FSQRTX = "fsqrtx"
  | decode_funary' FCMPS = "fcmps"
  | decode_funary' FCMPD = "fcmpd"
  | decode_funary' FCMPX = "fcmpx"

  val decode_funary = padit o decode_funary'

  fun decode_fbinary' FADDS = "fadds"
  | decode_fbinary' FADDD = "faddd"
  | decode_fbinary' FADDX = "faddx"
  | decode_fbinary' FSUBS = "fsubs"
  | decode_fbinary' FSUBD = "fsubd"
  | decode_fbinary' FSUBX = "fsubx"
  | decode_fbinary' FMULS = "fmuls"
  | decode_fbinary' FMULD = "fmuld"
  | decode_fbinary' FMULX = "fmulx"
  | decode_fbinary' FDIVS = "fdivs"
  | decode_fbinary' FDIVD = "fdivd"
  | decode_fbinary' FDIVX = "fdivx"

  val decode_fbinary = padit o decode_fbinary'

  fun decode_reg_or_imm (REG reg) = MachTypes.reg_to_string reg
  | decode_reg_or_imm (IMM i) = "#" ^ Int.toString i

  local
    fun add_branch (i,(n,labs)) =
      (n+1,(i+n)::labs)
  in
    fun get_lab (w,BRANCH (_,i)) =
      add_branch (i,w)
      | get_lab (w,BRANCH_ANNUL (_,i)) =
        add_branch (i,w)
      | get_lab (w,FBRANCH (_,i)) =
        add_branch (i,w)
      | get_lab (w,FBRANCH_ANNUL (_,i)) =
        add_branch (i,w)
      | get_lab (w,Call(_,i,_)) =
        add_branch (i,w)
      | get_lab ((n,labs),_) = (n+1,labs)
  end

  type LabMap = string Map.T

  fun make_labmap_from_list l =
    let
      fun remove_duplicates ([],acc) = acc
        | remove_duplicates ([a],acc) = a::acc
        | remove_duplicates (a::(rest as (b :: c)),acc) =
          if a = b 
            then remove_duplicates (a::c,acc)
          else remove_duplicates (rest,a::acc)
      val sorted = rev (remove_duplicates (Lists.qsort (op <) l,[]))
      fun print_label i =
        "L" ^ Int.toString i
      val (labmap,_) =
        Lists.reducel
        (fn ((map,n),m) => (Map.define (map,m,print_label n),n+1))
        ((Map.empty,0),sorted)
    in
      labmap
    end

  fun align n = if n mod 2 = 0 then n else n+1

  (* The diddling with +2 & align is to cope with backptr slots and alignment *)
  fun make_labmap (codelistlist) =
    let
      val (_,lablist) =
        Lists.reducel 
        (fn ((n,acc),codelist) => 
         (Lists.reducel 
          (fn ((n,acc),code) => Lists.reducel get_lab ((align (n+2),acc),code))
          ((align n,acc),codelist)))
        ((0,[]),codelistlist)
    in
      make_labmap_from_list lablist
    end

  fun print_label (labmap,current,index) =
    Map.apply'(labmap,current+index)
    handle Map.Undefined => "<Undefined:" ^ Int.toString index ^ ">"

  fun print' (LOAD_AND_STORE(load_and_store, rd, rs1, reg_or_imm),n,labmap) =
    concat
    [decode_load_and_store load_and_store,
     MachTypes.reg_to_string rd,
     ", [",
     MachTypes.reg_to_string rs1,
     ", ",
     decode_reg_or_imm reg_or_imm ^ "]"]
    | print'(LOAD_AND_STORE_FLOAT(load_and_store_float, rd, rs1, reg_or_imm),n,labmap) =
      concat
      [decode_load_and_store_float load_and_store_float,
       MachTypes.fp_reg_to_string rd,
       ", [",
       MachTypes.reg_to_string rs1,
       ", ",
       decode_reg_or_imm reg_or_imm ^ "]"]
    | print'(ARITHMETIC_AND_LOGICAL(arithmetic_and_logical, rd, rs1,reg_or_imm),n,labmap) =
      (* Put in a little hack to print moves separately *)
      (case (arithmetic_and_logical,rd,reg_or_imm,rs1) of
        (OR,_,REG (MachTypes.G0),_) =>
          concat [padit "mov",
                   MachTypes.reg_to_string rd,
                   ", ",
                   MachTypes.reg_to_string rs1]
      | (OR,_,_,MachTypes.G0) =>
          concat [padit "mov",
                   MachTypes.reg_to_string rd,
                   ", ",
                   decode_reg_or_imm reg_or_imm]
      | (AND,MachTypes.G0,IMM 0,MachTypes.G0) =>
          padit "nop"
      | (ADD,_,IMM _,MachTypes.G0) =>
          concat
          [padit "li",
           MachTypes.reg_to_string rd,
           ", ",
           decode_reg_or_imm reg_or_imm]
      | _ =>
          concat
          [decode_arith arithmetic_and_logical,
           MachTypes.reg_to_string rd,
           ", ",
           MachTypes.reg_to_string rs1,
           ", ",
           decode_reg_or_imm reg_or_imm])
    | print'(TAGGED_ARITHMETIC(tagged_arithmetic, rd, rs1, reg_or_imm),n,labmap) =
      concat
      [decode_tagged_arithmetic tagged_arithmetic,
       MachTypes.reg_to_string rd,
       ", ",
       MachTypes.reg_to_string rs1,
       ", ",
       decode_reg_or_imm reg_or_imm]
    | print'(SetHI(sethi, MachTypes.G0, 0),n,labmap) =
      padit "inop"
    | print'(SetHI(sethi, rd, i),n,labmap) =
      concat
      [padit "sethi",
       MachTypes.reg_to_string rd,
       " ",
       Int.toString i]
    | print'(SAVE_AND_RESTORE(RESTORE, MachTypes.G0, MachTypes.G0, IMM 0),n,labmap) =
      padit "restore"
    | print'(SAVE_AND_RESTORE(save_and_restore, rd, rs1, reg_or_imm),n,labmap) =
      concat
      [decode_save_and_restore save_and_restore,
       MachTypes.reg_to_string rd,
       ", ",
       MachTypes.reg_to_string rs1,
       ", ",
       decode_reg_or_imm reg_or_imm]
    | print'(BRANCH(branch, i),n,labmap) =
      concat
      [decode_branch branch,
       print_label (labmap,n,i)]
    | print'(BRANCH_ANNUL(branch, i),n,labmap) =
      concat
      [decode_branch_annulled branch,print_label(labmap,n,i)]
    | print'(Call(call, i,_),n,labmap) =
      concat
      [padit "call",
       print_label(labmap,n,i)]
    | print'(JUMP_AND_LINK(jump_and_link, MachTypes.G0,MachTypes.O7, IMM 8, _),n,labmap) =
      padit "retl"
    | print'(JUMP_AND_LINK(jump_and_link, MachTypes.G0,MachTypes.I7, IMM 8, _),n,labmap) =
      padit "ret"
    | print'(JUMP_AND_LINK(jump_and_link, MachTypes.G0, rs1, reg_or_imm,_),n,labmap) =
      concat
      [padit "jmp",
       MachTypes.reg_to_string rs1,
       ", ",
       decode_reg_or_imm reg_or_imm]
    | print'(JUMP_AND_LINK(jump_and_link, rd, rs1, reg_or_imm,_),n,labmap) =
      concat
      [padit "jmpl",
       MachTypes.reg_to_string rd,
       ", ",
       MachTypes.reg_to_string rs1,
       ", ",
       decode_reg_or_imm reg_or_imm]
    | print'(FBRANCH(fbranch, i),n,labmap) =
      concat
      [decode_fbranch fbranch,
       print_label(labmap,n,i)]
    | print'(FBRANCH_ANNUL(fbranch, i),n,labmap) =
      concat
      [decode_fbranch_annulled fbranch,print_label(labmap,n,i)]
    | print'(CONV_OP(conv_op, rd, rs2),n,labmap) =
      concat
      [decode_conv_op conv_op,
       MachTypes.fp_reg_to_string rd,
       ", ",
       MachTypes.fp_reg_to_string rs2]
    | print'(FUNARY(funary, rd, rs2),n,labmap) =
      concat
      [decode_funary funary,
       MachTypes.fp_reg_to_string rd,
       ", ",
       MachTypes.fp_reg_to_string rs2]
    | print'(FBINARY(fbinary, rd, rs1, rs2),n,labmap) =
      concat
      [decode_fbinary fbinary,
       MachTypes.fp_reg_to_string rd,
       ", ",
       MachTypes.fp_reg_to_string rs1,
       ", ",
       MachTypes.fp_reg_to_string rs2]
    | print'(LOAD_OFFSET(_, rd, i),n,labmap) =
      concat
      [padit "load_offset",
       MachTypes.reg_to_string rd,
       " plus ",
       Int.toString i]
    | print'(READ_STATE (RDY, rd),n,labmap) =
      concat
      [padit "rd",
       MachTypes.reg_to_string rd,
       ", %y"]
    | print'(WRITE_STATE (WRY, rd,reg_or_imm),n,labmap) =
      concat
      [padit "wr",
       "%y, ",
       MachTypes.reg_to_string rd,
       ", ",
       decode_reg_or_imm reg_or_imm]
    | print'(SPECIAL_ARITHMETIC _,n,labmap) = Crash.impossible"print SPECIAL_ARITHMETIC"
    | print'(SPECIAL_LOAD_OFFSET _,n,labmap) = Crash.impossible"print SPECIAL_LOAD_OFFSET"

  fun labprint (args as (_,n,labmap)) =
    let
      val line = print' args
    in
      case Map.tryApply' (labmap,n) of
        SOME s => (s ^ ":",line)
      | _ => ("",line)
    end

  fun print opcode =
    #2 (labprint (opcode,0,Map.empty))

  fun reverse_branch BA = BA
    | reverse_branch BN = BN
    | reverse_branch BNE = BNE
    | reverse_branch BE = BE
    | reverse_branch BG = BL
    | reverse_branch BLE = BGE
    | reverse_branch BGE = BLE
    | reverse_branch BL = BG
    | reverse_branch BGU = BCS
    | reverse_branch BLEU = BCC
    | reverse_branch BCC = BLEU
    | reverse_branch BCS = BGU
    | reverse_branch BPOS = Crash.impossible"reverse_branch BPOS"
    | reverse_branch BNEG = Crash.impossible"reverse_branch BNEG"
    | reverse_branch BVC = Crash.impossible"reverse_branch BVC"
    | reverse_branch BVS = Crash.impossible"reverse_branch BVS"

  fun inverse_branch BA = BN
    | inverse_branch BN = BA
    | inverse_branch BNE = BE
    | inverse_branch BE = BNE
    | inverse_branch BG = BLE
    | inverse_branch BLE = BG
    | inverse_branch BGE = BL
    | inverse_branch BL = BGE
    | inverse_branch BGU = BLEU
    | inverse_branch BLEU = BGU
    | inverse_branch BCC = BCS
    | inverse_branch BCS = BCC
    | inverse_branch BPOS = BNEG
    | inverse_branch BNEG = BPOS
    | inverse_branch BVC = BVS
    | inverse_branch BVS = BVC

  val all_windowed_regs =
    Set.list_to_set
    [MachTypes.I0,
     MachTypes.I1,
     MachTypes.I2,
     MachTypes.I3,
     MachTypes.I4,
     MachTypes.I5,
     MachTypes.I6,
     MachTypes.I7,
     MachTypes.L0,
     MachTypes.L1,
     MachTypes.L2,
     MachTypes.L3,
     MachTypes.L4,
     MachTypes.L5,
     MachTypes.L6,
     MachTypes.L7,
     MachTypes.O0,
     MachTypes.O1,
     MachTypes.O2,
     MachTypes.O3,
     MachTypes.O4,
     MachTypes.O5,
     MachTypes.O6,
     MachTypes.O7,
     MachTypes.stack]

  fun defines_and_uses(LOAD_AND_STORE(operation, rd, rs1, reg_or_imm)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
      val is_nil = rs1 = MachTypes.G5 orelse rs2 = MachTypes.G5
      val is_stack = rs1 = MachTypes.I6 orelse rs2 = MachTypes.I6
      val is_heap = (not is_nil) andalso (not is_stack)
      val is_load = case operation of
	STB => false
      | STH => false
      | ST => false
      | STD => false
      | _ => true
      val next_reg = case operation of
	STD => true
      | LDD => true
      | _ => false
      val main_uses = [rs1, rs2]
      val store =
	if is_nil then MachTypes.nil_v
	else
	  if is_stack then MachTypes.stack
	  else MachTypes.heap
    in
      (Set.list_to_set
       (if is_load then
	  if next_reg then [rd, MachTypes.next_reg rd] else [rd]
	else [store]),
	  Set.list_to_set
	  (if is_load then
	     store :: main_uses
	   else
	     if next_reg then rd :: MachTypes.next_reg rd :: main_uses
	     else rd :: main_uses),
	  if is_load then Set.empty_set else Set.singleton store,
	    if is_load then Set.singleton store else Set.empty_set)
    end
  | defines_and_uses(LOAD_AND_STORE_FLOAT(operation, rd, rs1,reg_or_imm)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
      val is_nil = rs1 = MachTypes.G5 orelse rs2 = MachTypes.G5
      val is_stack = rs1 = MachTypes.I6 orelse rs2 = MachTypes.I6
      val is_heap = (not is_nil) andalso (not is_stack)
      val is_load = case operation of
	STF => false
      | STDF => false
      | _ => true
      val store =
	if is_nil then MachTypes.nil_v
	else
	  if is_stack then MachTypes.stack
	  else MachTypes.heap
      val main_uses =
	if is_load then
	  Set.list_to_set[store, rs1, rs2]
	else
	  Set.list_to_set[rs1, rs2]
    in
      (if is_load then Set.empty_set else Set.singleton store,
	 main_uses,
	 Set.singleton(if is_load then rd else store),
	 Set.singleton(if is_load then store else rd))
    end
  | defines_and_uses(ARITHMETIC_AND_LOGICAL(opcode, rd, rs1, reg_or_imm)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
      val (defines_cond, uses_cond,defines_y) =
	case opcode of
	  ADD => (false, false, false)
	| ADDCC => (true, false, false)
	| ADDX => (false, true, false)
	| ADDXCC => (true, true, false)
	| SUB => (false, false, false)
	| SUBCC => (true, false, false)
	| SUBX => (false, true, false)
	| SUBXCC => (true, true, false)
	| AND => (false, false, false)
	| ANDCC => (true, false, false)
	| ANDN => (false, false, false)
	| ANDNCC => (true, false, false)
	| OR => (false, false, false)
	| ORCC => (true, false, false)
	| ORN => (false, false, false)
	| ORNCC => (true, false, false)
	| XOR => (false, false, false)
	| XORCC => (true, false, false)
	| XORN => (false, false, false)
	| XORNCC => (true, false, false)
	| SLL => (false, false, false)
	| SRL => (false, false, false)
	| SRA => (false, false, false)
        | UMUL => (false,false, true)
        | SMUL => (false,false, true)
        | UMULCC => (true,false, true)
        | SMULCC => (true,false, true)
        | UDIV => (false,false, true)
        | SDIV => (false,false, true)
        | UDIVCC => (true,false, true)
        | SDIVCC => (true,false, true)
    in
      (Set.list_to_set ((if defines_y then [MachTypes.y_reg] else []) @
                        (if defines_cond then [MachTypes.cond] else []) @
                        [rd]),
       if uses_cond then Set.list_to_set[MachTypes.cond, rs1, rs2]
       else Set.list_to_set[rs1, rs2],
       Set.empty_set, Set.empty_set)
    end
  | defines_and_uses(TAGGED_ARITHMETIC(_, rd, rs1,reg_or_imm)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
    in
      (Set.list_to_set[MachTypes.cond, rd], Set.list_to_set[rs1, rs2],
       Set.empty_set, Set.empty_set)
    end
  | defines_and_uses(SetHI(_, rd, i)) =
    (Set.singleton rd, Set.empty_set,
       Set.empty_set, Set.empty_set)
  | defines_and_uses(SAVE_AND_RESTORE(_, rd, rs1, reg_or_imm)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
    in
      (Set.add_member(rd, all_windowed_regs),
       Set.add_member(rs1, Set.add_member(rs2, all_windowed_regs)),
       Set.empty_set, Set.empty_set)
    end
  | defines_and_uses(BRANCH(branch, _)) =
    (Set.empty_set,
      (case branch of
	BA => Set.empty_set
      | BN => Set.empty_set
      | _ => Set.singleton MachTypes.cond),
	 Set.empty_set, Set.empty_set)
  | defines_and_uses(BRANCH_ANNUL(branch, _)) =
    (Set.empty_set,
      (case branch of
	BA => Set.empty_set
      | BN => Set.empty_set
      | _ => Set.singleton MachTypes.cond),
       Set.empty_set, Set.empty_set)
  | defines_and_uses(Call _) =
    (Set.singleton MachTypes.lr, Set.empty_set,
     Set.empty_set, Set.empty_set)
  | defines_and_uses(JUMP_AND_LINK(_, rd, rs1, reg_or_imm,_)) =
    let
      val rs2 = case reg_or_imm of
	REG rs2 => rs2
      | _ => rs1
    in
      (Set.singleton rd, Set.list_to_set[rs1, rs2],
       Set.empty_set, Set.empty_set)
    end
  | defines_and_uses(FBRANCH(fbranch, _)) =
    (Set.empty_set,
     Set.empty_set,
     Set.empty_set,
      (case fbranch of
	FBA => Set.empty_set
      | FBN => Set.empty_set
      | _ => Set.singleton MachTypes.cond))
  | defines_and_uses(FBRANCH_ANNUL(fbranch, _)) =
    (Set.empty_set,
     Set.empty_set,
     Set.empty_set,
      (case fbranch of
	FBA => Set.empty_set
      | FBN => Set.empty_set
      | _ => Set.singleton MachTypes.cond))
  | defines_and_uses(CONV_OP(conv_op, rd, rs2)) =
	(Set.empty_set, Set.empty_set, Set.singleton rd, Set.singleton rs2)
  | defines_and_uses(FUNARY(funary, rd, rs2)) =
    let
      val defines_cond = case funary of
	FCMPS => true
      | FCMPD => true
      | FCMPX => true
      | _ => false
    in
      (Set.empty_set, Set.empty_set,
       Set.singleton(if defines_cond then MachTypes.cond else rd),
       if defines_cond then Set.list_to_set[rd, rs2] else Set.singleton rs2)
    end
  | defines_and_uses(FBINARY(fbinary, rd, rs1, rs2)) =
    (Set.empty_set, Set.empty_set, Set.singleton rd,
     Set.list_to_set[rs1, rs2])
  | defines_and_uses(LOAD_OFFSET(_, rd, _)) =
    (Set.singleton rd, Set.empty_set,
     Set.empty_set, Set.empty_set)
  | defines_and_uses(READ_STATE(RDY,rd)) =
    (Set.singleton rd,
     Set.singleton MachTypes.y_reg,
     Set.empty_set,
     Set.empty_set)
  | defines_and_uses(WRITE_STATE(WRY,rs1,reg_or_imm)) =
    (Set.singleton MachTypes.y_reg,
     case reg_or_imm of
       REG rs2 => Set.list_to_set [rs1,rs2]
     | _ => Set.singleton rs1,
     Set.empty_set,
     Set.empty_set)
  | defines_and_uses(SPECIAL_ARITHMETIC _) = Crash.impossible"defines_and_uses"
  | defines_and_uses(SPECIAL_LOAD_OFFSET _) = Crash.impossible"defines_and_uses"

(*
  fun post_save_or_restore_reg_or_imm conv_fun =
    let
      fun post(REG r) = REG(conv_fun r)
      | post arg = arg
    in
      post
    end
  
  fun post_save_or_restore(conv_fun, opcode) =
    let
      val post_reg_or_imm = post_save_or_restore_reg_or_imm conv_fun
      fun post(LOAD_AND_STORE(load_and_store, rd, rs1,
			      reg_or_imm)) =
	LOAD_AND_STORE(load_and_store, conv_fun rd,
		       conv_fun rs1,
		       post_reg_or_imm reg_or_imm)
      | post(LOAD_AND_STORE_FLOAT(load_and_store_float, f,
				  rs1, reg_or_imm)) =
	LOAD_AND_STORE_FLOAT(load_and_store_float, f,
			     conv_fun rs1,
			     post_reg_or_imm reg_or_imm)
      | post(ARITHMETIC_AND_LOGICAL(arithmetic_and_logical,
				    rd, rs1, reg_or_imm)) =
	ARITHMETIC_AND_LOGICAL(arithmetic_and_logical,
			       conv_fun rd,
			       conv_fun rs1,
			       post_reg_or_imm reg_or_imm)
      | post(TAGGED_ARITHMETIC(tagged_arithmetic, rd,
			       rs1, reg_or_imm)) =
	TAGGED_ARITHMETIC(tagged_arithmetic,
			  conv_fun rd,
			  conv_fun rs1,
                          post_reg_or_imm reg_or_imm)
      | post(SetHI(sethi, rd, i)) =
	SetHI(sethi, conv_fun rd, i)
      | post(SAVE_AND_RESTORE _) =
	Crash.impossible"post SAVE_AND_RESTORE"
      | post(opcode as BRANCH _) = opcode
      | post(opcode as BRANCH_ANNUL _) = opcode
      | post(opcode as Call _) = opcode
      | post(JUMP_AND_LINK(jump_and_link, rd, rs1, reg_or_imm,debug)) =
	JUMP_AND_LINK(jump_and_link, conv_fun rd,
                      conv_fun rs1,
                      post_reg_or_imm reg_or_imm,
                      debug)
      | post(opcode as FBRANCH _) = opcode
      | post(opcode as FBRANCH_ANNUL _) = opcode
      | post(CONV_OP(conv_op, rd, rs1)) =
	(case conv_op of
	  FITOS => CONV_OP(conv_op, rd, conv_fun rs1)
	| FITOD => CONV_OP(conv_op, rd, conv_fun rs1)
	| FITOX => CONV_OP(conv_op, rd, conv_fun rs1)
	| FSTOI => CONV_OP(conv_op, conv_fun rd, rs1)
	| FDTOI => CONV_OP(conv_op, conv_fun rd, rs1)
	| FXTOI => CONV_OP(conv_op, conv_fun rd, rs1))
      | post(opcode as FUNARY _) = opcode
      | post(opcode as FBINARY _) = opcode
      | post(SPECIAL_ARITHMETIC _) = Crash.impossible"post"
    in
      post opcode
    end

  fun post_restore opcode =
    post_save_or_restore(MachTypes.after_restore, opcode)

  fun post_save opcode =
    post_save_or_restore(MachTypes.after_preserve, opcode)
*)
  val nop_code =
    ARITHMETIC_AND_LOGICAL(AND, MachTypes.G0, MachTypes.G0, IMM 0)
  val nop = (nop_code, NONE, "Delay slot")

  val other_nop_code =
    SetHI(SETHI, MachTypes.G0, 0)

end
