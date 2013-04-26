(* mips Mach_Cg functor
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *
 * Revison Log
 * $Log: _mach_cg.sml,v $
 * Revision 1.121  1998/04/23 10:54:57  mitchell
 * [Bug #30349]
 * Fix non-unit non-final expression warnings
 *
 * Revision 1.120  1998/02/13  15:35:20  jont
 * [Bug #70055]
 * Make sure argument saved whenever debugging or tracing are enabled
 *
 * Revision 1.119  1998/01/30  09:48:00  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.118  1997/11/13  11:19:32  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.117.2.2  1997/11/20  17:09:08  daveb
 * [Bug #30326]
 *
 * Revision 1.117.2.1  1997/09/11  20:57:59  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.117  1997/08/08  09:49:42  jont
 * [Bug #30243]
 * Remove tests for out of range shifts as we no longer generate them
 *
 * Revision 1.116  1997/08/01  14:02:13  jont
 * [Bug #30215]
 * Remove BIC, and replace by INTTAG instruction
 *
 * Revision 1.115  1997/06/12  14:46:46  matthew
 * [Bug #20071]
 *  Use 32 bit not for BIC
 *
 * Revision 1.114  1997/06/12  14:34:12  matthew
 * [Bug #20064]
 * Ensure r2 not overwritten in 32 bit int arithmetic.
 *
 * Revision 1.113  1997/05/30  11:56:48  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.112  1997/05/27  11:16:53  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.111  1997/05/22  13:37:02  matthew
 * Speeding up linearization
 *
 * Revision 1.110  1997/05/06  09:51:40  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.109  1997/04/01  12:23:59  daveb
 * [Bug #1995]
 * Changed the definition of no_delay so that the mips_r4000 and early_mips_r4000
 * definitions are no longer linked.
 *
 * Revision 1.108  1997/03/25  11:28:45  matthew
 * Renamed R4000 option
 *
 * Revision 1.107  1997/01/29  10:47:47  matthew
 * Changing CGT code
 *
 * Revision 1.106  1997/01/24  14:46:13  matthew
 * Adding version options
 *
 * Revision 1.105  1997/01/16  16:34:18  matthew
 * Adding hardware multiply
 *
 * Revision 1.104  1996/12/05  09:29:02  stephenb
 * [Bug #1832]
 * event_check_code: add a couple of nops to avoid load hazzards
 * on an R3000.
 *
 * Revision 1.103  1996/11/06  11:11:08  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.102  1996/11/04  15:28:00  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.101  1996/10/23  10:36:25  jont
 * Remove basis.toplevel
 *
 * Revision 1.100  1996/09/27  12:33:59  matthew
 * Adding restore_fps in tail call code
 *
 * Revision 1.99  1996/08/16  17:57:49  io
 * basify mach_cg
 *
 * Revision 1.98  1996/08/08  16:58:40  jont
 * [bug 1535]
 * Ensure spill references are faulted if no stack specified
 *
 * Revision 1.97  1996/08/01  16:40:33  jont
 * Problems with parameters to set_proc_data being wrong order
 *
 * Revision 1.96  1996/08/01  12:59:07  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.95  1996/05/30  12:43:18  daveb
 * The Ord exception is no longer at top level.
 *
 * Revision 1.94  1996/05/17  09:41:03  matthew
 * Moving Bits to Internal
 *
 * Revision 1.93  1996/05/14  10:41:14  matthew
 * Adding NOT32 MIR instruction
 *
 * Revision 1.92  1996/05/08  14:32:24  matthew
 * Fixing problem with untagged arithmetic.
 *
 * Revision 1.91  1996/05/07  16:54:14  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.90  1996/05/01  12:07:50  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.89  1996/04/29  14:51:39  matthew
 * Removing checks for validity of FP results
 *
 * Revision 1.88  1996/03/28  18:16:14  jont
 * Fixing looping problems generating ADDW rn, rn, rm
 *
 * Revision 1.87  1996/03/21  15:22:25  matthew
 * Fixing problem with immediate shifts
 *
 * Revision 1.86  1996/02/05  11:38:32  jont
 * Add implemetations of ADDW and SUBW
 * These are like ADDV and SUBV, except that
 * they cannot use exception trapping adds etc because they are untagged
 * and also when they detect overflow they must clean
 * all registers involved in the operation
 *
 * Revision 1.85  1996/01/30  14:26:59  jont
 * Ensure that stack frame sizes are always double word aligned
 *
 * Revision 1.84  1996/01/29  18:12:43  jont
 * Fix bug in polymorphic equality sequence by decrementing instead
 *
 * Revision 1.83  1995/12/22  13:26:43  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 * Revision 1.82  1995/11/22  10:56:12  jont
 * Tidy up some missing constructors in BINARY code generation
 *
 * Revision 1.81  1995/11/21  15:53:53  jont
 * Fix bugs in xor (and others) with immediate negative constants
 *
 * Revision 1.80  1995/11/21  12:05:32  jont
 * Modification for improved runtime env spill offsets
 * to indicate the kind of data spilled
 *
 * Revision 1.79  1995/09/22  15:59:50  jont
 * Fix bug in compiler crash when number of fp spill slots exceeded
 *
 * Revision 1.78  1995/09/15  13:49:34  io
 * fix MirTypes.TEST from overflowing ~1 on unsigned operations.
 *
 * Revision 1.77  1995/09/08  16:31:48  jont
 * Add a fixed branch type which can't be expanded beyond the 16 bit limit
 * This can be used to detect disastrous code generation in computed gotos
 * If this ever occurs, we can then fix the bug
 *
 * Revision 1.76  1995/09/08  13:30:20  io
 * ambiguity between const0 and reg0 in TEST
 *
 * Revision 1.75  1995/08/18  13:32:43  io
 * used slt/sltu in TEST, fixed bug introduced in BTA&BNT
 * sorted out overflow
 *
 * Revision 1.74  1995/08/10  16:00:10  io
 * implement jon's suggestion with imm32 cases in test and unsigned const comparisons
 *
 * Revision 1.73  1995/08/09  20:03:22  io
 * fix large imm problem, update mirtypes.test for unsigned code, shortcuts
 * eg [<u lhs zero] -> bnez lhs, optimize zero_reg tests
 *
 * Revision 1.72  1995/07/28  15:14:10  io
 * emit for BLO case (incomplete stub so that compiler can bootstrap)
 *
 * Revision 1.71  1995/07/25  15:50:23  jont
 * Add WORD to value_cg
 *
 * Revision 1.70  1995/07/19  14:22:18  jont
 * Add CHAR to value_cg
 *
 * Revision 1.69  1995/07/10  15:57:19  jont
 * Fix code generation problems with shifts
 *
 * Revision 1.68  1995/06/20  12:49:48  matthew
 * Fixing problem with not restoring fp registers
 *
 * Revision 1.67  1995/06/19  16:19:37  jont
 * Fix missing case in store floating point value
 *
 * Revision 1.66  1995/06/15  15:03:09  jont
 * Remove message about restarting linearise_sub
 *
 * Revision 1.65  1995/05/31  15:21:37  nickb
 * Rewrote the allocation code to get ml_gc_leaf to work.
 * Also tidied it up, and added a bunch of shorthand
 * names for registers &c.
 *
 * Revision 1.64  1995/05/09  15:39:29  nickb
 * Change stack overflow entry code; using fp as a temporary breaks
 * the profiler.
 *
 * Revision 1.63  1995/05/04  14:41:52  matthew
 * Partially fixing "restarting linearize_sub .." problem
 *
 * Revision 1.62  1995/05/02  15:31:39  matthew
 * Removing step and polyvariable options
 *
 * Revision 1.61  1995/04/27  15:59:26  nickb
 * Move the debugging argument save.
 * Plus a few general tidying changes.
 *
 * Revision 1.60  1995/04/20  10:52:30  nickb
 * Rearrange tail call instructions to make life easier for the profiler.
 *
 * Revision 1.59  1995/04/12  14:57:07  nickb
 * Turn on MIPS R4000 v 2.2 bug work-around
 *
 * Revision 1.58  1995/03/20  12:37:49  matthew
 * Disabling generation of "debugging" code
 *
 * Revision 1.57  1995/03/07  16:17:48  matthew
 * Fixing debugger stuff
 *
 * Revision 1.56  1995/03/01  17:20:21  matthew
 * Changes to Options structure/
 *
 * Revision 1.55  1995/02/02  15:27:08  nickb
 * Make arithmetic operations trap.
 * Also reduce code verbosity by adding some local names for things.
 *
 * Revision 1.54  1995/01/30  14:54:25  matthew
 * Debugger changes
 *
 * Revision 1.53  1995/01/10  18:06:51  nickb
 * Make the test for stack overflow unsigned so it catches the asynch events.
 *
 * Revision 1.52  1995/01/10  14:09:27  nickb
 * Add support for INTERRUPT.
 * Also extend INTERCEPT code.
 * Also allow functions which raise, or call real() or floor(), to be leaf.
 *
 * Revision 1.51  1994/12/09  12:00:14  nickb
 * Fix implicit entry points.
 *
 * Revision 1.50  1994/11/28  16:43:10  matthew
 * Fix for bytearray allocation length problem.
 * Changed real number unrepresentable message
 *
 * Revision 1.49  1994/11/25  17:59:46  nickb
 * Stack extension / function entry code changes.
 *
 * Revision 1.48  1994/11/24  14:44:35  matthew
 * Added code for ALLOC_VECTOR
 * Fixed problem with loop in initStackSlots
 *
 * Revision 1.47  1994/11/22  17:08:52  io
 * updating floor,
 * updating MirTypes.TEST for constant operands
 *
 * Revision 1.46  1994/11/16  12:28:31  jont
 * Add support for immediate store operation
 *
 * Revision 1.45  1994/11/15  12:14:50  matthew
 * Some changes for scheduling
 * Added elim_simple_branches functions
 *
 * Revision 1.44  1994/11/09  16:33:57  io
 * making stack initialisation shorter
 *
 * Revision 1.43  1994/11/08  19:22:30  io
 * rewriting real
 *
 * Revision 1.42  1994/11/02  12:37:27  matthew
 * Fixed problems with loading immediates:
 * use ADDUI for -2**15 .. 2**15-1
 * use ORI for 2**15 ..2**16-1
 * use LUI & ORI for other immediates
 * Fixed order of loading halves of double floats --
 * this may be endianness specific
 * Moved scheduling phase to during linearization.
 * Changed jumps in ALLOCATE to be to labels rather than by
 * fixed amounts.  This was confusing the scheduler.
 * Added removal of unreachable blocks before linearization.
 *
 * Revision 1.41  1994/10/24  14:21:57  matthew
 * Various things:
 * Fixed problems with pc-relative long branches
 * Rationalized some of the code comments
 * Reformatted a little
 * Commented out the "append_small_exit" part
 *
 * Revision 1.40  1994/10/05  13:42:27  jont
 * Changes for new NEW_HANDLER instruction
 *
 * Revision 1.39  1994/09/23  13:00:18  matthew
 * Abstraction of debug information
 *
 * Revision 1.38  1994/08/25  13:39:49  matthew
 * Changes to PROC_PARAMS
 *
 * Revision 1.37  1994/08/25  10:41:10  jont
 * Remove dependence on mir optimiser for fp registers used
 * Remove dependence on mir optimiser for gc registers used as well
 *
 * Revision 1.36  1994/07/28  16:27:52  jont
 * Use non-exception detecting arithmetic for the present
 *
 * Revision 1.35  1994/07/27  16:15:48  jont
 * Fix loading of large tagged integers
 *
 * Revision 1.34  1994/07/25  14:17:17  matthew
 * Added register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER instructions.
 *
 * Revision 1.33  1994/07/22  13:29:45  jont
 * Modifications to include number of callee saves in wordsets
 * Fixed bugs in BIC, NOT and array length calculations
 *
 * Revision 1.32  1994/07/15  16:30:07  jont
 * Fix alignment and size calculation for arrays and bytearrays
 *
 * Revision 1.31  1994/07/15  14:22:18  io
 * fixed rest of ALLOCATE
 *
 * Revision 1.30  1994/07/15  13:11:33  jont
 * Fix restore fp not allowed in delay slot for the second time
 *
 * Revision 1.29  1994/07/14  12:28:14  jont
 * Fix problem with load_large_IMM_ANY_into_register
 *
 * Revision 1.28  1994/07/14  10:12:36  io
 * unifying jon's changes & revising ALLOCATE.
 *
 * Revision 1.25  1994/07/07  14:08:36  io
 * cleared up redundant match patterns
 *
 * Revision 1.24  1994/07/07  13:12:39  io
 * revised changes
 *
 * Revision 1.23  1994/06/24  14:17:43  jont
 * Update debugger information production
 *
 * Revision 1.22  1994/06/16  18:36:03  sml
 * Blotched checkin: redoing again
 *
 * Revision 1.21  1994/06/16  18:11:55  io
 * Blotched checkin: redoing
 *
 * Revision 1.20  1994/06/16  15:27:54  io
 * add new ENTER conventions
 *
 * Revision 1.19  1994/06/14  12:59:11  io
 * cleaning up caller_arg and callee_arg
 *
 * Revision 1.18  1994/06/13  12:13:29  io
 * added path change to accomodate new runtime structure
 *
 * Revision 1.14  1994/03/18  18:18:42  jont
 * Rationalise stack layout information
 * Fix bug whereby spills were written in the wrong place
 * Fix bug whereby gc initialisation was starting and finishing too low
 *
 * Revision 1.13  1994/03/11  16:21:06  jont
 * Fix code generation of LEO for mutually recursive function case
 *
 * Revision 1.12  1994/03/10  12:53:19  jont
 * Added code generation of load_offset.
 * Added handling of case where load_offset can't be one instruction
 * similar to case where adr expands to more than one
 *
 * Revision 1.11  1994/03/09  10:39:27  jont
 * Moved module types to separate file (code_module)
 * Fixed out of range branches and calls when compiling large functions
 * Recoded switch statements for semantic integrity
 * and to avoid long branch problems
 *
 * Revision 1.10  1994/03/04  12:40:46  jont
 * Moved machpsec from mips to main
 * Fixed problem where store offset zero was returned as register 0
 *
 * Revision 1.9  1994/03/04  11:08:24  jont
 * Fixing some store instruction problems
 *
 * Revision 1.8  1994/03/01  17:56:52  jont
 * Bring into line with debugger changes
 *
 * Revision 1.5  1994/02/23  18:10:11  jont
 * Updates to entry sequence
 *
 * Revision 1.3  1993/12/20  14:53:36  io
 * minor path change
 *
 * Revision 1.2  1993/11/17  13:42:01  io
 * Deleted old SPARC comments and fixed type errors
 *
 *)

require "../basis/__int";
require "../basis/__string";
require "../basis/__list";
require "../basis/__list_pair";
require "../utils/lists";
require "../utils/print";
require "../utils/mlworks_timer";
require "../utils/crash";
require "../utils/diagnostic";
require "../utils/sexpr";
require "../basics/ident";
require "../main/reals";
require "../main/options";
require "../mir/mirtables";
require "../mir/mirregisters";
require "../rts/gen/implicit";
require "../rts/gen/tags";
require "../main/info";
require "../main/machspec";
require "../main/code_module";
require "mips_schedule";
require "../main/mach_cg";

functor Mach_Cg(
  structure Tags : TAGS
  structure Print : PRINT
  structure Timer : INTERNAL_TIMER
  structure Lists : LISTS
  structure Crash : CRASH
  structure Info : INFO
  structure Sexpr : SEXPR
  structure Reals : REALS
  structure Ident : IDENT
  structure Options : OPTIONS
  structure MirTables : MIRTABLES
  structure MirRegisters : MIRREGISTERS
  structure MachSpec : MACHSPEC
  structure Mips_Schedule : MIPS_SCHEDULE
  structure Code_Module : CODE_MODULE
  structure Implicit_Vector : IMPLICIT_VECTOR
  structure Diagnostic : DIAGNOSTIC

  sharing Info.Location = Ident.Location
  sharing MirTables.MirTypes.Set = MachSpec.Set
  sharing MirTables.MirTypes = MirRegisters.MirTypes = Mips_Schedule.Mips_Assembly.MirTypes
  sharing type Ident.SCon = MirTables.MirTypes.SCon

  sharing type Mips_Schedule.Mips_Assembly.Mips_Opcodes.MachTypes.Mips_Reg
    = MachSpec.register
     ) : MACH_CG =
struct
  structure Mips_Assembly = Mips_Schedule.Mips_Assembly
  structure Mips_Opcodes = Mips_Assembly.Mips_Opcodes
  structure MirTypes = MirTables.MirTypes
  structure MachTypes = Mips_Opcodes.MachTypes
  structure MachSpec = MachSpec
  structure Diagnostic = Diagnostic
  structure Debugger_Types = MirTypes.Debugger_Types
  structure Map = MirTypes.Map
  structure Ident = Ident
  structure Set = MirTypes.Set
  structure Info = Info
  structure RuntimeEnv = MirTypes.Debugger_Types.RuntimeEnv
  structure Options = Options

  structure Bits = MLWorks.Internal.Bits

  type Module = Code_Module.Module
  type Opcode = Mips_Assembly.opcode

  val do_timings = ref false

  (* <URI:rts/gen/__tags.sml#MIPS_INTERCEPT_LENGTH>
   * <URI:rts/src/arch/MIPS/interface.S#ml_nop>
   *)
  val trace_dummy_instructions =
    [(Mips_Assembly.trace_nop_code,NONE,"Tracing nop"),
     (Mips_Assembly.trace_nop_code,NONE,"Tracing nop"),
     (Mips_Assembly.trace_nop_code,NONE,"Tracing nop"),
     (Mips_Assembly.trace_nop_code,NONE,"Tracing nop")]

  val do_diag = false

  val diagnostic_output =
    if do_diag
      then Diagnostic.output
    else fn _ => fn _ => ()

  val print_code_size = ref false

  (* Constant limits on aspects of the MIPS architecture *)

  val fifteen_bits = 32768 (* 2 ^ 15 *)
  val sixteen_bits = 65536 (* 2 ^ 16 *)

  val arith_imm_limit = fifteen_bits
  val unsigned_arith_imm_limit = sixteen_bits
  val branch_disp_limit = fifteen_bits
  val sethi_hisize = sixteen_bits
  val sethi_losize = sixteen_bits

  (* shorthand for commonly-used registers to make code sequences more legible *)

  val global_mir = MirRegisters.global
  val global = MachTypes.global
  val global_op = Mips_Assembly.REG global
  val global_reg = MirTypes.GC_REG global_mir
  val global_gp = MirTypes.GP_GC_REG global_mir
  val zero = MachTypes.zero_reg
  val zero_op = Mips_Assembly.REG zero
  val lr = MachTypes.lr
  val lr_op = Mips_Assembly.REG lr
  val nop = Mips_Assembly.nop
  val other_nop = (Mips_Assembly.other_nop_code,NONE,"Don't reschedule or eliminate this")
  val dummy = MachTypes.dummy_reg
  val dummy_op = Mips_Assembly.REG dummy

  (* This is used to store lr temporarily during calculation of long jumps *)
  val hacky_temporary_reg = MachTypes.R16

  (* find_nop_offsets: searches for tracing nops *)
  local
    fun find_nop_offsets(_, []) = ~1
      | find_nop_offsets(offset, (opcode, _) :: rest) =
	if opcode = Mips_Assembly.trace_nop_code then
	  offset
	else
	  find_nop_offsets(offset+1, rest)
  in
    val find_nop_offsets = fn (tag, code) => find_nop_offsets(0, code)
  end (* local *)

  fun check_range(i:int, signed, pos_limit) =
    if signed then
	(i >= 0 andalso i < pos_limit) orelse
	(i < 0 andalso i >= ~pos_limit)
    else i >= 0 andalso i < pos_limit

  (* fault_range: checks for branching outside offset limits *)
  fun fault_range(i, signed, pos_limit) =
    if check_range(i, signed, pos_limit)
      then i
    else
      (diagnostic_output 3
       (fn _ => ["fault_range called with value ",
		 Int.toString i,
		 " in positive range ",
		 Int.toString pos_limit]);
       Crash.impossible"Immediate constant out of range")

  (* make_imm_fault: puts arg into IMM form *)
  fun make_imm_fault(0, signed, max_pos) = zero_op
    | make_imm_fault(i, signed, max_pos) = let
	val _ = fault_range(i, signed, max_pos)
      in
	Mips_Assembly.IMM i
      end

  val absent = NONE

  (* copy: duplicates element N times tail-recursively *)
  fun copy n x =
    let
      fun copy' (0,acc) = acc
        | copy' (n,acc) = copy' (n-1,x :: acc)
    in
      if n < 0 then
	Crash.impossible "copy: negative"
      else
	copy' (n,[])
    end (* copy *)

  fun rev_fold_append([], acc) = acc
    | rev_fold_append(x :: xs, acc) = rev_fold_append(xs, x @ acc)

  fun rev_map f arg =
    let
      fun map_sub([], acc) = acc
	| map_sub(x :: xs, acc) = map_sub(xs, f x :: acc)
    in
      map_sub arg
    end

  fun revapp ([],l) = l
    | revapp (a::b,c) = revapp (b,a::c)

  fun drop (0,l) = l
    | drop (n,[]) = Crash.impossible "drop ran out of items"
    | drop (n,a::b) = drop (n-1,b)

  fun move_regc(rd, rs, comment) =
    (Mips_Assembly.ARITHMETIC_AND_LOGICAL
     (Mips_Assembly.OR, rd, rs, zero_op),
      absent, comment)

  (* move_reg: or rd, rs *)
  fun move_reg(rd, rs) =
    (Mips_Assembly.ARITHMETIC_AND_LOGICAL
     (Mips_Assembly.OR, rd, rs, zero_op),
     absent, "")

  (* move_imm: addiu rd, $0 *)
  fun move_imm(rd, imm) =
    (Mips_Assembly.ARITHMETIC_AND_LOGICAL
     (Mips_Assembly.ADDIU, rd, zero, Mips_Assembly.IMM imm),
     absent, "")

  (* move_immc :: addiu rd, $0 *)
  (* ORI zero extends the immediate so won't work *)
  fun move_immc(rd, imm, comment) =
    (Mips_Assembly.ARITHMETIC_AND_LOGICAL
     (Mips_Assembly.ADDIU, rd, zero, Mips_Assembly.IMM imm),
     absent, comment)


  fun make_clean_code reg_list =
    let
      val regs_to_clean = Lists.rev_remove_dups reg_list
      val regs_to_clean =
        List.filter
        (fn reg => reg <> MachTypes.R0 andalso
         reg <> MachTypes.global)
        regs_to_clean
    in
      (* No point in cleaning global as it's non-gc *)
      (* R0 is already clean *)
      (map
       (fn reg => move_regc(reg, zero,"Clean register"))
       regs_to_clean)
    end

  fun binary_list_to_string(done, [], _, 128) = String.implode(rev done)
    | binary_list_to_string(_, [], _, l) =
      Crash.impossible("Binary_list_to_string length not 8, remainder length " ^
		       Int.toString l)
    | binary_list_to_string(done, x :: xs, digit, power) =
      let val x = ord x - ord #"0"
      in
	if power = 1 then
	  binary_list_to_string(chr(digit + x) :: done, xs, 0, 128)
	else
	  binary_list_to_string(done, xs, digit + x * power, power div 2)
      end


  (* to_binary converts 'value' into binary number stored in length 'digits' *)
  fun to_binary (digits:int, value:int) : char list =
    let
      fun to_sub(0, _, done) = done
	| to_sub(digs_to_go, value, done) =
	  let
	    val digit = chr (value mod 2 + ord #"0")
	  in
	    to_sub(digs_to_go - 1, value div 2, digit :: done)
	  end
    in
      to_sub(digits, value, [])
    end

  (* adjust: checks for overflow in expon notation *)
  local
    (* mantissa_is_zero: checks elements are all "0" *)
    fun mantissa_is_zero mantissa = List.all (fn x=> #"0" = x) (String.explode mantissa)
  in
    fun adjust (error_info,x,location) (mantissa, exponent, max_exponent, bits) =
      if mantissa_is_zero mantissa then
	(mantissa, 0)
      else
	if exponent > 0 andalso exponent < max_exponent then
	  (mantissa, exponent)
	else
	  (* Need to handle subnormal numbers *)
	  if exponent >= max_exponent then
	    Info.error'
	    error_info
	    (Info.FATAL,location,
	     "Real number unrepresentable: " ^ x)
	  else
	    if exponent < ~bits then (String.implode(copy bits #"0"), 0)
	    else
	      (String.implode(copy (abs exponent) #"0") ^ mantissa, 0)
  end (* adjust *)

  fun to_single_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 127
      val (mantissa, real_exponent) = adjust args (mantissa, real_exponent, 255, 23)
	
      val binary_list =
	(if sign then #"1" else #"0") ::
	   to_binary(8, real_exponent) @
	   String.explode (String.substring(mantissa, 1,23))
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun to_double_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 1023
      val (mantissa, real_exponent) = adjust args (mantissa, real_exponent, 2047, 52)
      val binary_list =
	(if sign then #"1" else #"0") ::
	   to_binary(11, real_exponent) @
	   String.explode(String.substring(mantissa, 1, 52))
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun to_extended_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 16383
      val (mantissa, real_exponent) =
	adjust args (mantissa, real_exponent, 32767, 63)
      val binary_list =
	(if sign then #"1" else #"0") ::
	   to_binary(15, real_exponent) @
	   copy 16 #"0" @
	   String.explode(String.substring(mantissa, 0, 64)) @
	   copy 32 #"0"
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun value_cg(i, MirTypes.SCON (Ident.STRING x),_) = Code_Module.STRING(i, x)
    | value_cg(i, MirTypes.SCON (Ident.REAL(x,location)),error_info) =
      (let
        val the_real = Reals.evaluate_real x
        val (sign, mantissa, exponent) = Reals.find_real_components the_real
        val encoding_function = case MachTypes.fp_used of
          MachTypes.single => to_single_string (error_info,x,location)
        | MachTypes.double => to_double_string (error_info,x,location)
        | MachTypes.extended => to_extended_string (error_info,x,location)
      in
        Code_Module.REAL(i, encoding_function(sign, mantissa, exponent))
      end handle MLWorks.Internal.StringToReal =>
	Info.error'
	error_info
	(Info.FATAL, location, "Real number unrepresentable: " ^ x)
      )
    | value_cg(_, MirTypes.SCON (Ident.INT _),_) = Crash.impossible"VALUE(INT)"
    | value_cg(_, MirTypes.SCON (Ident.CHAR _),_) = Crash.impossible"VALUE(CHAR)"
    | value_cg(_, MirTypes.SCON (Ident.WORD _),_) = Crash.impossible"VALUE(WORD)"
    | value_cg (i,MirTypes.MLVALUE value,_) =
      Code_Module.MLVALUE (i,value)

  (* last_opcode: return the external branch out of the block if one exists *)
  fun last_opcode [] = (nop, false)
    | last_opcode([elem as (Mips_Assembly.BRANCH(Mips_Assembly.BA, _, _, _), _, _), _])
      = (elem, true)
    | last_opcode([elem as (Mips_Assembly.FIXED_BRANCH(Mips_Assembly.BA, _, _, _), _, _), _])
      = (elem, true)
    | last_opcode(_ :: xs) = last_opcode xs

  fun make_proc_info(res as (main_tree, tag_tree), []) = res
    | make_proc_info((main_tree, tag_tree),
		     ((block_tag, opcode_list)) :: rest) =
      let
	val last_tag_exists as (tag, ok) = case last_opcode opcode_list of
	  ((_, SOME tag, _), true) => (tag, true)
	| _ => (block_tag, false)
      in
	make_proc_info
	((Map.define (main_tree, block_tag, last_tag_exists),
	  if ok then
	    Map.define (tag_tree, tag, 0)
	  else tag_tree), rest)
      end

  fun rev_app(     [], ys) = ys
    | rev_app(     xs, []) = xs
    | rev_app(x :: xs, ys) = rev_app(xs, x :: ys)


  (* remove_trailing_branch: deletes sll,ba,nop and stuffs comment into preceding opcode that it did so *)
  fun remove_trailing_branch(block_tag, opcode_list) =
    let
      val new_opc =
	case rev opcode_list of
	  (Mips_Assembly.ARITHMETIC_AND_LOGICAL  (* nop *)
	   (Mips_Assembly.SLL, MachTypes.R0, MachTypes.R0, _), _, _) ::
	  (Mips_Assembly.BRANCH _, _, _) :: rest => rest
	| (operation, opt, comment) :: (Mips_Assembly.BRANCH _, _, _) :: rest =>
	    (operation, opt, comment ^ " preceding BA removed") :: rest
	| (Mips_Assembly.ARITHMETIC_AND_LOGICAL  (* nop *)
	   (Mips_Assembly.SLL, MachTypes.R0, MachTypes.R0, _), _, _) ::
	  (Mips_Assembly.FIXED_BRANCH _, _, _) :: rest => rest
	| (operation, opt, comment) :: (Mips_Assembly.FIXED_BRANCH _, _, _) :: rest =>
	    (operation, opt, comment ^ " preceding BA removed") :: rest
	| _ => Crash.impossible"Remove trailing branch fails"
    in
      (block_tag, rev new_opc)
    end

  (* CT this now works on the continuer and non-continuer lists in turn *)
  fun find_dest_block(tag, [], [], x,y) = ((tag, []), false, x,y)
    | find_dest_block(dest_tag,
		      (block as (block_tag, opcode_list)) ::
		      rest,
		      other,
		      x , [] ) =
      if dest_tag = block_tag then
	(block, true, x @ rest, other)
      else find_dest_block(dest_tag, rest, other, block :: x,[])

    | find_dest_block(dest_tag,
		      [],
		      (block as (block_tag, opcode_list)) ::
		      rest,
		      x , y ) =
      if dest_tag = block_tag then
	(block, true, x , y @ rest)
      else find_dest_block(dest_tag, [], rest, x, block :: y)

    | find_dest_block _ =
      Crash.impossible "This should never happen in _mach_cg "

  (* Algorithm *)
  (* Start with the first block (entry block) *)
  (* Find the block it tails into, and append that *)
  (* Repeat until we end up with a block which either doesn't tail *)
  (* into an unused block (eg a loop), or doesn't tail at all (eg ret) *)
  (* Now find all blocks which tail into something *)
  (* and pick one from these which nothing tails into from these *)
  (* This is called a chain head *)
  (* Repeat as if we'd just started *)
  (* If no such block, pick one from the cycle and repeat as before *)
  (* If no blocks which tail at all, bung them on the end and finish *)
  (* A consequence of this algorithm is *)
  (* When searching for a new head of a chain, *)
  (* we need only check that a block which continues *)
  (* was never the target of another block (ie check at proc start) *)
  (* Because if it once was, and has now ceased to be *)
  (* Then it would have been processed already (reductio ad absurdum) *)

  fun reorder_blocks(proc as (proc_tag, block_list)) =
    (* Reorder the blocks for a proc so as to allow fall throughs *)
    (* Note that this will result in blocks with dangling ends *)
    (* So they must not be reordered again by any other means *)
    let
      val (proc_info, tag_tree) =
	make_proc_info((Map.empty , Map.empty), block_list)

      val proc_info_map = Map.tryApply proc_info
      val tag_tree_map = Map.tryApply tag_tree
      (* We don't have to repeatedly re-calculate the continuers lists *)
      fun do_fall_throughs_with_continuers_calculated(done, (block as (block_tag, opcode_list)),
                                                      continuers,non_continuers) =
        let
	  val (dest_tag, found_block) =
	    Map.apply_default'(proc_info, (block_tag, false), block_tag)

	  fun do_next() =
	    case continuers of
              (* CT this was rev(rev rest @ (block :: done)), but
               rev(rev rest @ (block::done)) = rev(block::done) @ rest
               = rev( [block] @ done) @ rest = rev done @ rev[block] @ rest
               = rev done @ (block :: rest)
               AND now rest = continuers @ non-continuers *)
	      [] =>
		rev_app(done, (block :: non_continuers))
	    | _ =>
		let
		  val (next_block, continuers') =
		    (let
		       val (tag,_) =
			 valOf (List.find (fn (x,_)=>not(isSome(tag_tree_map x))) continuers)
		       val (others,value) =
			 Lists.assoc_returning_others(tag,continuers)
		     in
		       ((tag, value),others)
		     end) handle Option =>
		       (hd continuers, tl continuers)
		in
		  do_fall_throughs_with_continuers_calculated(block :: done,
							      next_block,
                                                              continuers',
							      non_continuers)
		end
	in
	  if found_block then
	    let
	      val (dest_block, found_dest, non_continuers',continuers') =
		find_dest_block(dest_tag, non_continuers, continuers, [] , [])
	    in
	      if found_dest then
		do_fall_throughs_with_continuers_calculated
		(remove_trailing_branch block :: done,
		 dest_block, continuers', non_continuers')
	      else
		 do_next()
	    end
	  else
	     do_next()
	end

      fun do_fall_throughs(done, block, []) = rev(block :: done)
      | do_fall_throughs(done, block,rest) =
	let
	  fun continues(tag, _) =
	    case proc_info_map tag of
	      SOME(_, t) => t
	    | _ => false

	  val (continuers,non_continuers) =
	    Lists.partition continues rest
        in
          do_fall_throughs_with_continuers_calculated(done,block,continuers,non_continuers)
        end

      val (hd_block_list, tl_block_list) = case block_list of
	x :: y => (x, y)
      | _ => Crash.impossible"Empty block list"
    in
      (proc_tag, do_fall_throughs([], hd_block_list, tl_block_list))
    end

  fun tag_offsets([], offset, tag_env) = (offset, tag_env)
    | tag_offsets((tag, ho_list) :: rest, disp, tag_env) =
      tag_offsets(rest, disp + 4 * (List.length ho_list),
		  Map.define (tag_env, tag, disp))


  fun tag_offsets_for_list(_, [], env) = env
    | tag_offsets_for_list(offset, (_, proc) :: rest, env) =
      let
	val (next_offset, env) = tag_offsets(proc, offset, env)
	val next_offset' =
	  next_offset + 4 (* Back-pointer *) + 4 (* Procedure number within set *)
	val next_offset'' =
	  if next_offset' mod 8 = 4
	    then next_offset'+4
	  else next_offset'
      in
	tag_offsets_for_list(next_offset'', rest, env)
      end

  fun do_little_block(block as (tag, opcode_list)) =
    case opcode_list of _ => block (* I see no annulled branches here *)

  fun reschedule_little_blocks(proc_tag, block_list) =
    (proc_tag, map do_little_block block_list)

  (* linearise_list takes a list of procedures which have been code
   * generated and figures out all the displacements for branches &c,
   * so that instructions can be output. It also inserts nops to align
   * branch instructions (see the long comment below). It is called by
   * list_proc_cg *)

  fun linearise_list (mips_r4000, proc_list) =
    let

      val no_delay = mips_r4000
      val _ = diagnostic_output 3 (fn _ => (["Rescheduling code\n"]))

      val new_proc_list =
	Timer.xtime
	("Instruction Scheduling", !do_timings,
	 fn () => map (Mips_Schedule.reschedule_proc no_delay) proc_list)

      val _ = diagnostic_output 3 (fn _ => ["Rescheduled code\n"])

      (* We'd now like to reschedule any small blocks that branch backwards *)

      val new_proc_list = map reschedule_little_blocks new_proc_list

      fun do_linearise' (proc_list,bad_branches) =
	let
          fun addBadOffset item =
            (bad_branches := item :: !bad_branches;
             (Mips_Assembly.nop_code, "ERROR -- Dummy instruction for bad offset -- shouldn't see this"))

	  val tag_env = tag_offsets_for_list(0, proc_list, Map.empty)

	  val _ = diagnostic_output 3 (fn _ => ["Tag_env ="])
	  val _ =
	    diagnostic_output 3
	    (fn _ =>
             (app
              (fn (x, y) => Print.print("Tag " ^ MirTypes.print_tag x ^ ", value " ^ Int.toString y ^ "\n"))
              (Map.to_list tag_env) ;
              []))

	  fun lookup_env tag = Map.tryApply'(tag_env,tag)

	  fun copy_n( limit, xs, ys) =
	    if limit < 0 orelse limit > length xs then
	      Crash.impossible "copy_n: failed"
	    else
	      let
		fun scan (0, _, acc) = acc
		  | scan (n, x::xs, acc) = scan (n-1, xs, x::acc)
		  | scan (_, _, _) = Crash.impossible "scan: warnings & mmaps hate each other"
	      in
		rev_app(scan (limit, xs, []), ys)
	      end (* copy_n *)

	  fun linearise_proc(proc_offset, offset, [], done) =
	    (offset, rev done)
	    | linearise_proc(proc_offset, start, blocks as (block :: block_list), done) =
	    let
	      (* Insert algorithm for optimal linearisation of blocks here *)
	      (* Present algorithm just uses the current order *)
	      (* Also assumes NOPs inserted after all control transfers *)
	      fun do_block(block_start, (block_tag, opcode_list), done) =
		let
		  val fault_range =
		    fn (x, y as (offset, _, _)) =>
		    ((fault_range y) handle exn =>
		      (print ("fault_range fails on " ^ x ^
			      " with offset " ^ Int.toString offset ^
			      "\n");
		       raise exn))

		  fun invert_call_to_branch Mips_Assembly.BGEZAL = Mips_Assembly.BLTZ
		    | invert_call_to_branch Mips_Assembly.BLTZAL = Mips_Assembly.BGEZ

		  fun do_opcode((Mips_Assembly.BRANCH(branch, r1, r2, i),
				 tag_opt as SOME tag, comment), offset) =
                    (case lookup_env tag of
                       SOME res =>
                         let
			   val disp = ( res - offset) div 4 - 1
                         in
			   if check_range(disp, true, branch_disp_limit) then
			     (* Branch ok in one instruction *)
			     (Mips_Assembly.BRANCH(branch, r1, r2, disp), comment)
			   else
			     (* Nasty case *)
                             let
                               val _ =
                                 diagnostic_output 3
                                 (fn _ => ["Found bad branch, substituting\n",
					   "Offset = ",
					   Int.toString disp,
					   "\ntag = ",
					   MirTypes.print_tag tag])
                               val head_size = (offset - block_start) div 4
                               val tail = drop(1 + head_size, opcode_list)
			       val (delay_instr, tail) = case tail of
				 (x :: y) => (x, y)
			       | _ => Crash.impossible "branch instruction has no delay"
                               (* get the opcodes after this one *)
                               val new_comment = comment ^ " (expanded branch)"
                               (* Save lr in temporary during calculation of offset *)
                               (* This should be safe even if r1 or r2 are spills as their values *)
                               (* will have already been used *)
                               (* WARNING: If cross block spill optimizations are done, this may change *)
			       val new_code =
				 delay_instr ::
                                 move_regc (hacky_temporary_reg,lr,"Save current lr") ::
				 (Mips_Assembly.CALL
				  (Mips_Assembly.BGEZAL,
				   zero, 1,
                                   Debugger_Types.null_backend_annotation),
                                  NONE,
				  "call .") ::
                                 (Mips_Assembly.SETHI
                                  (Mips_Assembly.LUI, global, i-4),
                                  SOME tag, new_comment) ::
                                 (Mips_Assembly.SPECIAL_ARITHMETIC
                                  (Mips_Assembly.ADD_AND_MASK, global,
                                   Mips_Assembly.IMM i, global),
                                  tag_opt, new_comment) ::
                                 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                                  (Mips_Assembly.ADD, global, lr, global_op),
                                  absent, new_comment) ::
                                 move_regc (lr,hacky_temporary_reg,"Restore current lr") ::
				 (Mips_Assembly.JUMP
				  (Mips_Assembly.JR, global_op,
				   dummy,
				   Debugger_Types.null_backend_annotation),
				  NONE, "jump to original destination") ::
				 nop :: []
                               val new_code = case branch of
				 Mips_Assembly.BA => new_code
			       | _ =>
				 (Mips_Assembly.BRANCH
				  (Mips_Assembly.inverse_branch branch,
				   r1, r2, 9), NONE,
				  "short inverted branch to skip over long jump") ::
				 new_code
                             in
                               addBadOffset(offset,2,new_code)
                             end
                         end
                     | NONE =>
                         Crash.impossible ("Assoc do_opcode branch: " ^ MirTypes.print_tag tag))
		    | do_opcode((Mips_Assembly.FIXED_BRANCH(branch, r1, r2, i),
				 tag_opt as SOME tag, comment), offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = ( res - offset) div 4 - 1
			   in
			     if check_range(disp, true, branch_disp_limit) then
			       (* Branch ok in one instruction *)
			       (Mips_Assembly.BRANCH(branch, r1, r2, disp), comment)
			     else
			       Crash.impossible"range failure on fixed branch within computed goto"
			   end
		       | NONE =>
			   Crash.impossible ("Assoc do_opcode branch: " ^ MirTypes.print_tag tag))
		    | do_opcode((Mips_Assembly.FBRANCH(branch, i),
				 SOME tag, comment), offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp =
			       fault_range("fbranch", ((res - offset) div 4 - 1,
					   true, branch_disp_limit))
			   in
			     (Mips_Assembly.FBRANCH(branch, disp), comment)
			   end
		       | NONE =>
			   Crash.impossible ("Assoc do_opcode fbranch: " ^ MirTypes.print_tag tag))

		    | do_opcode((Mips_Assembly.CALL(call, r, i,debug_info),
				 tag_opt as SOME tag, comment), offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = ( res - offset) div 4 - 1
			   in
			     if check_range(disp, true, branch_disp_limit) then
			       (* Branch ok in one instruction *)
			       (Mips_Assembly.CALL(Mips_Assembly.BGEZAL, r, disp,debug_info),
                                comment)
			     else
			       (* Nasty case *)
                             let
                               val _ =
                                 diagnostic_output 3
                                 (fn _ => ["Found bad call, substituting\n",
					   "Offset = ",
					   Int.toString disp,
					   "\ntag = ",
					   MirTypes.print_tag tag])
                               val head_size = (offset - block_start) div 4
                               val tail = drop(1 + head_size, opcode_list)
			       val (delay_instr, tail) = case tail of
				 (x :: y) => (x, y)
			       | _ => Crash.impossible "call instruction has no delay"
                               (* get the opcodes after this one *)
                               val new_comment = comment ^ " (expanded call)"
			       val new_code =
				 delay_instr ::
				 (Mips_Assembly.CALL
				  (Mips_Assembly.BGEZAL,
				   zero, 1,
                                   Debugger_Types.null_backend_annotation),
                                  NONE,
				  "call .") ::
                                 (Mips_Assembly.SETHI
                                  (Mips_Assembly.LUI, global, i-4),
                                  tag_opt, new_comment) ::
                                 (Mips_Assembly.SPECIAL_ARITHMETIC
                                  (Mips_Assembly.ADD_AND_MASK, global,
                                   Mips_Assembly.IMM i, global),
                                  SOME tag, new_comment) ::
                                 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                                  (Mips_Assembly.ADD, global, lr,
                                   global_op),
                                  absent, new_comment) ::
                                 (* This overwrites lr so don't need to save *)
				 (Mips_Assembly.JUMP
				  (Mips_Assembly.JALR, lr_op, global,
				   Debugger_Types.null_backend_annotation),
				  NONE, "jump and link to original destination") ::
				 nop ::
				 []
			       val new_code = case (call, r) of
				 (Mips_Assembly.BGEZAL, MachTypes.R0) =>
				   new_code
				   (* Don't need the skip for always call *)
			       | _ =>
				 (Mips_Assembly.BRANCH
				  (invert_call_to_branch call,
				   r, zero, 7),
				  NONE,
				  "short inverted branch to skip over long jump") ::
				 new_code
                             in
                               addBadOffset(offset, 2, new_code)
                             end
			   end
		       | NONE => Crash.impossible "Assoc do_opcode call")
		    | do_opcode((Mips_Assembly.LOAD_OFFSET(Mips_Assembly.LEO, rd, i),
				 SOME tag, comment), offset) =
		      (* This will probably suffer the same problems as adr did *)
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = (res + i) - proc_offset
			   (* Must work relative to start of current proc in set *)
			   in
			     if check_range(disp, true, arith_imm_limit) then
			       (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                                (Mips_Assembly.ADD, rd, zero, Mips_Assembly.IMM disp),
                                comment)
			     else
			       let
				 val _ =
				   diagnostic_output 3
				   (fn _ => ["Found bad LEO, substituting\n"])
				 val head_size = (offset - block_start) div 4
				 val tail = drop(1 + head_size, opcode_list)
				 (* get the opcodes after this one *)
				 val new_comment = comment ^ " (expanded adr)"
				 val new_code =
				   (Mips_Assembly.SPECIAL_LOAD_OFFSET
				    (Mips_Assembly.LOAD_OFFSET_HIGH, rd,
				     zero, i),
				    SOME tag, new_comment) ::
				   (Mips_Assembly.SPECIAL_LOAD_OFFSET
				    (Mips_Assembly.LOAD_OFFSET_AND_MASK, rd, rd, i),
				    SOME tag, new_comment) :: []
			       in
				 addBadOffset (offset,1,new_code)
			       end
			   end
		       | NONE => Crash.impossible "Assoc do_opcode LEO")
		    | do_opcode((Mips_Assembly.ARITHMETIC_AND_LOGICAL
				 (Mips_Assembly.ADD, rd, rs1, Mips_Assembly.IMM i),
				 SOME tag, comment), offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = res + i - offset
			   in
			     if check_range(disp, true, arith_imm_limit) then
			       (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				(Mips_Assembly.ADD, rd, rs1, Mips_Assembly.IMM disp),
				comment)
			     else
			       let
				 val _ =
				   diagnostic_output 3
				   (fn _ => ["Found bad ADR, substituting\n"])
				 val head_size = (offset - block_start) div 4
				 val tail = drop(1 + head_size, opcode_list)
				 (* get the opcodes after this one *)
				 val _ =
				   if rs1 = rd then
				     Crash.impossible"ADR has dest in lr"
				   else ()
				 val new_comment = comment ^ " (expanded adr)"
				 val new_code =
				   (Mips_Assembly.SETHI
                                    (Mips_Assembly.LUI, rd, i),
				    SOME tag, new_comment) ::
				   (Mips_Assembly.SPECIAL_ARITHMETIC
				    (Mips_Assembly.ADD_AND_MASK, rd,
				     Mips_Assembly.IMM (i+4), rd),
				    SOME tag, new_comment) ::
				   (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				    (Mips_Assembly.ADD, rd, rs1,
				     Mips_Assembly.REG rd),
				    absent, new_comment) :: []
			       in
				 addBadOffset(offset,1,new_code)
			       end
			   end
		       | NONE =>
			   Crash.impossible"Assoc do_opcode arith")

		    | do_opcode((Mips_Assembly.SPECIAL_ARITHMETIC
				 (_, rd, Mips_Assembly.IMM i,
				  rs1),
				 SOME tag, comment), offset) =
                      (* This needs to do an OR of the low part *)
                      (* ADD won't work here *)
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp =
			       make_imm_fault
			       ((res + i - offset) mod sethi_losize,
				false, unsigned_arith_imm_limit)
			   in
			     (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			      (Mips_Assembly.ORI, rd, rs1, disp),
			      comment)
			   end
		       | NONE =>
			   Crash.impossible"Assoc do_opcode arith")

		    | do_opcode((Mips_Assembly.SPECIAL_LOAD_OFFSET(load, rd, rn, i),
				 SOME tag, comment), _) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = res + i - proc_offset
			   (* Must work relative to start of current proc in set *)
			   in
			     case load of
			       Mips_Assembly.LOAD_OFFSET_HIGH =>
				 (Mips_Assembly.SETHI
				  (Mips_Assembly.LUI, rd,
				   (disp div sethi_losize) mod sethi_hisize),
				  comment)
			     | Mips_Assembly.LOAD_OFFSET_AND_MASK =>
				 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.ORI, rd, rn,
				   make_imm_fault (disp mod sethi_losize, false, unsigned_arith_imm_limit)),
				  comment)
			   end
		       | NONE =>
			   Crash.impossible"Assoc do_opcode SPECIAL_LOAD_OFFSET")

		    | do_opcode((Mips_Assembly.SETHI(_, rd, i),
				 SOME tag, comment), offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = res + i - offset
			     val disp = (disp div sethi_losize) mod sethi_hisize
			   (* Ensure positive *)
			   in
			     (Mips_Assembly.SETHI(Mips_Assembly.LUI, rd, disp),
			      comment)
			   end
		       | NONE =>
			   Crash.impossible"Assoc do_opcode sethi")

		    | do_opcode((Mips_Assembly.OFFSET i, SOME tag, comment),
				offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp = res + i - offset
			   in
			     (Mips_Assembly.OFFSET disp, comment)
			   end
		       | NONE =>
			   Crash.impossible"Assoc do_opcode offset")

		    | do_opcode((opcode, NONE, comment), offset) =
		      (opcode, comment)
		    | do_opcode _ = Crash.impossible"Bad tagged instruction"

		  val (opcodes_and_offsets, next) =
		    Lists.number_from(opcode_list, block_start, 4, fn x => x)

		in
		  (rev_map do_opcode (opcodes_and_offsets, done), next)
		end
	      val (so_far, next) = do_block(start, block, done)
	    in
	      linearise_proc(proc_offset, next, block_list, so_far)
	    end

	  fun do_linearise_sub(_, []) = []
	    | do_linearise_sub(offset, ((tag, proc)) :: rest) =
	      let
		val (offset', done') = linearise_proc(offset, offset, proc, [])
		val offset'' =
		  offset' + 4 (* Back-pointer *) + 4 (* Procedure number within set *)
		val offset''' =
		  if offset'' mod 8 = 4
		    then offset'' + 4
		  else offset''
	      in
		(tag, done') :: do_linearise_sub(offset''', rest)
	      end

	in
	  do_linearise_sub(0, proc_list)
	end

(*
      fun subst_branches ([],offset,subst_list,acc) = raise Div
*)

      fun subst_branches (proclist,offset,subst_list) =
        let
(*
          val _ = print "Doing subst_branches..\n"
          val _ = map (fn (i,_,_) => print (Int.toString i ^ " ")) subst_list
          val _ = print "\n"
*)
          (* Now just iterate through the proclist, keeping track of the offset *)
          (* as used to insert entries in subst_list ie.  starting from zero, counting in *)
          (* bytes, and double-word aligning the start of procedures *)
          (* Note that subst_list is in offset order so we only need to look at the first *)
          (* item.  *)
          fun loop ([],offset,subst_list,acc)  = rev acc
            | loop ((tag,blocklist)::proclist,offset,subst_list,acc) =
            let
              fun subst_proc ([],offset,subst_list,acc) =
                (offset,subst_list,rev acc)
                | subst_proc ((tag,opcodelist)::rest,offset,subst_list,acc) =
                let
                  fun subst_block ([],offset,subst_list,acc) =
                    (offset,subst_list,rev acc)
                    | subst_block (opcodelist,offset,[],acc) =
                    (offset,[],revapp (acc,opcodelist))
                    | subst_block (opcode::rest,offset,
                                   subst_list as ((ix,count,newcode)::subst_list'),acc) =
                    if ix = offset
                      then ((* print ("Found a substitution " ^ Int.toString ix ^ " " ^ Int.toString count ^ " \n"); *)
                            subst_block (drop (count-1,rest),offset+(4 * count),
                                         subst_list',revapp (newcode,acc)))
                     else subst_block (rest,offset+4,subst_list,opcode::acc)
                  val (offset,subst_list,opcodelist) =
                    subst_block (opcodelist,offset,subst_list,[])
                in
                  subst_proc (rest,offset,subst_list,(tag,opcodelist)::acc)
                end

              val (offset,subst_list,blocklist) =
                subst_proc (blocklist,offset,subst_list,[])
              (* Calculate offset of next procedure *)
              (* see above for details *)
              val offset =
                let
                  val t = offset + 4 + 4 (* backptr and count *)
                in
                  if t mod 8 = 4 then t + 4 else t (* double word align *)
                end
            in
              loop (proclist,offset,subst_list,(tag,blocklist)::acc)
            end
        in
          loop (proclist,offset,subst_list,[])
        end

      fun do_linearise (proclist) =
        let
          val bad_branches = ref []
          val result = do_linearise' (proclist,bad_branches)
        in
          case !bad_branches of
            [] => result
          | subst_list =>
              ((* print "Restarting do_linearise\n"; *)
               do_linearise (subst_branches (proclist,0,rev subst_list)))
        end
    in
      do_linearise new_proc_list
    end

  fun is_reg(MirTypes.GP_GC_REG reg) = true
    | is_reg(MirTypes.GP_NON_GC_REG reg) = true
    | is_reg _ = false


  fun reg_from_gp(MirTypes.GP_GC_REG x)     = MirTypes.GC_REG x
    | reg_from_gp(MirTypes.GP_NON_GC_REG x) = MirTypes.NON_GC_REG x
    | reg_from_gp _ = Crash.impossible "reg_from_gp(IMM)"

  fun gp_from_reg(MirTypes.GC_REG reg) = MirTypes.GP_GC_REG reg
    | gp_from_reg(MirTypes.NON_GC_REG reg) = MirTypes.GP_NON_GC_REG reg

  (* check_reg: returns true for a callee_save register *)
  fun check_reg MachTypes.R0 = false
    | check_reg MachTypes.R1 = false
    | check_reg MachTypes.R2 = false
    | check_reg MachTypes.R3 = false
    | check_reg MachTypes.R4 = false
    | check_reg MachTypes.R5 = false
    | check_reg MachTypes.R6 = false
    | check_reg MachTypes.R7 = false
    | check_reg MachTypes.R8 = false
    | check_reg MachTypes.R9 = false
    | check_reg MachTypes.R10 = true
    | check_reg MachTypes.R11 = true
    | check_reg MachTypes.R12 = true
    | check_reg MachTypes.R13 = true
    | check_reg MachTypes.R14 = true
    | check_reg MachTypes.R15 = true
    | check_reg MachTypes.R16 = false
    | check_reg MachTypes.R17 = false
    | check_reg MachTypes.R18 = false
    | check_reg MachTypes.R19 = false
    | check_reg MachTypes.R20 = false
    | check_reg MachTypes.R21 = false
    | check_reg MachTypes.R22 = false
    | check_reg MachTypes.R23 = false
    | check_reg MachTypes.R24 = true
    | check_reg MachTypes.R25 = true
    | check_reg MachTypes.R26 = false
    | check_reg MachTypes.R27 = false
    | check_reg MachTypes.R28 = false
    | check_reg MachTypes.R29 = false
    | check_reg MachTypes.R30 = false
    | check_reg MachTypes.R31 = false
    | check_reg MachTypes.cond = Crash.impossible"check_reg: the condition codes"
    | check_reg MachTypes.heap = Crash.impossible"check_reg: the heap"
    | check_reg MachTypes.stack = Crash.impossible"check_reg: the stack"
    | check_reg MachTypes.mult_result = Crash.impossible"check_reg: mult_result"
    | check_reg MachTypes.nil_v = Crash.impossible"check_reg: the nil vector"
	
  fun compare_reg(r, s) = Mips_Opcodes.register_val r < Mips_Opcodes.register_val s

  datatype proc_stack =
    PROC_STACK of
    {non_gc_spill_size     : int, (* In words *)
     fp_spill_size         : int, (* In singles, doubles or extendeds *)
     fp_save_size          : int, (* As for fp_spill_size *)
     gc_spill_size         : int, (* In words *)
     gc_stack_alloc_size   : int, (* In words *)
     register_save_size    : int, (* In bytes *)
     non_gc_spill_offset   : int, (* In bytes *)
     fp_spill_offset       : int, (* In bytes *)
     fp_save_offset        : int, (* In bytes *)
     gc_spill_offset       : int, (* In bytes *)
     gc_stack_alloc_offset : int, (* In bytes *)
     register_save_offset  : int, (* In bytes *)
     allow_fp_spare_slot   : bool, (* slot needed for float/int conversion? *)
     float_value_size      : int  (* Number of bytes per float value *)
     }

  fun mach_cg
    error_info
    (Options.OPTIONS {compiler_options = Options.COMPILEROPTIONS {generate_debug_info, debug_variables, generate_moduler, opt_leaf_fns, intercept, mips_r4000, ...},
                      ...},
     MirTypes.CODE(MirTypes.REFS(loc_refs,
                                 {requires = ext_refs,
                                  vars = vars,
                                  exns = exns,
                                  strs = strs,
                                  funs = funs}),
                    value_list,
                    proc_list_list),
    (gc_map,
     non_gc_map,
     fp_map),
    debugging_map) =
    let
      val save_arg_for_debugging = generate_debug_info orelse debug_variables orelse intercept
      val {gc, non_gc, fp} = MirRegisters.pack_next
      val gc_array = MLWorks.Internal.Array.array(gc, global)
      val _ =
	MirTypes.GC.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(gc_array, MirTypes.GC.unpack mir_reg, reg))
	gc_map
      val non_gc_array = MLWorks.Internal.Array.array(non_gc, global)
      val _ =
	MirTypes.NonGC.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(non_gc_array, MirTypes.NonGC.unpack mir_reg, reg))
	non_gc_map
      val fp_array = MLWorks.Internal.Array.array(fp, global)
      val _ =
	MirTypes.FP.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(fp_array, MirTypes.FP.unpack mir_reg, reg))
	fp_map

      val debug_map = ref debugging_map

      val value_elements =
	(map
	(fn(MirTypes.VALUE(tag, x)) =>
	 value_cg(Lists.assoc(tag, loc_refs), x,error_info))
	value_list) handle Lists.Assoc => Crash.impossible"Assoc value_elements"
	
	(* do_blocks is called by proc_cg (q.v.) to generate all the
         * code for a procedure. First it defines instruction
         * sequences for things like saving and restoring the
         * GC-saves, FP-saves and so forth, then it defines the big
         * do_everything function, which actually does the code
         * generation, and enters its complex recursion appropriately.
         * See the comment for that function. *)

      fun do_blocks(_, [], _, _, _) = []
      | do_blocks(needs_preserve, MirTypes.BLOCK(tag,opcodes) :: rest,
		  PROC_STACK
		  {non_gc_spill_size,
		   fp_spill_size,
		   fp_save_size,
		   gc_spill_size,
		   gc_stack_alloc_size,
		   register_save_size,
		   non_gc_spill_offset,
		   fp_spill_offset,
		   fp_save_offset,
		   gc_spill_offset,
		   gc_stack_alloc_offset,
		   register_save_offset,
		   allow_fp_spare_slot,
		   float_value_size
		   },
		  fps_to_preserve,
		  gcs_to_preserve
	          ) =
	let
	  val frame_size = register_save_offset + register_save_size
	  val _ =
	    if frame_size mod 8 <> 0 then
	      Info.error error_info (Info.WARNING, Info.Location.UNKNOWN,
				     "Warning: frame_size not a multiple of eight\n")
	    else
	      ()
	  val non_save_frame_size = frame_size - 44

	  fun symbolic_value MirTypes.GC_SPILL_SIZE = gc_spill_size * 4
	    | symbolic_value MirTypes.NON_GC_SPILL_SIZE =
	      non_gc_spill_size * 4
	    | symbolic_value(MirTypes.GC_SPILL_SLOT i) =
	      let
		val symbolic_value =
		  fn i =>
		  (if i >= gc_spill_size then
		     Crash.impossible
		     ("Spill slot " ^ Int.toString i ^
		      " requested, but only " ^ Int.toString gc_spill_size ^
		      " allocated\n")
		   else
		     ();
		     ~(gc_spill_offset + 4 * (1 + i))
		     )
	      in
                case i of
                  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1 i),name) =>
                    ((*output(std_out,"\n name = "^name^"\n");*)
		     let
		       val value = symbolic_value i
		     in
		       spill := RuntimeEnv.OFFSET2(RuntimeEnv.GC, value);
		       value
		     end)
                | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) =>
                    ((*output(std_out,"\n name = "^name^"\n");*)
                     i)
                | MirTypes.SIMPLE i => symbolic_value i
	      end
	    | symbolic_value(MirTypes.NON_GC_SPILL_SLOT i) =
	      let
		fun symbolic_value i =
		  let
		    val offset = if allow_fp_spare_slot then 1 else 0
		  in
		    if i >= non_gc_spill_size then
		      Crash.impossible
		      ("non gc spill slot " ^ Int.toString i ^
		       " requested, but only " ^ Int.toString non_gc_spill_size ^
		       " allocated\n")
		    else
		      ();
		      ~(non_gc_spill_offset + 4 * (1 + offset + i))
		  end
	      in
                case i of
                  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1 i),name) =>
                    ((*output(std_out,"\n name = "^name^"\n");*)
		     let
		       val value = symbolic_value i
		     in
		       spill := RuntimeEnv.OFFSET2(RuntimeEnv.NONGC, value);
		       value
		     end)
                | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) =>
                    ((*output(std_out,"\n name = "^name^"\n");*)
                     i)
                | MirTypes.SIMPLE i => symbolic_value i
	      end
	    | symbolic_value(MirTypes.FP_SPILL_SLOT i) =
	      let
		val spare_size = if float_value_size >= 8 then 8 else 4
		fun symbolic_value i =
		  let
		    val offset = if allow_fp_spare_slot then 1 else 0
		  in
		    (if i>= fp_spill_size then
		       Crash.impossible
		       ("fp spill slot " ^ Int.toString i ^
			" requested, but only " ^ Int.toString fp_spill_size ^
			" allocated\n")
		     else
		       ();
		       ~(fp_spill_offset + float_value_size * (1 + i) +
			 offset * spare_size)
		       )
		  end
	      in
		case i of
		  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1 i),name) =>
		    let
		      val value = symbolic_value i
		    in
		      spill := RuntimeEnv.OFFSET2(RuntimeEnv.FP, value);
		      value
		    end
		  | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) => i
		  | MirTypes.SIMPLE i => symbolic_value i
	      end

	  fun gp_check_range(MirTypes.GP_IMM_INT i, signed, pos_limit) =
	    check_range(i, signed, pos_limit div 4)
	    | gp_check_range(MirTypes.GP_IMM_ANY i, signed, pos_limit) =
	      check_range(i, signed, pos_limit)
	    | gp_check_range(MirTypes.GP_IMM_SYMB symb, signed, pos_limit) =
	      check_range(symbolic_value symb, signed, pos_limit)
	    | gp_check_range _ =
	      Crash.impossible"gp_check_range of non-immediate"

	  fun is_imm32 mreg = not (is_reg mreg) andalso not (gp_check_range (mreg, true, arith_imm_limit))
	  fun is_imm16 mreg = not (is_reg mreg) andalso gp_check_range (mreg, true, arith_imm_limit)
	  fun is_imm mreg = not (is_reg mreg)

	  fun split_imm(MirTypes.GP_IMM_INT i) =
	    (i div (sethi_hisize div 4), 4*(i mod (sethi_losize div 4)))
	    | split_imm(MirTypes.GP_IMM_ANY i) =
	      (i div sethi_hisize, (i mod sethi_losize))
	    | split_imm(MirTypes.GP_IMM_SYMB symb) =
	      let
		val i = symbolic_value symb
	      in
		(i div sethi_hisize, (i mod sethi_losize))
	      end
	    | split_imm _ = Crash.impossible"split_imm of non-immediate"

          (* This should only be used for small immediates *)
          (* converts an mir immediate into an int *)
	  fun get_small_imm (MirTypes.GP_IMM_INT i) =
              fault_range (4*i, true, arith_imm_limit)
	    | get_small_imm (MirTypes.GP_IMM_ANY i) =
              fault_range (i, true, arith_imm_limit)
	    | get_small_imm (MirTypes.GP_IMM_SYMB symb) =
              fault_range (symbolic_value symb, true, arith_imm_limit)
	    | get_small_imm _ = Crash.impossible"get_small_imm of non-immediate"

	  fun load_imm_into_register (reg, imm) =
	    (* See if we can use an immediate value *)
            if gp_check_range (imm,true,arith_imm_limit)
              then
                case get_small_imm imm of
                  0 => [move_reg (reg, zero)]
                | i =>
                    [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
                      (Mips_Assembly.ADDIU, reg, zero, Mips_Assembly.IMM i),
                      absent, "")]
            else
              case (split_imm imm) of
                (0,0) => Crash.impossible "zero not in range"
              | (0, low) =>
                  (* Need to ORI in the immediate *)
                  (* Don't use ADDI here as it sign extends *)
                  [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
                      (Mips_Assembly.ORI, reg, zero,
                       Mips_Assembly.IMM low),
                      absent, "")]
              | (high, 0) =>
                  [(Mips_Assembly.SETHI
                    (Mips_Assembly.LUI, reg, high),
                    absent, MachTypes.reg_to_string reg ^ " := " ^ Int.toString high ^ ", load upper half")]
              | (high, low) =>
                  let
                    val comment = case imm of
                      MirTypes.GP_IMM_ANY x => "ANY(" ^ Int.toString x ^ ")"
                    | MirTypes.GP_IMM_INT x => "INT(" ^ Int.toString x ^ ")"
                    | MirTypes.GP_IMM_SYMB symb =>
                        "SYMB(" ^ Int.toString(symbolic_value symb) ^ ")"
                    | _ => Crash.impossible"load_imm_into_register bad value"
                  in
                    [(Mips_Assembly.SETHI
                      (Mips_Assembly.LUI, reg, high),
                      absent, MachTypes.reg_to_string reg ^ " := " ^ comment ^ ", loading large number"),
                     (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                      (Mips_Assembly.ORI, reg, reg,
                       Mips_Assembly.IMM low),
                      absent, "")]
                  end

          (* This should only be used for small immediates *)
          (* converts an mir immediate into a machine immediate *)
	  fun convert_small_imm (MirTypes.GP_IMM_INT i) =
              make_imm_fault (4*i, true, arith_imm_limit)
	    | convert_small_imm (MirTypes.GP_IMM_ANY i) =
              make_imm_fault (i, true, arith_imm_limit)
	    | convert_small_imm (MirTypes.GP_IMM_SYMB symb) =
              make_imm_fault (symbolic_value symb, true, arith_imm_limit)
	    | convert_small_imm _ = Crash.impossible"convert_small_imm of non-immediate"

	  fun load_large_number_into_register (reg, num) =
	    load_imm_into_register (reg, MirTypes.GP_IMM_ANY num)

	  (* make_imm_for_store: restrict make_imm_fault on IMM_INT and converts R0 to #0 *)
	  (* what is an IMM_INT *)
	  (* redo in the future *)
	  local
	    fun make_imm_for_store(MirTypes.GP_IMM_ANY i) = make_imm_fault(i, true, arith_imm_limit)
	      | make_imm_for_store(MirTypes.GP_IMM_SYMB symb) = make_imm_fault(symbolic_value symb, true, arith_imm_limit)
	      | make_imm_for_store _ = Crash.impossible"make_imm_for_store(bad value)"
	  in
	    val make_imm_for_store =
	      fn x => case make_imm_for_store x of
	      x as Mips_Assembly.IMM _ => x
	    | Mips_Assembly.REG MachTypes.R0 => Mips_Assembly.IMM 0
	    | _ => Crash.impossible"make_imm_for_store produces bad register value"
	  end (* local *)

          (* NB. For double floats, the ith word goes to reg+1, the i+1th word to reg. *)
          (* This may be different of different ended machines *)
	  fun do_save_fps(_, []) = []
	    | do_save_fps(offset, fp :: rest) =
	      case MachTypes.fp_used of
		MachTypes.single =>
		  (Mips_Assembly.LOAD_AND_STORE_FLOAT
		   (Mips_Assembly.SWC1, fp, MachTypes.fp,
		    Mips_Assembly.IMM offset), NONE,
		   "save float") :: do_save_fps(offset+4, rest)
	      | MachTypes.double =>
		  (Mips_Assembly.LOAD_AND_STORE_FLOAT
		   (Mips_Assembly.SWC1, fp,
		    MachTypes.fp,
		    Mips_Assembly.IMM (offset+4)), NONE,
		   "save float") ::
		  (Mips_Assembly.LOAD_AND_STORE_FLOAT
		   (Mips_Assembly.SWC1,
		    MachTypes.next_reg fp,
		    MachTypes.fp,
		    Mips_Assembly.IMM (offset)), NONE,
		   "save float") ::
		  do_save_fps(offset+8, rest)
	      | MachTypes.extended => Crash.impossible "do_save_fps: Extended floats not supported"
	  local
	    fun really_do_restore_fps(_, []) = []
	      | really_do_restore_fps(offset, fp :: rest) =
		case MachTypes.fp_used of
		  MachTypes.single =>
		    (Mips_Assembly.LOAD_AND_STORE_FLOAT
		     (Mips_Assembly.LWC1, fp, MachTypes.fp,
		      Mips_Assembly.IMM offset), NONE,
		     "restore float") ::
		    nop ::
		    really_do_restore_fps(offset+4, rest)
		| MachTypes.double =>
		    (Mips_Assembly.LOAD_AND_STORE_FLOAT
		     (Mips_Assembly.LWC1, fp,
		      MachTypes.fp,
		      Mips_Assembly.IMM (offset+4)), NONE,
		     "restore float") ::
		    (Mips_Assembly.LOAD_AND_STORE_FLOAT
		     (Mips_Assembly.LWC1,
		      MachTypes.next_reg fp,
		      MachTypes.fp,
		      Mips_Assembly.IMM (offset)), NONE,
		     "restore float") ::
		    really_do_restore_fps(offset+8, rest)
		| MachTypes.extended => Crash.impossible "really_do_restore_fps: Extended floats not supported"
	  in
	    fun do_restore_fps(_, []) = []
	      | do_restore_fps a = really_do_restore_fps a
	  end

	  fun do_save_gcs(offset, []) =
	    if save_arg_for_debugging then
	      [(Mips_Assembly.LOAD_AND_STORE
		(Mips_Assembly.SW, MachTypes.arg, MachTypes.fp, offset),
		NONE, "save argument for debugging")]
	    else []
	    | do_save_gcs(offset, gc :: rest) =
	      (Mips_Assembly.LOAD_AND_STORE
	       (Mips_Assembly.SW, gc, MachTypes.fp,
		offset), NONE,
	       "save gcs") :: do_save_gcs(offset+4, rest)
	
	  fun do_restore_gcs(_, []) = []
	    | do_restore_gcs(offset, gc :: rest) =
		  (Mips_Assembly.LOAD_AND_STORE
		   (Mips_Assembly.LW, gc, MachTypes.fp,
		    offset), NONE,
		   "restore gcs") :: do_restore_gcs(offset+4, rest)

	  val fp_save_start = gc_spill_offset
	  val save_fps = do_save_fps(~fp_save_start, fps_to_preserve)
	  val restore_fps = do_restore_fps(~fp_save_start, fps_to_preserve)
	  (* Note that these work up from this slot *)

	  val callee_save_size =
	    List.length gcs_to_preserve +
	    (if save_arg_for_debugging then 1 else 0)

	  val callee_save_offset = register_save_offset + callee_save_size * 4

	  val save_gcs = do_save_gcs(~callee_save_offset, gcs_to_preserve)

	  val restore_gcs = do_restore_gcs(~callee_save_offset, gcs_to_preserve)
	
	  fun is_comment(MirTypes.COMMENT _) = true
	    | is_comment _ = false

(*

fun do_everything, called by fun do_blocks to actually generate
machine instructions for each MIR opcode, recurses through opcodes in
order within each block, and through the blocks in order.

do_everything takes 6 arguments:

needs_preserve
	a boolean, true if we are in a function which creates a stack
	frame, i.e. a non-leaf,
tag
	the tag of the current block,
opcode_list
	the MIR opcodes left to translate in the current block
done
	a Sexpr of lists of the MIPS instructions produced so far in this block
block_list
	blocks remaining to be translated
final_result
	a list of blocks (i.e. pairs of tags and instruction lists)
	produced so far.

The recursion is such that the translation of an individual
instruction can:

(1) generate finished blocks to add to the final_result (e.g. a loop),
    or remove finished blocks from the final_result.

(2) construct MIR blocks to push back onto the block_list (e.g. if
    code generating some instructions needs to be postponed, if a set
    of instructions needs to be tagged differently, a new MIR block can be
    made of them and pushed on the block_list)

(3) modify the opcode_list (e.g. delete all remaining opcodes from this block)

(4) add instructions to the done sexpr.

*)
	  fun do_everything(_, tag, [], done, [], final_result) = (tag, Sexpr.toList done) :: final_result
	    | do_everything
	    (needs_preserve, tag, [], done,
	     MirTypes.BLOCK(tag',opcodes) :: blocks,
	     final_result) =
	    do_everything
	    (needs_preserve, tag',
	     List.filter (fn x=>not(is_comment x)) opcodes,
	     Sexpr.NIL,
	     blocks,
	     (tag, Sexpr.toList done) :: final_result)

	  | do_everything
	    (needs_preserve, tag, opcode :: opcode_list, done,
	     block_list, final_result) =
	    let
	      fun lookup_reg(reg, table) =
		let
		  val reg = MLWorks.Internal.Array.sub(table, reg)
		in
		  if needs_preserve then reg
		  else MachTypes.after_restore reg
		end

	      fun lookup_reg_operand(MirTypes.GC_REG reg) =
	        lookup_reg(MirTypes.GC.unpack reg, gc_array)
	      | lookup_reg_operand(MirTypes.NON_GC_REG reg) =
		lookup_reg(MirTypes.NonGC.unpack reg, non_gc_array)
		
	      fun lookup_gp_operand(MirTypes.GP_GC_REG reg) =
	        lookup_reg(MirTypes.GC.unpack reg, gc_array)
	      | lookup_gp_operand(MirTypes.GP_NON_GC_REG reg) =
		lookup_reg(MirTypes.NonGC.unpack reg, non_gc_array)
	      | lookup_gp_operand _ =
		Crash.impossible"lookup_gp_operand(constant)"

	      fun lookup_fp_operand(MirTypes.FP_REG reg) =
		MLWorks.Internal.Array.sub(fp_array, MirTypes.FP.unpack reg)

              fun is_tagged_mult_op MirTypes.MULS = true
                | is_tagged_mult_op MirTypes.DIVS = true
                | is_tagged_mult_op MirTypes.MODS = true
                | is_tagged_mult_op MirTypes.MUL32S = true
                | is_tagged_mult_op MirTypes.DIV32S = true
                | is_tagged_mult_op MirTypes.MOD32S = true
                | is_tagged_mult_op MirTypes.DIVU = true
                | is_tagged_mult_op MirTypes.MODU = true
                | is_tagged_mult_op MirTypes.DIV32U = true
                | is_tagged_mult_op MirTypes.MOD32U = true
                | is_tagged_mult_op _ = false

              fun is_mult_op MirTypes.MULU = true
                | is_mult_op MirTypes.MUL32U = true
                | is_mult_op _ = false

	      val (result_list, opcode_list, new_blocks, new_final_result) =

		(* the case statement from hell!
		 * each case returns the above 4-tuple so that we can
		 * achieve the recursion result described in the big
		 * comment above. *)

		case opcode of
		  (* TBINARY rewritten by nickb 1995-01-19 *)
		  MirTypes.TBINARY(tagged_op, taglist, reg, gp, gp') =>
                    let
                      val preserve_order =
                        case tagged_op of
                          MirTypes.SUBS => true
                        | MirTypes.DIVS => true
                        | MirTypes.MODS => true
                        | MirTypes.SUB32S => true
                        | MirTypes.DIV32S => true
                        | MirTypes.MOD32S => true
                        | MirTypes.DIVU => true
                        | MirTypes.MODU => true
                        | MirTypes.DIV32U => true
                        | MirTypes.MOD32U => true
                        | _ => false
			
                      val error_tag = case taglist of [] => NONE | (a::b) => SOME a

                      val is_reg_gp = is_reg gp
                      val is_reg_gp' = is_reg gp'

                      val xchg = (not is_reg_gp) andalso is_reg_gp' andalso (not preserve_order)
                      val redo = (not is_reg_gp) andalso is_reg_gp' andalso preserve_order

                      val (gp,gp') = if xchg then (gp',gp) else (gp,gp')
                      val is_reg_gp = is_reg gp
                      val is_reg_gp' = is_reg gp'
                    in
                      if redo then
                        ([],
                         MirTypes.UNARY(MirTypes.MOVE, global_reg, gp) ::
                         MirTypes.TBINARY(tagged_op, taglist, reg, global_gp, gp') ::
                         opcode_list, block_list, final_result)
                      else if is_tagged_mult_op tagged_op
                        then
                          (* First rewrite case when either argument is non-register *)
                          if not is_reg_gp
                            then
                              ([],
                               MirTypes.UNARY (MirTypes.MOVE,reg,gp) ::
                               MirTypes.TBINARY (tagged_op, taglist, reg,gp_from_reg reg, gp') ::
                               opcode_list, block_list, final_result)
                          else if not is_reg_gp'
                             then
                               ([],
                                MirTypes.UNARY(MirTypes.MOVE,global_reg, gp') ::
                                MirTypes.TBINARY(tagged_op, taglist,reg, gp, global_gp) ::
                                opcode_list,
                                block_list, final_result)
                          else
                            (* its a mult_op and both operands are registers *)
                            (* r3 can't be the global reg *)
                            let
                              val r1 = lookup_gp_operand gp
                              val r2 = lookup_gp_operand gp'
                              val r3 = lookup_reg_operand reg (* This is the result register *)
                              val check =
                                if r3 = global
                                  then Crash.impossible "TBINARY, mult_op: r3 is global"
                                else ()
                              val check =
                                if r1 = r2 andalso r2 = global
                                  then Crash.impossible "TBINARY(multiply): both r1 & r2 are global"
                                else ()
                              fun make_clean_blocks (error_tag,true) =
                                (error_tag,[])
                                | make_clean_blocks (error_tag,false) =
                                let
                                  val tag = MirTypes.new_tag ()
                                in
                                  (SOME tag,
                                   [(tag,
                                     make_clean_code [r1,r2,r3] @
                                     [(Mips_Assembly.BRANCH (Mips_Assembly.BA, zero, zero, 0),
                                       error_tag, ""),
                                      Mips_Assembly.nop])])
                                end

                              (* Test for exceptional conditions *)
                              (* These tests are done in between the multiplication and returning the result *)
                              fun mul_code (r1,r2,r3,tagged_calc) =
                                let
                                  val (overflow_tag,overflow_blocks) =
                                    make_clean_blocks (error_tag,tagged_calc)
                                in
                                  ([(Mips_Assembly.MULT_AND_DIV_RESULT (Mips_Assembly.MFHI, r3),
                                     absent,"get high word of result"),
                                    (Mips_Assembly.MULT_AND_DIV_RESULT (Mips_Assembly.MFLO, global),
                                     absent,"get low word of result"),
                                    (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.SRA,
                                                                           global,
                                                                           global,
                                                                           Mips_Assembly.IMM 31),
                                     absent,"and sign extend"),
                                    (Mips_Assembly.BRANCH (Mips_Assembly.BNE, global, r3, 0),
                                     overflow_tag, "and check if they are the same"),
                                    (Mips_Assembly.MULT_AND_DIV_RESULT (Mips_Assembly.MFLO, r3),
                                     absent,"get answer in delay")],
                                  overflow_blocks,opcode_list, block_list)
                                end
                              fun adjust_code (r2,temp,r3,getcode,tag_result,cont_tag,adjust_op) =
                                let
                                  val adjust = MirTypes.new_tag ()
                                  val noadjust = MirTypes.new_tag ()
                                  val noadjust1 = MirTypes.new_tag ()
                                  val tag_op =
                                    if not tag_result
                                      then move_reg (r3,temp)
                                    else
                                      (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.SLL,
                                                                             r3,
                                                                             temp,
                                                                             Mips_Assembly.IMM 2),
                                       absent, "Tag result in delay")
                                in
                                  ([(Mips_Assembly.MULT_AND_DIV_RESULT (Mips_Assembly.MFHI, temp),
                                     absent,""),
                                    (Mips_Assembly.BRANCH (Mips_Assembly.BEQ, temp, zero, 0),
                                     SOME noadjust1,""),
                                    (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.XOR,
                                                                           temp,
                                                                           r2,
                                                                           Mips_Assembly.REG temp),
                                     absent,"check remainder is same sign"),
                                    (Mips_Assembly.BRANCH (Mips_Assembly.BLTZ,temp,zero,0),
                                     SOME adjust, ""),
                                    (Mips_Assembly.MULT_AND_DIV_RESULT (getcode, temp),
                                     absent, "fetch actual result"),
                                    (Mips_Assembly.BRANCH (Mips_Assembly.BA,zero,zero,0),
                                     SOME noadjust,""),
                                    nop],
                                [(adjust,
                                  [(Mips_Assembly.BRANCH (Mips_Assembly.BA,zero,zero,0),
                                    SOME noadjust,""),
                                   (adjust_op,absent,"adjust result in delay")]),
                                 (noadjust1,
                                  [(Mips_Assembly.MULT_AND_DIV_RESULT (getcode, temp),
                                     absent, "fetch actual result"),
                                   (Mips_Assembly.BRANCH (Mips_Assembly.BA,zero,zero,0),
                                    SOME cont_tag,""),
                                   tag_op]),
                                 (noadjust,
                                  [(Mips_Assembly.BRANCH (Mips_Assembly.BA,zero,zero,0),
                                    SOME cont_tag,""),
                                   tag_op])])
                                end


                              fun div_code (r1,r2,r3,tagged_calc) =
                                let
                                  val (overflow_tag,div_tag) =
                                    case taglist of
                                      [a,b] => (a,b)
                                    | _ => Crash.impossible "Wrong tags for div"
                                  val (div_tag,div_blocks) =
                                    make_clean_blocks (SOME div_tag,tagged_calc)
                                  val (overflow_tag,overflow_blocks) =
                                    make_clean_blocks (SOME overflow_tag,tagged_calc)
                                  val cont_tag = MirTypes.new_tag ()
                                  val ok_tag = MirTypes.new_tag ()
                                  val temp = if r2 = global then r3 else global
                                  (* Note that temp could be the same as r1 *)
                                  val arg_test =
                                    [(Mips_Assembly.BRANCH (Mips_Assembly.BEQ,
                                                            r2,
                                                            zero,
                                                            0),
                                      div_tag, "branch on division by zero"),
                                     nop,
                                     (* Now see if we are dividing MININT by ~1 *)
                                     (* if r1 is non-negative then we are OK *)
                                     (Mips_Assembly.BRANCH (Mips_Assembly.BGEZ,
                                                            r1,
                                                            zero,
                                                            0),
                                      SOME ok_tag, ""),
                                     nop,
                                     (* else subtract one *)
                                     (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.SUBU,
                                                                            r1,
                                                                            r1,
                                                                            Mips_Assembly.IMM 1),
                                      absent,""),
                                     (* its positive iff it was originally MININIT *)
                                     (Mips_Assembly.BRANCH (Mips_Assembly.BLTZ,
                                                            r1,
                                                            zero,
                                                            0),
                                      SOME ok_tag, ""),
                                     (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.ADDU,
                                                                            r1,
                                                                            r1,
                                                                            Mips_Assembly.IMM 1),
                                      absent,"Restore reg in delay"),
                                     (* Now check for (tagged) ~1 *)
                                     (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.SUB,
                                                                            temp,
                                                                            zero,
                                                                            if tagged_calc
                                                                              then Mips_Assembly.IMM 4
                                                                            else Mips_Assembly.IMM 1),
                                      absent,""),
                                     (Mips_Assembly.BRANCH (Mips_Assembly.BEQ,
                                                            r2,
                                                            temp,
                                                            0),
                                      overflow_tag, ""),
                                     nop,
                                     (Mips_Assembly.BRANCH (Mips_Assembly.BA,
                                                            zero,
                                                            zero,
                                                            0),
                                      SOME ok_tag, ""),
                                     nop]

                                  val (rest,blocks) =
                                    adjust_code (r2,temp,r3,Mips_Assembly.MFLO,tagged_calc,cont_tag,
                                                 Mips_Assembly.ARITHMETIC_AND_LOGICAL
                                                 (Mips_Assembly.SUB,
                                                  temp,
                                                  temp,
                                                  Mips_Assembly.IMM 1))
                                in
                                  (arg_test,
                                   (ok_tag,rest) :: div_blocks @ overflow_blocks @ blocks,
                                   [],
                                   MirTypes.BLOCK (cont_tag,opcode_list) ::  block_list)
                                end
                              fun mod_code (r1,r2,r3,tagged_calc) =
                                let
                                  val (div_tag,div_blocks) =
                                    make_clean_blocks (error_tag,tagged_calc)
                                  val arg_test = [(Mips_Assembly.BRANCH (Mips_Assembly.BEQ, r2, zero, 0),
                                                   div_tag, "branch on division by zero")]
                                  val cont_tag = MirTypes.new_tag ()
                                  val temp = if r2 = global then r3 else global
                                  val (rest,blocks) =
                                    adjust_code (r2,temp,r3,Mips_Assembly.MFHI,false,cont_tag,
                                                 Mips_Assembly.ARITHMETIC_AND_LOGICAL
                                                 (Mips_Assembly.ADD,
                                                  temp,
                                                  temp,
                                                  Mips_Assembly.REG r2))
                                in
                                  (arg_test @ rest,
                                   div_blocks @ blocks,
                                   [],
                                   MirTypes.BLOCK (cont_tag,opcode_list) :: block_list)
                                end
                              fun modu_code (r1,r2,r3,tagged_calc) =
                                let
                                  val (div_tag,div_blocks) =
                                    make_clean_blocks (error_tag,tagged_calc)
                                  val code = [(Mips_Assembly.BRANCH (Mips_Assembly.BEQ, r2, zero, 0),
                                               div_tag, "branch on division by zero"),
                                              nop,
                                              (Mips_Assembly.MULT_AND_DIV_RESULT (Mips_Assembly.MFHI, r3),
                                               absent,"")]
                                in
                                  (code,
                                   div_blocks,
                                   opcode_list,
                                   block_list)
                                end
                              fun divu_code (r1,r2,r3,tagged_calc) =
                                let
                                  val (div_tag,div_blocks) =
                                    make_clean_blocks (error_tag,tagged_calc)
                                  val code = [(Mips_Assembly.BRANCH (Mips_Assembly.BEQ, r2, zero, 0),
                                               div_tag, "branch on division by zero"),
                                              nop,
                                              (Mips_Assembly.MULT_AND_DIV_RESULT (Mips_Assembly.MFLO, r3),
                                               absent,"")]
                                  val tag_result =
                                    if tagged_calc then
                                      [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
                                        (Mips_Assembly.SLL,
                                         r3,
                                         r3,
                                         Mips_Assembly.IMM 2),
                                        absent, "Tag result")]
                                    else []
                                in
                                  (code @ tag_result,
                                   div_blocks,
                                   opcode_list,
                                   block_list)
                                end
                              val (opcode, (result_code,extra,opcode_list,block_list), untag) =
                                case tagged_op of
                                  (* pass global as second parameter because of untagging *)
                                  MirTypes.MULS => (Mips_Assembly.MULT, mul_code (r1,global,r3,true), true)
                                | MirTypes.DIVS => (Mips_Assembly.DIV, div_code (r1,r2,r3,true), false)
                                | MirTypes.MODS => (Mips_Assembly.DIV, mod_code (r1,r2,r3,true), false)
                                | MirTypes.DIVU => (Mips_Assembly.DIVU, divu_code (r1,r2,r3,true),false)
                                | MirTypes.MODU => (Mips_Assembly.DIVU, modu_code (r1,r2,r3,true),false)
                                | MirTypes.MUL32S => (Mips_Assembly.MULT, mul_code (r1,r2,r3,false), false)
                                | MirTypes.DIV32S => (Mips_Assembly.DIV, div_code (r1,r2,r3,false), false)
                                | MirTypes.MOD32S => (Mips_Assembly.DIV, mod_code (r1,r2,r3,false), false)
                                | MirTypes.DIV32U => (Mips_Assembly.DIVU, divu_code (r1,r2,r3,false),false)
                                | MirTypes.MOD32U => (Mips_Assembly.DIVU, modu_code (r1,r2,r3,false),false)
                                | _ => Crash.impossible ("mult_op opcode")
                            in
                              (* Untag r2 into global -- r1 can't be the global register *)
                              ((if untag then
                                  if r1 = global
                                    then Crash.impossible "TBINARY (MULS) untagging into r1"
                                  else
                                    [(Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.SRA,
                                                                            MachTypes.global, r2, Mips_Assembly.IMM 2),
                                      absent, "Untag arg")]
                                else []) @
                               [(Mips_Assembly.MULT_AND_DIV (opcode,r1,if untag then MachTypes.global else r2),
                                 absent, "")] @
                               result_code,
                               opcode_list, block_list, extra @ final_result)
                            end (* of mult_op case *)
                      else if is_reg_gp then
                         if is_reg_gp' orelse
			  gp_check_range(gp', true, arith_imm_limit) then
			  let
			    val reg_or_imm =
			      if is_reg_gp' then
				Mips_Assembly.REG(lookup_gp_operand gp')
			      else convert_small_imm gp'
			      val use_traps = case tagged_op of
				MirTypes.ADDS => true
			      | MirTypes.SUBS => true
                              | _ => false
			      val rs1 = lookup_gp_operand gp
                              val rd = lookup_reg_operand reg
			  in
			    if use_traps then
			      let
				val opcode = case tagged_op of
				  MirTypes.ADDS => Mips_Assembly.ADD
				| MirTypes.SUBS => Mips_Assembly.SUB
				| _ => Crash.impossible"do_opcodes(TBINARY)"
			      in
				([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				   (opcode, rd, rs1, reg_or_imm), absent, "")],
				 opcode_list, block_list, final_result)
			      end
			    else
			      let
				val opcode = case tagged_op of
				  MirTypes.ADD32S => Mips_Assembly.ADDU
				| MirTypes.SUB32S => Mips_Assembly.SUBU
				| _ => Crash.impossible"do_opcodes(TBINARY)"
				val _ =
				  if rd = MachTypes.global then
				    Crash.impossible"TBINARY global destination"
				  else
				    ()
				val regs_to_clean = [rd, rs1]
				val regs_to_clean = case reg_or_imm of
				  Mips_Assembly.REG reg => reg :: regs_to_clean
				| _ => regs_to_clean
                                val clean_code =
                                  make_clean_code regs_to_clean @
                                  [(Mips_Assembly.BRANCH
				    (Mips_Assembly.BA, zero, zero, 0),
				    error_tag, ""),
				   Mips_Assembly.nop]
				val exn_tag = MirTypes.new_tag()
				val exn_tag_opt = SOME exn_tag
			      in
				(* Tricky stuff here *)
				(* We must do manual overflow detection *)
				(* for x + y this is (x + y < x) <> (y < 0) *)
				(* for x - y this is (x - y > x) <> (y < 0) *)
				(* The general case can be improved *)
				(* if y is a constant as y < 0 is then also constant *)
				(* First deal with some silly cases *)
				case reg_or_imm of
				  Mips_Assembly.REG rs2 =>
				    (if rs1 = rs2 then
				       (* this is either double (ADDW) or *)
				       (* produce zero (SUBW) *)
				       case opcode of
					 Mips_Assembly.ADDU =>
					   (* What if rd = rs1? *)
					   let
					     val (extra, rs1) =
					       if rs1 = rd then
						 ([move_reg(MachTypes.global, rs1)], global)
					       else
						 ([], rs1)
					   in
					     ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
						(opcode, rd, rs1, reg_or_imm), absent, ""),
					       (Mips_Assembly.ARITHMETIC_AND_LOGICAL
						(Mips_Assembly.XOR, MachTypes.global,
						 rd, Mips_Assembly.REG MachTypes.global),
						absent, "Check for sign change across add"),
					       (Mips_Assembly.BRANCH
						(Mips_Assembly.BLTZ, MachTypes.global,
						 zero, 0), exn_tag_opt,
						"Branch on overflow"),
					       Mips_Assembly.nop],
					      opcode_list, block_list, final_result)
					   end
				       | Mips_Assembly.SUBU =>
					   ([move_regc(rd, zero, "sub rd, x, x!")],
					    opcode_list, block_list, final_result)
				       | _ => Crash.impossible"TBINARY failure"
				     else
				       (* All register args, sources distinct *)
				       (* Must now check if rs1 = rd *)
				       (* As this will mess up the first test *)
				       if rd = rs1 then
					 if opcode = Mips_Assembly.ADDU then
					   (* Just swap the operands in this case *)
					   (* as we already know rs2 <> rs1 *)
					   ([],
					    MirTypes.TBINARY(tagged_op, taglist, reg, gp', gp) :: opcode_list,
					    block_list, final_result)
					 else
					   (* Subtract case, can't swap operands *)
					   (* So put rs1 into global then repeat *)
					   if rs2 = MachTypes.global then
					     Crash.unimplemented"TBINARY SUB rd, rd, global"
					   else
					     ([],
					      MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global, gp) ::
					      MirTypes.TBINARY(tagged_op, taglist, reg, MirTypes.GP_GC_REG MirRegisters.global, gp') ::
					      opcode_list, block_list, final_result)
				       else
					 (* rs1 <> rd *)
					 let
                                           (* If rs2 = rd then we need to save its value in global *)
                                           (* If so, we should check that rs1 <> global and rd <> global *)
                                           (* And rs1 = global only if rs1 was originally rd, but rs2 and rs1 can't *) 
                                           (* be equal, so we should be OK *)
                                           (* Check anyway to make sure *)
                                           val (get_rs2,rs2_reg) =
                                             if rs2 = rd then
                                               (if rd = global 
                                                  then Crash.impossible ("rd = global in int 32 op")
                                                else if rs1 = global 
                                                  then Crash.impossible ("rs1 = global in int 32 op")
                                                else ();
                                                ([move_regc(global, rs2, "Save rs2 in global")],
                                                 global))
                                             else ([], rs2)
					   val swap_for_slt =
					     case opcode of
					       Mips_Assembly.ADDU => false
					     | Mips_Assembly.SUBU => true
					     | _ => Crash.impossible"TBINARY failure"
					   (* true if we test result < source *)
					   (* false if we test source < result *)

					   val slt =
					     if swap_for_slt then
					       Mips_Assembly.ARITHMETIC_AND_LOGICAL
					       (Mips_Assembly.SLT,
						MachTypes.global, rs1,
						Mips_Assembly.REG rd)
					     else
					       Mips_Assembly.ARITHMETIC_AND_LOGICAL
					       (Mips_Assembly.SLT,
						MachTypes.global, rd,
						Mips_Assembly.REG rs1)
					   val second_test_tag = MirTypes.new_tag()
					   val second_test_tag_opt =
					     SOME second_test_tag
					   val cont_tag = MirTypes.new_tag()
					   val cont_tag_opt =
					     SOME cont_tag
					 in
					   (get_rs2 @
                                            [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					      (opcode, rd, rs1, reg_or_imm), absent, ""),
					     (Mips_Assembly.BRANCH
					      (Mips_Assembly.BLTZ, rs2_reg, zero, 0),
					      second_test_tag_opt,
					      "Branch on y < 0"),
					     (* y >= 0 case *)
					     (* Test rd < rs1 for ADD *)
					     (* Or rs1 < rd for SUB *)
					     (slt, absent, "binary operation overflow check"),
					     (Mips_Assembly.BRANCH
					      (Mips_Assembly.BGTZ, global, zero, 0),
					      exn_tag_opt,
					      "Branch on < for ADD and > for SUB"),
					     Mips_Assembly.nop,
					     (Mips_Assembly.BRANCH
					      (Mips_Assembly.BA, zero, zero, 0),
					      cont_tag_opt, "Continue normal flow"),
					     Mips_Assembly.nop],
					   [],
					   MirTypes.BLOCK(cont_tag, opcode_list) ::
					   block_list,
					   (second_test_tag,
					    (* Use the same test result, but *)
					    (* Take the opposite branch *)
					     [(Mips_Assembly.BRANCH
					       (Mips_Assembly.BEQZ, global, zero, 0),
					       exn_tag_opt,
					       "Branch on >= for ADD and <= for SUB"),
                                              Mips_Assembly.nop,
					      (Mips_Assembly.BRANCH
					       (Mips_Assembly.BA, zero, zero, 0),
					       cont_tag_opt, "Continue normal flow"),
					      Mips_Assembly.nop]) ::
					    (exn_tag, clean_code) :: final_result)
					 end)
				| Mips_Assembly.IMM imm =>
				    (* y is immediate here *)
				    let
				      val test =
					if imm < 0 then
					  Mips_Assembly.BEQZ
					else
					  Mips_Assembly.BGTZ
				      val swap_for_slt =
					case opcode of
					  Mips_Assembly.ADDU => false
					| Mips_Assembly.SUBU => true
					| _ => Crash.impossible"TBINARY failure"
				      (* true if we test result < source *)
				      (* false if we test source < result *)

				      (* Now check rd <> rs1, else we must use *)
				      (* global to hold one of them *)
				      val (extra, rs1) =
					if rs1 = rd then
					  ([move_reg(MachTypes.global, rs1)], global)
					else
					  ([], rs1)
				      val slt =
					if swap_for_slt then
					  Mips_Assembly.ARITHMETIC_AND_LOGICAL
					  (Mips_Assembly.SLT,
					   MachTypes.global, rs1,
					   Mips_Assembly.REG rd)
					else
					  Mips_Assembly.ARITHMETIC_AND_LOGICAL
					  (Mips_Assembly.SLT,
					   MachTypes.global, rd,
					   Mips_Assembly.REG rs1)
				    in
				      (extra @
				       [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					 (opcode, rd, rs1, reg_or_imm), absent, ""),
					(slt, absent, "binary operation overflow check"),
					(Mips_Assembly.BRANCH
					 (test, global, zero, 0),
					 exn_tag_opt,
					 "Branch to clean before raising exception"),
					Mips_Assembly.nop],
				       opcode_list, block_list,
				       (exn_tag, clean_code) :: final_result)
				    end
			      end
			  end
			else
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  global_reg, gp') ::
			   MirTypes.TBINARY(tagged_op, taglist,
					    reg, gp, global_gp) ::
			   opcode_list, block_list, final_result)
		      else
			([],
			  MirTypes.UNARY(MirTypes.MOVE, reg, gp) ::
			  MirTypes.TBINARY(tagged_op, taglist, reg,
					   gp_from_reg reg, gp') ::
			  opcode_list, block_list, final_result)
		  end
		| MirTypes.BINARY(binary_op, reg_operand, gp_operand,
				  gp_operand') =>
		  if is_mult_op binary_op then
		    if not (is_reg gp_operand) then
		       ([],
			MirTypes.UNARY (MirTypes.MOVE, reg_operand, gp_operand) ::
			MirTypes.BINARY (binary_op, reg_operand,
					 gp_from_reg reg_operand, gp_operand') ::
			opcode_list, block_list, final_result)
		     else
		     if not (is_reg gp_operand') then
		       ([],
			MirTypes.UNARY(MirTypes.MOVE,
				       global_reg, gp_operand') ::
			MirTypes.BINARY(binary_op, reg_operand, gp_operand, global_gp) ::
			opcode_list,
			block_list, final_result)
		     else (* its a mult_op and both operands are registers *)
		       let
			 val r1 = lookup_gp_operand gp_operand
			 val r2 = lookup_gp_operand gp_operand'
			 val r3 = lookup_reg_operand reg_operand
			 val (opcode,result_opcode,untag) =
			   case binary_op of
			     MirTypes.MULU =>
			       (Mips_Assembly.MULTU,Mips_Assembly.MFLO,true)
			   | MirTypes.MUL32U =>
			       (Mips_Assembly.MULTU,Mips_Assembly.MFLO,false)
			   | _ => Crash.impossible ("mult_op opcode")
		       in
			 ((if untag then
			     [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			       (Mips_Assembly.SRA, MachTypes.global, r2,
				Mips_Assembly.IMM 2),
			       absent, "Untag arg")]
			   else []) @
			     [(Mips_Assembly.MULT_AND_DIV
			       (opcode, r1,
				if untag then MachTypes.global else r2),
			       absent, "")] @
			     [(Mips_Assembly.MULT_AND_DIV_RESULT (result_opcode,r3),
			       absent, "")],
			     opcode_list, block_list, final_result)
		       end (* of mult_op case *)
                  else
                    let
		      (* Shifts are difficult, we'll do them separately *)
		      fun is_shift MirTypes.ADDU = false
			| is_shift MirTypes.SUBU = false
			| is_shift MirTypes.MULU = false
			| is_shift MirTypes.MUL32U = false
			| is_shift MirTypes.AND = false
			| is_shift MirTypes.OR = false
			| is_shift MirTypes.EOR = false
			| is_shift MirTypes.LSR = true
			| is_shift MirTypes.ASL = true
			| is_shift MirTypes.ASR = true

		      val rd = lookup_reg_operand reg_operand
		      val opcode =
			case binary_op of
			  MirTypes.ADDU => Mips_Assembly.ADDU
			| MirTypes.SUBU => Mips_Assembly.SUBU
			| MirTypes.AND => Mips_Assembly.AND
			| MirTypes.OR => Mips_Assembly.OR
			| MirTypes.EOR => Mips_Assembly.XOR
			| MirTypes.LSR => Mips_Assembly.SRL
			| MirTypes.ASL => Mips_Assembly.SLL
			| MirTypes.ASR => Mips_Assembly.SRA
			| MirTypes.MULU => Crash.impossible"MirTypes.MULU"
			| MirTypes.MUL32U => Crash.impossible"MirTypes.MULS"

		      fun needs_reverse Mips_Assembly.SUB	= true
			| needs_reverse Mips_Assembly.SUBU	= true
			| needs_reverse Mips_Assembly.SRL	= true
			| needs_reverse Mips_Assembly.SLL	= true
			| needs_reverse Mips_Assembly.SRA	= true
			| needs_reverse _ 			= false

		      val (gp_operand, gp_operand', redo) =
			if is_reg gp_operand then
			  (gp_operand, gp_operand', false)
			else
			  if is_reg gp_operand' then
			    if needs_reverse opcode then
			      (gp_operand, gp_operand', true)
			    else
			      (gp_operand', gp_operand, false)
			  else (* Both immediate so no problem *)
			    (gp_operand, gp_operand', false)
		      val is_a_shift = is_shift binary_op
		    in
		      if redo andalso not is_a_shift then
			let
			  val inter_reg =
			    case gp_operand' of
			      MirTypes.GP_GC_REG r =>
				(if r = global_mir then
				   (* The nasty case *)
				   (case reg_operand of
				      MirTypes.GC_REG r' =>
					if r = r' then
					  Crash.impossible "source and dest global with large int"
					else
					  r'
				    | MirTypes.NON_GC_REG _ =>
					  Crash.impossible"BINARY doesn't deliver GC")
				 else
				   global_mir)
			    | _ => Crash.impossible "BINARY has non-gc register"
			in
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG inter_reg,
					  gp_operand) ::
			   MirTypes.BINARY(binary_op, reg_operand,
					   MirTypes.GP_GC_REG inter_reg,
					   gp_operand') ::
			   opcode_list, block_list, final_result)
			end
		      else
			if is_a_shift then
			  (* Deal with possible out of range shifts *)
			  let
			    val const_shift = case gp_operand' of
			      MirTypes.GP_GC_REG _ => false
			    | MirTypes.GP_NON_GC_REG _ => false
			    | _ => true
			  in
			    if const_shift then
			      let
				val shift_size = convert_small_imm gp_operand'
				fun get_shift(Mips_Assembly.IMM i) = i
				  | get_shift(Mips_Assembly.REG (MachTypes.R0)) = 0
				  | get_shift _ =
				  Crash.impossible"mach_cg:non_constant in shift by constant"
				val shift_val = get_shift shift_size
			      in
				case binary_op of
				  MirTypes.LSR =>
				    (* Deal with possible immediate value here *)
				    if is_reg gp_operand then
				      let
					val rs1 = lookup_gp_operand gp_operand
				      in
					([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					   (opcode, rd, rs1, shift_size),
					   absent, "")],
					 opcode_list, block_list, final_result)
				      end
				    else
				      (* A rare case, just replace by move *)
				      (* and shift the result *)
				      ([],
				       MirTypes.UNARY(MirTypes.MOVE,
						      global_reg,
						      gp_operand) ::
				       MirTypes.BINARY(binary_op,
						       reg_operand,
						       global_gp,
						       gp_operand') ::
				       opcode_list,
				       block_list, final_result)
				| MirTypes.ASR =>
				  if is_reg gp_operand then
				    let
				      val rs1 = lookup_gp_operand gp_operand
				    in
				      ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					 (opcode, rd, rs1, shift_size),
					 absent, "")],
				       opcode_list, block_list, final_result)
				    end
				  else
				    (* A rare case, just replace by move *)
				    (* and shift the result *)
				    ([],
				     MirTypes.UNARY(MirTypes.MOVE,
						    global_reg,
						    gp_operand) ::
				     MirTypes.BINARY(binary_op,
						     reg_operand,
						     global_gp,
						     gp_operand') ::
				     opcode_list,
				     block_list, final_result)
				| MirTypes.ASL =>
				    (* Deal with possible immediate value here *)
				    if is_reg gp_operand then
				      let
					val rs1 = lookup_gp_operand gp_operand
				      in
					([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					   (opcode, rd, rs1, shift_size),
					   absent, "")],
					 opcode_list, block_list, final_result)
				      end
				    else
				      (* A rare case, just replace by move *)
				      (* and shift the result *)
				      ([],
				       MirTypes.UNARY(MirTypes.MOVE,
						      global_reg,
						      gp_operand) ::
				       MirTypes.BINARY(binary_op,
						       reg_operand,
						       global_gp,
						       gp_operand') ::
				       opcode_list,
				       block_list, final_result)
				| _ => Crash.impossible"mach_cg: non-shift in shift case"
			      end
			    else
			      (* Need a range test to sort out shifts by large amounts *)
			      (* This includes the case of a constant shifted by a variable amount *)
			      let
				val rs1 = lookup_gp_operand gp_operand'
				val cont_tag = MirTypes.new_tag()
				fun make_range_test limit =
				  let
				    val bad_tag = MirTypes.new_tag()
				  in
				    (bad_tag,
				     [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				       (Mips_Assembly.SLTIU,
					MachTypes.global, rs1,
					Mips_Assembly.IMM limit),
				       absent, "shift range test"),
				      (Mips_Assembly.BRANCH
				       (Mips_Assembly.BEQ, MachTypes.global,
					zero, 0),
				       SOME bad_tag, ""),
				      nop])
				  end

				val continue =
				  [(Mips_Assembly.BRANCH
				    (Mips_Assembly.BA, zero, zero, 0),
				    SOME cont_tag, ""),
				   nop]

				fun constant_out_of_range_shift gp_op =
				  case binary_op of
				    MirTypes.ASL => [move_imm(rd, 0)]
				  | MirTypes.ASR =>
				      if gp_check_range(gp_op, false, arith_imm_limit) then
					[move_imm(rd, 0)]
				      else
					(case gp_operand of
					   MirTypes.GP_IMM_INT i =>
					     [move_imm(rd, if i < 0 then ~4 else 0)]
					 | MirTypes.GP_IMM_ANY i =>
					     [move_imm(rd, 0)]
					 | _ => Crash.impossible"Mach_cg:shift:bad constant")
				  | MirTypes.LSR => [move_imm(rd, 0)]
				  | _ => Crash.impossible"mach_cg: non-shift in shift case"
				val shift_limit = case binary_op of
				  MirTypes.ASL => 32
				| MirTypes.ASR => 31
				| MirTypes.LSR => 32
				| _ => Crash.impossible"mach_cg: non-shift in shift case"

				fun variable_out_of_range_shift gp_op =
				  case binary_op of
				    MirTypes.ASL => [move_imm(rd, 0)]
				  | MirTypes.ASR =>
				      (* Shift by 31 and tag if necessary *)
				      [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					(opcode, rd, lookup_gp_operand gp_op,
					 Mips_Assembly.IMM 31),
					absent, "")]
				  | MirTypes.LSR => [move_imm(rd, 0)]
				  | _ => Crash.impossible"mach_cg: non-shift in shift case"

				val (bad_tag, range_test) =
				  make_range_test shift_limit
				val shift_op =
				  if is_reg gp_operand then
				    [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				      (opcode, rd,
				       lookup_gp_operand gp_operand,
				       Mips_Assembly.REG rs1),
				      absent, "")]
				  else
				    load_imm_into_register(rd, gp_operand) @
				    [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				      (opcode, rd, rd, Mips_Assembly.REG rs1),
				      absent, "")]
			      in
				(range_test @ shift_op @ continue, [],
				 MirTypes.BLOCK(cont_tag, opcode_list) ::
				 block_list,
				 (bad_tag,
				  (if is_reg gp_operand then
				     variable_out_of_range_shift gp_operand
				   else
				     constant_out_of_range_shift gp_operand) @
				     continue) :: final_result)
			      end
			  end
			else
			  (* Not a shift *)
			  let
			    fun cant_extend_negative_imm x =
			      case x of
				Mips_Assembly.ADD => false
			      | Mips_Assembly.ADDI => false
			      | Mips_Assembly.ADDIU => false
			      | Mips_Assembly.ADDU => false
			      | Mips_Assembly.SUB => false
			      | Mips_Assembly.SUBU => false
			      | Mips_Assembly.AND => true
			      | Mips_Assembly.ANDI => true
			      | Mips_Assembly.OR => true
			      | Mips_Assembly.ORI => true
			      | Mips_Assembly.XOR => true
			      | Mips_Assembly.XORI => true
			      | Mips_Assembly.NOR => true
			      | Mips_Assembly.SLT => false
			      | Mips_Assembly.SLTU => false
			      | Mips_Assembly.SLTI => false
			      | Mips_Assembly.SLTIU => false
			      | Mips_Assembly.SLL => false
			      | Mips_Assembly.SRL => false
			      | Mips_Assembly.SRA => false
			      | Mips_Assembly.SLLV => false
			      | Mips_Assembly.SRLV => false
			      | Mips_Assembly.SRAV => false
			    fun negative_imm(Mips_Assembly.IMM i) = i < 0
			      | negative_imm _ = false
			  in
			    if is_reg gp_operand then
			      let
				val rs1 = lookup_gp_operand gp_operand
			      in
				if is_reg gp_operand' orelse
				  gp_check_range(gp_operand', true,
						 arith_imm_limit) then
				  let
				    val reg_or_imm =
				      if is_reg gp_operand' then
					Mips_Assembly.REG(lookup_gp_operand
							  gp_operand')
				      else
					convert_small_imm gp_operand'
				  in
				    if negative_imm reg_or_imm andalso
				      cant_extend_negative_imm opcode then
				      let
					val inter_reg =
					  case gp_operand of
					    MirTypes.GP_GC_REG r =>
					      (if r = global_mir then
						 (* The nasty case *)
						 (case reg_operand of
						    MirTypes.GC_REG r' =>
						      if r = r' then
							Crash.impossible "source and dest global with large int"
						      else
							r'
						  | MirTypes.NON_GC_REG _ =>
							Crash.impossible"BINARY doesn't deliver GC")
					       else
						 global_mir)
					  | _ => Crash.impossible "BINARY has non-gc register"
				      in
					([],
					 MirTypes.UNARY(MirTypes.MOVE,
							MirTypes.GC_REG inter_reg,
							gp_operand') ::
					 MirTypes.BINARY(binary_op, reg_operand,
							 gp_operand,
							 MirTypes.GP_GC_REG inter_reg) ::
					 opcode_list, block_list, final_result)
				      end
				    else
				      ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
					 (opcode, rd, rs1, reg_or_imm), absent, "")],
				       opcode_list, block_list, final_result)
				  end
				else
				  let
				    val inter_reg =
				      case gp_operand of
					MirTypes.GP_GC_REG r =>
					  (if r = global_mir then
					     (* The nasty case *)
					     (case reg_operand of
						MirTypes.GC_REG r' =>
						  if r = r' then
						    Crash.impossible
						    "source and dest global with large int"
						  else
						    r'
					      | MirTypes.NON_GC_REG _ =>
						    Crash.impossible"BINARY doesn't deliver GC")
					   else
					     global_mir)
				      | _ => Crash.impossible "BINARY has non-gc register"
				  in
				    ([],
				     MirTypes.UNARY(MirTypes.MOVE,
						    MirTypes.GC_REG inter_reg,
						    gp_operand') ::
				     MirTypes.BINARY(binary_op, reg_operand,
						     gp_operand,
						     MirTypes.GP_GC_REG inter_reg) ::
				     opcode_list, block_list, final_result)
				  end
			      end
			    else
			      (* gp_operand not a register *)
			      if is_reg gp_operand' then
				([],
				 MirTypes.UNARY(MirTypes.MOVE,
						global_reg,
						gp_operand) ::
				 MirTypes.BINARY(binary_op, reg_operand,
						 global_gp,
						 gp_operand') ::
				 opcode_list, block_list, final_result)
			      else
				(* gp_operand' also not a register *)
				([],
				 MirTypes.UNARY(MirTypes.MOVE,
						reg_operand,
						gp_operand) ::
				 MirTypes.BINARY(binary_op, reg_operand,
						 gp_from_reg reg_operand,
						 gp_operand') ::
				 opcode_list, block_list, final_result)
			  end
		    end
		| MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) =>
		    let
		      val rd = lookup_reg_operand reg_operand (* dest reg *)
		    in
		      if is_reg gp_operand then
			let val rs1 = lookup_gp_operand gp_operand in
			  (if rd = rs1 then
			     []
			   else
			     [move_regc(rd, rs1, "")],
			     opcode_list, block_list, final_result)
			end
		      else
			(load_imm_into_register(rd, gp_operand), opcode_list, block_list, final_result)
		    end
                (* This one masks out bottom two bits *)
	        | MirTypes.UNARY(MirTypes.NOT, reg_operand, gp_operand) =>
		    let
		      val rd = lookup_reg_operand reg_operand
		      fun not_seq(rs1, imm) =
			[(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			  (Mips_Assembly.SUBU, rd, zero,
			   Mips_Assembly.REG rs1), absent, "negate"),
			 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			  (Mips_Assembly.ADDIU, rd, rd, Mips_Assembly.IMM imm),
			  absent, "and subtract")]
		    in
		      if is_reg gp_operand then
			let
			  val rs1 = lookup_gp_operand gp_operand
			  val imm = ~4
			in
			  (not_seq(rs1, imm),
			   opcode_list, block_list, final_result)
			end
		      else
                        ([],
                         MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) ::
                         MirTypes.UNARY(MirTypes.NOT, reg_operand,
                                        gp_from_reg reg_operand)
                         :: opcode_list, block_list, final_result)
		    end

                (* No masking for this one *)
	        | MirTypes.UNARY(MirTypes.NOT32, reg_operand, gp_operand) =>
		    let
		      val rd = lookup_reg_operand reg_operand (* dest reg *)
		    in
		      if is_reg gp_operand then
			let
                          val rs1 = lookup_gp_operand gp_operand
                        in
			  ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.NOR, rd, rs1,Mips_Assembly.REG rs1),
                             absent, "")],
                           opcode_list, block_list, final_result)
			end
		      else
                        ([],
                         MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) ::
                         MirTypes.UNARY(MirTypes.NOT32, reg_operand, gp_from_reg reg_operand)
                         :: opcode_list, block_list, final_result)
		    end
		| MirTypes.UNARY(MirTypes.INTTAG, reg_operand, gp_operand) =>
		    let
		      val rn = lookup_reg_operand reg_operand
		    in
		      if is_reg gp_operand then
			let
			  val gp = lookup_gp_operand gp_operand
			in
			  ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			     (Mips_Assembly.SRL, rn, gp,
			      Mips_Assembly.IMM 2),
			     absent, "move right 2"),
			    (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			     (Mips_Assembly.SLL, rn, rn,
			      Mips_Assembly.IMM 2), absent, "then left 2 to tag as integer")],
			   opcode_list, block_list, final_result)
			end 
		      else
			([], MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					    gp_operand) ::
			 MirTypes.UNARY(MirTypes.INTTAG, reg_operand,
					gp_from_reg reg_operand) ::
			 opcode_list, block_list, final_result)
		    end
		| MirTypes.NULLARY(MirTypes.CLEAN, reg_operand) =>
		    ([move_regc(lookup_reg_operand reg_operand, zero, "clean")],
		     opcode_list, block_list, final_result)

		| MirTypes.BINARYFP(binary_fp_op, fp_operand, fp_operand',
				    fp_operand'') =>
		  let
		    val operation = case (MachTypes.fp_used, binary_fp_op) of
		      (MachTypes.single, MirTypes.FADD) => Mips_Assembly.ADD_S
		    | (MachTypes.single, MirTypes.FSUB) => Mips_Assembly.SUB_S
		    | (MachTypes.single, MirTypes.FMUL) => Mips_Assembly.MUL_S
		    | (MachTypes.single, MirTypes.FDIV) => Mips_Assembly.DIV_S
		    | (MachTypes.double, MirTypes.FADD) => Mips_Assembly.ADD_D
		    | (MachTypes.double, MirTypes.FSUB) => Mips_Assembly.SUB_D
		    | (MachTypes.double, MirTypes.FMUL) => Mips_Assembly.MUL_D
		    | (MachTypes.double, MirTypes.FDIV) => Mips_Assembly.DIV_D
		    | (MachTypes.extended, MirTypes.FADD) => Crash.impossible "Extended floats not supported"
		    | (MachTypes.extended, MirTypes.FSUB) => Crash.impossible "Extended floats not supported"
		    | (MachTypes.extended, MirTypes.FMUL) => Crash.impossible "Extended floats not supported"
		    | (MachTypes.extended, MirTypes.FDIV) => Crash.impossible "Extended floats not supported"
		  in
		    ([(Mips_Assembly.FBINARY
		       (operation,lookup_fp_operand fp_operand,
			lookup_fp_operand fp_operand',
			lookup_fp_operand fp_operand''),
		       absent, "")], opcode_list, block_list, final_result)
		  end

		| MirTypes.UNARYFP(unary_fp_op, fp_operand, fp_operand') =>
		    let
		      val rd = lookup_fp_operand fp_operand
		      val rs2 = lookup_fp_operand fp_operand'
		      val (operation, extra_moves) =
			case (MachTypes.fp_used, unary_fp_op) of
			  (MachTypes.single, MirTypes.FSQRT)	=> Crash.impossible "no hardware square root"
			| (MachTypes.single, MirTypes.FMOVE)	=> (Mips_Assembly.MOV_S, 0)
			| (MachTypes.single, MirTypes.FABS)	=> (Mips_Assembly.ABS_S, 0)
			| (MachTypes.single, MirTypes.FNEG)	=> (Mips_Assembly.NEG_S, 0)
			| (MachTypes.double, MirTypes.FSQRT)	=> Crash.impossible "no hardware square root"
			| (MachTypes.double, MirTypes.FMOVE)	=> (Mips_Assembly.MOV_D, 0)
			| (MachTypes.double, MirTypes.FABS)	=> (Mips_Assembly.ABS_D, 0)
			| (MachTypes.double, MirTypes.FNEG)	=> (Mips_Assembly.NEG_D, 0)
			| (MachTypes.extended, MirTypes.FSQRT)	=> Crash.impossible "Extended floats not supported"
			| (MachTypes.extended, MirTypes.FMOVE)	=> Crash.impossible "Extended floats not supported"
			| (MachTypes.extended, MirTypes.FABS)	=> Crash.impossible "Extended floats not supported"
			| (MachTypes.extended, MirTypes.FNEG)	=> Crash.impossible "Extended floats not supported"
			| _ 					=> Crash.impossible "Bad unary fp generated"
		      fun add_moves(_, _, 0) = []
		      | add_moves(rd, rs2, moves) = let
			  val rd = MachTypes.next_reg rd
			  val rs2 = MachTypes.next_reg rs2
			in
			  (Mips_Assembly.FUNARY(Mips_Assembly.MOV_D, rd, rs2),
			   absent, "") :: add_moves(rd, rs2, moves - 1)
			end
		      val extra_code = add_moves(rd, rs2, extra_moves)
		    in
		      ((Mips_Assembly.FUNARY(operation, rd, rs2), absent,
			"") :: extra_code, opcode_list, block_list,
		       final_result)
		    end
		| MirTypes.TBINARYFP(tagged_binary_fp_op, taglist, fp_operand,
				     fp_operand', fp_operand'') =>
		  let
		    val rd = lookup_fp_operand fp_operand
		    val rs1 = lookup_fp_operand fp_operand'
		    val rs2 = lookup_fp_operand fp_operand''
                    val tag = case taglist of [] => NONE | (a::b) => SOME a
		    val (operation, test) =
                      case (MachTypes.fp_used, tagged_binary_fp_op)
                        of (MachTypes.single,   MirTypes.FADDV) => (Mips_Assembly.ADD_S, Mips_Assembly.C_UN_S)
                         | (MachTypes.single,   MirTypes.FSUBV) => (Mips_Assembly.SUB_S, Mips_Assembly.C_UN_S)
                         | (MachTypes.single,   MirTypes.FMULV) => (Mips_Assembly.MUL_S, Mips_Assembly.C_UN_S)
                         | (MachTypes.single,   MirTypes.FDIVV) => (Mips_Assembly.DIV_S, Mips_Assembly.C_UN_S)
                         | (MachTypes.double,   MirTypes.FADDV) => (Mips_Assembly.ADD_D, Mips_Assembly.C_UN_D)
                         | (MachTypes.double,   MirTypes.FSUBV) => (Mips_Assembly.SUB_D, Mips_Assembly.C_UN_D)
                         | (MachTypes.double,   MirTypes.FMULV) => (Mips_Assembly.MUL_D, Mips_Assembly.C_UN_D)
                         | (MachTypes.double,   MirTypes.FDIVV) => (Mips_Assembly.DIV_D, Mips_Assembly.C_UN_D)
                         | (MachTypes.extended, MirTypes.FADDV) => Crash.impossible "Extended floats not supported"
                         | (MachTypes.extended, MirTypes.FSUBV) => Crash.impossible "Extended floats not supported"
                         | (MachTypes.extended, MirTypes.FMULV) => Crash.impossible "Extended floats not supported"
                         | (MachTypes.extended, MirTypes.FDIVV) => Crash.impossible "Extended floats not supported"
		  in
		    ([(Mips_Assembly.FBINARY(operation, rd, rs1, rs2), absent, "")],
                     opcode_list, block_list, final_result)
		  end
		| MirTypes.TUNARYFP(tagged_unary_fp_op, tag, fp_operand,
				    fp_operand') =>
		    let
		      val rd = lookup_fp_operand fp_operand
		      val rs2 = lookup_fp_operand fp_operand'
		      val (operation, test, extra_moves) =
			case (MachTypes.fp_used, tagged_unary_fp_op)
                          of (MachTypes.single,   MirTypes.FABSV)  => (Mips_Assembly.ABS_S,   Mips_Assembly.C_UN_S, 0)
                           | (MachTypes.single,   MirTypes.FNEGV)  => (Mips_Assembly.NEG_S,   Mips_Assembly.C_UN_S, 0)
                           | (MachTypes.single,   MirTypes.FSQRTV) => Crash.impossible "No hardware sqrt"
                           | (MachTypes.double,   MirTypes.FABSV)  => (Mips_Assembly.ABS_D,   Mips_Assembly.C_UN_D, 0)
                           | (MachTypes.double,   MirTypes.FNEGV)  => (Mips_Assembly.NEG_D,   Mips_Assembly.C_UN_D, 0)
                           | (MachTypes.double,   MirTypes.FSQRTV) => Crash.impossible "No hardware sqrt"
                           | (MachTypes.extended, MirTypes.FABSV)  => Crash.impossible "Extended floats not supported"
                           | (MachTypes.extended, MirTypes.FNEGV)  => Crash.impossible "Extended floats not supported"
                           | (MachTypes.extended, MirTypes.FSQRTV) => Crash.impossible "Extended floats not supported"
                           | _ => Crash.impossible "Bad tagged unary FP generated"
		      fun add_moves(_, _, 0) = []
                        | add_moves(rd, rs2, moves) =
                          let
                            val rd = MachTypes.next_reg rd
                            val rs2 = MachTypes.next_reg rs2
			    val mov_instr =
			      (case MachTypes.fp_used of
				MachTypes.single => Mips_Assembly.MOV_S
			      | MachTypes.double => Mips_Assembly.MOV_D
			      | MachTypes.extended => Crash.impossible "Extended floats not supported")
                          in
			    if rd=rs2 then [] else
			      (Mips_Assembly.FUNARY(mov_instr, rd, rs2),
			       absent, "") :: add_moves(rd, rs2, moves - 1)
                          end
		      val extra_code = add_moves(rd, rs2, extra_moves)
		    in
		      ((Mips_Assembly.FUNARY(operation, rd, rs2), absent, "") ::
                       extra_code, opcode_list, block_list, final_result)
		    end

		| MirTypes.STACKOP(stack_op, reg_operand,
				   SOME offset) =>
		  let
		    val opcode = case stack_op of
		      MirTypes.PUSH => MirTypes.STREF
		    | MirTypes.POP => MirTypes.LDREF
		    val _ =
		      if offset > gc_stack_alloc_size then
			Crash.impossible("Stack access at offset " ^
					 Int.toString offset ^
					 " requested, in total area of only " ^
					 Int.toString
					 gc_stack_alloc_size ^
					 "\n")
		      else()
		  in
		    ([],
		     MirTypes.STOREOP(opcode, reg_operand,
				      MirTypes.GC_REG MirRegisters.fp,
				      MirTypes.GP_IMM_ANY
				      (~(gc_stack_alloc_offset + 4 * (offset + 1)))) ::
		     opcode_list, block_list, final_result)
		  end
		| MirTypes.STACKOP _ => Crash.impossible"Offset missing on STACK_OP"
		| MirTypes.IMMSTOREOP _ =>
		    Crash.impossible"IMMSTOREOP not supported on mips"
		| opcode as MirTypes.STOREOP(store_op, reg_operand, reg_operand',
					     gp_operand) =>
		  let
		    val rd = lookup_reg_operand reg_operand
		    val rs1 = lookup_reg_operand reg_operand'
		    val (load_or_store, noop_if_needed) = case store_op of
		      MirTypes.LD => (Mips_Assembly.LW, [nop])
		    | MirTypes.ST => (Mips_Assembly.SW, [])
		    | MirTypes.LDB => (Mips_Assembly.LBU, [nop])
		    | MirTypes.STB => (Mips_Assembly.SB, [])
		    | MirTypes.LDREF => (Mips_Assembly.LW, [nop])
		    | MirTypes.STREF => (Mips_Assembly.SW, [])
		  in
		    if is_reg gp_operand then
		      (* Difficult case, we have two registers for the store *)
		      (* but the mips doesn't allow this *)
		      ([],
		       MirTypes.BINARY
		       (MirTypes.ADDU, global_reg,
			gp_from_reg reg_operand', gp_operand) ::
		       MirTypes.STOREOP(store_op, reg_operand,
					global_reg,
					MirTypes.GP_IMM_ANY 0) ::
		       opcode_list, block_list, final_result)
		    else
		      if gp_check_range(gp_operand, true, arith_imm_limit) then
			let
			  val imm = case make_imm_for_store gp_operand of
			    Mips_Assembly.IMM(n) => n
			  | _ => Crash.impossible "Store, expecting immediate offset"
			in
			  (((Mips_Assembly.LOAD_AND_STORE(load_or_store, rd, rs1,
							  imm)), absent, "")
			   :: noop_if_needed,
			   opcode_list, block_list, final_result)
			end
		      else
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					global_reg,
					gp_operand) ::
			 MirTypes.STOREOP(store_op, reg_operand,
					  reg_operand',
					  global_gp) ::
			 opcode_list, block_list, final_result)
		  end
		| MirTypes.STOREFPOP(store_fp_op, fp_operand, reg_operand,
				     gp_operand) =>
		  let
		    val frd = lookup_fp_operand fp_operand
		    val rs1 = lookup_reg_operand reg_operand
		    val (store, repeat, noop_if_required) =
		      case (MachTypes.fp_used, store_fp_op) of
			(MachTypes.single, MirTypes.FLD)    => (Mips_Assembly.LWC1, false, [nop])
		      | (MachTypes.single, MirTypes.FST)    => (Mips_Assembly.SWC1, false, [])
		      | (MachTypes.single, MirTypes.FLDREF) => (Mips_Assembly.LWC1, false, [nop])
		      | (MachTypes.single, MirTypes.FSTREF) => (Mips_Assembly.SWC1, false, [])
		      | (MachTypes.double, MirTypes.FLD)    => (Mips_Assembly.LWC1, false, [nop])
		      | (MachTypes.double, MirTypes.FST)    => (Mips_Assembly.SWC1, false, [])
		      | (MachTypes.double, MirTypes.FLDREF) => (Mips_Assembly.LWC1, false, [nop])
		      | (MachTypes.double, MirTypes.FSTREF) => (Mips_Assembly.SWC1, false, [])
		      | (MachTypes.extended, _)             => Crash.impossible "Extended floats not supported"
		    val gp_op = case reg_operand of
		      MirTypes.GC_REG reg => MirTypes.GP_GC_REG reg
		    | MirTypes.NON_GC_REG reg => MirTypes.GP_NON_GC_REG reg
		
		    fun gp_op_is_large arg =
		      case arg of
			MirTypes.GP_IMM_ANY i     => gp_check_range(arg, true, arith_imm_limit) andalso
			  gp_check_range(MirTypes.GP_IMM_INT(i+8), true, arith_imm_limit)
		      | MirTypes.GP_IMM_INT i     => gp_op_is_large( MirTypes.GP_IMM_ANY (i*4))
		      | MirTypes.GP_IMM_SYMB symb => gp_op_is_large( MirTypes.GP_IMM_ANY (symbolic_value symb))
		      | MirTypes.GP_GC_REG _      => true
		      | MirTypes.GP_NON_GC_REG _  => true
		  in
		    if repeat then
                      (* Since repeat is always false this lot isn't executed !? *)
		      if gp_op_is_large gp_operand then
			([],
			 MirTypes.BINARY(MirTypes.ADDU,
					 global_reg,
					 gp_op,
					 gp_operand) ::
			 MirTypes.STOREFPOP(store_fp_op, fp_operand,
					    global_reg,
					    MirTypes.GP_IMM_ANY 0) ::
			 opcode_list, block_list, final_result)
		      else
			let
			  val (imm, arg) =
			    case make_imm_for_store gp_operand of
			      imm as Mips_Assembly.IMM arg => (imm, arg)
			    | _ => Crash.impossible
				"make_imm_for_store fails to return IMM"
			  val imm' = Mips_Assembly.IMM(arg+8)
			in
			  ([(Mips_Assembly.LOAD_AND_STORE_FLOAT
			     (store, frd, rs1, imm),
			     absent, ""),
			    (Mips_Assembly.LOAD_AND_STORE_FLOAT
			     (store,
			      MachTypes.next_reg(MachTypes.next_reg frd),
			      MachTypes.next_reg(MachTypes.next_reg rs1),
			      imm'),
			     absent, "")],
			  opcode_list, block_list, final_result)
			end
		    else
		      if is_reg gp_operand orelse
			gp_check_range(gp_operand, true, arith_imm_limit) then
			let
			  val (reg_or_imm, reg_or_imm') =
			    if is_reg gp_operand then
                              (* This case doesn't look right *)
			      (Mips_Assembly.REG(lookup_gp_operand gp_operand),
			       Mips_Assembly.REG(lookup_gp_operand gp_operand))
			    else
			      let val i = case  gp_operand of
				MirTypes.GP_IMM_ANY i => i
			      | MirTypes.GP_IMM_INT i => i*4
			      | MirTypes.GP_IMM_SYMB symbolic =>
				  (case symbolic of
				     MirTypes.FP_SPILL_SLOT info =>
				       symbolic_value symbolic
				   | _ => Crash.impossible"Store FP Op bad symbolic")
			      | MirTypes.GP_GC_REG _ =>
				  Crash.impossible"Store FP Op GP_GC_REG"
			      | MirTypes.GP_NON_GC_REG _ =>
				  Crash.impossible"Store FP Op GP_NON_GC_REG"
			      in
				(make_imm_for_store gp_operand,
				 make_imm_for_store (MirTypes.GP_IMM_ANY (4+i)))
			      end
			in
                          (if MachTypes.fp_used = MachTypes.single
                             then
                               (Mips_Assembly.LOAD_AND_STORE_FLOAT(store, frd, rs1, reg_or_imm), absent, "") ::
                               noop_if_required
                           else
                             (Mips_Assembly.LOAD_AND_STORE_FLOAT
                              (store, frd, rs1, reg_or_imm'), absent, "") ::
                             (Mips_Assembly.LOAD_AND_STORE_FLOAT
                              (store, MachTypes.next_reg frd, rs1, reg_or_imm), absent, "") ::
                             noop_if_required,
                             opcode_list, block_list, final_result)
			end
		      else
			([],
			 MirTypes.BINARY(MirTypes.ADDU,
					 global_reg,
					 gp_op,
					 gp_operand) ::
			 MirTypes.STOREFPOP(store_fp_op, fp_operand,
					    global_reg,
					    MirTypes.GP_IMM_ANY 0) ::
			 opcode_list, block_list, final_result)
		  end
		| MirTypes.REAL(int_to_float, fp_operand, gp_operand) =>
		    let
		      val operation = case MachTypes.fp_used of
			MachTypes.single => Mips_Assembly.CVT_S_W
		      | MachTypes.double => Mips_Assembly.CVT_D_W
		      | _ => Crash.impossible "T[REAL] extended floats not supported"
		      val rd = lookup_fp_operand fp_operand
		      val rs2 =
			if is_reg gp_operand then
			  lookup_gp_operand gp_operand
			else
			  global
		    in
		      if is_reg gp_operand then
			([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			   (Mips_Assembly.SRA, global, lookup_gp_operand gp_operand, Mips_Assembly.IMM 2),
			   absent, "untag operand"),
			  (Mips_Assembly.LOAD_AND_STORE_FLOAT
			   (Mips_Assembly.MTC1, global, rd, dummy_op),
			   absent, ""),
			  nop,
			  (Mips_Assembly.CONV_OP
			   (operation, rd, rd), absent, "")
			  ], opcode_list, block_list, final_result)
		      else
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					global_reg, gp_operand) ::
			 MirTypes.REAL(int_to_float, fp_operand, global_gp) ::
			 opcode_list, block_list, final_result)
		    end



		(* T[FLOOR float_to_int tag rd rs2] =>

		   floor : real -> int

		   -----------------------------------------------------------
		   -2^29 <= x < 2^29
		
		   fp_global := 2^29
		   if rs2 >= fp_global then go tag
		   fp_global := negate fp_global
		   if rs2<fp_global go tag
		   calculate the result
		   box the result
		
		   tag: raise Floor
		   -----------------------------------------------------------
		   "overflow checking, use conversion to check avail precision"
		
		      saveRoundingMode rd global "save rounding mode"
		      changeRoundingMode rd global
		      li global 1
		      sll global global 29
		      mtc1 global fp_global
		      nop
		      operation' fp_global fp_global

		      test rs2 fp_global
		      nop
		      bc1f tag "branch on overflow, unable to tag"
		      nop

		      negate fp_global fp_global
		      test' fp_global rs2
		      nop
		      bc1f tag "branch on overflow, unable to tag"
		      nop

		      "do the conversion operation"
		      operation fp_global rs2
		      nop
		      restoreRoundingMode rd
		      mfc1 rd fp_global
		      nop
		      sll rd rd 2 "tag the result, no overflow"
		      where
		         (operation, operation', test, test', negate)
			    | fp_used == single =
			         (CVT_W_S, CVT_S_W, C_OLT_S, C_OLE_S, NEG_S)
			    | fp_used == double =
			         (CVT_W_D, CVT_D_W, C_OLT_D, C_OLE_D, NEG_D)
			    | _ = BANG! extended floats not supported
			 saveRoundingMode rd gl =
			    cfc1 rd $31 "get FPU status"
			    changeRoundingMode 3
			    where
			       changeRoundingMode bitseq =
			          | bitseq == 3 =
				       ori gl rd bitseq ""
				  | otherwise =
				       ori gl rd 0x3 "mask & reset rounding mode"
				       xori gl gl bitseq ""
				  ctc1 gl $31 ""
				  nop
		         restoreRoundingMode rd =
			    ctc1 rd $31 "restore FPU status"
			    nop
		 *)

		| MirTypes.FLOOR(float_to_int, tag, reg_operand, fp_operand) =>
		    let
		      val (operation, operation', test, test', negate) =
			case MachTypes.fp_used of
			  MachTypes.single =>
			    (Mips_Assembly.CVT_W_S, Mips_Assembly.CVT_S_W,
			     Mips_Assembly.C_OLT_S, Mips_Assembly.C_OLE_S,
			     Mips_Assembly.NEG_S)
                        | MachTypes.double =>
			    (Mips_Assembly.CVT_W_D, Mips_Assembly.CVT_D_W,
			     Mips_Assembly.C_OLT_D, Mips_Assembly.C_OLE_D,
			     Mips_Assembly.NEG_D)
                        | _ => Crash.impossible "extended floats not supported"
			
		      (*
		         fun changeRoundingMode bitseq =
			   (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			   (Mips_Assembly.ORI, gl, rd, Mips_Assembly.IMM 3),
			   absent, "mask & reset rounding mode")
			   ::
			   (if bitseq = 3 then [] else
			      [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			      (Mips_Assembly.XORI, gl, gl, Mips_Assembly.IMM bitseq),
			      absent, "")])
			      @
			      [(Mips_Assembly.LOAD_AND_STORE_FLOAT
			      (Mips_Assembly.CTC1, gl, MachTypes.R31, dummy_op),
			      absent, ""),
			      nop]
		       *)
		      val rs2 = lookup_fp_operand fp_operand
		      val rd = lookup_reg_operand reg_operand

		      val restore_rounding_mode =
			(* fun restoreRoundingMode rd = *)
			[(Mips_Assembly.LOAD_AND_STORE_FLOAT
			  (Mips_Assembly.CTC1, rd, MachTypes.R31, dummy_op),
			  absent, "restore FPU status"),
			 nop]
		      val roundingmode_instrs =
			[(Mips_Assembly.LOAD_AND_STORE_FLOAT
			  (Mips_Assembly.CFC1, rd, MachTypes.R31, dummy_op),    (* special reg r31 here *)
			  absent, "get fpu status"),
			 nop,
			 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			  (Mips_Assembly.ORI, global, rd, Mips_Assembly.IMM 3),
			  absent, "mask& reset roundingmode"),
			 (Mips_Assembly.LOAD_AND_STORE_FLOAT
			  (Mips_Assembly.CTC1, global, MachTypes.R31, dummy_op), (* special reg r31 here *)
			  absent, "save rounding mode changes")]
		    in
		      (roundingmode_instrs
		       @
		       [(* Test for a possible overflow if the number is too big in magnitude *)
			move_imm(global,1),
                        (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                         (Mips_Assembly.SLL,global,global, Mips_Assembly.IMM 29),
			 absent,""),
			(Mips_Assembly.LOAD_AND_STORE_FLOAT
			 (Mips_Assembly.MTC1, global, MachTypes.fp_global,
			  dummy_op),
			 absent,""),
			nop,
                        (Mips_Assembly.CONV_OP(operation', MachTypes.fp_global, MachTypes.fp_global),
			 absent, ""),
                        (Mips_Assembly.FCMP(test, rs2, MachTypes.fp_global), absent, ""),
			nop,
                        (Mips_Assembly.FBRANCH(Mips_Assembly.BC1F, 0),
			 SOME tag, "branch on overflow, unable to tag"),
                        nop,
                        (Mips_Assembly.FUNARY(negate, MachTypes.fp_global, MachTypes.fp_global), 			
			 absent, ""),
                        (Mips_Assembly.FCMP(test', MachTypes.fp_global, rs2), absent, ""),
			nop,
                        (Mips_Assembly.FBRANCH(Mips_Assembly.BC1F, 0),
			 SOME tag, "branch on overflow, unable to tag"),
                        nop,
                        (* Do the conversion operation *)
                        (Mips_Assembly.CONV_OP(operation, MachTypes.fp_global, rs2),
			 absent, ""),
			nop]
		       @ restore_rounding_mode
		       @
		       [(Mips_Assembly.LOAD_AND_STORE_FLOAT
			 (Mips_Assembly.MFC1, rd, MachTypes.fp_global, dummy_op),
			 absent,""),
			nop,
			(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			 (Mips_Assembly.SLL, rd, rd, Mips_Assembly.IMM 2),
			 absent, "Tag the result, no more overflow")],
		       opcode_list, block_list, final_result)
		    end
		
		| MirTypes.BRANCH(branch, bl_dest) =>
		    ((case bl_dest of
		      MirTypes.REG reg =>
			[(Mips_Assembly.JUMP
			  (Mips_Assembly.JR,
			   Mips_Assembly.REG (lookup_reg_operand reg), dummy,
                           Debugger_Types.null_backend_annotation),
			  absent, "Branch indirect"),
			 nop]
		    | MirTypes.TAG tag =>
			[(Mips_Assembly.BRANCH(Mips_Assembly.BA, dummy,dummy,0),
			  (* was annulled *)
			  SOME tag, "branch"),
			 nop]),
			opcode_list, block_list, final_result)

		| MirTypes.TEST (mn, tag, lhs, rhs) =>
		    let
		      (* is_zero identifies if is a 0 or zero_reg *)
		      val poly_test =
			(mn = MirTypes.BNE) andalso
			(((lhs = MirTypes.GP_GC_REG MirRegisters.global) andalso
			  (rhs = MirTypes.GP_IMM_ANY 1)) orelse
			 ((rhs = MirTypes.GP_GC_REG MirRegisters.global) andalso
			  (lhs = MirTypes.GP_IMM_ANY 1)))
		    in
		      if poly_test then
			(* We can't handle this normally as global gets overloaded *)
			(* But we can decrement and test for zero instead *)
			([],
			 MirTypes.BINARY(MirTypes.SUBU,
					 MirTypes.GC_REG MirRegisters.global,
					 MirTypes.GP_GC_REG MirRegisters.global,
					 MirTypes.GP_IMM_ANY 1) ::
			 MirTypes.TEST(MirTypes.BNE, tag,
				       MirTypes.GP_GC_REG MirRegisters.global,
				       MirTypes.GP_IMM_ANY 0) ::
			 opcode_list, block_list, final_result)
		      else
			let
			  local
			    val zero_virtual = case MirRegisters.zero of
			      SOME zero_virtual => MirTypes.GP_GC_REG zero_virtual
			    | _ => Crash.impossible "zero_virtual"
			  in
			    fun is_zero (MirTypes.GP_IMM_INT 0) = true
			      | is_zero (MirTypes.GP_IMM_ANY 0) = true
			      | is_zero x = x = zero_virtual
			    fun convert0 (MirTypes.GP_IMM_INT 0) = zero_virtual
			      | convert0 (MirTypes.GP_IMM_ANY 0) = zero_virtual
			      | convert0 e = e

			    fun convertImm0 e =
			      if e=zero_virtual then
				(MirTypes.GP_IMM_ANY 0)
			      else
				e
			  end
			  val imm_lhs = is_imm lhs
			  val imm_rhs = is_imm rhs

			  (* if lhs and rsh are constants or zero_regs then make both constants
			   otherwise convert Imm0s to zero_regs in both lhs and rhs *)
			  val (lhs, rhs) =
			    if (imm_lhs orelse is_zero lhs) andalso
			      (imm_rhs orelse is_zero rhs) then
			      (convertImm0 lhs, convertImm0 rhs)
			    else
			      (convert0 lhs, convert0 rhs)

			  val imm_lhs = is_imm lhs
			  val imm_rhs = is_imm rhs
			  val imm32_rhs = is_imm32 rhs
			  val imm32_lhs = is_imm32 lhs

			  val simpler = case mn of
			    MirTypes.BEQ => true
			  | MirTypes.BNE => true
			  | _ => false
			in
			  if imm_lhs andalso imm_rhs then
			    let
                              (* gp_value : ??? *)
                              fun gp_value gpmush = case gpmush of
                                MirTypes.GP_IMM_INT i  => (i,0)
                              | MirTypes.GP_IMM_ANY i  => (i div 4, i mod 4)
                              | MirTypes.GP_IMM_SYMB s => (symbolic_value s, 0)
                              | _             => Crash.impossible "gp_value: non constant operand"
			      val (gp1 as (gp11, gp12), gp2 as (gp21, gp22)) = (gp_value lhs, gp_value rhs)
                              (* synthesize unsigned comparisons *)
                              infix less greater lesseq greatereq
                              fun n less m =
                                if n >= 0
                                  then if m >=0 then n < m else true
                                else if m >= 0 then false else n > m
                              fun n lesseq m = n = m orelse n less m
                              fun n greater m = not (n lesseq m)
                              fun n greatereq m = not (n less m)
			      val branch =
				if mn = MirTypes.BGE then
                                  gp11 > gp21 orelse (gp11 = gp21 andalso gp12 >= gp22)
				else if mn = MirTypes.BLE then
				  gp11 < gp21 orelse (gp11 = gp21 andalso gp12 <= gp22)
				else if mn = MirTypes.BGT then
				  gp11 > gp21 orelse (gp11 = gp21 andalso gp12 > gp22)
				else if mn = MirTypes.BLT then
				  gp11 < gp21 orelse (gp11 = gp21 andalso gp12 < gp22)

                                else if mn = MirTypes.BHS then
                                  gp11 greater gp21 orelse (gp11 = gp21 andalso gp12 greatereq gp22)
				else if mn = MirTypes.BLS then
				  gp11 less gp21 orelse (gp11 = gp21 andalso gp12 lesseq gp22)
				else if mn = MirTypes.BHI then
				  gp11 greater gp21 orelse (gp11 = gp21 andalso gp12 greater gp22)
				else if mn = MirTypes.BLO then
				  gp11 less gp21 orelse (gp11 = gp21 andalso gp12 less gp22)
				else case mn of
				  MirTypes.BEQ => gp1 =  gp2
				| MirTypes.BNE => gp1 <> gp2
				| MirTypes.BNT => Bits.andb (gp12, gp22) =  0
				| MirTypes.BTA => Bits.andb (gp12, gp22) <> 0
				| _ => Crash.impossible "mir test const precalc failed"
			    in
			      if branch (* precalculated result *) then
				(* remainder of opcode_list irrelevant here *)
				([], [MirTypes.BRANCH (MirTypes.BRA, MirTypes.TAG tag)],
				 block_list, final_result)
			      else (* false, so fall through *)
				([], opcode_list, block_list, final_result)
			    end
			  else if imm32_lhs then
			    ([],
			     MirTypes.UNARY (MirTypes.MOVE, global_reg, lhs) ::
			     MirTypes.TEST (mn, tag, global_gp, rhs) ::
			     opcode_list, block_list, final_result)
			  else if imm32_rhs then
			    ([],
			     MirTypes.UNARY (MirTypes.MOVE, global_reg, rhs) ::
			     MirTypes.TEST (mn, tag, lhs, global_gp) ::
			     opcode_list, block_list, final_result)
			  else if simpler then
			    let
			      val branch = case mn of
				MirTypes.BEQ => Mips_Assembly.BEQ
			      | MirTypes.BNE => Mips_Assembly.BNE
			      | _ => Crash.impossible "simplebranch"
			      val (lhs, rhs) = if is_imm lhs then (rhs, lhs) else (lhs, rhs)
			    in
			      (if is_imm16 rhs then
				 (load_imm_into_register (MachTypes.global, rhs)
				  @
				  [(Mips_Assembly.BRANCH
				    (branch, lookup_gp_operand lhs, MachTypes.global, 0),
				    SOME tag, ""),
				   nop])
			       else
				 [(Mips_Assembly.BRANCH
				   (branch, lookup_gp_operand lhs, lookup_gp_operand rhs, 0),
				   SOME tag, ""),
				  nop],
				 opcode_list, block_list, final_result)
			    end
			  else if is_zero lhs orelse is_imm16 lhs then
			    let
			      val mn' = case mn of
				MirTypes.BGT => MirTypes.BLT
			      | MirTypes.BLT => MirTypes.BGT
			      | MirTypes.BGE => MirTypes.BLE
			      | MirTypes.BLE => MirTypes.BGE
			      | MirTypes.BEQ => MirTypes.BEQ
			      | MirTypes.BNE => MirTypes.BNE
			      | MirTypes.BNT => MirTypes.BNT
			      | MirTypes.BTA => MirTypes.BTA
			      | MirTypes.BHS => MirTypes.BLS
			      | MirTypes.BLS => MirTypes.BHS
			      | MirTypes.BHI => MirTypes.BLO
			      | MirTypes.BLO => MirTypes.BHI
			    in
			      ([],
			       MirTypes.TEST (mn', tag, rhs, lhs)
			       :: opcode_list, block_list, final_result)
			    end
			  else if is_zero rhs then (* rhs is in focus *)
			    if mn = MirTypes.BNT orelse mn = MirTypes.BHS then (* shortcut branch-true *)
			      ([], [MirTypes.BRANCH (MirTypes.BRA, MirTypes.TAG tag)],
			       block_list, final_result)
			    else if mn = MirTypes.BTA orelse mn = MirTypes.BLO then (* shortcut branch-false *)
			      ([], opcode_list, block_list, final_result)
			    else
			      let
				val branch = case mn of
				  MirTypes.BGT => Mips_Assembly.BGTZ
				| MirTypes.BLT => Mips_Assembly.BLTZ
				| MirTypes.BGE => Mips_Assembly.BGEZ
				| MirTypes.BLE => Mips_Assembly.BLEZ
				| MirTypes.BEQ => Mips_Assembly.BEQZ
				| MirTypes.BNE => Mips_Assembly.BNEZ
				| MirTypes.BLS => Mips_Assembly.BEQZ
				| MirTypes.BHI => Mips_Assembly.BNEZ
				(* MirTypes.BNT => branch-true
				  * MirTypes.BTA => branch-false
				  * MirTypes.BHS => branch-true
				  * MirTypes.BLO => branch-false
				  *)
				| _ => Crash.impossible "shortbranch"
			      in
				if is_zero lhs then (* uncertain if imm and zero can exist at same time *)
				  ([(Mips_Assembly.BRANCH
				     (Mips_Assembly.reverse_branch branch, lookup_gp_operand rhs, zero, 0),
				     SOME tag, ""),
				    nop], opcode_list, block_list, final_result)
				else (* is_zero rhs *)
				  ([(Mips_Assembly.BRANCH
				     (branch, lookup_gp_operand lhs, zero, 0),
				     SOME tag, ""),
				    nop], opcode_list, block_list, final_result)
			      end

			    else (* rhs is in focus *)
			      let
				val andt = Mips_Assembly.AND
				val sltu = Mips_Assembly.SLTU
				val slt = Mips_Assembly.SLT
				val iftrue = Mips_Assembly.BNEZ
				val iffalse = Mips_Assembly.BEQ
				val (test, (lhs, rhs), branch) =
				  let
				    val swap = (rhs, lhs)
				    val usual = (lhs, rhs)
				    fun inc (MirTypes.GP_IMM_INT n) = MirTypes.GP_IMM_INT (n+1)
				      | inc (MirTypes.GP_IMM_ANY n) = MirTypes.GP_IMM_ANY (n+1)
				      | inc s = s
				    val rhs' = inc rhs
				    val imm16_rhs' = is_imm16 rhs'
				  in
				    case mn of
				      MirTypes.BNT => (andt, usual, iffalse)
				    | MirTypes.BTA => (andt, usual, iftrue)
				    | MirTypes.BLT => (slt,  usual, iftrue)
				    | MirTypes.BLO => (sltu, usual, iftrue)
				    | MirTypes.BGE => (slt,  usual, iffalse)
				    | MirTypes.BHS => (sltu, usual, iffalse)
				    | MirTypes.BGT =>
					if imm16_rhs' then
					  (slt, (lhs, rhs'), iffalse)
					else
					  (slt, swap, iftrue)
				    | MirTypes.BLE =>
					if imm16_rhs' then
					  (slt, (lhs, rhs'), iftrue)
					else
					  (slt, swap, iffalse)
				    | MirTypes.BLS =>
					if imm16_rhs' andalso not (is_zero rhs') then
					  (sltu, (lhs, rhs'), iftrue)
					else
					  (sltu, swap, iffalse)
				    | MirTypes.BHI =>
					if imm16_rhs' andalso not (is_zero rhs') then
					  (sltu, (lhs, rhs'), iffalse)
					else
					  (sltu, swap, iftrue)
				    | _ => Crash.impossible "mirtypes"
				  end
				val rhs' =
				  if is_imm16 rhs then convert_small_imm rhs
				  else Mips_Assembly.REG (lookup_gp_operand rhs)
			      in
				if is_imm lhs then
				  (* this is a hack to ensure
				   * when BHS ~1 r2
				   * => li global ~1; sltu global r2, global; beqz global
				   * optimised to
				   * => sltiu global r2 (~1+1); bnez global
				   * doesnt happen, as thats wrong
				   * ~1 unsigned is maxint
				   * maxint+1=0 is a problem
				   *)
				  (load_imm_into_register (MachTypes.global, lhs)
				   @
				   [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				     (test, MachTypes.global, MachTypes.global, rhs'),
				     absent, ""),
				    (Mips_Assembly.BRANCH
				     (branch, MachTypes.global, zero, 0),
				     SOME tag, ""),
				    nop], opcode_list, block_list, final_result)
				else
				  ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				     (test, MachTypes.global, lookup_gp_operand lhs, rhs'),
				     absent, ""),
				    (Mips_Assembly.BRANCH
				     (branch, MachTypes.global, zero, 0),
				     SOME tag, ""),
				    nop], opcode_list, block_list, final_result)
			      end
			end
		    end
		| MirTypes.FTEST(fcond_branch, tag, fp_operand, fp_operand') => let
		    val (test_instr, branch) =
		      case (MachTypes.fp_used, fcond_branch) of
			(MachTypes.single, MirTypes.FBEQ) => (Mips_Assembly.C_EQ_S, Mips_Assembly.BC1T)
		      | (MachTypes.single, MirTypes.FBNE) => (Mips_Assembly.C_EQ_S, Mips_Assembly.BC1F)
		      | (MachTypes.single, MirTypes.FBLE) => (Mips_Assembly.C_OLE_S, Mips_Assembly.BC1T)
		      | (MachTypes.single, MirTypes.FBLT) => (Mips_Assembly.C_OLT_S, Mips_Assembly.BC1T)
		      | (MachTypes.double, MirTypes.FBEQ) => (Mips_Assembly.C_EQ_D, Mips_Assembly.BC1T)
		      | (MachTypes.double, MirTypes.FBNE) => (Mips_Assembly.C_EQ_D, Mips_Assembly.BC1F)
		      | (MachTypes.double, MirTypes.FBLE) => (Mips_Assembly.C_OLE_D, Mips_Assembly.BC1T)
		      | (MachTypes.double, MirTypes.FBLT) => (Mips_Assembly.C_OLT_D, Mips_Assembly.BC1T)
		      | (MachTypes.extended, _) 	  => Crash.impossible "Extended floats not supported"
		  in
		    ([(Mips_Assembly.FCMP
		       (test_instr,
			lookup_fp_operand fp_operand,
			lookup_fp_operand fp_operand'), absent, "fptest"),
		      nop,
		      (Mips_Assembly.FBRANCH(branch, 0),
		       SOME tag, "Do the branch"),
		      nop], opcode_list, block_list, final_result)
		  end

		| MirTypes.BRANCH_AND_LINK(_, MirTypes.REG reg_operand,debug_information,_) =>
		    ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
		       (Mips_Assembly.ADDU, global,
			lookup_reg_operand reg_operand, Mips_Assembly.IMM Tags.CODE_OFFSET),
		       absent, "address to jump to"),
		      (Mips_Assembly.JUMP
		       (Mips_Assembly.JALR, lr_op, global, debug_information),
		       absent, "Call to tagged value"),
		      nop],
		    opcode_list, block_list, final_result)
		
		| MirTypes.BRANCH_AND_LINK(_, MirTypes.TAG tag,debug_info,_) =>
		    ([(Mips_Assembly.CALL
		      (Mips_Assembly.BGEZAL, zero, 0,debug_info),
		      SOME tag, "Call"),
		     nop],
		    opcode_list, block_list, final_result)

		| MirTypes.TAIL_CALL(_, target,_) => let
		    val restores =
                      if needs_preserve then
                         restore_fps @
                         restore_gcs @
                         [(Mips_Assembly.LOAD_AND_STORE
                           (Mips_Assembly.LW, lr, MachTypes.sp, 8),
                           absent, "reset link"),
			  (Mips_Assembly.LOAD_AND_STORE
                           (Mips_Assembly.LW, MachTypes.callee_closure, MachTypes.sp, 4),
                           absent, "restore our own caller's closure"),
                          move_reg(MachTypes.sp, MachTypes.fp)]
                      else
                        []
                    val reset =
                      if needs_preserve
                        then [(Mips_Assembly.LOAD_AND_STORE
                               (Mips_Assembly.LW, MachTypes.fp, MachTypes.sp, 0),
                               absent, "reset fp to old fp")]
                      else []
                    (* This sets the delay slot for the jump or branch *)
                    val postRestores =
                      if needs_preserve then
                        Mips_Assembly.nopc "delay slot unusable for fp"
                      else
                        nop
		  in
		    (case target of
		       MirTypes.REG reg =>
                         restores @
                         [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
                           (Mips_Assembly.ADDU, global, lookup_reg_operand reg, Mips_Assembly.IMM 3),
                           absent, "")] @
                         reset @
                         [(Mips_Assembly.JUMP
                           (Mips_Assembly.JR, global_op,
                            dummy,
                            Debugger_Types.null_backend_annotation),
                           absent, "tail call"),
                         postRestores]
		     | MirTypes.TAG tag =>
                         restores @
                         reset @
                         [(Mips_Assembly.BRANCH
                           (Mips_Assembly.BA, dummy, dummy, 0),
                           SOME tag, "branch"),
                          postRestores],
                      opcode_list, block_list, final_result)
		  end (* let *)

                (* There are some interesting interactions with load delays & branches here *)
                (* Note that both the old and the new versions have their branches with the *)
                (* same double word alignment.  We can save an instruction, but then we may *)
                (* gain one from the R4000 bug case, which is also the case if the load delay *)
                (* is eliminated for mips2.  Knowing how much code we have to jump over *)
                (* involves knowing if a nop has been inserted for double word alignment *)
                (* which is something we can't determine at this stage *)
		 | MirTypes.SWITCH(computed_goto, reg_operand, tag_list) =>
		     (let
			val reg = lookup_reg_operand reg_operand
		      in
			if List.length tag_list <= 2 then
			  let
			    fun do_test(done,[]) = []
			      | do_test(done, [tag]) =
				Mips_Assembly.nopc "table entry padding"
				:: (Mips_Assembly.BRANCH
				    (Mips_Assembly.BA, dummy, dummy, 0),
				    SOME tag, "branch to table entry")
				:: done
			      | do_test(done, tag :: rest) =
				   do_test(
					   Mips_Assembly.nopc "branch delay"
					   :: (Mips_Assembly.BRANCH
					       (Mips_Assembly.BEQ, global, zero, 0),
					       SOME tag, "")
					   :: (Mips_Assembly.ARITHMETIC_AND_LOGICAL
					       (Mips_Assembly.SUB, global, reg, Mips_Assembly.IMM 4),
					       absent, "do the test")
					   :: done,
					   rest)
			  in
			    rev (do_test([], tag_list))
			  end
			else if not needs_preserve andalso reg = global then
			  Crash.impossible "incorrect MIR SWITCH output"
			else if needs_preserve then
			  (Mips_Assembly.CALL (Mips_Assembly.BGEZAL, zero, 1,
                                               Debugger_Types.null_backend_annotation),
			   absent, "call self") ::
                          (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.ADDIU,
                                                                 lr,
                                                                 lr, Mips_Assembly.IMM (6 *4)),
                           absent, "offset to start of table") ::
                          (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.ADDU,
                                                                 global,
                                                                 lr, Mips_Assembly.REG reg ),
                           absent, "offset to entry") ::
                          (Mips_Assembly.LOAD_AND_STORE  (Mips_Assembly.LW,
                                                          global,
                                                          global, 0),
                           absent, "get table entry") ::
                          other_nop ::
			  (Mips_Assembly.ARITHMETIC_AND_LOGICAL (Mips_Assembly.ADDU,
                                                                 lr,
                                                                 lr, global_op),
                           absent, "calculate destination") ::
			  (Mips_Assembly.JUMP (Mips_Assembly.JR,
                                               lr_op, dummy,
                                               Debugger_Types.null_backend_annotation),
                           absent, "jump to table entry") ::
			  nop ::
                          (rev (#1(foldl
                                   (fn (tag,(l,n)) =>
                                    ((Mips_Assembly.OFFSET n,SOME tag,"") :: l,n+4))
                                   ([],0)
                                   tag_list)))
			else Crash.impossible "unaccounted for MIR SWITCH case"
		      end,
		    opcode_list, block_list, final_result)
(*		
		 | MirTypes.SWITCH(computed_goto, reg_operand, tag_list) =>
		     (let
			val reg = lookup_reg_operand reg_operand
		      in
			if List.length tag_list <= 2 then
			  let
			    fun do_test(done,[]) = []
			      | do_test(done, [tag]) =
				Mips_Assembly.nopc "table entry padding"
				:: (Mips_Assembly.BRANCH
				    (Mips_Assembly.BA, dummy, dummy, 0),
				    SOME tag, "branch to table entry")
				:: done
			      | do_test(done, tag :: rest) =
				   do_test(
					   Mips_Assembly.nopc "branch delay"
					   :: (Mips_Assembly.BRANCH
					       (Mips_Assembly.BEQ, global, zero, 0),
					       SOME tag, "")
					   :: (Mips_Assembly.ARITHMETIC_AND_LOGICAL
					       (Mips_Assembly.SUB, global, reg, Mips_Assembly.IMM 4),
					       absent, "do the test")
					   :: done,
					   rest)
			  in
			    rev (do_test([], tag_list))
			  end
			else if not needs_preserve andalso reg = global then
			  Crash.impossible "incorrect MIR SWITCH output"
			else if needs_preserve then
			  (Mips_Assembly.CALL
			   (Mips_Assembly.BGEZAL, zero, 1,
                            Debugger_Types.null_backend_annotation),
			   absent, "call self")
			  :: (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			      (Mips_Assembly.ADDIU, lr, lr, Mips_Assembly.IMM (4*4)),
			      absent, "point lr to start of table")
			  :: (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			      (Mips_Assembly.ADDU, global, reg, Mips_Assembly.REG reg),
			      absent, "double index to get offset into table")
			  :: (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			      (Mips_Assembly.ADDU, lr, lr, global_op),
			      absent, "calculate offset into table")
			  :: (Mips_Assembly.JUMP
			      (Mips_Assembly.JR, lr_op, dummy, Debugger_Types.null_backend_annotation),
			      absent, "jump to table offset")
			  :: nop
			  :: rev_fold_append
			  (rev_map
			   (fn t=>
			    (Mips_Assembly.FIXED_BRANCH
			     (Mips_Assembly.BA, dummy, dummy, 0),
			     SOME t, "branch to table entry")
			    :: Mips_Assembly.nopc "table entry padding"
			    :: []) (tag_list, []), [])
			else Crash.impossible "unaccounted for MIR SWITCH case"
		      end,
		    opcode_list, block_list, final_result)
*)		
		| MirTypes.ALLOCATE_STACK(allocate, reg_operand, alloc_size,
					  SOME fp_offset) =>
		  if alloc_size + fp_offset > gc_stack_alloc_size then
		    Crash.impossible("Stack allocation of "^Int.toString alloc_size
				     ^" at offset "
				     ^Int.toString fp_offset
				     ^"requested, in total area of only "
				     ^Int.toString gc_stack_alloc_size
				     ^"\n")
		  else (
			case allocate of
			  MirTypes.ALLOC =>
			    ([],
			     MirTypes.BINARY(MirTypes.SUBU, reg_operand,
					     MirTypes.GP_GC_REG MirRegisters.fp,
					     MirTypes.GP_IMM_ANY
					     (gc_stack_alloc_offset +
					      4 * (fp_offset + alloc_size) - Tags.PAIRPTR)) ::
			     (* Note tagging on pointer *)
			     opcode_list, block_list, final_result)
			| _ => Crash.impossible "ALLOCATE_STACK strange allocate")
		
		| MirTypes.ALLOCATE_STACK _ => Crash.impossible"ALLOCATE_STACK with no offset from fp"
		| MirTypes.DEALLOCATE_STACK _ => ([], opcode_list, block_list, final_result)
(*
                  ALLOCATE code rewritten by nickb, 1995-05-31
*)
		| MirTypes.ALLOCATE(allocate, reg_operand, gp_operand) =>
		    let			
		      val rd = lookup_reg_operand reg_operand
		      (* lift common registers out here to clarify things *)
		      val gc1 = MachTypes.gc1
		      val reg_gc2 = Mips_Assembly.REG MachTypes.gc2
		      val reg_rd = Mips_Assembly.REG rd

			(* leaf functions use gc2 as a link because lr is live *)
		      val (link, gc_entry) =
			if needs_preserve then
			  (lr, 4 * Implicit_Vector.gc)
			else
			  (MachTypes.gc2, 4 * Implicit_Vector.gc_leaf)

                      val end_gc_tag = MirTypes.new_tag ()
                      val finish_tag = MirTypes.new_tag ()

		(* lift common instructions out here to clarify the code *)
                      val branch_finish =
                        [(Mips_Assembly.BRANCH
                          (Mips_Assembly.BA, dummy, dummy, 0),
                          SOME finish_tag, ""),
                        nop]
		      val branch_end =
			(Mips_Assembly.BRANCH
			 (Mips_Assembly.BA, dummy, dummy, 0),
			 SOME end_gc_tag, "")
		      val gc_test =
			(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			 (Mips_Assembly.SUB, global, gc1, reg_gc2),
			 absent, "test for GC")
		      val gc_test_branch =
			(Mips_Assembly.BRANCH
			 (Mips_Assembly.BLTZ, global, dummy, 0),
			 SOME end_gc_tag, "branch if no GC required")
		      val get_gc_entry =
			(Mips_Assembly.LOAD_AND_STORE
			 (Mips_Assembly.LW, global, MachTypes.implicit, gc_entry),
			 absent, "get GC entry")
		      val call_gc =
			(Mips_Assembly.JUMP
			 (Mips_Assembly.JALR, Mips_Assembly.REG link, global,
			  Debugger_Types.null_backend_annotation),
			 absent, "call GC")
		      fun tag_result(primary) =
			(Mips_Assembly.ARITHMETIC_AND_LOGICAL
			 (Mips_Assembly.ADD, rd, global, Mips_Assembly.IMM primary),
			 absent, "tag result")

		      val (allocation,finish_block) =
                       case gp_operand of
			MirTypes.GP_IMM_INT size =>
                         let
			  val (bytes, primary, pad, secondary) =
			    case allocate of
			      MirTypes.ALLOC =>
				if size = 2 then
				  (8, Tags.PAIRPTR, false, 0)
				else
				  (8 * ((size+2) div 2), Tags.POINTER,
				   size mod 2 = 0, 64*size+Tags.RECORD)
                            | MirTypes.ALLOC_VECTOR =>
                                (8 * ((size+2) div 2), Tags.POINTER,
                                 size mod 2 = 0, 64*size+Tags.RECORD)
			    | MirTypes.ALLOC_STRING =>
				(((size+11) div 8) * 8,
				 Tags.POINTER, false, 64*size+Tags.STRING)
			    | MirTypes.ALLOC_REAL =>
				(case MachTypes.fp_used
				   of MachTypes.single   => Crash.unimplemented "ALLOC_REAL single"
				    | MachTypes.extended => Crash.unimplemented "ALLOC_REAL extended"
				    | MachTypes.double   =>
					(16, Tags.POINTER, false,
					 64*(16 - 4) + Tags.BYTEARRAY))
			    | MirTypes.ALLOC_REF  =>
				(8 + 8*((size+2) div 2),
				 Tags.REFPTR, size mod 2 = 0, 64*size+Tags.ARRAY)
			    | MirTypes.ALLOC_BYTEARRAY =>
				(((size+11) div 8) * 8, Tags.REFPTR, false,
				 64*size+Tags.BYTEARRAY)

			  val write_header =
			    if secondary = 0 then
			      []
			    else
			      (load_large_number_into_register (global, secondary) @
			       [(Mips_Assembly.LOAD_AND_STORE
                                 (Mips_Assembly.SW, global, rd, ~primary),
                                 absent, "write header word")])
			in
			  if check_range (bytes, true, arith_imm_limit) then
			   ([(Mips_Assembly.ARITHMETIC_AND_LOGICAL
                              (Mips_Assembly.ADD, gc1, gc1, Mips_Assembly.IMM bytes),
                              absent, "advance alloc point"),
			     gc_test,
			     gc_test_branch,
                             (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                              (Mips_Assembly.ADD, rd, gc1, Mips_Assembly.IMM (primary - bytes)),
                              absent, "tag result in delay slot"),
                             get_gc_entry,
                             move_regc(rd,zero,"clear invalid register"),
			     call_gc,
                             move_immc(global, bytes, "pass size to gc"),
			     tag_result (primary),
                             branch_end,
                             nop],
                           (if pad then
                              (Mips_Assembly.LOAD_AND_STORE
                               (Mips_Assembly.SW, zero, rd, bytes - primary - 4),
			       absent, "clear unaligned padding") ::
                              write_header
                            else
                              write_header))
			  else
			    (load_large_number_into_register(rd, bytes) @
                             [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
                               (Mips_Assembly.ADD, gc1, gc1, Mips_Assembly.REG rd),
                               absent, "advance alloc point"),
			      gc_test,
                              gc_test_branch,
                              (Mips_Assembly.ARITHMETIC_AND_LOGICAL
                               (Mips_Assembly.SUB, global, gc1, Mips_Assembly.REG rd),
                               absent, "point to new object in delay slot"),
                              get_gc_entry,
                              nop,
			      call_gc,
                              move_regc(global, rd, "pass size to gc"),
                             branch_end,
                             nop],
			     (if pad then
				tag_result (primary) ::
				write_header
			      else
				(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				 (Mips_Assembly.ADD, rd, global, Mips_Assembly.REG rd),
				 absent, "clear unaligned padding") ::
				(Mips_Assembly.LOAD_AND_STORE
				 (Mips_Assembly.SW, zero, rd, ~4), absent, "") ::
				tag_result (primary) ::
				write_header))
			end
		      | MirTypes.GP_GC_REG reg =>
			  let
			    val reg = lookup_reg(MirTypes.GC.unpack reg, gc_array)
			    val (primary, secondary, byte_length, header, padding, comment) =
			      case allocate
				of MirTypes.ALLOC        => Crash.unimplemented "ALLOC variable size"
				 | MirTypes.ALLOC_VECTOR =>
                                     (Tags.POINTER,Tags.RECORD, false, 4+7, true, "vector length")
				 | MirTypes.ALLOC_STRING =>
				     (Tags.POINTER, Tags.STRING, true, 4+7, false, "string length")
				 | MirTypes.ALLOC_REAL   => Crash.unimplemented "ALLOC_REAL variable size"
				 | MirTypes.ALLOC_REF    =>
				     (Tags.REFPTR, Tags.ARRAY, false, 12+7, true, "array length")
				 | MirTypes.ALLOC_BYTEARRAY =>
				     (Tags.REFPTR, Tags.BYTEARRAY, true, 4+7, false, "bytearray length")
			  in
			    (* get the length in bytes into rd *)
			    ((if byte_length then
				[(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.SRL, rd, reg, Mips_Assembly.IMM 2),
				  absent, "untag length")]
			      else
				[]) @
				[(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.ADD, rd,
				   if byte_length then rd else reg,
				     Mips_Assembly.IMM header), absent, comment)] @
				[(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.SRL, rd, rd, Mips_Assembly.IMM 3),
				  absent, "clear bottom bits"),
				 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.SLL, rd, rd, Mips_Assembly.IMM 3),
				  absent, "and realign"),
				 (* check for allocation overflow *)
				 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.ADDU, gc1, gc1, Mips_Assembly.REG rd),
				  absent, "advance alloc point"),
				 gc_test,
				 gc_test_branch,
				 (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.SUBU, global, gc1, Mips_Assembly.REG rd),
				  absent, "point to new object in delay slot"),
				 get_gc_entry,
				 nop,
				 call_gc,
				 move_regc(global, rd, "pass size to gc"),
				 branch_end,
				 nop],
				(if padding then
				   [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				     (Mips_Assembly.ADD, rd, global, Mips_Assembly.REG rd),
				     absent, "clear unaligned padding"),
				    (Mips_Assembly.LOAD_AND_STORE
				     (Mips_Assembly.SW, zero, rd, ~4),
				     absent, "")]
				 else []) @
				   [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				     (Mips_Assembly.ADD, rd, global, Mips_Assembly.IMM primary),
				     absent, "tag result"),
				     (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				      (Mips_Assembly.SLL, global, reg,
				       Mips_Assembly.IMM 4),
				      absent, "make header word"),
				    (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				     (Mips_Assembly.ADD, global, global, Mips_Assembly.IMM secondary),
				     absent, "with secondary tag"),
				    (Mips_Assembly.LOAD_AND_STORE (Mips_Assembly.SW, global, rd, ~primary),
				     absent, "store header word")])
			  end
		      | _ => Crash.impossible "Strange parameter to ALLOCATE"
		    in
		      (allocation,
                       [],
                       MirTypes.BLOCK (finish_tag,opcode_list) :: block_list,
                       (end_gc_tag,finish_block @ branch_finish) :: final_result)
		    end
		| MirTypes.ADR(adr, reg_operand, tag) =>
		    let
		      val reg = lookup_reg_operand reg_operand
		    in
		      ((case adr of
			  MirTypes.LEA =>
			    [(Mips_Assembly.CALL
			      (Mips_Assembly.BGEZAL, zero, 1,Debugger_Types.null_backend_annotation),
			      absent, "Call self"),
			     (Mips_Assembly.ARITHMETIC_AND_LOGICAL
			      (Mips_Assembly.ADD, reg, lr,
			       Mips_Assembly.IMM 4),
			      SOME tag, "Update gc pointer")]
			| MirTypes.LEO =>
			    [(Mips_Assembly.LOAD_OFFSET
			      (Mips_Assembly.LEO, reg, 0),
			      SOME tag,
			      "Get offset of tag from procedure start")]),
			  opcode_list, block_list, final_result)
		     end
		(* Note that lr points to the call instruction *)
		(* Thus lr + 4, as computed by the ADD *)
		(* points to the ADD instruction, which is fixed *)
		(* up during linearisation *)

		(* Warning. If we ever make a leaf adr, we must ensure *)
		(* handler continuations are done safely. This is not currently *)
		(* true since they use o1 as the address. *)
	
		| MirTypes.INTERCEPT => (trace_dummy_instructions, opcode_list, block_list, final_result)
		(* T[INTERRUPT] =>
		   Written by nickb, 1995-01-05 *)
		| MirTypes.INTERRUPT =>
		    let
		      val continue_tag = MirTypes.new_tag()
			val block_list' =
			  MirTypes.BLOCK(continue_tag,opcode_list)::block_list
			val opcode_list' = []
			val (implicit_offset,link) =
			  if needs_preserve then
			    (4 * Implicit_Vector.event_check, lr)
			  else
			    (4*Implicit_Vector.event_check_leaf, MachTypes.gc2)
			val event_check_code =
			  [(Mips_Assembly.BRANCH
			    (Mips_Assembly.BGTZ, MachTypes.stack_limit,
			     dummy, 0),
			    SOME continue_tag,
			    "test for asynch event"),
                           nop, (* See bug report #1834 *)
			   (Mips_Assembly.LOAD_AND_STORE
			    (Mips_Assembly.LW, global,
			     MachTypes.implicit,
			     implicit_offset),
			    absent, ""),
                           nop,
			   (Mips_Assembly.JUMP
			    (Mips_Assembly.JALR,
			     Mips_Assembly.REG link,
			     global,
			     Debugger_Types.null_backend_annotation),
			    absent, "enter event check"),
			   Mips_Assembly.nopc "Can't fill this",
			   (Mips_Assembly.BRANCH
			    (Mips_Assembly.BA, dummy,
			     dummy, 0),
			    SOME continue_tag, "End of block"),
			   nop]
		    in
		      (event_check_code,
		       opcode_list', block_list', final_result)
		    end
		
		(* T[ENTER] =>
		  Rewritten by nickb, 1994-11-25 *)
		| MirTypes.ENTER _ =>
		    (* leaf case *)
		    if not needs_preserve then
		      ([], opcode_list, block_list, final_result)
		    else (* non-leaf case *)
		      let

                        (* There are three kinds of frame:

                         - Normal, which means it will fit in the leeway on the stack
                         (i.e. if sp >= stackLimit, we're OK)
                         - Medium, which means we can fit the frame size into an immediate
                         - Large, which means we can't
                         (so we put the frame size in 'global' and then keep it
                         there).
                         *)

			datatype frame =
			  Normal
			| Medium
			| Large
			val frame = if (non_save_frame_size <= 0) then Normal
				    else if (frame_size < arith_imm_limit)
					   then Medium
					 else Large
			val stackOKTag = MirTypes.new_tag()

			(* endTag tags the body of the function *)
			val endTag = MirTypes.new_tag()
			val block_list' =
			  MirTypes.BLOCK(endTag, opcode_list) :: block_list
			(* no more opcodes in this block *)
			val opcode_list' = []

                        (* there are five phases to the entry:

                         (0) saving the fp
                         (1) checking for stack overflow
                         .stackOK:
                         (2) making the stack frame and linkage,
                         (3) saving any GC & FP saves (already constructed as save_gcs and save_fps),
                         (4) initialising GC stack slots to zero. (can require a loop).
                         *)

                        (* (0) one instruction to save the fp *)
 			val save_the_fp =
			  (Mips_Assembly.LOAD_AND_STORE
			   (Mips_Assembly.SW, MachTypes.fp, MachTypes.sp, 0),
			   absent, "save fp")
                        (* (1) checking for stack overflow *)
			val check_for_stack_overflow =
			  let
                            (* first, get the value to check against the stack limit in a reg *)
			    val preCheck =
			      case frame of
				Normal => []
			      | Medium =>
				  [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				    (Mips_Assembly.ADDIU, global,
				     MachTypes.sp,
				     Mips_Assembly.IMM (~frame_size)),
				    absent, "new sp for checking")]
			    | Large =>
				load_large_number_into_register
				(global, frame_size)
				@ [(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				    (Mips_Assembly.SUBU, hacky_temporary_reg,
				     MachTypes.sp, global_op),
				    absent, "new sp for checking")]
                            (* next, compare it to the stack limit and skip to part (2) if OK *)
			    val stack_overflow_test =
			      let
				val stack_overflow_bool_reg =
				  case frame of
				    Large => hacky_temporary_reg
				  | _ => global
				val stack_overflow_test_reg =
				  case frame of
				    Normal => MachTypes.sp
				  | Medium => global
				  | Large => hacky_temporary_reg
			      in
				[(Mips_Assembly.ARITHMETIC_AND_LOGICAL
				  (Mips_Assembly.SLTU, stack_overflow_bool_reg,
				   MachTypes.stack_limit,
				   Mips_Assembly.REG stack_overflow_test_reg),
				  absent,"stack overflow test"),
				 (Mips_Assembly.BRANCH
				  (Mips_Assembly.BNE, stack_overflow_bool_reg,
				   zero,0),
				  SOME stackOKTag, "branch if OK"),
				 move_regc(MachTypes.fp, MachTypes.sp,
					   "update fp in delay slot")]
			      end
                            (* last, if the stack check failed, call the stack extension code *)
			    val stack_extension =
			      let
				val call_delay_slot_instr =
				  case frame of
				    Large =>
				      Mips_Assembly.nopc "Can't fill this"
				  | _ =>
				      move_imm(global, frame_size)
			      in
				[(Mips_Assembly.LOAD_AND_STORE
				  (Mips_Assembly.LW, hacky_temporary_reg,
				   MachTypes.implicit,
				   4 * Implicit_Vector.extend),
				  absent, ""),
				 Mips_Assembly.nopc "Can't fill this",
				 (Mips_Assembly.JUMP
				  (Mips_Assembly.JALR,
				   Mips_Assembly.REG MachTypes.gc2,
				   hacky_temporary_reg,
				   Debugger_Types.null_backend_annotation),
				  absent, ""),
				 call_delay_slot_instr,
				 (Mips_Assembly.BRANCH
				  (Mips_Assembly.BA, dummy,
				   dummy, 0),
				  SOME stackOKTag, "Do the branch"),
				 nop]
			      end
			  in
			    preCheck @ stack_overflow_test @ stack_extension
			  end

                        (* (2) making the stack frame and linkage *)			
			
			val make_frame =
			  let
			    val push_frame_instruction =
			      case frame of
				Large =>
				  (* we have the frame size in 'global' *)
				  (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				   (Mips_Assembly.SUBU, MachTypes.sp,
				    MachTypes.sp, global_op),
				   absent, "make the frame")
			      | _ =>
				  (* the frame size is immediate *)
				  (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				   (Mips_Assembly.ADDIU, MachTypes.sp,
				    MachTypes.sp,
				    Mips_Assembly.IMM (~frame_size)),
				   absent, "make the frame")
			  in
			    (* save values in the newly made slots *)
			      [push_frame_instruction,
			       (Mips_Assembly.LOAD_AND_STORE
				(Mips_Assembly.SW, MachTypes.callee_closure,
				 MachTypes.sp, 4), absent, "save closure"),
			       (Mips_Assembly.LOAD_AND_STORE
				(Mips_Assembly.SW, lr,
				 MachTypes.sp, 8), absent, "save link"),
			       (* set up our closure register *)
			       move_reg(MachTypes.callee_closure,
					MachTypes.caller_closure)]
			  end

                        (* (4) initialising  GC stack slots to zero *)

                        val (clear_frame_code,clear_frame_blocks) =
			  let
			    val gc_stack_slots =
			      (gc_spill_size + gc_stack_alloc_size)

			    (* Final branch to the end *)
			    val endInstrs =
			      [(Mips_Assembly.BRANCH
				(Mips_Assembly.BA, dummy,
				 dummy, 0),
				SOME endTag, "branch"),
			       nop]
			  in
			    if gc_stack_slots < 10 then
                              (* For small numbers of stack slots, initialize each one separately *)
			      let
				(* Clear a single stack slot *)
				fun saveInstr offset =
				  (Mips_Assembly.LOAD_AND_STORE
				   (Mips_Assembly.SW, zero,
				    MachTypes.sp, offset),
				   absent, "init stack slot")
				
				fun initStackSlots(offset, 0, done) = done
				  | initStackSlots(offset, n, done) =
				    initStackSlots(offset+4, n-1,
						   saveInstr offset :: done)
			      in
				(initStackSlots (register_save_size,
						 gc_stack_slots, endInstrs),[])
			      end
			    else
                              (* For larger numbers, we make a loop *)
			      let
				val loop_tag = MirTypes.new_tag ()
			      in
				([move_imm (hacky_temporary_reg,
					    gc_stack_slots),
				  (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				   (Mips_Assembly.ADDIU, global,
				    MachTypes.sp,
				    Mips_Assembly.IMM register_save_size),
				   absent, "global = first slot location"),
				  (Mips_Assembly.BRANCH
				   (Mips_Assembly.BA, dummy,
				    dummy, 0),
				   SOME loop_tag, ""),
				  nop],
				[(loop_tag,
				  [(Mips_Assembly.LOAD_AND_STORE
				    (Mips_Assembly.SW, zero,
				     global, 0),
				    absent, "clear stack slot"),
				   (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				    (Mips_Assembly.ADDI, global,
				     global, Mips_Assembly.IMM 4),
				    absent, "increment pointer"),
				   (Mips_Assembly.ARITHMETIC_AND_LOGICAL
				    (Mips_Assembly.SUB, hacky_temporary_reg,
				     hacky_temporary_reg, Mips_Assembly.IMM 1),
				    absent, "decrement loop counter"),
				   (Mips_Assembly.BRANCH
				    (Mips_Assembly.BGTZ, hacky_temporary_reg,
				     dummy, 0),
				    SOME loop_tag, "and loop"),
				   nop] @
				  endInstrs)])
			      (* temp is now zero so no need to clean *)
			      end
			  end

                        (* Now put it all together *)
                        (* phases 0 and 1 *)
                        val entry =
                          save_the_fp :: check_for_stack_overflow
                        (* phases 2, 3, and part of 4 *)			
                        val stackOKblock =
                          (stackOKTag,
                           make_frame @ save_gcs @ save_fps @ clear_frame_code)
                      (* rest of 4 is in clear_frame_blocks *)
		      in
			(entry, opcode_list', block_list',
			 stackOKblock :: clear_frame_blocks @ final_result)
		      end

		| MirTypes.RTS =>
		    if needs_preserve then
			(restore_fps @
			 restore_gcs @
			 [(Mips_Assembly.LOAD_AND_STORE (Mips_Assembly.LW, lr, MachTypes.sp, 8),
			   NONE, "restore lr"),
			  (Mips_Assembly.LOAD_AND_STORE (Mips_Assembly.LW, MachTypes.callee_closure, MachTypes.sp, 4),
			   NONE, ""),
			  move_regc(MachTypes.sp, MachTypes.fp, "restore previous sp"),
			  (Mips_Assembly.LOAD_AND_STORE(Mips_Assembly.LW, MachTypes.fp, MachTypes.sp, 0),
			   NONE, "restore fp not in delay slot"),
			  (Mips_Assembly.JUMP (Mips_Assembly.JR, lr_op,dummy, Debugger_Types.null_backend_annotation),
			  NONE, "return"),
			  nop],
			 opcode_list, block_list, final_result)
		    else
		     ([(Mips_Assembly.JUMP
			(Mips_Assembly.JR, lr_op, dummy, Debugger_Types.null_backend_annotation),
			absent, "return"), nop],
			opcode_list, block_list, final_result)

		| MirTypes.NEW_HANDLER(handler_frame, tag) =>
		    ([(Mips_Assembly.LOAD_AND_STORE
		       (Mips_Assembly.SW, MachTypes.handler,
			lookup_reg_operand handler_frame, ~1),
		       absent, "Insert pointer to previous handler"),
		      move_reg(MachTypes.handler, lookup_reg_operand handler_frame)],
		     opcode_list, block_list, final_result)

		| MirTypes.OLD_HANDLER =>
		    ([(Mips_Assembly.LOAD_AND_STORE
		       (Mips_Assembly.LW, MachTypes.handler, MachTypes.handler,
			~1),
		       absent,
		       "Restore old handler"),
		      nop], opcode_list, block_list, final_result)

		| MirTypes.RAISE reg =>
		    ( (* #1 *)
		     (Mips_Assembly.LOAD_AND_STORE
		      (Mips_Assembly.LW, global, MachTypes.implicit, 4 *
		       (if needs_preserve then
			  Implicit_Vector.raise_code
			else
			  Implicit_Vector.leaf_raise_code)),
		      absent, "Find handler")
		     :: nop
		     :: (Mips_Assembly.JUMP
			 (Mips_Assembly.JALR, lr_op,
			  global,
			  Debugger_Types.null_backend_annotation), absent, "Raise")
		     :: move_regc(MachTypes.arg, lookup_reg_operand reg, "move arg to raise into arg reg")
		     :: [],
(*
                     handle MachTypes.OutOfScope r =>
		       Crash.impossible ("Raise parameter was in " ^ MachSpec.print_register r ^ " in a leaf procedure")
*)			
		     (* #2-4 *)
		     opcode_list, block_list, final_result)

		| MirTypes.COMMENT _ => Crash.impossible "MirTypes.COMMENT not filtered out"

		| MirTypes.CALL_C =>
		    ([(Mips_Assembly.LOAD_AND_STORE
		       (Mips_Assembly.LW, global,
			MachTypes.implicit, 4 * Implicit_Vector.external),
		       absent, "Get address of callc"),
		      nop,
		    (Mips_Assembly.JUMP
		     (Mips_Assembly.JALR,
		      lr_op, global,
		      Debugger_Types.null_backend_annotation),
		     absent, "Do call_c"), nop],
		    opcode_list, block_list, final_result)
	    in
	      do_everything
	      (needs_preserve, tag, opcode_list,
	       Sexpr.CONS(done, Sexpr.ATOM result_list), new_blocks,
	       new_final_result)
	    end

	in
	  do_everything(needs_preserve, tag, List.filter (fn x=>not(is_comment x)) opcodes,
			Sexpr.NIL, rest, [])
	end

      (* Some stuff to do with optimising unconditional branches to returns *)

      fun exit_block [] = NONE
      | exit_block((block as MirTypes.BLOCK(tag, opcode_list)) :: rest) =
	if List.exists
	  (fn MirTypes.RTS => true | _ => false)
	  opcode_list
	  then SOME block
	else exit_block rest

      fun small_exit_block(MirTypes.BLOCK(tag,opcode_list)) =
        let
          fun less_than_three_opcodes_that_are_not_comments([],occ) = true
            | less_than_three_opcodes_that_are_not_comments(MirTypes.COMMENT _ :: rest,occ) =
              less_than_three_opcodes_that_are_not_comments(rest,occ)
            | less_than_three_opcodes_that_are_not_comments(_,2) = false
            | less_than_three_opcodes_that_are_not_comments(h::t,occ) =
              less_than_three_opcodes_that_are_not_comments(t,occ+1)
        in
          less_than_three_opcodes_that_are_not_comments(opcode_list,0)
        end

      fun append_small_exit(MirTypes.BLOCK(tag, opcode_list), block_list) =
	let
	  fun do_block(block as MirTypes.BLOCK(tag', opc_list)) =
	    if List.exists
	      (fn (MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG t)) => tag = t
	      | _ => false) opc_list then
	      (* Difficult case. Append the exit block onto the block *)
	      (* branching to it, and remove the branch and tag *)
	      let
		val opc' = rev opc_list
		fun get_new_opc_list((comm as MirTypes.COMMENT _) :: rest) =
		  comm :: get_new_opc_list rest
		| get_new_opc_list(MirTypes.BRANCH(MirTypes.BRA,
						   MirTypes.TAG t) ::
				   rest) =
		  if t = tag then rest
		  else
		    Crash.impossible"get_new_opc fails to find proper branch"
		| get_new_opc_list _ = Crash.impossible"get_new_opc fails to find proper branch"
		val new_opc = get_new_opc_list opc'
	      in
		MirTypes.BLOCK(tag', rev_app(new_opc, opcode_list))
	      end
	    else
	      block
	in
	  map do_block block_list
	end

	(* proc_cg code generates for a single procedure. It
         * calculates all values concerned with a procedure's stack
         * frame (e.g. size of floating point save area, whether a
         * stack frame is required, etc.). Then it calls do_blocks
         * (see above) to actually generate the blocks of
         * instructions, moves the entry block to the start of the
         * list, and returns the result. *)

      fun proc_cg(MirTypes.PROC
		  (procedure_name,
                   tag, MirTypes.PROC_PARAMS
		   {spill_sizes, stack_allocated, ...},
		   block_list,runtime_env)) =
	let
          (*val _ = output(std_out,"\n proc_cg : "^procedure_name^"\n")*)
	  val exit_block = exit_block block_list

(* mips exit blocks can be quite long, even if they are < 3 _mir_ opcodes *)
(* So don't do this -- MLA *)
(*
	  val block_list =
	    case exit_block of
	      NONE => block_list
	    | SOME exit_block =>
		if small_exit_block exit_block then
		  append_small_exit(exit_block, block_list)
		else
		  block_list
*)

	  fun define_fp(map, MirTypes.FP_REG fp) =
	    case MirTypes.FP.Map.tryApply'(map, fp) of
	      NONE => MirTypes.FP.Map.define(map, fp, true)
	    | _ => map

	  fun get_fps_from_opcode(MirTypes.TBINARYFP(_, _, fp1, fp2, fp3), map) =
	    define_fp(define_fp(define_fp(map, fp1), fp2), fp3)
	    | get_fps_from_opcode(MirTypes.TUNARYFP(_, _, fp1, fp2),map) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(MirTypes.BINARYFP(_, fp1, fp2, fp3),map) =
	      define_fp(define_fp(define_fp(map, fp1), fp2), fp3)
	    | get_fps_from_opcode(MirTypes.UNARYFP(_, fp1, fp2),map) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(MirTypes.STOREFPOP(_, fp1, _, _),map) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(MirTypes.REAL(_, fp1, _), map) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(MirTypes.FLOOR(_, _, _, fp1),map) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(MirTypes.FTEST(_, _, fp1, fp2),map) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(_, map) = map

	  fun get_fps_from_block(MirTypes.BLOCK(_, instr_list), map) =
	    List.foldl get_fps_from_opcode map instr_list

	  val fp = MirTypes.FP.Map.domain(List.foldl get_fps_from_block MirTypes.FP.Map.empty block_list)

	  fun define_gc(map, MirTypes.GC_REG r) =
	    (case MirTypes.GC.Map.tryApply'(map, r) of
	       NONE => MirTypes.GC.Map.define(map, r, true)
	     | _ => map)
	    | define_gc(map, _) = map

	  fun define_gp(map, MirTypes.GP_GC_REG r) =
	    (case MirTypes.GC.Map.tryApply'(map, r) of
               NONE => MirTypes.GC.Map.define(map, r, true)
	     | _ => map)
	    | define_gp(map, _) = map

	  fun define_bl_dest(map, MirTypes.REG r) = define_gc(map, r)
	    | define_bl_dest(map, _) = map

	  fun get_gcs_from_opcode(MirTypes.TBINARY(_, _, rd, g1, g2), map) =
	    define_gp(define_gp(define_gc(map, rd), g1), g2)
	    | get_gcs_from_opcode(MirTypes.BINARY(_, rd, g1, g2), map) =
	      define_gp(define_gp(define_gc(map, rd), g1), g2)
	    | get_gcs_from_opcode(MirTypes.UNARY(_, rd, g), map) =
	      define_gp(define_gc(map, rd), g)
	    | get_gcs_from_opcode(MirTypes.NULLARY(_, rd), map) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(MirTypes.TBINARYFP _, map) = map
	    | get_gcs_from_opcode(MirTypes.TUNARYFP _, map) = map
	    | get_gcs_from_opcode(MirTypes.BINARYFP _, map) = map
	    | get_gcs_from_opcode(MirTypes.UNARYFP _, map) = map
	    | get_gcs_from_opcode(MirTypes.STACKOP(_, rd, _), map) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(MirTypes.IMMSTOREOP _, map) =
	      Crash.impossible"IMMSTOREOP not supported on mips"
	    | get_gcs_from_opcode(MirTypes.STOREOP(_, rd, rs, g), map) =
	      define_gp(define_gc(define_gc(map, rd), rs), g)
	    | get_gcs_from_opcode(MirTypes.STOREFPOP(_, _, rs, g), map) =
	      define_gp(define_gc(map, rs), g)
	    | get_gcs_from_opcode(MirTypes.REAL(_, _, g), map) =
	      define_gp(map, g)
	    | get_gcs_from_opcode(MirTypes.FLOOR(_, _, rd, _), map) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(MirTypes.BRANCH(_, dest), map) =
	      define_bl_dest(map, dest)
	    | get_gcs_from_opcode(MirTypes.TEST(_, _, g1, g2), map) =
	      define_gp(define_gp(map, g1), g2)
	    | get_gcs_from_opcode(MirTypes.FTEST _, map) = map
	    | get_gcs_from_opcode(MirTypes.BRANCH_AND_LINK(_, dest, _, _), map) =
	      define_bl_dest(map, dest)
	    | get_gcs_from_opcode(MirTypes.TAIL_CALL(_, dest, _), map) =
	      define_bl_dest(map, dest)
	    | get_gcs_from_opcode(MirTypes.CALL_C, map) = map
	    | get_gcs_from_opcode(MirTypes.SWITCH(_, rs, _), map) =
	      define_gc(map, rs)
	    | get_gcs_from_opcode(MirTypes.ALLOCATE(_, rd, g), map) =
	      define_gp(define_gc(map, rd), g)
	    | get_gcs_from_opcode(MirTypes.ALLOCATE_STACK(_, rd, _, _), map) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(MirTypes.DEALLOCATE_STACK _, map) = map
	    | get_gcs_from_opcode(MirTypes.ADR(_, rd, _), map) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(MirTypes.INTERCEPT, map) = map
	    | get_gcs_from_opcode(MirTypes.INTERRUPT, map) = map
	    | get_gcs_from_opcode(MirTypes.ENTER _, map) = map
	    | get_gcs_from_opcode(MirTypes.RTS, map) = map
	    | get_gcs_from_opcode(MirTypes.NEW_HANDLER _, map) = map
	    | get_gcs_from_opcode(MirTypes.OLD_HANDLER, map) = map
	    | get_gcs_from_opcode(MirTypes.RAISE rd, map) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(MirTypes.COMMENT _, map) = map

	  fun get_gcs_from_block(MirTypes.BLOCK(_, instr_list), map) =
	    List.foldl get_gcs_from_opcode map instr_list

          (* The set of gc registers used *)
	  val gc = MirTypes.GC.Map.domain(List.foldl get_gcs_from_block MirTypes.GC.Map.empty block_list)

	  val fps = Set.list_to_set(map (fn r => MirTypes.FP.Map.apply'(fp_map, r)) fp)
	  val gcs = Set.list_to_set(map (fn r => MirTypes.GC.Map.apply'(gc_map, r)) gc)
	  val fps_to_preserve =
	    Set.set_to_list(Set.setdiff(fps, #fp MachSpec.corrupted_by_callee))
	
	  val fp_save_size = List.length fps_to_preserve
	  val preserve_fps = fp_save_size <> 0

	  fun check_gp_op(MirTypes.GP_GC_REG r) = false
	    | check_gp_op(MirTypes.GP_NON_GC_REG r) = false
	    | check_gp_op(MirTypes.GP_IMM_INT _) = false
	    | check_gp_op(MirTypes.GP_IMM_ANY _) = false
	    | check_gp_op(MirTypes.GP_IMM_SYMB symbolic) =
	      case symbolic of
		MirTypes.GC_SPILL_SIZE => false
	      | MirTypes.NON_GC_SPILL_SIZE => false
	      | MirTypes.GC_SPILL_SLOT _ => true
	      | MirTypes.NON_GC_SPILL_SLOT _ => true
	      | MirTypes.FP_SPILL_SLOT _ => true

	  (* check_instr: determines instrs that need preserving *)
	  fun check_instr(MirTypes.BRANCH_AND_LINK _) = true
	    | check_instr MirTypes.CALL_C = true
	    | check_instr(MirTypes.SWITCH _) = true
	    (* handler manipulations need the stack *)
            | check_instr(MirTypes.NEW_HANDLER _) = true
	    | check_instr(MirTypes.ADR _) = true
	    | check_instr(MirTypes.ALLOCATE_STACK _) = true
	    | check_instr(MirTypes.DEALLOCATE_STACK _) = true
	    | check_instr(MirTypes.STACKOP _) = true
	    (* Loads and stores can reference the stack directly *)
	    | check_instr(MirTypes.STOREOP(_, _, _, gp_op)) =
	      check_gp_op gp_op
	    | check_instr(MirTypes.STOREFPOP(_, _, _, gp_op)) =
	      check_gp_op gp_op
	    (* nothing else needs the stack *)
	    | check_instr _ = false

	  fun check_instr_block(MirTypes.BLOCK(_, instr_list)) =
	    List.exists check_instr instr_list

	  (* needs_preserve: checks if non-leaf, non-leaf operations or uses non-leaf registers *)
	  (* the 'ch' stuff has got to go...
	     check_reg is dependant on exceptions because it transverses non-list datatypes and provides
	     short-cut evaluation. This is why it looks so ugly.
	     check if leaf optimisation is allowed
	     check if stack has been used (sparc version)
	     check if fps needs preserving
	     check if instructions force non-leaf
	     check if non_leaf registers are used
	     and finaly get that magic exception catch all shyte
	  *)
	  local
	     fun ch f s = (app f s; false) handle MachTypes.NeedsPreserve => true
	  in
            val needs_preserve =
              not opt_leaf_fns
	      orelse preserve_fps
	      orelse (ch (fn r =>
			  MachTypes.check_reg(MirTypes.GC.Map.apply'(gc_map, r))) gc)
(* Unnecessary, we never preserve non_gc values
	      orelse (ch (fn r =>
			  MachTypes.check_reg(MirTypes.NonGC.Map.apply'(non_gc_map, r))) non_gc)
*)
	      orelse List.exists check_instr_block block_list
	  end (* local *)

          val _ =
            if generate_debug_info orelse debug_variables orelse generate_moduler
              then
                debug_map := Debugger_Types.set_proc_data (procedure_name,
                                                           not needs_preserve,
							   generate_debug_info,
                                                           runtime_env,
                                                           !debug_map)
            else ()

	  val _ =
	    if needs_preserve then ()
	    else
	      diagnostic_output 3
	      (fn _ => [procedure_name, " is leaf\n"])

	  (* move_first: does a lookup on a tag and stuffs an entry after the tagged element back into the list AND
	     the transversed entries so far are reversed *)
	  fun move_first (_, []) = Crash.impossible "move_first"
	    | move_first (L, (t, code) :: rest) =
	      if t = tag then (t, code) :: (L @ rest)
	      else move_first ((t, code) :: L, rest)

	  (* Moved this from do_block as it's independent of block number *)
	  val spills_opt = spill_sizes
	  val stack_opt = stack_allocated
	  val (gc_spill_size, non_gc_spill_size, fp_spill_size) =
	    case spills_opt of
	      SOME{gc = gc_spill_size,
			       non_gc = non_gc_spill_size,
			       fp = fp_spill_size} =>
	      (gc_spill_size, non_gc_spill_size, fp_spill_size)
	     | _ => Crash.impossible"Spill sizes missing to mach_cg"
	  val stack_extra = case stack_opt of
	    SOME stack_extra => stack_extra
	  | _ =>  Crash.impossible"Stack size missing to mach_cg"
	  val float_value_size = case MachTypes.fp_used of
	    MachTypes.single => 4
	  | MachTypes.double => 8
	  | MachTypes.extended => 16
	  val total_fp_size = fp_spill_size + fp_save_size
	  val total_gc_size = gc_spill_size + stack_extra

	  val non_gc_stack_size =
	    non_gc_spill_size * 4 + float_value_size * total_fp_size

	  val linkage_size = 3 (* fp, caller's closure, link to caller *)

	  val callee_saves =
	    Lists.qsort compare_reg
	    (List.filter check_reg (Set.set_to_list gcs))

	  val callee_save_area = List.length callee_saves

	  val register_save_size = 4 * (linkage_size + callee_save_area +
					(if save_arg_for_debugging
					  then 1 else 0))

	  val total = non_gc_stack_size +
	    gc_spill_size * 4 +
	    stack_extra * 4 +
	    register_save_size
	  val non_gc_stack_size =
	    if total mod 8 <> 0 then
	      non_gc_stack_size + 4
	    else
	      non_gc_stack_size
	  val fp_spill_offset = non_gc_spill_size * 4
	  val fp_save_offset =
	    fp_spill_offset + fp_spill_size * float_value_size
	  val gc_spill_offset  = non_gc_stack_size
	  val gc_stack_alloc_offset = gc_spill_offset + gc_spill_size * 4
	  val register_save_offset = gc_stack_alloc_offset + stack_extra * 4

	  val stack_layout =
	    PROC_STACK
	    {non_gc_spill_size = non_gc_spill_size,
	     fp_spill_size = fp_spill_size,
	     fp_save_size = fp_save_size,
	     gc_spill_size = gc_spill_size,
	     gc_stack_alloc_size = stack_extra,
	     register_save_size = register_save_size,
	     non_gc_spill_offset = 0,
	     fp_spill_offset = fp_spill_offset,
	     fp_save_offset = fp_save_offset,
	     gc_spill_offset = gc_spill_offset,
	     gc_stack_alloc_offset = gc_stack_alloc_offset,
	     register_save_offset = register_save_offset,
	     allow_fp_spare_slot = false,
	     float_value_size = float_value_size
	     }

	  val code =
	    move_first([], do_blocks(needs_preserve,
				     block_list,
				     stack_layout,
				     fps_to_preserve,
				     callee_saves))

	  val code_len =
	    List.foldl (op+) 0 (map (fn (_, opcodes) => List.length opcodes) code)

	  fun zeroes 1 = "\000"
	    | zeroes 2 = "\000\000"
	    | zeroes 3 = "\000\000\000"
	    | zeroes 4 = "\000\000\000\000"
	    | zeroes n = Crash.impossible"zeroes: Int.toString n"

	  (* generate_nulls and normalise_to_four_bytes *)
          val padded_name =
	    procedure_name ^ zeroes(4-(size procedure_name mod 4))

	in
	  {code=(tag, code),
	   non_gc_area_size=non_gc_stack_size,
           name=procedure_name,
           padded_name=padded_name,
	   leaf=not needs_preserve,
	   saves=callee_save_area,
	   parms=0}
	end

      (* proc_cg end *)

      (* remove_redundant_loads checks for save,store using the same registers *)
      fun remove_redundant_loads(acc, []) = rev acc
	| remove_redundant_loads(acc, arg as [x]) = rev(x :: acc)
	| remove_redundant_loads(acc, (ins1 as (Mips_Assembly.LOAD_AND_STORE
						(Mips_Assembly.SW, rd1, rs11, rs12),
						tag1, comment1)) ::
				 (ins2 as (Mips_Assembly.LOAD_AND_STORE
					   (Mips_Assembly.LW, rd2, rs21, rs22),
					   tag2, comment2)) :: rest) =
	  if rs11 = rs21 andalso rs12 = rs22 andalso rd1 = rd2 then
	    (diagnostic_output 3
	     (fn _ => ["Removing redundant load after store\n"]);
	     remove_redundant_loads(acc, ins1 :: rest))
	  else
	    remove_redundant_loads(ins2 :: ins1 :: acc, rest)
	| remove_redundant_loads(acc, x :: rest) = remove_redundant_loads(x :: acc, rest)

      val remove_redundant_loads = fn x => remove_redundant_loads([], x)

      fun remove_redundant_loads_from_block(tag, opcode_list) =
	(tag, remove_redundant_loads opcode_list)

      fun remove_redundant_loads_from_proc(tag, block_list) =
	(tag, map remove_redundant_loads_from_block block_list)

    (* fun list_proc_cg code generates for a list of (mutually
     * recursive) procedures. It uses proc_cg above to generate for
     * each individual procedure, then reschedules the code,
     * linearises it (see linearise_list above), and finally assembles
     * the code into machine code in a string (using
     * Mips_Opcodes.output_opcode), and returns a wordset containing
     * that string.
    *)

      fun list_proc_cg proc_list =
	let
	  fun print_unscheduled_code((tag, block_list),name) =
	    let
	      fun print_block(tag, opcode_list) =
		let
		  fun print_opcode(opcode, tag_opt, comment) =
		    Print.print(
			  Mips_Assembly.print opcode ^
			  (case tag_opt of
			    SOME tag =>
			       " tag " ^ MirTypes.print_tag tag
			  | NONE => " no tag") ^
			     " ; " ^ comment ^ "\n")
		in
		  (Print.print("Block tag " ^ MirTypes.print_tag tag ^ "\n");
		   app print_opcode opcode_list)
		end
	    in
	      (Print.print("Procedure entry tag " ^ MirTypes.print_tag tag ^
                           " " ^ name ^
			   "\n");
	       app print_block block_list)
	    end

	  val temp_code_list =
	    Timer.xtime
	    ("main proc_cg stage", !do_timings,
	     fn () => map proc_cg proc_list)

	  val code_list =
            map (fn tuple=>remove_redundant_loads_from_proc (#code(tuple))) temp_code_list
          val procedure_name_list = map #name temp_code_list
	  val leaf_list = map #leaf temp_code_list
	  val stack_parameters = map #parms temp_code_list

	  val code_list' = code_list

	  val _ = diagnostic_output 3
	    (fn _ => ["Unscheduled code\n"])

	  val _ = diagnostic_output 3
	    (fn _ => (app print_unscheduled_code
                      (ListPair.zip(code_list',procedure_name_list)) ;
		      []))

	  fun print_scheduled_code (code_list) =
	    let
	      fun print_proc((proc_tag, proc),name) =
		let
		  fun print_block(tag, opcode_list) =
		    let
		      fun print_opcode(opcode, tag_opt, comment) =
			Print.print(
			      Mips_Assembly.print opcode ^
			      (case tag_opt of
				 SOME tag =>
				   " tag " ^ MirTypes.print_tag tag
			       | NONE => " no tag") ^
				 " ; " ^ comment ^ "\n")
		    in
		      (Print.print("Block tag " ^ MirTypes.print_tag tag ^ " " ^ name ^ "\n");
		       map print_opcode opcode_list)
		    end
		in
		  (Print.print("Procedure tag " ^ MirTypes.print_tag proc_tag ^ "\n");
		   map print_block proc)
		end
	    in
	      map print_proc code_list
	    end

          val (nopcode,_,_) = nop
          fun is_nop (opcode,_,_) = opcode = nopcode

          (* Eliminate branch to branches *)
          fun elim_simple_branches (tag,blocklist) =
            let
              (* Given a block. returns the tag if it is just an unconditional branch *)
              fun get_branch_tag ([(Mips_Assembly.BRANCH (Mips_Assembly.BA,_,_,_),SOME tag,_),
                                   op2]) =
                if is_nop op2
                  then SOME tag
                else NONE
                | get_branch_tag _ = NONE
              (* Find all the blocks with just a branch *)
              val branch_map =
		List.foldl
		(fn ((tag,opcodes), map)=>
                 case get_branch_tag opcodes of
                   SOME tag' => Map.define (map,tag,tag')
                 | _ => map)
                Map.empty blocklist
              val branch_fn = Map.tryApply branch_map
              (* Return the new tag if the tag is just a block with a branch *)
              (* The counter is to prevent infinite looping *)
              fun lookup_branch (tag,0) = tag
                | lookup_branch (tag,n) =
                  (case branch_fn tag of
                     SOME tag' => lookup_branch (tag',n-1)
                   | _ => tag)
              (* Replace branch destinations *)
              (* We could do this just for the branches that need it *)
              fun scan (op1 as (Mips_Assembly.BRANCH b,SOME tag,c) :: rest,acc) =
                  scan (rest, (Mips_Assembly.BRANCH b,SOME (lookup_branch (tag,20)), c) :: acc)
                | scan (op1 ::rest,acc) = scan (rest,op1 :: acc)
                | scan ([],acc) = rev acc
            in
              (tag, map (fn (tag,opcodes) => (tag, scan (opcodes, []))) blocklist)
            end

          (* Return a list of the tags referenced by the opcode list *)
          (* Maybe this should use a more efficient table *)

          fun tags_from opcode_list =
	    List.foldl (fn ((opcode, SOME t, _), acc)=>t::acc
			|  (_, acc)=> acc) [] opcode_list

          fun elim_unreachable (tag,blocklist) =
            let
              val block_map = Map.from_list blocklist
              val block_fn = Map.tryApply block_map
              val seen = ref [] : MirTypes.tag list ref
              val result = ref Map.empty : unit Map.T ref
              fun scan tag =
		if List.exists (fn x=>x=tag) (!seen) then
		  ()
                else
                  (seen := tag :: (!seen);
                   case block_fn tag of
                     SOME opcode_list =>
                       let
                         val tags = tags_from opcode_list
                       in
                         result := Map.define (!result,tag,());
                         List.app scan (tags_from opcode_list)
                       end
                   | _ => ())
              val _ = scan tag
              val blocklist' =
                List.filter
		(fn (tag,_) => isSome (Map.tryApply' (!result, tag))) blocklist
            in
              (tag,blocklist')
            end

	  val new_code_list = map (elim_unreachable o elim_simple_branches) code_list

	  val _ = diagnostic_output 3 (fn _ => ["Linearising\n"])

          val new_code_list =
            Timer.xtime
            ("reordering blocks", !do_timings,
             fn () => map reorder_blocks new_code_list)

	  val linear_code' =
	    Timer.xtime
	    ("linearising", !do_timings,
	     fn () => linearise_list (mips_r4000, new_code_list))

	  val nop_offsets = map find_nop_offsets linear_code'
	  val _ = diagnostic_output 3 (fn _ => ["Linearised\n"])

	  val nop_instruction =
	    Mips_Opcodes.output_opcode
	    (Mips_Assembly.assemble (Mips_Assembly.nop_code))
		
	  fun make_tagged_code linear_code =
            (map
	     (fn ((tag, code),{non_gc_area_size, padded_name, saves, ...}) =>
		{a_clos=Lists.assoc(tag, loc_refs),
		 b_spills=non_gc_area_size,
		 c_saves=saves,
		 d_code =
		 let
                   fun do_point (debug,count) =
                     let
                       val unpadded_name =
                         let
                           val s = size padded_name
                           fun check_index to =
			     if String.sub (padded_name, to) = #"\000" then
                               check_index(to-1)
			     else String.substring (padded_name, 0, to+1)
                         in
                           check_index (s-1)
			   handle Subscript => ""
                         end
                     in
                       debug_map := Debugger_Types.add_annotation (unpadded_name,
                                                                   count,
                                                                   debug,
                                                                   !debug_map)
                     end
                   fun annotation_points ([],_,res) = rev res
                     | annotation_points ((inst,_)::t,count,res) =
                       (case inst of
                          Mips_Assembly.JUMP (_,_,_,debug) => do_point (debug,count)
                        | Mips_Assembly.CALL (_,_,_,debug) => do_point (debug,count)
                        | _ => ();
                            annotation_points(t,count+4,
                                              Mips_Opcodes.output_opcode(Mips_Assembly.assemble inst)::res))
                   val code =
                     if generate_debug_info
                       then String.concat (annotation_points (code,0,[]))
                     else
                       String.concat
                       (map
                        (fn (x, _) =>
                         Mips_Opcodes.output_opcode(Mips_Assembly.assemble x))
                        code)

                   val padded_code =
                     if size code mod 8 = 4
                       then code ^ nop_instruction
                     else code
		 in
                   padded_code
		 end})
	       (ListPair.zip(linear_code,temp_code_list)))
	      handle Lists.Assoc => Crash.impossible"Assoc tagged_code"
	    handle Lists.Assoc => Crash.impossible"Assoc tagged_code"

	  val tagged_code' = make_tagged_code linear_code'

	(* Here we have leaf_list corresponding to procedure_name_list *)
	in
	  (Code_Module.WORDSET(Code_Module.WORD_SET
			       {a_names=procedure_name_list,
				b=tagged_code',
				c_leafs=leaf_list,
				d_intercept=nop_offsets,
				e_stack_parameters=stack_parameters}),
	   ListPair.zip(linear_code', procedure_name_list))
	end

      val (proc_elements, code_list) =
	ListPair.unzip(map list_proc_cg proc_list_list)

      fun code_size proc_elements =
	let
	  fun sizeof_element (Code_Module.WORDSET
			      (Code_Module.WORD_SET{b=tagged_code', ...})) =
	    List.foldl
	    (fn ({d_code=y, ...}, sofar) => (size y) + sofar) 0 tagged_code'
	    | sizeof_element _ = 0
	  fun f (e, sofar) = sofar + (sizeof_element e)
	in
	  List.foldl f 0 proc_elements
	end

      val _ =
        if ! print_code_size
          then
            print ("Normalised code size is " ^
                   Int.toString (code_size proc_elements)  ^ "\n")
        else ()

      fun make_external_refs(con, list) = map (fn (x, y) => con(y, x)) list

      val ext_elements = make_external_refs(Code_Module.EXTERNAL, ext_refs)
      val ext_vars = make_external_refs(Code_Module.VAR, vars)
      val ext_exns = make_external_refs(Code_Module.EXN, exns)
      val ext_strs = make_external_refs(Code_Module.STRUCT, strs)
      val ext_funs = make_external_refs(Code_Module.FUNCT, funs)

      val module =
	Code_Module.MODULE(value_elements @
			 proc_elements @
			 ext_elements @
			 ext_vars @
			 ext_exns @
			 ext_strs @
			 ext_funs)
	in
	  ((module, !debug_map), code_list)
	end
end
