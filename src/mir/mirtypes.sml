(* mirtypes.sml the signature *)
(*
$Log: mirtypes.sml,v $
Revision 1.85  1999/02/02 16:01:21  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.84  1997/07/31  12:57:13  jont
 * [Bug #30215]
 * Remove BIC, and replace by INTTAG instruction
 *
 * Revision 1.83  1997/05/01  12:37:40  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.82  1997/01/16  12:33:34  matthew
 * Allow multiple tags for tagged instructions
 *
 * Revision 1.81  1996/05/14  10:16:44  matthew
 * Adding NOT32 MIR instruction
 *
 * Revision 1.80  1996/02/26  12:48:36  jont
 * mononewmap becomes monomap
 *
 * Revision 1.79  1996/02/02  12:20:12  jont
 * Add ADDW, SUBW for untagged integer operations
 * with register cleaning on overflow
 *
Revision 1.78  1995/12/20  12:41:49  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.77  1995/01/04  12:59:40  matthew
require "../debugger/runtime_env";
\\nRenaming debugger_env to runtime_env

Revision 1.76  1994/11/23  13:59:47  matthew
Adding ALLOC_VECTOR

Revision 1.75  1994/11/11  14:04:44  jont
Add immediate store operations

Revision 1.74  1994/09/30  12:44:00  jont
Remove handler register concept

Revision 1.73  1994/09/14  13:50:05  matthew
Abstraction of debug information

Revision 1.72  1994/08/25  13:31:34  matthew
Remove various bits of annotation

Revision 1.71  1994/07/21  15:50:11  matthew
Added function argument register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER
Changed loop_entry in procedure parameters to be a tag list, so we can have lots.

Revision 1.70  1994/05/12  12:40:40  richard
Add loop entry point to procedure parameters.

Revision 1.69  1994/03/09  14:56:59  jont
Adding load offset instruction

Revision 1.68  1994/01/17  18:29:04  daveb
Removed unnecessary exceptions from closures.

Revision 1.67  1993/11/04  16:29:56  jont
Added INTERRUPT instruction

Revision 1.66  1993/07/29  14:18:32  nosa
Debugger Environments for local and closure variable inspection
in the debugger;
new stack spill slots;
structure Option.

Revision 1.65  1993/04/27  10:58:57  richard
Changed PROFILE instruction to INTERCEPT.

Revision 1.64  1993/03/10  18:01:09  matthew
Signature revisions

Revision 1.63  1993/03/04  09:56:22  matthew
Removed (commented out) options.
Options & Info changes.

Revision 1.62  1993/03/01  14:06:26  matthew
Changed representation of value to include MLVALUEs

Revision 1.61  1993/01/28  09:46:25  jont
Added default options

Revision 1.60  1993/01/04  17:00:39  jont
Added code printing controls to options

Revision 1.59  1992/12/08  19:30:24  jont
Removed a number of duplicated signatures and structures

Revision 1.58  1992/12/01  12:47:30  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.57  1992/10/29  17:30:04  jont
Added Map structure for mononewmaps to allow efficient implementation
of lookup tables for integer based values

Revision 1.56  1992/08/26  13:29:49  jont
Removed some redundant structures and sharing

Revision 1.55  1992/08/24  13:10:37  richard
Added NULLARY opcode type and ALLOC_BYTEARRAY.

Revision 1.54  1992/06/29  08:07:27  clive
Added type annotation information at application points

Revision 1.53  1992/06/18  16:12:49  richard
Added parameter to RAISE once again.

Revision 1.52  1992/06/16  19:14:45  jont
Expanded refs section of mir_code to allow for interpretive stuff

Revision 1.51  1992/05/06  17:14:29  jont
Added int_of_tag function

Revision 1.50  1992/04/14  08:56:01  clive
First version of the profiler

Revision 1.49  1992/02/27  15:34:33  richard
Changed the virtual register types to be structures of signature
VIRTUALREGISTER.

Revision 1.48.1.1  1992/02/27  15:34:33  richard
This version of MirTypes supplied monomorphic virtual register sets
as abstract types.

Revision 1.48  1992/02/07  12:47:47  richard
Added `hash_*_register'.
Abolished PRESERVE_ALL_REGS and PREVIOUS_ENVIRONMENT.

Revision 1.47  1992/01/16  11:19:17  clive
Alloc may now have a register argument for allocating arrays

Revision 1.46  1992/01/14  13:47:43  jont
Raise no longer has a parameter

Revision 1.45  1991/12/02  13:57:47  jont
Added tail call operation

Revision 1.44  91/11/20  12:20:34  jont
Added exception generating fp opcodes

Revision 1.43  91/11/14  15:20:52  richard
Added CALL_C opcode.

Revision 1.42  91/11/14  10:51:03  richard
Removed references to fp_double registers.

Revision 1.41  91/11/08  16:09:01  richard
Added FSTREF, FLDREF and an offset argument to STACKOPs.

Revision 1.40  91/10/28  15:16:47  richard
Changed the form of the allocation instructions yet again. This
time they're a bit more orthogonal.

Revision 1.39  91/10/28  11:23:09  davidt
ALLOCATE doesn't have a scratch register or a proc_ref any more.

Revision 1.38  91/10/24  10:40:33  jont
Added BTA and BNT for tagged value testing

Revision 1.37  91/10/21  09:29:24  jont
New local and external reference code

Revision 1.36  91/10/17  14:17:15  jont
New style ALLOC opcodes

Revision 1.35  91/10/16  14:14:11  jont
Added parameter to heap allocation to indicate position in closure
of call_c function
Updated to reflect new simplified module structure

Revision 1.34  91/10/15  15:10:34  richard
Added ALLOC_PAIR.

Revision 1.33  91/10/11  13:43:08  richard
Added DEALLOC_STACK.

Revision 1.32  91/10/11  09:55:58  richard
Parameters removed from ENTER and added to the
procedure type. Parameters for spill, stack, and register
usage added.

Revision 1.31  91/10/10  13:44:42  richard
Removed RESTORE_REGS and PRESERVE_REGS and replaced with parameterized
ENTER and PREVIOUS_ENVIRONMENT. Parameterized RAISE.

Revision 1.30  91/10/04  11:31:58  jont
Added new PROC type

Revision 1.29  91/10/03  11:22:25  jont
New code structure

Revision 1.28  91/10/03  11:06:12  jont
Added tag to refs

Revision 1.27  91/10/03  10:57:04  jont
Changed CODE structure to enable easier handling of code, values
and load time semantics

Revision 1.26  91/10/02  11:02:58  jont
Removed real register options, these are being done elsewhere

Revision 1.25  91/10/01  09:55:18  richard
Added ordering functions on gc, non_gc, fp and fp_double registers so
that they can be used in tables.

Revision 1.24  91/09/30  10:03:12  richard
Added an ordering function on the any_register type.

Revision 1.23  91/09/25  14:54:29  richard
Added register conversion functions.

Revision 1.22  91/09/24  10:41:32  richard
Added tag equality function.

Revision 1.21  91/09/23  15:08:35  richard
Added an ordering function on block tags to allow use of lookup tables.

Revision 1.20  91/09/23  10:38:30  richard
Added NEW_HANDLER, OLD_HANDLER, and RAISE directives.

Revision 1.19  91/09/20  15:30:27  jont
Added PRESERVE_ALL_REGS.

Revision 1.18  91/09/19  15:52:08  jont
Added MODV

Revision 1.17  91/09/17  13:49:48  jont
Changed branches to target bl_dest

Revision 1.16  91/09/17  10:43:15  jont
Added ALLOCA for stack allocated items

Revision 1.15  91/09/10  14:27:59  jont
Added new type symbolic, and extra constructor GP_IMM_SYMB for
values not yet known

Revision 1.14  91/09/05  15:56:11  jont
Added LDREF and STREF to assist optimiser deduce available expressions

Revision 1.13  91/09/03  16:34:59  jont
Added LDB, STB

Revision 1.12  91/09/03  13:53:22  jont
Added PRESERVE_REGS and RESTORE_REGS. Removed ENTER_NO_CALLS
and EXIT_NO_CALLS

Revision 1.11  91/08/30  16:33:43  jont
Changed format for floating point operations to allow register colouring

Revision 1.10  91/08/29  14:02:28  jont
Slight change to ALLOC

Revision 1.9  91/08/22  16:39:14  jont
New ALLOC_REF
Removed data flow hints, these can be deduced.

Revision 1.8  91/08/15  14:15:10  jont
Updated for later version of HARP

Revision 1.7  91/08/09  17:04:18  jont
Added EXT_REF type

Revision 1.6  91/08/02  16:35:12  jont
Added a comment opcode to allow information to be passed through

Revision 1.5  91/08/01  17:18:39  jont
Added new opcodes for local reference and FN_CALL as required by the
loader

Revision 1.4  91/07/31  18:02:23  jont
Added some new instructions to indicate leaf procedures

Revision 1.3  91/07/30  14:07:54  jont
Minor changes

Revision 1.2  91/07/26  17:29:59  jont
Changed some types to allow register colouring information plus
more general purpose operands

Revision 1.1  91/07/25  15:05:11  jont
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

require "../utils/set";
require "../utils/monomap";
require "../debugger/debugger_types";
require "virtualregister";


signature MIRTYPES =
  sig
    structure Set : SET
    structure Map : MONOMAP
    structure Debugger_Types : DEBUGGER_TYPES

    eqtype SCon

    structure GC	: VIRTUALREGISTER
    structure NonGC	: VIRTUALREGISTER
    structure FP	: VIRTUALREGISTER
    sharing GC.Set.Text = NonGC.Set.Text = FP.Set.Text
    datatype any_register =
      GC of GC.T |
      NON_GC of NonGC.T |
      FLOAT of FP.T

    val order_any_reg : any_register * any_register -> bool

    (* offset of spill slot N from the frame pointer *)
    datatype SlotInfo = SIMPLE of int | DEBUG of Debugger_Types.RuntimeEnv.Offset ref * string

    (* Symbolic values *)
    datatype symbolic =
      GC_SPILL_SIZE |
      NON_GC_SPILL_SIZE |
      GC_SPILL_SLOT of SlotInfo |
      NON_GC_SPILL_SLOT of SlotInfo |
      FP_SPILL_SLOT of SlotInfo

    (* Operands *)
    datatype gp_operand =
      GP_GC_REG of GC.T
    | GP_NON_GC_REG of NonGC.T
    | GP_IMM_INT of int (* For real ints, represented with run time tags *)
    | GP_IMM_ANY of int (* For other values *)
    | GP_IMM_SYMB of symbolic (* For unknown (macro) values *)
    exception NotAnyRegister
    val gp_to_any : gp_operand -> any_register
    val any_to_gp : any_register -> gp_operand
    datatype reg_operand =
      GC_REG of GC.T
    | NON_GC_REG of NonGC.T
    val reg_to_any : reg_operand -> any_register
    val any_to_reg : any_register -> reg_operand
    datatype fp_operand =
      FP_REG of FP.T
    val fp_to_any : fp_operand -> any_register
    val any_to_fp : any_register -> fp_operand
    (* Addresses in store *)
    eqtype tag
    sharing type tag = Map.object
    val init_tag: unit -> unit
    val new_tag: unit -> tag
    val int_of_tag : tag -> int
    val print_tag: tag -> string
    val print_tag_list: tag list -> string
    val order_tag: tag * tag -> bool
    val equal_tag: tag * tag -> bool
    datatype bl_dest = TAG of tag | REG of reg_operand
    (* Operations *)
    datatype binary_op =
      ADDU |
      SUBU |
      MULU |
      MUL32U |
      AND |
      OR | 
      EOR | 
      LSR | 
      ASL | 
      ASR

    datatype tagged_binary_op =
      ADDS |
      SUBS |

      (* Handle overflow specially for these *)
      (* (because traps are hard) *)
      ADD32S |
      SUB32S |

      MULS |
      DIVS |
      MODS |

      MUL32S |
      DIV32S |
      MOD32S |

      (* These can raise Div *)
      DIVU |
      MODU |
      DIV32U |
      MOD32U

    datatype unary_op = 
      MOVE |
      INTTAG |
      NOT | 
      NOT32
    datatype tagged_binary_fp_op = FADDV | FSUBV | FMULV | FDIVV
    datatype binary_fp_op = FADD | FSUB | FMUL | FDIV
    datatype tagged_unary_fp_op =
      FABSV |
      FNEGV |
      FSQRTV |
      FLOGEV |
      FETOXV
    datatype unary_fp_op =
      FMOVE |
      FABS |
      FNEG |
      FINT |
      FSQRT |
      FLOG10 |
      FLOG2 |
      FLOGE |
      FLOGEP1 |
      F10TOX |
      F2TOX |
      FETOX |
      TETOXM1 |
      FSIN |
      FCOS |
      FTAN |
      FASIN |
      FACOS |
      FATAN
    datatype stack_op = PUSH | POP
    datatype store_op = LD | ST | LDB | STB | LDREF | STREF
    datatype store_fp_op = FLD | FST | FSTREF | FLDREF
    datatype int_to_float = ITOF
    datatype float_to_int = FTOI
    datatype branch = BRA (* Branch to basic block *)
    datatype cond_branch =
      BTA | (* Branch on tagged *)
      BNT | (* Branch on not tagged *)
      BEQ |
      BNE | (* Branch on eq/not eq *)
      BHI | (* Unsigned > *)
      BLS | (* Unsigned <= *)
      BHS | (* Unsigned >= *)
      BLO | (* Unsigned < *)
      BGT | (* Signed > *)
      BLE | (* Signed <= *)
      BGE | (* Signed >= *)
      BLT   (* Signed < *)
    datatype fcond_branch =
      FBEQ |
      FBNE | (* Branch on eq/not eq *)
      FBLE | (* Signed <= *)
      FBLT   (* Signed < *)
    datatype branch_and_link = BLR
    datatype tail_call = TAIL
    datatype computed_goto = CGT
    datatype allocate =
      ALLOC |
      ALLOC_VECTOR |
      ALLOC_REAL |
      ALLOC_STRING |
      ALLOC_BYTEARRAY |
      ALLOC_REF
    datatype adr = LEA | LEO
    datatype nullary_op = CLEAN

    datatype opcode =
      TBINARY of tagged_binary_op * tag list * reg_operand * gp_operand * gp_operand |
      BINARY of binary_op * reg_operand * gp_operand * gp_operand |
      UNARY of unary_op * reg_operand * gp_operand |
      NULLARY of nullary_op * reg_operand |
      TBINARYFP of tagged_binary_fp_op * tag list * fp_operand * fp_operand *
      fp_operand |
      TUNARYFP of tagged_unary_fp_op * tag list * fp_operand * fp_operand |
      BINARYFP of binary_fp_op * fp_operand * fp_operand * fp_operand |
      UNARYFP of unary_fp_op * fp_operand * fp_operand |
      STACKOP of stack_op * reg_operand * int option |
      STOREOP of store_op * reg_operand * reg_operand * gp_operand |
      IMMSTOREOP of store_op * gp_operand * reg_operand * gp_operand | (* For CISCs only *)
      STOREFPOP of store_fp_op * fp_operand * reg_operand * gp_operand |
      REAL of int_to_float * fp_operand * gp_operand |
      FLOOR of float_to_int * tag * reg_operand * fp_operand |
      BRANCH of branch * bl_dest |
      TEST of cond_branch * tag * gp_operand * gp_operand |
      FTEST of fcond_branch * tag * fp_operand * fp_operand |
      (* Added set of argument registers *)
      BRANCH_AND_LINK of branch_and_link * bl_dest * Debugger_Types.Backend_Annotation * any_register list |
      (* Added set of argument registers *)
      TAIL_CALL of tail_call * bl_dest * any_register list |
      CALL_C |
      SWITCH of computed_goto * reg_operand * tag list |
      ALLOCATE of allocate * reg_operand * gp_operand |
      ALLOCATE_STACK of allocate * reg_operand * int * int option |
      DEALLOCATE_STACK of allocate * int |
      ADR of adr * reg_operand * tag |
      (* Interception *)
      INTERCEPT |
      (* Interruption *)
      INTERRUPT |
      (* Information points *)
      ENTER of any_register list | (* Entry point for procedure *)
      RTS | (* Return point from procedure *)
      NEW_HANDLER of reg_operand (* Pointer to the frame *) *
	tag (* tag on continuation point *) | (* Set handler inside function *)
      OLD_HANDLER | (* Restore previous handler *)
      RAISE of reg_operand | (* Raise the current handler (special call) *)
      COMMENT of string

    datatype refs = REFS of
      (tag * int) list *		(* internal references *)
      {requires : (string * int) list,		(* external references *)
       vars : (string * int) list, (* interpretive environment vars *)
       exns : (string * int) list, (* interpretive environment exns *)
       strs : (string * int) list, (* interpretive environment strs *)
       funs : (string * int) list} (* interpretive environment funs *)

    datatype valspec =
      SCON of SCon
    | MLVALUE of MLWorks.Internal.Value.ml_value

    datatype value =
      VALUE of tag * valspec

    datatype block = BLOCK of tag * opcode list

    datatype procedure_parameters = PROC_PARAMS of
      {spill_sizes	: {gc		: int,
                           non_gc	: int,
                           fp		: int} option,
       old_spill_sizes	: {gc		: int,
                           non_gc	: int,
                           fp		: int} option,
       stack_allocated	: int option}

    datatype procedure = PROC of
      string *          (* Procedure name *)
      tag *		(* tag of the procedure entry block *)
      procedure_parameters *
      block list *		(* procedure code *)
      Debugger_Types.RuntimeEnv.RuntimeEnv    (* runtime environment for code *)

    datatype mir_code = CODE of
      refs *
      value list *
      procedure list list	(* list of recursive procedure sets *)

  end
