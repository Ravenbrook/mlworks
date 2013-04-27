(* _mirprint.sml the functor *)
(*
$Log: _mirprint.sml,v $
Revision 1.97  1997/07/31 13:22:22  jont
[Bug #30215]
Replacing BIC by INTTAG

 * Revision 1.96  1997/05/21  17:02:19  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.95  1997/01/16  12:46:57  matthew
 * Have tag list in tagged operations
 *
 * Revision 1.94  1996/11/06  11:08:21  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.93  1996/10/09  11:54:35  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.92  1996/05/14  10:48:33  matthew
 * Added NOT32
 *
 * Revision 1.91  1996/04/30  16:49:04  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.89  1996/04/29  14:47:36  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.88  1996/04/03  14:56:19  jont
 * Add ability to deal with RuntimeEnv.OFFSET spill entries
 *
 * Revision 1.87  1996/02/02  10:57:10  jont
 * Add printing of new tagged operations for 32 bit integers
 *
Revision 1.86  1995/12/20  12:57:25  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.85  1994/11/23  14:00:18  matthew
Adding ALLOC_VECTOR

Revision 1.84  1994/11/11  14:20:40  jont
Add immediate store operations

Revision 1.83  1994/09/30  12:44:31  jont
Remove handler register concept

Revision 1.82  1994/09/13  11:24:15  matthew
Abstraction of debug information

Revision 1.81  1994/08/25  13:45:08  matthew
Changes to annotations

Revision 1.80  1994/07/22  16:40:12  matthew
Added function argument register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER
Changed loop entry points to be a list

Revision 1.79  1994/05/12  12:50:30  richard
Add field to MirTypes.PROC_PARAMS.

Revision 1.78  1994/03/09  14:58:11  jont
Adding load offset instruction

Revision 1.77  1994/01/17  18:31:52  daveb
Removed unnecessary exceptions from closures.

Revision 1.76  1993/11/04  16:30:08  jont
Added INTERRUPT instruction

Revision 1.75  1993/07/29  15:02:52  nosa
New stack spill slots for local and closure variable inspection
in the debugger;
structure Option.

Revision 1.74  1993/05/18  14:30:57  jont
Removed Integer parameter

Revision 1.73  1993/04/27  13:44:05  richard
Changed PROFILE instruction to INTERCEPT.

Revision 1.72  1993/03/10  17:11:19  matthew
Signature revisions

Revision 1.71  1993/03/01  14:55:19  matthew
Added MLVALUE lambda exp

Revision 1.70  1993/01/05  16:01:27  jont
Modified to print directly to a given stream for speed and controllability

Revision 1.69  1992/11/02  17:35:02  jont
Reworked in terms of mononewmap

Revision 1.68  1992/08/26  13:58:55  jont
Removed some redundant structures and sharing

Revision 1.67  1992/08/24  13:33:57  richard
Added NULLARY opcode type.
Added ALLOC_BYTEARRAY.

Revision 1.66  1992/06/29  09:14:56  clive
Added type annotation information at application points

Revision 1.65  1992/06/18  16:15:30  richard
Added parameter to RAISE once again.

Revision 1.64  1992/06/17  15:19:11  jont
Added printing for interpretive external types

Revision 1.63  1992/06/16  19:02:18  jont
Expanded refs section of mir_code to allow for interpretive stuff

Revision 1.62  1992/05/18  14:19:28  richard
Removed redundant names from register printing routines.

Revision 1.61  1992/04/14  15:41:02  clive
First version of the profiler

Revision 1.60  1992/02/28  15:35:25  richard
Changed the way virtual registers are handled.  See MirTypes.
Added switches to allow different printing format for virtual
registers.

Revision 1.59  1992/02/07  13:25:18  richard
Abolished PREVIOUS_ENVIRONMENT and PRESERVE_ALL_REGS.
Changed register lookup to use Map rather than Table.

Revision 1.58  1992/01/23  10:01:06  richard
Added special case printing of the `implicit' register.

Revision 1.57  1992/01/16  11:20:49  clive
Alloc may now have a register argument for allocating arrays

Revision 1.56  1992/01/14  13:48:38  jont
Raise no longer has a parameter

Revision 1.55  1992/01/03  16:05:35  richard
Added the zero register (if present) to those registers printed
with names.

Revision 1.54  1991/12/02  14:00:22  jont
Added tail call operation

Revision 1.53  91/11/20  12:31:34  jont
Added exception generating fp opcodes

Revision 1.52  91/11/14  15:48:58  richard
Added printing for the CALL_C opcode.

Revision 1.51  91/11/14  11:15:14  richard
Removed references to fp_double registers.

Revision 1.50  91/11/08  16:09:39  richard
Added argument to STACKOP and new opcodes FSTREF and FLDREF.

Revision 1.49  91/11/05  10:16:31  richard
Added procedure print function.

Revision 1.48  91/10/28  15:21:26  richard
Changed the form of the allocation instructions yet again.

Revision 1.47  91/10/28  12:02:46  davidt
ALLOCATE doesn't have a scratch register or a proc_ref any more.

Revision 1.46  91/10/24  10:42:05  jont
Added BTA and BNT for tagged value testing

Revision 1.45  91/10/21  09:35:17  jont
New local and external reference code

Revision 1.44  91/10/18  14:23:01  richard
Tidied up output of ALLOCATE opcodes.

Revision 1.43  91/10/17  14:39:15  jont
New ALLOC opcodes

Revision 1.42  91/10/17  09:27:49  richard
Changed the way registers are displayed again.

Revision 1.41  91/10/16  16:07:11  richard
A big mindless clean-up while I thought about register colouring.

Revision 1.40  91/10/16  14:18:21  jont
Updated to reflect new simplified module structure
Added parameter to heap allocation to indicate position in closure
of call_c function

Revision 1.39  91/10/15  15:24:56  richard
When decoding the names of registers which are aliases of real registers
the real names are displayed also. Added ALLOC_PAIR.

Revision 1.38  91/10/11  14:53:39  richard
Added DEALLOC_STACK and fixed a minor carriage return bug.

Revision 1.37  91/10/11  10:05:24  richard
Slight alterations to cope with new MirTypes.

Revision 1.36  91/10/10  13:39:48  richard
Removed RESTORE_REGS and PRESERVE_REGS and replaced with
PREVIOUS_ENVIRONMENT. Parameterized RAISE.

Revision 1.34  91/10/08  15:49:05  richard
Added code to print "global" for the global GC register rather than
its number.

Revision 1.33  91/10/04  15:12:13  richard
Rewrote higher level printing functions to nest neatly, and also
to print the non-procedure information from the Mir code.

Revision 1.32  91/10/04  11:54:07  jont
Changed to use new PROC type for bundling up procedures

Revision 1.31  91/10/04  08:35:14  richard
Added fp_operand.

Revision 1.30  91/10/03  11:25:08  jont
Printed new structure of code

Revision 1.29  91/10/03  10:57:42  jont
Changed CODE structure to enable easier handling of code, values
and load time semantics

Revision 1.28  91/10/02  11:11:47  jont
Removed real register options, these are being done elsewhere

Revision 1.27  91/09/25  16:11:08  richard
Removed redundant FP(...) from printing functions.

Revision 1.26  91/09/23  10:38:29  richard
Added NEW_HANDLER, OLD_HANDLER, and RAISE directives.

Revision 1.25  91/09/20  15:48:46  jont
Added PRESERVE_ALL_REGS

Revision 1.24  91/09/20  13:53:58  richard
Modified register printing functions to display the names of the
special registers rather than their numbers.

Revision 1.23  91/09/19  15:53:07  jont
Added printing for MODV

Revision 1.22  91/09/17  13:52:21  jont
Changed branches to target bl_dest

Revision 1.21  91/09/17  10:45:27  jont
Added ALLOCA for stack allocated items

Revision 1.20  91/09/11  14:40:36  richard
Brought reg_operand function to the outside.

Revision 1.19  91/09/10  15:51:43  jont
Decoded symbolics

Revision 1.18  91/09/09  14:05:26  davida
Changed to use reduce function from Lists

Revision 1.17  91/09/09  13:41:59  richard
Yet more functions made available. Names containing ``print''
shortened (it's in the structure name).

Revision 1.16  91/09/06  15:55:12  richard
Still more functions revealed to the outside world (but
mostly to MirDataFlow so I can watch what it is doing).

Revision 1.15  91/09/05  15:57:59  jont
Added LDREF and STREF to assist optimiser deduce available expressions

Revision 1.14  91/09/05  13:06:49  richard
Added functions to allow individual opcodes and blocks to be printed.

Revision 1.13  91/09/03  16:36:13  jont
Added printing of byte loads and stores needed for string operations

Revision 1.12  91/09/03  13:55:19  jont
Changed printing of ENTRY and EXIT. Added printing of STOREFPOP

Revision 1.11  91/08/30  16:34:35  jont
Changed format for floating point operations

Revision 1.10  91/08/29  15:57:54  jont
Slight change to ALLOC

Revision 1.9  91/08/22  16:41:03  jont
Data flow analysis

Revision 1.8  91/08/15  14:39:07  jont
Updated for later version of HARP

Revision 1.7  91/08/09  16:58:29  jont
More items printed

Revision 1.6  91/08/05  10:46:45  jont
More items printed.

Revision 1.5  91/08/02  16:36:42  jont
More opcodes printed

Revision 1.4  91/08/01  17:20:40  jont
More opcodes printed

Revision 1.3  91/07/30  16:22:11  jont
Printed more opcodes (branch and cgt)

Revision 1.2  91/07/26  20:00:13  jont
Redid some printing in light of changes in mirtypes

Revision 1.1  91/07/25  15:45:09  jont
Initial revision

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
*)

require "../basis/__int";
require "../basis/__text_io";

require "../utils/lists";
require "../utils/crash";
require "../basics/identprint";
require "mirregisters";
require "mirprint";


functor MirPrint(
  structure Lists : LISTS
  structure Crash : CRASH
  structure IdentPrint : IDENTPRINT
  structure MirRegisters : MIRREGISTERS

  sharing type IdentPrint.Ident.SCon = MirRegisters.MirTypes.SCon

) : MIRPRINT =

struct

  structure MirTypes = MirRegisters.MirTypes
  structure Set = MirTypes.Set
  structure RuntimeEnv = MirTypes.Debugger_Types.RuntimeEnv

  fun binary MirTypes.ADDU = "ADDU"
    | binary MirTypes.SUBU = "SUBU"
    | binary MirTypes.MULU = "MULU"
    | binary MirTypes.MUL32U = "MUL32U"
    | binary MirTypes.AND = "AND"
    | binary MirTypes.OR = "OR"
    | binary MirTypes.EOR = "EOR"
    | binary MirTypes.LSR = "LSR"
    | binary MirTypes.ASL = "ASL"
    | binary MirTypes.ASR = "ASR"
      
    fun tagged_binary MirTypes.ADDS = "ADDS"
      | tagged_binary MirTypes.SUBS = "SUBS"

      (* Handle overflow specially for these *)
      (* (because traps are hard) *)
      | tagged_binary MirTypes.ADD32S = "ADD32S"
      | tagged_binary MirTypes.SUB32S = "SUB32S"

      | tagged_binary MirTypes.MULS = "MULS"
      | tagged_binary MirTypes.DIVS = "DIVS"
      | tagged_binary MirTypes.MODS = "MODS"

      | tagged_binary MirTypes.MUL32S = "MUL32S"
      | tagged_binary MirTypes.DIV32S = "DIV32S"
      | tagged_binary MirTypes.MOD32S = "MOD32S"
      (* These can raise Div *)
      | tagged_binary MirTypes.DIVU = "DIVU"
      | tagged_binary MirTypes.MODU = "MODU"
      | tagged_binary MirTypes.DIV32U = "DIV32U"
      | tagged_binary MirTypes.MOD32U = "MOD32U"

  fun unary MirTypes.MOVE = "MOVE"
    | unary MirTypes.INTTAG = "INTTAG"
    | unary MirTypes.NOT = "NOT"
    | unary MirTypes.NOT32 = "NOT32"

  fun nullary MirTypes.CLEAN = "CLEAN"

  fun binaryfp MirTypes.FADD = "FADD"
    | binaryfp MirTypes.FSUB = "FSUB"
    | binaryfp MirTypes.FMUL = "FMUL"
    | binaryfp MirTypes.FDIV = "FDIV"

  fun tagged_binaryfp MirTypes.FADDV = "FADDV"
    | tagged_binaryfp MirTypes.FSUBV = "FSUBV"
    | tagged_binaryfp MirTypes.FMULV = "FMULV"
    | tagged_binaryfp MirTypes.FDIVV = "FDIVV"

  fun unaryfp MirTypes.FABS = "FABS"
    | unaryfp MirTypes.FNEG = "FNEG"
    | unaryfp MirTypes.FMOVE = "FMOVE"
    | unaryfp MirTypes.FINT = "FINT"
    | unaryfp MirTypes.FSQRT = "FSQRT"
    | unaryfp MirTypes.FLOG10 = "FLOG10"
    | unaryfp MirTypes.FLOG2 = "FLOG2"
    | unaryfp MirTypes.FLOGE = "FLOGE"
    | unaryfp MirTypes.FLOGEP1 = "FLOGEP1"
    | unaryfp MirTypes.F10TOX = "F10TOX"
    | unaryfp MirTypes.F2TOX = "F2TOX"
    | unaryfp MirTypes.FETOX = "FETOX"
    | unaryfp MirTypes.TETOXM1 = "TETOXM1"
    | unaryfp MirTypes.FSIN = "FSIN"
    | unaryfp MirTypes.FCOS = "FCOS"
    | unaryfp MirTypes.FTAN = "FTAN"
    | unaryfp MirTypes.FASIN = "FASIN"
    | unaryfp MirTypes.FACOS = "FACOS"
    | unaryfp MirTypes.FATAN = "FATAN"

  fun tagged_unaryfp MirTypes.FABSV = "FABSV"
    | tagged_unaryfp MirTypes.FNEGV = "FNEGV"
    | tagged_unaryfp MirTypes.FSQRTV = "FSQRTV"
    | tagged_unaryfp MirTypes.FLOGEV = "FLOGEV"
    | tagged_unaryfp MirTypes.FETOXV = "FETOXV"

  fun store MirTypes.LD = "LD"
    | store MirTypes.ST = "ST"
    | store MirTypes.LDB = "LDB"
    | store MirTypes.STB = "STB"
    | store MirTypes.LDREF = "LDREF"
    | store MirTypes.STREF = "STREF"

  fun storefp MirTypes.FLD = "FLD"
    | storefp MirTypes.FST = "FST"
    | storefp MirTypes.FSTREF = "FSTREF"
    | storefp MirTypes.FLDREF = "FLDREF"

  fun int_to_float MirTypes.ITOF = "ITOF"

  fun float_to_int MirTypes.FTOI = "FTOI"

  fun allocate MirTypes.ALLOC = "ALLOC"
    | allocate MirTypes.ALLOC_VECTOR = "ALLOC_VECTOR"
    | allocate MirTypes.ALLOC_REAL = "ALLOC_REAL"
    | allocate MirTypes.ALLOC_STRING = "ALLOC_STRING"
    | allocate MirTypes.ALLOC_REF = "ALLOC_REF"
    | allocate MirTypes.ALLOC_BYTEARRAY = "ALLOC_BYTEARRAY"

  fun allocate_stack operator =
    "STACK_" ^ allocate operator

  fun deallocate_stack operator =
    "STACK_DE" ^ allocate operator
      
  fun branch MirTypes.BRA = "BRA"

  fun test MirTypes.BTA = "BTA"
    | test MirTypes.BNT = "BNT"
    | test MirTypes.BEQ = "BEQ"
    | test MirTypes.BNE = "BNE"
    | test MirTypes.BHI = "BHI"
    | test MirTypes.BLS = "BLS"
    | test MirTypes.BHS = "BHS"
    | test MirTypes.BLO = "BLO"
    | test MirTypes.BGT = "BGT"
    | test MirTypes.BLE = "BLE"
    | test MirTypes.BGE = "BGE"
    | test MirTypes.BLT = "BLT"

  fun ftest MirTypes.FBEQ = "FBEQ"
    | ftest MirTypes.FBNE = "FBNE"
    | ftest MirTypes.FBLE = "FBLE"
    | ftest MirTypes.FBLT = "FBLT"

  fun adr MirTypes.LEA = "LEA"
    | adr MirTypes.LEO = "LEO"

  fun stack_op MirTypes.PUSH = "PUSH"
    | stack_op MirTypes.POP = "POP"

  fun branch_and_link MirTypes.BLR = "BLR"

  fun tail_call MirTypes.TAIL = "TAIL"

  val show_register_names = ref true
  val show_real_registers = ref true

  local
    open MirRegisters
  in
    fun gc_register gc_reg =
      let
	val name =
          if !show_register_names then
            if gc_reg = caller_arg then "/caller_argument"
            else if gc_reg = callee_arg then "/argument"
            else if gc_reg = caller_closure then "/caller_closure"
            else if gc_reg = callee_closure then "/closure"
            else if gc_reg = fp then "/frame"
            else if gc_reg = sp then "/stack"
            else if gc_reg = global then "/global"
            else if gc_reg = implicit then "/implicit"
                 else
                   case MirRegisters.zero
                     of SOME zero => if gc_reg = zero then "/zero" else ""
                      | NONE => ""
          else ""

        val machine_reg =
          if !show_real_registers then
            ("/" ^ MachSpec.print_register (MirTypes.GC.Map.apply (#gc machine_register_assignments) gc_reg))
            handle MirTypes.GC.Map.Undefined => ""
          else ""
      in
	MirTypes.GC.to_string gc_reg ^ name ^ machine_reg
      end

    fun non_gc_register non_gc_reg =
      let
        val machine_reg =
          if !show_real_registers then
            ("/" ^ MachSpec.print_register (MirTypes.NonGC.Map.apply (#non_gc machine_register_assignments) non_gc_reg))
            handle MirTypes.NonGC.Map.Undefined => ""
          else ""
      in
        MirTypes.NonGC.to_string non_gc_reg ^ machine_reg
      end

    fun fp_register fp_reg =
      let
        val machine_reg =
          if !show_real_registers then
            ("/" ^ MachSpec.print_register (MirTypes.FP.Map.apply (#fp machine_register_assignments) fp_reg))
            handle MirTypes.FP.Map.Undefined => ""
          else ""
      in
        MirTypes.FP.to_string fp_reg ^ machine_reg
      end

  end


  fun reg_operand(MirTypes.GC_REG gc_reg) =
      gc_register gc_reg
    | reg_operand(MirTypes.NON_GC_REG non_gc_reg) =
      non_gc_register non_gc_reg

  fun fp_operand(MirTypes.FP_REG fp_reg) =
      fp_register fp_reg

  fun any_reg(MirTypes.GC gc_reg) =
      gc_register gc_reg
    | any_reg(MirTypes.NON_GC non_gc_reg) =
      non_gc_register non_gc_reg
    | any_reg(MirTypes.FLOAT fp_reg) =
      fp_register fp_reg

  fun offset2(ref(RuntimeEnv.OFFSET2(RuntimeEnv.GC, i)), name) =
    "GC_SPILL_SLOT (mach_cg) (" ^ Int.toString i ^ ":" ^ name ^ ")"
    | offset2(ref(RuntimeEnv.OFFSET2(RuntimeEnv.NONGC, i)), name) =
      "NON_GC_SPILL_SLOT (mach_cg) (" ^ Int.toString i ^ ":" ^ name ^ ")"
    | offset2(ref(RuntimeEnv.OFFSET2(RuntimeEnv.FP, i)), name) =
      "FP_SPILL_SLOT (mach_cg) (" ^ Int.toString i ^ ":" ^ name ^ ")"
    | offset2 _ = Crash.impossible "offset2:_mirprint.sml"

  fun symb MirTypes.GC_SPILL_SIZE = "GC_SPILL_SIZE"
    | symb MirTypes.NON_GC_SPILL_SIZE = "NON_GC_SPILL_SIZE"
    | symb (MirTypes.GC_SPILL_SLOT (MirTypes.SIMPLE n)) =
      "GC_SPILL_SLOT(" ^ Int.toString n ^ ")"
    | symb (MirTypes.GC_SPILL_SLOT (MirTypes.DEBUG (ref (RuntimeEnv.OFFSET1(n)),name))) =
      "GC_SPILL_SLOT(" ^ Int.toString n ^ ":"^name^")"
    | symb (MirTypes.NON_GC_SPILL_SLOT (MirTypes.SIMPLE n)) =
      "NON_GC_SPILL_SLOT(" ^ Int.toString n ^ ")"
    | symb (MirTypes.NON_GC_SPILL_SLOT (MirTypes.DEBUG (ref (RuntimeEnv.OFFSET1(n)),name))) =
      "NON_GC_SPILL_SLOT(" ^ Int.toString n ^ ":"^name^")"
    | symb (MirTypes.FP_SPILL_SLOT (MirTypes.SIMPLE n)) =
      "FP_SPILL_SLOT(" ^ Int.toString n ^ ")"
    | symb (MirTypes.FP_SPILL_SLOT (MirTypes.DEBUG (ref (RuntimeEnv.OFFSET1(n)),name))) =
      "FP_SPILL_SLOT(" ^ Int.toString n ^ ":"^name^")"
    | symb(MirTypes.GC_SPILL_SLOT(MirTypes.DEBUG x)) = offset2 x
    | symb(MirTypes.NON_GC_SPILL_SLOT(MirTypes.DEBUG x)) = offset2 x
    | symb(MirTypes.FP_SPILL_SLOT(MirTypes.DEBUG x)) = offset2 x

  fun gp_operand(MirTypes.GP_GC_REG gc_reg) =
      gc_register gc_reg
    | gp_operand(MirTypes.GP_NON_GC_REG non_gc_reg) =
      non_gc_register non_gc_reg
    | gp_operand(MirTypes.GP_IMM_INT imm) =
      Int.toString imm
    | gp_operand(MirTypes.GP_IMM_ANY imm) =
      "Any:" ^ Int.toString imm
    | gp_operand(MirTypes.GP_IMM_SYMB symbol) =
      symb symbol

  fun bl_dest(MirTypes.TAG tag) = MirTypes.print_tag tag
    | bl_dest(MirTypes.REG reg) = reg_operand reg

  fun cat x =
    let
      fun cat'([], done) = concat(rev done)
      | cat'(s :: ss, done) = cat'(ss, " " :: s :: done)
    in
      cat'(x, [])
    end

  val tag = MirTypes.print_tag

  fun opcode(MirTypes.BINARY(operator, reg, gp1, gp2)) =
      cat [binary operator, reg_operand reg, gp_operand gp1, gp_operand gp2]

    | opcode(MirTypes.TBINARY(operator, tag1, reg, gp1, gp2)) =
      cat [tagged_binary operator, MirTypes.print_tag_list tag1, reg_operand reg,
	   gp_operand gp1, gp_operand gp2]

    | opcode(MirTypes.UNARY(operator, reg, gp)) =
      cat [unary operator, reg_operand reg, gp_operand gp]

    | opcode(MirTypes.NULLARY(operator, reg)) =
      cat [nullary operator, reg_operand reg]

    | opcode(MirTypes.STOREOP(operator, reg1, reg2, gp)) =
      cat [store operator, reg_operand reg1, reg_operand reg2, gp_operand gp]
    
    | opcode(MirTypes.IMMSTOREOP(operator, gp1, reg, gp2)) =
      cat [store operator, gp_operand gp1, reg_operand reg, gp_operand gp2]
    
    | opcode(MirTypes.ALLOCATE(operator, reg1, imm)) =
      cat [allocate operator, reg_operand reg1,
	   case operator of
	     MirTypes.ALLOC_REAL => ""
	   | _ => gp_operand imm]

    | opcode(MirTypes.ALLOCATE_STACK(operator, reg1, imm, NONE)) =
      cat [allocate_stack operator, reg_operand reg1,
	   case operator
	     of MirTypes.ALLOC_REAL => ""
	      | _ => Int.toString imm]

    | opcode(MirTypes.ALLOCATE_STACK(operator, reg1, imm,
				     SOME offset)) =
      cat [allocate_stack operator, reg_operand reg1,
	   case operator
	      of MirTypes.ALLOC_REAL => ""
	       | _ => Int.toString imm,
	   "OFFSET", Int.toString offset]

    | opcode(MirTypes.DEALLOCATE_STACK(operator, imm)) =
      cat [deallocate_stack operator, Int.toString imm]

    | opcode(MirTypes.BRANCH(operator, bl_dest1)) =
      cat [branch operator, bl_dest bl_dest1]
    
    | opcode(MirTypes.TEST(operator, tag1, gp, gp')) =
      cat [test operator, tag tag1, gp_operand gp, gp_operand gp']
    
    | opcode(MirTypes.FTEST(operator, tag1, fp, fp')) =
      cat [ftest operator, tag tag1, fp_operand fp, fp_operand fp']

    | opcode(MirTypes.SWITCH(_, reg, tag_list)) =
      cat (["CGT", reg_operand reg] @ map tag tag_list)

    | opcode(MirTypes.ADR(operator, reg, tag1)) =
      cat [adr operator, reg_operand reg, tag tag1]

    | opcode MirTypes.INTERCEPT = "Intercept"

    | opcode MirTypes.INTERRUPT = "Interrupt"

    | opcode (MirTypes.ENTER _) = "Procedure entry"

    | opcode MirTypes.RTS = "Procedure exit"
    
    | opcode(MirTypes.NEW_HANDLER (stack, tag1)) =
      "New exception handler at tag " ^ tag tag1

    | opcode(MirTypes.OLD_HANDLER) =
      "Restore previous exception handler"

    | opcode(MirTypes.RAISE reg) =
      "Raise " ^ reg_operand reg

    | opcode(MirTypes.BINARYFP(operator, fp1, fp2, fp3)) =
      cat [binaryfp operator, fp_operand fp1, fp_operand fp2,
	   fp_operand fp3]

    | opcode(MirTypes.UNARYFP(operator, fp, fp')) =
      cat [unaryfp operator, fp_operand fp, fp_operand fp']

    | opcode(MirTypes.TBINARYFP(operator, tag, fp1, fp2, fp3)) =
      cat [tagged_binaryfp operator, MirTypes.print_tag_list tag, fp_operand fp1,
	   fp_operand fp2, fp_operand fp3]

    | opcode(MirTypes.TUNARYFP(operator, tag, fp, fp')) =
      cat [tagged_unaryfp operator, MirTypes.print_tag_list tag, fp_operand fp,
	   fp_operand fp']

    | opcode(MirTypes.STACKOP(operator, reg, NONE)) =
      cat [stack_op operator, reg_operand reg]

    | opcode (MirTypes.STACKOP(operator, reg, SOME offset)) =
      cat [stack_op operator, reg_operand reg,
	   "OFFSET", Int.toString offset]

    | opcode(MirTypes.STOREFPOP(operator, fp, reg, gp)) =
      cat [storefp operator, fp_operand fp, reg_operand reg, gp_operand gp]

    | opcode(MirTypes.REAL(operator, fp, gp)) =
      cat [int_to_float operator, fp_operand fp, gp_operand gp]

    | opcode(MirTypes.FLOOR(operator, tag, reg, fp)) =
      cat [float_to_int operator, MirTypes.print_tag tag, reg_operand reg,
	   fp_operand fp]

    | opcode(MirTypes.BRANCH_AND_LINK(operator, bl_dest1,_,_)) =
      cat [branch_and_link operator, bl_dest bl_dest1]

    | opcode(MirTypes.TAIL_CALL(operator, bl_dest1,_)) =
      cat [tail_call operator, bl_dest bl_dest1]

    | opcode MirTypes.CALL_C = "CALL_C"

    | opcode(MirTypes.COMMENT s) = " ; " ^ s


  local

    fun any_block_list (name, indent) (MirTypes.BLOCK(tag, opcodes)) =
      let
	val newl = "\n " ^ indent
      in
	indent ^ name ^ " " ^ MirTypes.print_tag tag ::
	map
	(fn opc => newl ^ opcode opc)
	opcodes
      end

    fun any_block(name, indent) (MirTypes.BLOCK(tag, opcodes)) =
      concat(any_block_list (name, indent) (MirTypes.BLOCK(tag, opcodes)))
  in
    val block = any_block ("Block", "    ")
    fun block_print(stream, MirTypes.BLOCK(tag, opcodes)) =
      Lists.iterate
      (fn x => TextIO.output(stream, x))
      (any_block_list ("Block", "    ")
       (MirTypes.BLOCK(tag, opcodes)))
  end


  fun procedure (MirTypes.PROC(name_string,
                               start_tag,
			       MirTypes.PROC_PARAMS {spill_sizes,
						     old_spill_sizes,
						     stack_allocated},
			       blocks,_)) =
    let

      val spill_string =
	case spill_sizes
	  of NONE => "\n    No spill size information."
	   | SOME {gc, non_gc, fp} =>
	       ("\n    Spill areas: GC " ^ Int.toString gc ^
		", NON_GC " ^ Int.toString non_gc ^
		", FP " ^ Int.toString fp)

      val old_spill_string =
	case old_spill_sizes
	  of NONE => "\n    No previous spill size information."
	   | SOME {gc, non_gc, fp} =>
	       ("\n    Spill areas: GC " ^ Int.toString gc ^
		", NON_GC " ^ Int.toString non_gc ^
		", FP " ^ Int.toString fp)

      val stack_string =
	case stack_allocated
	  of NONE => "\n    No stack allocation information."
	   | SOME s =>
	       ("\n    " ^ Int.toString s ^
		" words of stack required.")


      val message =
	"   Procedure " ^ MirTypes.print_tag start_tag ^ " " ^ name_string ^
	spill_string ^ old_spill_string ^ stack_string 

    in
      Lists.reducel
      (fn (a,b) => a ^ "\n" ^ b)
      (message, map block blocks)
    end

  fun procedure_print(stream,
		      MirTypes.PROC(name_string,
				    start_tag,
				    MirTypes.PROC_PARAMS {spill_sizes,
							  old_spill_sizes,
							  stack_allocated},
				    blocks,_)) =
    let
      val spill_string =
	case spill_sizes
	  of NONE => "\n    No spill size information."
	   | SOME {gc, non_gc, fp} =>
	       ("\n    Spill areas: GC " ^ Int.toString gc ^
		", NON_GC " ^ Int.toString non_gc ^
		", FP " ^ Int.toString fp)

      val old_spill_string =
	case old_spill_sizes
	  of NONE => "\n    No previous spill size information."
	   | SOME {gc, non_gc, fp} =>
	       ("\n    Spill areas: GC " ^ Int.toString gc ^
		", NON_GC " ^ Int.toString non_gc ^
		", FP " ^ Int.toString fp)

      val stack_string =
	case stack_allocated
	  of NONE => "\n    No stack allocation information."
	   | SOME s =>
	       ("\n    " ^ Int.toString s ^
		" words of stack required.")

    in
      TextIO.output(stream, "   Procedure ");
      TextIO.output(stream, MirTypes.print_tag start_tag);
      TextIO.output(stream, " ");
      TextIO.output(stream, name_string);
      TextIO.output(stream, " (");
      TextIO.output(stream, spill_string);
      TextIO.output(stream, old_spill_string);
      TextIO.output(stream, stack_string);
      Lists.iterate
      (fn x => (TextIO.output(stream, "\n"); block_print(stream, x)))
      blocks
    end

  val set_up = procedure

  fun proc_set_print(stream, procs) =
    (TextIO.output(stream, "  Procedure set { ");
     Lists.iterate
     (fn (MirTypes.PROC(_,tag,_,_,_)) =>
      (TextIO.output(stream, MirTypes.print_tag tag); TextIO.output(stream, " ")))
     procs;
     TextIO.output(stream, "}");
     Lists.iterate
     (fn proc => (TextIO.output(stream, "\n"); procedure_print(stream,  proc)))
     procs
     )

  fun proc_set procs =
    let
      val proc_tags =
	Lists.reducel
	(fn (a,b) => a ^ " " ^ b)
	("", map (fn MirTypes.PROC(_,tag,_,_,_) => MirTypes.print_tag tag) procs)
    in
      Lists.reducel
      (fn (a,b) => a ^ "\n" ^ b)
      ("  Procedure set {" ^ proc_tags ^ " }",
       map procedure procs)
    end


  fun refs (MirTypes.REFS(tags,
			  {requires, vars, exns, strs, funs})) =
    "  References\n   Local " ^
    Lists.to_string
    (fn (x, i) => ("Tag " ^ MirTypes.print_tag x ^ ", position " ^
		   Int.toString i)) tags ^
    "\n   External " ^
    Lists.to_string
    (fn (s, i) => s ^ ", position " ^ Int.toString i)
    requires ^
    "\n   Interpreter vars " ^
    Lists.to_string
    (fn (s, i) => s ^ ", position " ^ Int.toString i)
    vars ^
    "\n   Interpreter exns " ^
    Lists.to_string
    (fn (s, i) => s ^ ", position " ^ Int.toString i)
    exns ^
    "\n   Interpreter strs " ^
    Lists.to_string
    (fn (s, i) => s ^ ", position " ^ Int.toString i)
    strs ^
    "\n   Interpreter funs " ^
    Lists.to_string
    (fn (s, i) => s ^ ", position " ^ Int.toString i)
    funs

  fun value (MirTypes.VALUE(tag, value)) =
    case value of
      MirTypes.SCON scon =>
        MirTypes.print_tag tag ^ ": " ^ IdentPrint.printSCon scon
    | MirTypes.MLVALUE _ =>
        MirTypes.print_tag tag ^ ": <ml_value>"

  fun string_mir_code(MirTypes.CODE(the_refs, values, proc_sets)) =
    "MIR code unit\n" ^
    refs the_refs ^ "\n" ^
    (Lists.reducel
     (fn (a,b) => a ^ "\n  " ^ b)
     (" Values", map value values)) ^ "\n" ^
    (Lists.reducel
     (fn (a,b) => a ^ "\n" ^ b)
     (" Procedure sets", map proc_set proc_sets)) ^ "\n"

  fun print_mir_code (MirTypes.CODE(the_refs, values, proc_sets)) stream =
    (TextIO.output(stream, "MIR code unit\n");
     TextIO.output(stream, refs the_refs);
     TextIO.output(stream, "\n Values\n");
     Lists.iterate
     (fn x => (TextIO.output(stream, value x); TextIO.output(stream, "\n")))
     values;
     TextIO.output(stream, " Procedure sets\n");
     Lists.iterate
     (fn x => (proc_set_print(stream, x); TextIO.output(stream, "\n")))
     proc_sets)

  val binary_op = binary
  val unary_op = unary
  val binary_fp_op = binaryfp
  val unary_fp_op = unaryfp
  val store_op = store
  val store_fp_op = storefp

end
