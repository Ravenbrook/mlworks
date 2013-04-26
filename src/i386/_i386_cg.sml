(* _i386_cg.sml the functor *)
(*
$Log: _i386_cg.sml,v $
Revision 1.84  1998/07/14 17:17:57  jont
[Bug #70073]
Remove half word aligned pushes and pops of AX
during floating point sequences

 * Revision 1.83  1998/07/01  17:51:48  jont
 * [Bug #20117]
 * Add align directive for benefit of jump tables
 *
 * Revision 1.82  1998/06/26  10:40:46  jont
 * [Bug #20109]
 * Modify branch size algorithm to start small
 *
 * Revision 1.81  1998/06/24  14:51:54  jont
 * [Bug #20108]
 * Ensure LEO uses short form of mov when destination is real register
 *
 * Revision 1.80  1998/06/23  15:00:51  jont
 * [Bug #20107]
 * Modify stack overflow test to compare with small immediate
 *
 * Revision 1.79  1998/02/19  17:07:00  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.78  1998/02/12  14:49:32  jont
 * [Bug #70022]
 * Make sure floor leaves the i387 stack in a clean state
 *
 * Revision 1.77  1998/02/10  17:58:51  jont
 * [Bug #70055]
 * Modify code generator to save argument if debugging or tracing/profiling
 *
 * Revision 1.76  1998/01/30  09:38:46  johnh
 * [Bug #30326]
 * Merge in change from MLWorks_workspace_97 branch.
 *
 * Revision 1.75  1997/12/22  15:24:33  jont
 * [Bug #70037]
 * Fix single push 0 in function entry sequence
 *
 * Revision 1.74  1997/12/15  17:31:29  jont
 * [Bug #70027]
 * Fix call stack chopping to use add esp, #n instead of lea esp, n[esp]
 *
 * Revision 1.73  1997/11/13  11:17:13  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.72  1997/09/19  09:19:27  brucem
 * [Bug #30153]
 * Remove references to Old.
 * Revision 1.71.2.2  1997/11/20  17:08:45  daveb
 * [Bug #30326]
 *
 * Revision 1.71.2.1  1997/09/11  20:53:53  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.71  1997/08/11  09:37:47  jont
 * [Bug #30243]
 * Remove tests for out of range shifts as we no longer generate them
 *
 * Revision 1.70  1997/08/06  11:22:54  jont
 * [Bug #30215]
 * Remove BIC in favour of INTTAG
 *
 * Revision 1.69  1997/06/03  09:21:53  jont
 * [Bug #30076]
 * Modifications to code generate stack based argument passing
 *
 * Revision 1.68  1997/05/30  12:08:40  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.67  1997/05/06  10:09:04  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.66  1997/04/25  12:46:04  jont
 * [Bug #20018]
 * Correct failure message on trying to save an fp register
 *
 * Revision 1.65  1997/03/13  14:39:31  jont
 * [Bug #0]
 * Fix real comparisons to deal with nans
 *
 * Revision 1.64  1997/03/13  12:02:36  jont
 * [Bug #1962]
 * Sort out problems overloading global during store instructions
 *
 * Revision 1.63  1997/02/10  13:57:52  matthew
 * Don't reverse real bytes in value_cg
 *
 * Revision 1.62  1997/01/16  16:48:09  matthew
 * Changed tag option to tag list in tagged instructions
 *
 * Revision 1.61  1996/11/06  11:12:23  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.60  1996/11/01  15:09:40  andreww
 * [Bug #1707]
 * threading debugger information.
 * (into calls).
 *
 * Revision 1.59  1996/10/31  15:14:31  io
 * removing toplevel String.
 *
 * Revision 1.58  1996/10/29  17:34:01  jont
 * [Bug #1618]
 * Ensure real does not trash its argument if already on the stack
 *
 * Revision 1.57  1996/08/27  11:37:40  jont
 * [Bug #1572]
 * Fix problems with self multiplies producing answer too small by factor of 4
 *
 * Revision 1.56  1996/08/01  16:39:44  jont
 * Porblems with parameters to set_proc_data being wrong order
 *
 * Revision 1.55  1996/08/01  13:09:41  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.54  1996/06/05  13:01:15  jont
 * Fix array code generation problems
 *
 * Revision 1.53  1996/05/30  12:44:42  daveb
 * The Ord exception is no longer at top level.
 *
 * Revision 1.52  1996/05/17  09:47:11  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.51  1996/05/14  13:20:46  jont
 * Fix non-reversible binary operations with stack operations
 *
 * Revision 1.50  1996/05/14  10:47:04  matthew
 * Adding NOT32 MIR instruction
 *
 * Revision 1.49  1996/05/07  17:00:58  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.48  1996/05/01  12:50:51  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.47  1996/04/30  13:20:52  matthew
 * Removing use of MLWorks.Integer
 *
 * Revision 1.46  1996/04/22  15:12:41  matthew
 * Removing error checks for FP operations
 *
 * Revision 1.45  1996/04/04  14:07:23  jont
 * Allow offsets in mem_operands to be bigger than an int, to cope with words
 *
 * Revision 1.44  1996/04/03  16:41:12  jont
 * Fix problems when doing fstref relative to frame
 *
Revision 1.43  1996/02/06  11:29:24  jont
Add implemetations of ADDW and SUBW
These are like ADDV and SUBV, except that
they cannot use exception trapping adds etc because they are untagged
and also when they detect overflow they must clean
all registers involved in the operation
Also fixed faulty string allocation size causing 16 bytes instead
of 8 to be allocated for 32 bit integers (with an inconsistent header)

Revision 1.42  1996/01/23  14:34:02  matthew
Fixing problem with fp_spills and leafness

Revision 1.41  1995/12/22  12:53:19  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.40  1995/12/18  16:41:38  matthew
Save argument register on stack when generating debug code.

Revision 1.39  1995/11/21  13:58:18  jont
Modification for improved runtime env spill offsets
to indicate the kind of data spilled

Revision 1.38  1995/10/26  17:08:06  jont
Fix local variable compilation problems

Revision 1.37  1995/09/22  16:10:29  jont
Fix bug in compiler crash when number of fp spill slots exceeded

Revision 1.36  1995/09/18  16:59:38  jont
Fix problem whereby final word of vectors may be left uninitialised

Revision 1.35  1995/09/01  14:59:59  nickb
Make intercept offset count bytes, not instructions.

Revision 1.34  1995/07/25  15:59:38  jont
Add WORD to value_cg

Revision 1.33  1995/07/19  14:30:32  jont
Add CHAR to value_cg

Revision 1.32  1995/07/13  09:41:52  jont
Fix problems in shift generation

Revision 1.31  1995/06/20  17:56:47  jont
Implement integer multiply

Revision 1.30  1995/06/14  12:21:37  jont
Implement event checking in leaf case

Revision 1.29  1995/06/08  08:55:41  jont
Fixed tagged pointer computation in variable sized allocations

Revision 1.28  1995/06/02  15:19:09  jont
Change stack_limit to register_stack_limit

Revision 1.27  1995/05/19  09:27:57  jont
Modifications for equality tests with zero

Revision 1.26  1995/05/02  15:31:11  matthew
Removing step and polyvariable options

Revision 1.25  1995/03/02  11:06:53  matthew
Changes to Parser and Lexer structures

Revision 1.24  1995/02/15  13:35:25  jont
Improvements to lineariser

Revision 1.23  1995/02/09  17:22:48  jont
Tidy up, and implement some unimplemented opcodes

Revision 1.22  1995/01/30  14:20:46  matthew
Debugger changes

Revision 1.21  1994/12/13  11:00:04  matthew
More work on fp stuff.

Revision 1.20  1994/12/08  13:27:25  matthew
Floating point code generation
,

Revision 1.19  1994/11/28  21:01:04  jont
Handle BINARY a := b - a type stuff
Modify messages for unrepresentable reals

Revision 1.18  1994/11/24  16:34:11  matthew
Adding ALLOC_VECTOR
Include variable length strings & vectors

Revision 1.17  1994/11/22  15:51:45  jont
Minor improvements to tail, rts

Revision 1.16  1994/11/18  14:02:51  jont
Rework stack clearing using push
Modify constant loading in gc sequences

Revision 1.15  1994/11/16  11:23:37  jont
Add immediate store operations

Revision 1.14  1994/11/07  16:07:52  jont
Recode binary add and sub using lea

Revision 1.13  1994/11/04  17:22:48  jont
Sort out small stack initialisation code

Revision 1.12  1994/11/02  17:14:48  jont
Fix new_handler code when handler frame pointer is spilled
Sort out some stack size and initialisation problems
Fix bug in array allocation when both size and destination are spills

Revision 1.11  1994/10/27  15:17:11  jont
Fix problems with overloaded use of ECX during store byte

Revision 1.10  1994/10/20  16:38:44  jont
Get offsets right in stack allocations

Revision 1.9  1994/10/18  14:11:55  jont
Fix various bugs, particularly in gc sequences

Revision 1.8  1994/10/07  16:21:12  jont
Get branch offsets right for cross procedure calls and tails

Revision 1.7  1994/10/06  13:03:21  jont
Sort out load/store code
Fix minor problems in tail

Revision 1.6  1994/10/05  12:59:04  jont
Do more opcodes

Revision 1.5  1994/09/27  16:32:07  jont
Add stack initialisation and overflow checking, and variable size allocation
Stack initialisation not in yet

Revision 1.4  1994/09/23  15:11:57  jont
Add more opcodes and deal with spills
First version to complete __builtin_library
No stak overflow check or initialisation

Revision 1.3  1994/09/21  15:27:08  jont
More opcodes

Revision 1.2  1994/09/16  14:55:48  jont
Compiled move, load/store, enter and rts (leaf only) and started on alloc

Revision 1.1  1994/09/15  17:07:14  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../basis/__int";

require "../utils/print";
require "../utils/mlworks_timer";
require "../utils/lists";
require "../utils/crash";
require "../utils/diagnostic";
require "../utils/sexpr";
require "../basics/ident";
require "../main/reals";
require "../main/options";
require "../main/code_module";
require "../mir/mirtables";
require "../mir/mirregisters";
require "../mir/mirprint";
require "../rts/gen/implicit";
require "../rts/gen/tags";
require "../main/info";
require "../main/machspec";
require "i386_schedule";
require "../main/mach_cg";

functor I386_Cg(
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
  structure MirPrint : MIRPRINT
  structure MachSpec : MACHSPEC
  structure Code_Module : CODE_MODULE
  structure I386_Schedule : I386_SCHEDULE
  structure Implicit_Vector : IMPLICIT_VECTOR
  structure Diagnostic : DIAGNOSTIC

  sharing Info.Location = Ident.Location
  sharing MirTables.MirTypes.Set = MachSpec.Set
  sharing MirTables.MirTypes = MirRegisters.MirTypes = MirPrint.MirTypes

  sharing type Ident.SCon = MirTables.MirTypes.SCon

  sharing type I386_Schedule.I386_Assembly.I386_Opcodes.I386Types.I386_Reg
    = MachSpec.register
  sharing type MirTables.MirTypes.Map.object = I386_Schedule.I386_Assembly.tag
  sharing type I386_Schedule.I386_Assembly.Backend_Annotation =
    MirTables.MirTypes.Debugger_Types.Backend_Annotation
     ) : MACH_CG =
struct
  structure I386_Assembly = I386_Schedule.I386_Assembly
  structure I386_Opcodes = I386_Assembly.I386_Opcodes
  structure MirTypes = MirTables.MirTypes
  structure I386Types = I386_Opcodes.I386Types
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
  type Opcode = I386_Assembly.opcode

  val do_timings = ref false

  val trace_dummy_instructions =
    [(I386_Assembly.other_nop_code,NONE,"Dummy instructions for tracing"),
     (I386_Assembly.other_nop_code,NONE,"Dummy instructions for tracing"),
     (I386_Assembly.other_nop_code,NONE,"Dummy instructions for tracing")]

  val diagnostic_output = Diagnostic.output

  val print_code_size = ref false

  val linkage_size = 3
  val frame_offset = 4 (* Leave room for return address on stack *)
  val fp_spare_offset = frame_offset + 4 (* one down from the return address *)

  fun B l =
    let
      fun aux ([],acc) = acc
        | aux (#"0" ::rest,acc) =
          aux (rest,acc+acc)
        | aux (#"1" ::rest,acc) =
          aux (rest,acc+acc+1)
        | aux (#" " ::rest,acc) =
          aux (rest,acc)
        | aux (d::rest,acc) =
          Crash.impossible "bad binary number"
    in
      aux (explode l,0)
    end

  val fpu_error_bits = B"0000 1101" (* The bits to check for an error *)
  val fpu_control_rounding_bits           = B"1111 0011 1111 1111"
  val fpu_control_round_to_minus_infinity = B"0000 0100 0000 0000"

  fun contract_sexpr(Sexpr.NIL, [], acc) =
    Lists.reducel (fn (x, y) => y @ x) ([], acc)
    | contract_sexpr(Sexpr.NIL, x :: xs, acc) = contract_sexpr(x, xs, acc)
    | contract_sexpr(Sexpr.ATOM x, to_do, acc) =
      contract_sexpr(Sexpr.NIL, to_do, x :: acc)
    | contract_sexpr(Sexpr.CONS(x, y), to_do, acc) =
      contract_sexpr(x, y :: to_do, acc)

  val contract_sexpr =
    fn x => contract_sexpr(x, [], [])

  fun find_nop_offsets(_, []) = ~1
    | find_nop_offsets(offset, (opcode, _) :: rest) =
      if opcode = I386_Assembly.other_nop_code then
	offset
      else
	find_nop_offsets(offset+(I386_Assembly.opcode_size opcode), rest)

  val find_nop_offsets = fn (tag, code) => find_nop_offsets(0, code)

  fun check_range(i:int, signed, pos_limit) =
    if signed then
	(i >= 0 andalso i < pos_limit) orelse
	(i < 0 andalso i >= ~pos_limit)
    else i >= 0 andalso i < pos_limit

  fun fault_range(i, signed, pos_limit) =
    if check_range(i, signed, pos_limit) then i
    else
      (diagnostic_output 3
       (fn _ => ["fault_range called with value ",
		 Int.toString i,
		 " in positive range ",
		 Int.toString pos_limit]);
       Crash.impossible"Immediate constant out of range" )

  fun mantissa_is_zero (mantissa:string):bool =
    let
      val sz = size mantissa
      fun scan i =
      if i < sz then
	(MLWorks.String.ordof (mantissa, i) = ord #"0") andalso
	scan (i+1)
      else
	true
    in
      scan 0
    end (* mantissa_is_zero *)

  fun binary_list_to_string(done, [], _, 128) = implode (rev done)
    | binary_list_to_string(_, [], _, l) =
      Crash.impossible("Binary_list_to_string length not 8, remainder length " ^
		       Int.toString l)
    | binary_list_to_string(done, x :: xs, digit, power) =
      let
	val x = ord x - ord #"0"
      in
	if power = 1 then
	  binary_list_to_string(chr (digit + x) :: done, xs, 0, 128)
	else
	  binary_list_to_string(done, xs, digit + x * power, power div 2)
      end

  fun to_binary(digits, value) =
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

  fun n_zeroes(done, 0) = done
    | n_zeroes(done, n) = n_zeroes(#"0" :: done, n-1)

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
	  if exponent < ~bits then (implode (n_zeroes([], bits)), 0)
	  else
	    (implode (n_zeroes([], abs exponent)) ^ mantissa, 0)

  fun to_single_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 127
      val (mantissa, real_exponent) = adjust args (mantissa, real_exponent, 255, 23)
      val binary_list =
	(if sign then #"1" else #"0") ::
	   to_binary(8, real_exponent) @
	   explode(substring (* could raise Substring *) (mantissa, 1, 23))
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
	   explode(substring(mantissa, 1, 52))
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
	   n_zeroes([], 16) @
	   explode(substring(mantissa, 0, 64)) @
	   n_zeroes([], 32)	
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun value_cg(i, MirTypes.SCON (Ident.STRING x),_) = Code_Module.STRING(i, x)
    | value_cg(i, MirTypes.SCON (Ident.REAL(x,location)),error_info) =
      (let
	 val the_real = Reals.evaluate_real x
	 val (sign, mantissa, exponent) = Reals.find_real_components the_real
	 val encoding_function =
           case I386Types.fp_used of
             I386Types.single => to_single_string (error_info,x,location)
           | I386Types.double => to_double_string (error_info,x,location)
           | I386Types.extended => to_extended_string (error_info,x,location)
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

  type half_op = I386_Assembly.opcode * MirTypes.tag option
  type half_op_block = MirTypes.tag * half_op list
  (* A half compiled form with unresolved branches *)

  val absent = NONE

  val full_nop = (I386_Assembly.nop_code, absent, "padding nop")

  val no_tag_full_nop = (I386_Assembly.nop_code, "padding nop")

  (* A function to return the terminating branch of a block if one exists *)
  fun last_opcode [] = (I386_Assembly.no_op, false)
    | last_opcode [elem as (I386_Assembly.OPCODE(I386_Assembly.jmp, _),
                            _, _)] =
      (elem, true)
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

  fun rev_app([], acc) = acc
    | rev_app(x :: xs, acc) = rev_app(xs, x :: acc)

  fun remove_trailing_branch(block_tag, opcode_list) =
    let
      val rev_opc = rev opcode_list
      val new_opc =
	case rev_opc of
	  (I386_Assembly.OPCODE(I386_Assembly.jmp, [I386_Assembly.rel32 0]), _, _) :: rest => rest
	| (I386_Assembly.OPCODE(I386_Assembly.jmp, [I386_Assembly.rel8 0]), _, _) :: rest => rest
	| opcodes as ((I386_Assembly.OPCODE(I386_Assembly.jmp, _), _, _) :: _) => opcodes
	| _ =>
	    Crash.impossible"Remove trailing branch fails"
    in
      (block_tag, rev new_opc)
    end

  (* CT this now works on the continuer and non-continuer lists in turn *)
  (* JT and now on the tails and non_continuers *)
  (* There's no point in looking through the heads, as by definition *)
  (* nothing continues into them *)

  fun find_dest_block(tag, [], [], y, z) = ((tag, []), false, y, z)
    | find_dest_block(dest_tag,
		      (block as (block_tag, opcode_list)) :: tails,
		      non_continuers,
		      tails', []) =
      if dest_tag = block_tag then
	(block, true, rev_app(tails', tails), non_continuers)
      else
	find_dest_block(dest_tag, tails, non_continuers, block :: tails', [])
    | find_dest_block(dest_tag,
		      [],
		      (block as (block_tag, opcode_list)) :: non_continuers,
		      tails', non_continuers') =
      if dest_tag = block_tag then
	(block, true, tails', rev_app(non_continuers', non_continuers))
      else
	find_dest_block(dest_tag, [], non_continuers, tails', block :: non_continuers')
    | find_dest_block _ =
      Crash.impossible "This should never happen in _mach_cg "

  fun move_first proc_tag =
    let
      fun move_sub(_, []) = Crash.impossible "move_first"
	| move_sub(L, (t, code) :: rest) =
	  if t = proc_tag then
	    (t, code) :: rev_app(L, rest)
	  else
	    move_sub ((t, code) :: L, rest)
    in
      move_sub
    end

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
    (* We would also like to ensure that short blocks on the *)
    (* normal instruction path for allocation sequences tail into the following code *)
    let
      val (proc_info, tag_tree) =
	make_proc_info((Map.empty , Map.empty), block_list)

      val proc_info_map = Map.tryApply proc_info
      val tag_tree_map = Map.tryApply tag_tree
      (* We don't have to repeatedly re-calculate the continuers lists *)

      fun do_fall_throughs_with_continuers_calculated(arg as
						      (done,
						       (block as (block_tag, opcode_list)),
						       heads,
						       tails,
						       non_continuers)) =
        let
	  val (dest_tag, found_block) =
	    Map.apply_default'(proc_info, (block_tag, false), block_tag)

	in
	  if found_block then
	    let
	      val (dest_block, found_dest, non_continuers', tails') =
		find_dest_block(dest_tag, non_continuers, tails , [], [])
	    in
	      if found_dest then
		do_fall_throughs_with_continuers_calculated
		(remove_trailing_branch block :: done,
		 dest_block, heads, tails', non_continuers')
	      else
		 do_next arg
	    end
	  else
	     do_next arg
	end

      and do_next(done, block, heads, tails, non_continuers) =
	case (heads, tails) of
	  (* CT this was rev(rev rest @ (block :: done)), but
	   rev(rev rest @ (block::done)) = rev(block::done) @ rest
	   = rev( [block] @ done) @ rest = rev done @ rev[block] @ rest
	   = rev done @ (block :: rest)
	   AND now rest = continuers @ non-continuers *)
	  ([], []) =>
	    rev_app(done, (block :: non_continuers))
	| ([], tail :: tails) =>
	    do_fall_throughs_with_continuers_calculated(block :: done,
							tail,
							[],
							tails,
							non_continuers)
	| (hd :: heads, _) =>
	    do_fall_throughs_with_continuers_calculated(block :: done,
							hd,
							heads,
							tails,
							non_continuers)

      fun do_fall_throughs(block, rest) =
	let
	  fun continues(tag, _) =
	    case proc_info_map tag of
	      SOME (_, t) => t
	    | _ => false

	  fun is_head_of_chain(tag, _) =
	    case tag_tree_map tag of
	      NONE => true
	    | _ => false

	  val (continuers,non_continuers) =
	    Lists.partition continues rest
	  val (heads, tails) =
	    Lists.partition is_head_of_chain continuers
	in
	  do_fall_throughs_with_continuers_calculated([], block, heads, tails, non_continuers)
	end

      val (hd_block_list, tl_block_list) = case move_first proc_tag ([], block_list) of
	x :: y => (x, y)
      | _ => Crash.impossible"Empty block list"
    in
      (proc_tag,
       case tl_block_list of
	 [] => [hd_block_list]
       | _ =>
	   do_fall_throughs(hd_block_list, tl_block_list))
    end

  fun opcode_list_size opcode_list =
    Lists.reducel
    (fn (x, (opcode, _, _)) => x + I386_Assembly.opcode_size opcode)
    (0, opcode_list)

  fun double_align n = ((n+7) div 8) * 8

  fun tag_offsets([], offset, tag_env) = (offset, tag_env)
    | tag_offsets((tag, ho_list) :: rest, disp, tag_env) =
      tag_offsets(rest, disp + opcode_list_size ho_list,
		  Map.define (tag_env, tag, disp))


  fun tag_offsets_for_list(_, [], env) = env
    | tag_offsets_for_list(offset, (_, proc) :: rest, env) =
      let
	val (next_offset, env) = tag_offsets(proc, offset, env)
	val next_offset' =
	  double_align(next_offset) + 4 (* Back-pointer *) +
	  4 (* Procedure number within set *)
      in
	tag_offsets_for_list(next_offset', rest, env)
      end

  fun do_offsets(start, done, []) = (rev done, start)
    | do_offsets(start, done, (opcode as (opc, _, _)) :: rest) =
      let
	val next = start + I386_Assembly.opcode_size opc
      in
	do_offsets(next, (opcode, next) :: done, rest)
      end

  val ref_redo = ref false

  fun rev_map f arg =
    let
      fun map_sub([], acc) = acc
	| map_sub(x :: xs, acc) = map_sub(xs, f x :: acc)
    in
      map_sub arg
    end

  fun rev_app([], y) = y
    | rev_app(x :: xs, y) = rev_app(xs, x :: y)

  fun copy_n(n, from, acc, new_tail) =
    if n < 0 then
      Crash.impossible"copy_n negative arg"
    else
      if n = 0 then
	rev_app(acc, new_tail)
      else
	case from of
	  (x :: xs) =>
	    copy_n(n-1, xs, x :: acc, new_tail)
	| _ => Crash.impossible"copy_n short list"

  fun drop(n, the_list) =
    if n < 0 then
      Crash.impossible"drop negative arg"
    else
      if n = 0 then the_list
      else
	case the_list of
	  [] => Crash.impossible"drop bad list"
	| _ :: rest => drop(n-1, rest)

  fun short_range i = i <= 127 andalso i >= ~128

  fun linearise_list proc_list =
    let
      val new_proc_list =
	Timer.xtime
	("reordering blocks", !do_timings,
	 fn () => map reorder_blocks proc_list)

      (* We'd now like to reschedule any small blocks that branch backwards *)

      fun do_linearise proc_list =
	let
	  fun linearise_check tag_env =
	    let
	      fun lookup_env tag = Map.tryApply'(tag_env,tag)

	      fun linearise_proc_check(_, offset, [], done, redo) = (offset, rev done, redo)
		| linearise_proc_check(proc_offset, start,
				       blocks as ((block as (block_tag, _)) :: block_list),
				       done, redo) =
		  let
		    val _ = ref_redo := redo

		    fun do_block(block_start, (block_tag, opcode_list)) =
		      let
			fun do_opcode(full_opcode as
				      (opcode as
				       I386_Assembly.OPCODE(opc as I386_Assembly.jcc _,
							    [I386_Assembly.rel8 i]),
				       tag_opt as SOME tag, comment), offset) =
			  (case lookup_env tag of
			     SOME res =>
			       let
				 val disp = res + i - offset
			       (* Calculate relative to next instruction *)
			       in
				 if short_range disp then
				   full_opcode
				 else
				   (ref_redo := true;
				    (I386_Assembly.OPCODE(opc, [I386_Assembly.rel32 i]),
				     tag_opt, comment))
			       end
			   | NONE =>
			       Crash.impossible("Assoc do_opcode:" ^
						I386_Assembly.print_mnemonic opc))
			
			  | do_opcode(full_opcode as
				      (opcode as
				       I386_Assembly.OPCODE(opc as I386_Assembly.jmp,
							    [I386_Assembly.rel8 i]),
				       tag_opt as SOME tag, comment), offset) =
			     (case lookup_env tag of
			       SOME res =>
				 let
				   val disp = res + i - offset
				 (* Calculate relative to next instruction *)
				 in
				   if short_range disp then
				     full_opcode
				   else
				     (ref_redo := true;
				      (I386_Assembly.OPCODE(opc, [I386_Assembly.rel32 i]),
				       tag_opt, comment))
				 end
			     | NONE =>
				 Crash.impossible("Assoc do_opcode:" ^
						  I386_Assembly.print_mnemonic opc))

			  | do_opcode(full_opcode, offset) = full_opcode

			val (opcodes_and_offsets, next) =
			  do_offsets(block_start, [], opcode_list)
		      in
			(rev_map do_opcode (opcodes_and_offsets, []), next)
		      end
		    val (so_far, next) = do_block(start, block)
		  in
		    linearise_proc_check(proc_offset, next, block_list,
					 (block_tag, rev so_far) :: done, !ref_redo)
		  end
	    in
	      linearise_proc_check
	    end

	  fun do_linearise_check(_, _, [], result, redo) = (rev result, redo)
	    | do_linearise_check(tag_env, offset, (tag, proc) :: rest, result, redo) =
	      let
		val (offset', done', redo') =
		  linearise_check tag_env (offset, offset, proc, [], redo)
		val offset'' =
		  double_align offset' +
		  4 (* Back-pointer *) +
		  4 (* Procedure number within set *)
	      in
		do_linearise_check(tag_env, offset'', rest, (tag, done') :: result,
				   redo')
	      end

	  fun shrink_branches proc_list =
	    let
	      val tag_env = tag_offsets_for_list(0, proc_list, Map.empty)
	      val _ = diagnostic_output 3 (fn _ => ["Tag_env ="])
	      val _ =
		diagnostic_output 3
		(fn _ => (app
			  (fn (x, y) => ignore(Print.print("Tag " ^ MirTypes.print_tag x ^ ", value " ^ Int.toString y ^ "\n")))
			  (Map.to_list tag_env) ;
			  [] ))
	      val (new_list, redo) = do_linearise_check(tag_env, 0, proc_list, [], false)
	    in
	      if redo then
		((*output(std_out, "Recursively shrinking branches\n");*)
		 shrink_branches new_list)
	      else
		proc_list
	    end

	  val proc_list = shrink_branches proc_list
	  val tag_env = tag_offsets_for_list(0, proc_list, Map.empty)

	  val _ = diagnostic_output 3 (fn _ => ["Tag_env ="])
	  val _ =
	    diagnostic_output 3
	    (fn _ => (app
	     (fn (x, y) => ignore(Print.print("Tag " ^ MirTypes.print_tag x ^ ", value " ^ Int.toString y ^ "\n")))
		      (Map.to_list tag_env) ;
		      [] ))

	  fun lookup_env tag = Map.tryApply'(tag_env,tag)

	  fun linearise_proc(_, offset, [], done) = (offset, rev done)
	    | linearise_proc(proc_offset, start, blocks as (block :: block_list), done) =
	      let
		(* Insert algorithm for optimal linearisation of blocks here *)
		(* Present algorithm just uses the current order *)
		fun do_block(block_start, (block_tag, opcode_list), done) =
		  let
		    fun do_opcodes([], res) = res
		      | do_opcodes(opcode_and_offset :: rest, done) =
		      case opcode_and_offset of
			((opcode as
				   I386_Assembly.OPCODE(opc as I386_Assembly.jcc _,
							[I386_Assembly.rel32 i]),
				   SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				(* Calculate relative to next instruction *)
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel32 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.jcc _,
					       [I386_Assembly.rel8 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				  (* Calculate relative to next instruction *)
				  val _ =
				    if disp > 127 orelse disp < ~128 then
				      Crash.impossible
				      ("Short branch of " ^
				       Int.toString disp ^ " out of range in " ^
				       I386_Assembly.print_mnemonic opc ^ " " ^
				       MirTypes.print_tag tag ^
				       " in block with tag " ^
				       MirTypes.print_tag block_tag ^
				       ", disp = " ^
				       Int.toString disp ^
				       " res = " ^
				       Int.toString res ^
				       " i = " ^
				       Int.toString i ^
				       " offset " ^
				       Int.toString offset)
				    else
				      ()
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel8 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.jcc _,
					       [I386_Assembly.fix_rel32 i]),
			  SOME tag, comment), offset) =>
			Crash.impossible"i386_cg: jcc fix_rel32 encountered"
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.jmp,
					       [I386_Assembly.rel32 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				(* Calculate relative to next instruction *)
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel32 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.jmp,
					       [I386_Assembly.fix_rel32 i]),
			  SOME tag, comment), offset) =>
			(case lookup_env tag of
			   NONE =>
			     Crash.impossible("Assoc do_opcode:" ^
					      I386_Assembly.print_mnemonic opc)
			 | SOME res =>
			     let
			       val disp = res + i - offset
			       val jmp =
				 (I386_Assembly.OPCODE(I386_Assembly.jmp,
						       [I386_Assembly.fix_rel32 disp]),
				  comment)
			       val opcodes = jmp :: done
			       (* Calculate relative to next instruction *)
			       (* Now for the tricky part, putting in the align directives *)
			       (* We have to allow for the fact that gas may shorten *)
			       (* one of these jmps which we want to be full size *)
			       (* So we add an align statement to force the code out *)
			       (* to the correct size *)
			       (* Unfortunately, gas is defective in that it doesn't *)
			       (* have a fully functional align directive *)
			       (* ie allign to offset from boundary *)
			       (* So we place the align amongst the nops following the nop *)
			       (* which should produce the correct alignment if the *)
			       (* were not shortened. So if gas gets the instruction right *)
			       (* the align has no effect, whereas if it gets it wrong *)
			       (* the align forces the padding to be inserted *)
			       val new_arg =
				 case rest of
				   ((I386_Assembly.OPCODE(I386_Assembly.nop, []), _, _), _) ::
				   ((I386_Assembly.OPCODE(I386_Assembly.nop, []), _, _), _) ::
				   ((I386_Assembly.OPCODE(I386_Assembly.nop, []), _, _), _) ::
				   rest' =>
				     let
				       val align_val = if (offset-5) mod 8 < 4 then 8 else 4
				       val align = (offset-5) mod 4
				       nonfix before
				       val (before, after) = (3 - align, align)
				       val align_dir =
					 (I386_Assembly.OPCODE
					  (I386_Assembly.align,
					   [I386_Assembly.r_m32
					    (I386_Assembly.INR
					     (I386_Assembly.MEM
					      {base=NONE, index=NONE,
					       offset=SOME(I386_Assembly.SMALL align_val)}))]),
					     "ensure correct alignment")
				       fun insert_nops(i, opcodes) =
					 if i <= 0 then
					   opcodes
					 else
					   insert_nops(i-1, no_tag_full_nop :: opcodes)
				       val opcodes = insert_nops(before, opcodes)
				       val opcodes = insert_nops(after, align_dir :: opcodes)
				     in
				       (rest', opcodes)
				     end
				 | _ => (* Last in list, no worries *)
				     (rest, opcodes)
			     in
			       do_opcodes new_arg
			     end)
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.jmp,
					       [I386_Assembly.rel8 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				  (* Calculate relative to next instruction *)
				  val _ =
				    if disp > 127 orelse disp < ~128 then
				      Crash.impossible
				      ("Short branch of " ^
				       Int.toString disp ^ " out of range in " ^
				       I386_Assembly.print_mnemonic opc ^ " " ^
				       MirTypes.print_tag tag ^
				       " in block with tag " ^
				       MirTypes.print_tag block_tag ^
				       ", disp = " ^
				       Int.toString disp ^
				       " res = " ^
				       Int.toString res ^
				       " i = " ^
				       Int.toString i ^
				       " offset " ^
				       Int.toString offset)
				    else
				      ()
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel8 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.loop,
					       [I386_Assembly.rel8 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				  (* Calculate relative to next instruction *)
				  val _ =
				    if disp > 127 orelse disp < ~128 then
				      Crash.impossible
				      ("Short branch of " ^
				       Int.toString disp ^ " out of range in " ^
				       I386_Assembly.print_mnemonic opc ^ " " ^
				       MirTypes.print_tag tag ^
				       " in block with tag " ^
				       MirTypes.print_tag block_tag ^
				       ", disp = " ^
				       Int.toString disp ^
				       " res = " ^
				       Int.toString res ^
				       " i = " ^
				       Int.toString i ^
				       " offset " ^
				       Int.toString offset)
				    else
				      ()
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel8 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.loopz,
					       [I386_Assembly.rel8 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				  (* Calculate relative to next instruction *)
				  val _ =
				    if disp > 127 orelse disp < ~128 then
				      Crash.impossible
				      ("Short branch of " ^
				       Int.toString disp ^ " out of range in " ^
				       I386_Assembly.print_mnemonic opc ^ " " ^
				       MirTypes.print_tag tag ^
				       " in block with tag " ^
				       MirTypes.print_tag block_tag ^
				       ", disp = " ^
				       Int.toString disp ^
				       " res = " ^
				       Int.toString res ^
				       " i = " ^
				       Int.toString i ^
				       " offset " ^
				       Int.toString offset)
				    else
				      ()
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel8 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.loopnz,
					       [I386_Assembly.rel8 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				  (* Calculate relative to next instruction *)
				  val _ =
				    if disp > 127 orelse disp < ~128 then
				      Crash.impossible
				      ("Short branch of " ^
				       Int.toString disp ^ " out of range in " ^
				       I386_Assembly.print_mnemonic opc ^ " " ^
				       MirTypes.print_tag tag ^
				       " in block with tag " ^
				       MirTypes.print_tag block_tag ^
				       ", disp = " ^
				       Int.toString disp ^
				       " res = " ^
				       Int.toString res ^
				       " i = " ^
				       Int.toString i ^
				       " offset " ^
				       Int.toString offset)
				    else
				      ()
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel8 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.call,
					       [I386_Assembly.rel32 i]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = res + i - offset
				(* Calculate relative to next instruction *)
				in
				  (I386_Assembly.OPCODE(opc, [I386_Assembly.rel32 disp]),
				   comment)
				end
			    | NONE =>
				Crash.impossible("Assoc do_opcode:" ^
						 I386_Assembly.print_mnemonic opc)
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode as
			  I386_Assembly.OPCODE(opc as I386_Assembly.mov,
					       [rd, I386_Assembly.imm32(i, j)]),
			  SOME tag, comment), offset) =>
			let
			  val opcode =
			    case lookup_env tag of
			      SOME res =>
				let
				  val disp = (res + 4*i + j) - proc_offset
				(* Must work relative to start of current proc in set *)
				in
				  (I386_Assembly.OPCODE
				   (opc, [rd, I386_Assembly.imm32(disp div 4, disp mod 4)]),
				   comment)
				end
			    | NONE => Crash.impossible "Assoc do_opcode: LEO"
			in
			  do_opcodes(rest, opcode :: done)
			end
		      | ((opcode, NONE, comment), offset) =>
			do_opcodes(rest, (opcode, comment) :: done)
		      |  _ => Crash.impossible"Bad tagged instruction"

		    val (opcodes_and_offsets, next) =
		      do_offsets(block_start, [], opcode_list)
		  in
		    (do_opcodes (opcodes_and_offsets, done), next)
		  end
		val (so_far, next) = do_block(start, block, done)
	      in
		linearise_proc(proc_offset, next, block_list, so_far)
	      end

	  fun do_linearise_sub(_, []) = []
	    | do_linearise_sub(offset, (tag, proc) :: rest) =
	      let
		val (offset', done') =
		  linearise_proc(offset, offset, proc, [])
		val offset'' =
		  double_align offset' +
		  4 (* Back-pointer *) +
		  4 (* Procedure number within set *)
	      in
		(tag, done') :: do_linearise_sub(offset'', rest)
	      end

	in
	  do_linearise_sub(0, proc_list)
	end
    in
      do_linearise new_proc_list
    end

  fun is_reg(MirTypes.GP_GC_REG reg) = true
    | is_reg(MirTypes.GP_NON_GC_REG reg) = true
    | is_reg _ = false

  fun move_reg(rd, rs, comment) =
    (I386_Assembly.OPCODE
     (I386_Assembly.mov,
      [I386_Assembly.r32 rd,
       I386_Assembly.r_m32(I386_Assembly.INL rs)]), absent, comment)

  fun move_reg_zx(rd, rs, comment) =
    (I386_Assembly.OPCODE
     (I386_Assembly.movzx,
      [I386_Assembly.r32 rd,
       I386_Assembly.r_m8(I386_Assembly.INL rs)]), absent, comment)

  fun move_imm(rd, imm, comment) =
    (I386_Assembly.OPCODE
     (I386_Assembly.mov,
      [I386_Assembly.r32 rd,
       I386_Assembly.imm32(imm div 4, imm mod 4)]), absent, comment)

  fun gp_from_reg(MirTypes.GC_REG reg) = MirTypes.GP_GC_REG reg
    | gp_from_reg(MirTypes.NON_GC_REG reg) = MirTypes.GP_NON_GC_REG reg

  datatype proc_stack =
    PROC_STACK of
    {non_gc_spill_size     : int, (* In words *)
     fp_spill_size         : int, (* In singles, doubles or extendeds as appropriate *)
     fp_save_size          : int, (* As for non_fp_spill_size *)
     gc_spill_size         : int, (* In words *)
     gc_stack_alloc_size   : int, (* In words *)
     register_save_size    : int, (* In bytes *)
     non_gc_spill_offset   : int, (* In bytes *)
     fp_spill_offset       : int, (* In bytes *)
     fp_save_offset        : int, (* In bytes*)
     gc_spill_offset       : int, (* In bytes *)
     gc_stack_alloc_offset : int, (* In bytes *)
     register_save_offset  : int, (* In bytes *)
     allow_fp_spare_slot   : bool, (* Do we need a slot for float to int conversion? *)
     float_value_size      : int,  (* Number of bytes per float value *)
     old_spill_sizes	   : {gc : int, non_gc : int, fp : int}
     }

  fun mach_cg
    error_info
    (Options.OPTIONS {compiler_options =
                      Options.COMPILEROPTIONS
		      {generate_debug_info, debug_variables, generate_moduler, opt_leaf_fns, intercept, ...},
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
      val gc_array = MLWorks.Internal.Array.array(gc, MachSpec.global)
      val _ =
	MirTypes.GC.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(gc_array, MirTypes.GC.unpack mir_reg, reg))
	gc_map
      val non_gc_array = MLWorks.Internal.Array.array(non_gc, MachSpec.global)
      val _ =
	MirTypes.NonGC.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(non_gc_array, MirTypes.NonGC.unpack mir_reg, reg))
	non_gc_map
      val fp_array = MLWorks.Internal.Array.array(fp, MachSpec.global)
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

      exception bad_spill of string

      fun get_frame_size(register_save_offset, register_save_size, needs_preserve) =
	if needs_preserve then
	  register_save_offset - frame_offset + register_save_size
	else
	  frame_offset

      fun symb_value(PROC_STACK
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
		      float_value_size,
		      old_spill_sizes
		      },
		     frame_size) =
	let
	  fun symbolic_value MirTypes.GC_SPILL_SIZE = gc_spill_size * 4
	    | symbolic_value MirTypes.NON_GC_SPILL_SIZE = non_gc_spill_size * 4
	    | symbolic_value(MirTypes.GC_SPILL_SLOT i) =
	      let
		fun symbolic_value i =
		  (if i >= gc_spill_size then
		     raise bad_spill
		     ("Spill slot " ^ Int.toString i ^
		      " requested, but only " ^ Int.toString gc_spill_size ^
		      " allocated\n")
		   else
		     ();
		   frame_size - (gc_spill_offset + 4 * (1 + i))
                   )
	      in
		case i of
		  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1(i)),name) =>
		    let
		      val value = symbolic_value i
		    in
		      spill := RuntimeEnv.OFFSET2(RuntimeEnv.GC, value);
		      value
		    end
		  | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) => i
		  | MirTypes.SIMPLE(i) => symbolic_value i
	      end
	    | symbolic_value(MirTypes.NON_GC_SPILL_SLOT i) =
	      let
		fun symbolic_value i =
                  (if i >= non_gc_spill_size then
		     raise bad_spill ("non gc spill slot " ^ Int.toString i ^
				      " requested, but only " ^
				      Int.toString non_gc_spill_size ^
				      " allocated\n")
                   else ();
                   frame_size - (non_gc_spill_offset + 4 * (1 + i))
                   )
	      in
		case i of
		  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1(i)),name) =>
		    let
		      val value = symbolic_value i
		    in
		      spill := RuntimeEnv.OFFSET2(RuntimeEnv.NONGC, value);
		      value
		     end
		  | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) => i
		  | MirTypes.SIMPLE(i) => symbolic_value i
	      end
	    | symbolic_value(MirTypes.FP_SPILL_SLOT i) =
	      let
		fun symbolic_value i =
                  (if i >= fp_spill_size then
                     raise bad_spill ("fp spill slot " ^ Int.toString i ^
                                      " requested, but only " ^
                                      Int.toString fp_spill_size ^
                                      " allocated\n")
                   else ();
                   frame_size - (fp_spill_offset + float_value_size * (1 + i)))
	      in
		case i of
		  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1(i)),name) =>
		    let
		      val value = symbolic_value i
		    in
		      spill := RuntimeEnv.OFFSET2(RuntimeEnv.FP, value);
		      value
		    end
		  | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) => i
		  | MirTypes.SIMPLE(i) => symbolic_value i
	      end
	in
	  symbolic_value
	end

      (* utility functions for enter *)
      local
	fun store_seq'(size, so_far) =
	  if size < 0 then
	    so_far
	  else
	    if size = 0 then
	      (I386_Assembly.OPCODE
	       (I386_Assembly.xor,
		[I386_Assembly.r32 I386Types.global,
		 I386_Assembly.r_m32(I386_Assembly.INL I386Types.global)]),
	       absent, "clear global prior to storing") ::
	      (I386_Assembly.OPCODE
	       (I386_Assembly.push,
		[I386_Assembly.r32 I386Types.global]),
	       absent, "initialise one stack slot") :: so_far
	    else
	      store_seq'(size-1,
			(I386_Assembly.OPCODE
			 (I386_Assembly.push,
			  [I386_Assembly.r32 I386Types.global]),
			 absent, "initialise one stack slot") :: so_far)
      in
	(* Initialise those parts of the stack that will be scanned by the gc *)
	(* The parameters are the number of slots to initialise -1 *)
        (* and the continuation jmp *)
	(* Initialising 1 or 2 slots is done by push immediate *)
	(* Initialising between 3 and 9 slots is done by clearing ecx and pushing it *)
	(* Initialising more than 9 slots is done by another piece of code entirely *)
	(* The driving force behind this is code size *)
	(* In the cases where this fails to determine which sequence *)
	(* we should use, speed of operation is used *)
	fun store_seq(0, so_far) =
	  (I386_Assembly.OPCODE
	   (I386_Assembly.push,
	    [I386_Assembly.imm8 0]),
	   absent, "initialise one stack slot") :: so_far
	  | store_seq(1, so_far) =
	  store_seq(0,
		    (I386_Assembly.OPCODE
		     (I386_Assembly.push,
		      [I386_Assembly.imm8 0]),
		     absent, "initialise one stack slot") :: so_far)
	  | store_seq x = store_seq' x
      end
      fun store_loop(loop_tag, size) =
	((I386_Assembly.OPCODE
	  (I386_Assembly.xor,
	   [I386_Assembly.r32 I386Types.global,
	    I386_Assembly.r_m32(I386_Assembly.INL I386Types.global)]),
	  absent, "clear ecx, set zero flag") ::
	 (I386_Assembly.OPCODE
	  (I386_Assembly.add,
	   [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global),
	    if size <= 127 then
	      I386_Assembly.imm8 size
	    else
	      I386_Assembly.imm32(size div 4, size mod 4)]),
	  absent, "initialise counter, zero false") ::
	 (I386_Assembly.OPCODE
	  (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
	  SOME loop_tag, "enter at head of initialisation loop") :: [],
	 (I386_Assembly.OPCODE
	  (I386_Assembly.push, [I386_Assembly.imm8 0]),
	  absent, "clear one stack slot") ::
	 (I386_Assembly.OPCODE
	  (I386_Assembly.loop, [I386_Assembly.rel8 0]),
	  SOME loop_tag, "loop if not finished") :: []
	 )

      fun get_binary_op MirTypes.ADDU = (I386_Assembly.add, false)
	| get_binary_op MirTypes.SUBU = (I386_Assembly.sub, false)
	| get_binary_op MirTypes.MULU = Crash.unimplemented"MirTypes.MULU"
	| get_binary_op MirTypes.MUL32U = Crash.unimplemented"MirTypes.MUL32U"
	| get_binary_op MirTypes.AND = (I386_Assembly.and_op, false)
	| get_binary_op MirTypes.OR = (I386_Assembly.or, false)
	| get_binary_op MirTypes.EOR = (I386_Assembly.xor, false)
	| get_binary_op MirTypes.LSR = (I386_Assembly.shr, true)
	| get_binary_op MirTypes.ASL = (I386_Assembly.sal, true)
	| get_binary_op MirTypes.ASR = (I386_Assembly.sar, true)

      fun do_blocks(_, [], _, _, _, _, _) = []
      | do_blocks(needs_preserve, MirTypes.BLOCK(tag,opcodes) :: rest,
		  stack_layout as PROC_STACK
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
		   float_value_size,
		   old_spill_sizes =
		   {gc=gc_spill_start_offset,
		    non_gc=non_gc_spill_start_offset,
		    fp=fp_spill_start_offset}
		   },
		  fps_to_preserve,
		  gcs_to_preserve,
		  (stack_parms, (* Number of parameters on the stack when called *)
		   max_tail_size, (* The maximum number of tail parameters from this fn *)
		   max_args), (* The maximum space required *)
		  procedure_name
		  ) =
	let
	  val parm_space_above_ret = max_args * 4
	  val frame_size = get_frame_size(register_save_size, register_save_offset, needs_preserve)

          (* Save fp registers -- we don't have any of these just yet *)
	  fun do_save_fp_instrs(_, []) = []
	    | do_save_fp_instrs(offset, fp :: rest) =
	      Crash.impossible"do_save_fp_instrs"

	  fun do_restore_fp_instrs(_, []) = []
	    | do_restore_fp_instrs(offset, fp :: rest) =
	      Crash.impossible"do_restore_fp_instrs"

	  fun do_save_gcs([], done) = done
	    | do_save_gcs(gc :: rest, done) =
	      do_save_gcs(rest, (I386_Assembly.OPCODE
				 (I386_Assembly.push, [I386_Assembly.r32 gc]),
				 NONE,
				 "save gcs") :: done)

	  fun do_restore_gcs([], done) = rev done
	    | do_restore_gcs(gc :: rest, done) =
	      do_restore_gcs
	      (rest, (I386_Assembly.OPCODE
		      (I386_Assembly.pop, [I386_Assembly.r32 gc]), NONE,
		      "restore gcs") :: done)

	  fun do_restore_gcs_from_offset([], offset, done) = done
	    | do_restore_gcs_from_offset(gc :: rest, offset, done) =
	      do_restore_gcs_from_offset
	      (rest, offset+4,
	       (I386_Assembly.OPCODE
		(I386_Assembly.mov,
		 [I386_Assembly.r32 gc,
		  I386_Assembly.r_m32
		  (I386_Assembly.INR
		   (I386_Assembly.MEM
		    {base=SOME I386Types.sp,
		     index=absent,
		     offset=SOME(I386_Assembly.SMALL offset)}))]), NONE,
		"restore gcs") :: done)

          (* Save the callee saves and the argument if we are debugging *)

	  val do_save_gcs = fn x =>
            let
              val regs = do_save_gcs (x,[])
            in
              if save_arg_for_debugging then
                (I386_Assembly.OPCODE
                 (I386_Assembly.push, [I386_Assembly.r32 I386Types.caller_arg]),
                 NONE,
                 "save arg for debugging") :: regs
              else regs
            end

          (* The number of bytes to pop above the callee save registers *)
          (* If we have saved the arg, have an extra 4 bytes in frame *)
          val frame_left = frame_size - register_save_size +
            (if save_arg_for_debugging then 4 else 0)

	  val do_restore_gcs = fn x => do_restore_gcs(x, [])

	  val fp_save_start = gc_spill_offset
	  val save_fps = do_save_fp_instrs(~fp_save_start, fps_to_preserve)

	  val restore_fps = do_restore_fp_instrs(~fp_save_start, fps_to_preserve)

	  val save_gcs = do_save_gcs gcs_to_preserve

	  val restore_gcs = do_restore_gcs gcs_to_preserve
	
	  fun is_comment(MirTypes.COMMENT _) = true
	    | is_comment _ = false

	  fun is_load MirTypes.LD = (true)
	    | is_load MirTypes.ST = false
	    | is_load MirTypes.LDB = true
	    | is_load MirTypes.STB = false
	    | is_load MirTypes.LDREF = true
	    | is_load MirTypes.STREF = false

	  fun lookup_reg(reg, table) =
	    let
	      val mach_reg = MLWorks.Internal.Array.sub(table, reg)
	    in
	      if needs_preserve orelse
		reg <> MirTypes.GC.unpack MirRegisters.callee_closure then
		mach_reg
	      else
		I386Types.caller_closure
	    end

	  fun reg_from_gp(MirTypes.GP_GC_REG reg) = reg
	    | reg_from_gp _ = Crash.impossible"reg_from_gp: not reg"

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

	  fun looked_up_gc_reg_is_arg I386Types.i_arg1 = true
	    | looked_up_gc_reg_is_arg I386Types.i_arg2 = true
	    | looked_up_gc_reg_is_arg I386Types.i_arg3 = true
	    | looked_up_gc_reg_is_arg I386Types.i_arg4 = true
	    | looked_up_gc_reg_is_arg I386Types.i_arg5 = true
	    | looked_up_gc_reg_is_arg I386Types.i_arg6 = true
	    | looked_up_gc_reg_is_arg I386Types.i_arg7 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg1 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg2 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg3 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg4 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg5 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg6 = true
	    | looked_up_gc_reg_is_arg I386Types.o_arg7 = true
	    | looked_up_gc_reg_is_arg _ = false

	  fun looked_up_gc_reg_input_value I386Types.i_arg1 = ~1
	    | looked_up_gc_reg_input_value I386Types.i_arg2 = ~2
	    | looked_up_gc_reg_input_value I386Types.i_arg3 = ~3
	    | looked_up_gc_reg_input_value I386Types.i_arg4 = ~4
	    | looked_up_gc_reg_input_value I386Types.i_arg5 = ~5
	    | looked_up_gc_reg_input_value I386Types.i_arg6 = ~6
	    | looked_up_gc_reg_input_value I386Types.i_arg7 = ~7
	    | looked_up_gc_reg_input_value _ =
	    Crash.impossible"looked_up_gc_reg_input_value:not i_arg"

	  fun looked_up_gc_reg_output_value I386Types.o_arg1 = ~1
	    | looked_up_gc_reg_output_value I386Types.o_arg2 = ~2
	    | looked_up_gc_reg_output_value I386Types.o_arg3 = ~3
	    | looked_up_gc_reg_output_value I386Types.o_arg4 = ~4
	    | looked_up_gc_reg_output_value I386Types.o_arg5 = ~5
	    | looked_up_gc_reg_output_value I386Types.o_arg6 = ~6
	    | looked_up_gc_reg_output_value I386Types.o_arg7 = ~7
	    | looked_up_gc_reg_output_value _ =
	    Crash.impossible"looked_up_gc_reg_output_value:not i_arg"

	  fun non_spill_gc_reg_is_arg reg =
	    looked_up_gc_reg_is_arg(lookup_reg(reg, gc_array))

	  fun gc_reg_is_arg' reg = non_spill_gc_reg_is_arg reg

	  fun gc_reg_is_arg reg =
	    reg < #gc(MirRegisters.pack_next) andalso
	    gc_reg_is_arg' reg

	  fun gc_reg_is_spill reg =
	    let
	      val reg = MirTypes.GC.unpack reg
	    in
	      reg >= #gc(MirRegisters.pack_next) orelse
	      gc_reg_is_arg' reg
	    end

	  fun reg_operand_is_spill(MirTypes.GC_REG reg) =
	    gc_reg_is_spill reg
	    | reg_operand_is_spill _ = false

	  fun gp_operand_is_spill(MirTypes.GP_GC_REG reg) =
	    gc_reg_is_spill reg
	    | gp_operand_is_spill _ = false

	  fun lookup_fp_operand(MirTypes.FP_REG reg) =
	    MLWorks.Internal.Array.sub(fp_array, MirTypes.FP.unpack reg)

	  fun fp_operand_is_spill(MirTypes.FP_REG reg) =
	    MirTypes.FP.unpack reg >= #fp(MirRegisters.pack_next)

	  val symbolic_value = symb_value(stack_layout, frame_size)

	  val doing_move = ref false

	  fun do_everything
	    (_, tag, [], stack_drop, param_slots, done, [], final_result, _) =
	    let
	      val _ =
		if stack_drop = 0 andalso param_slots = 0 then
		  ()
		else
		  Crash.impossible("stack_drop or param_slots not zero at block end in " ^ procedure_name)
	    in
	      (tag, contract_sexpr done) :: final_result
	    end
	  | do_everything
	    (needs_preserve, tag, [], stack_drop, param_slots, done,
	     MirTypes.BLOCK(tag',opcodes) :: blocks,
	     final_result, stack_drop_ok) =
	    let
	      val _ =
		if stack_drop_ok orelse
		  (stack_drop = 0 andalso param_slots = 0) then
		  ()
		else
		  Crash.impossible("stack_drop or param_slots not zero at block end" ^ procedure_name)
	    in
	      do_everything
	      (needs_preserve, tag', Lists.filter_outp is_comment opcodes, stack_drop, param_slots, Sexpr.NIL,
	       blocks, (tag, contract_sexpr done) :: final_result, stack_drop_ok)
	    end

	  | do_everything
	    (needs_preserve, tag, opcode :: opcode_list, stack_drop, param_slots, done,
	     block_list, final_result, _) =
	    let
(*
	      val _ = print(MirPrint.opcode opcode ^ "\n")
*)
	      val symbolic_value =
		fn x => stack_drop + param_slots + symbolic_value x

	      fun assemble_imm32(MirTypes.GP_IMM_INT i) = (i, 0)
		| assemble_imm32(MirTypes.GP_IMM_ANY i) = (i div 4, i mod 4)
		| assemble_imm32(MirTypes.GP_IMM_SYMB symb) =
		  let
		    val i = symbolic_value symb
		  in
		    (i div 4, i mod 4)
		  end
		| assemble_imm32 _ =
		  Crash.impossible"assemble_imm32:non-immediate"

	      fun assemble_sized_gp_imm gp_imm =
		let
		  val (i, j) = assemble_imm32 gp_imm
		in
		  if i <= 31 andalso i >= ~32 then
		    I386_Assembly.imm8(4*i+j)
		  else
		    I386_Assembly.imm32(i, j)
		end

	      fun assemble_large_offset gp_operand =
		let
		  val (i, j) = assemble_imm32 gp_operand
		in
		  if i <= 134217727 andalso i >= ~134217728 then
		    I386_Assembly.SMALL(4*i+j)
		  else
		    I386_Assembly.LARGE(i, j)
		end

	      fun gc_spill_value reg =
		let
		  val reg' = MirTypes.GC.unpack reg
		in
		  if gc_reg_is_arg reg' then
		    if Lists.member(reg, MirRegisters.callee_arg_regs) then
		      (* Lives above the return address *)
		      (frame_size + stack_drop + param_slots +
		       4*(max_args + looked_up_gc_reg_input_value
			  (lookup_reg(reg', gc_array))))
		    else
		      let
			val neg_param_slots = ~param_slots
			val offset =
			  if
			    Lists.member(reg, MirRegisters.caller_arg_regs) then
			    (looked_up_gc_reg_output_value
			     (lookup_reg(reg', gc_array)) * 4)
			  else
			    Crash.unimplemented("i386_cg:stack parameter unknown in " ^ procedure_name)
		      in
			if offset < neg_param_slots andalso
			  stack_drop <> 0 then
			  Crash.impossible"i386_cg:stack parameter generated when stack already dropped"
			else
			  if !doing_move orelse offset >= neg_param_slots then
			    (* Ok if we've already generated this parameter *)
			    offset
			  else
			    Crash.impossible("i386_cg:gc_spill_value: parameter reg found in non-move context in " ^ procedure_name)
		      end
		  else
		    symbolic_value
		    (MirTypes.GC_SPILL_SLOT
		     (MirTypes.SIMPLE(gc_spill_start_offset + reg' - #gc(MirRegisters.pack_next))))
		end

	      fun reg_spill_value(MirTypes.GC_REG reg) = gc_spill_value reg
		| reg_spill_value _ =
		Crash.impossible"reg_spill_value:bad argument"

	      fun gp_spill_value(MirTypes.GP_GC_REG reg) = gc_spill_value reg
		| gp_spill_value _ =
		Crash.impossible"gp_spill_value:bad argument"

	      fun fp_spill_value(MirTypes.FP_REG reg) =
		symbolic_value
		(MirTypes.FP_SPILL_SLOT
		 (MirTypes.SIMPLE(fp_spill_start_offset + MirTypes.FP.unpack reg - #fp(MirRegisters.pack_next))))

              (* Make a memory operand for a fp "register" *)

              fun convert_fp_operand operand =
                if fp_operand_is_spill operand
                  then
                    I386_Assembly.fp_mem
                    (I386_Assembly.MEM
                     {base=SOME I386Types.sp,
                      index=absent,
                      offset=SOME(I386_Assembly.SMALL(fp_spill_value operand))})
                else Crash.impossible "Can't do non-spill fp's yet"

	      fun reg_equals_gp(r as MirTypes.GC_REG r', s as MirTypes.GP_GC_REG s') =
(* This bit believed to be irrelevant.
		(reg_operand_is_spill r andalso gp_operand_is_spill s andalso
		 reg_spill_value r = gp_spill_value s) orelse
*)
		r' = s'
		| reg_equals_gp(MirTypes.NON_GC_REG r, MirTypes.GP_NON_GC_REG s) =
		  r = s
		| reg_equals_gp _ = false

	      fun move_gp_to_reg(rd, gp_operand, other_code) =
		let
		  val opcode = I386_Assembly.mov
		  val code_list =
		    if is_reg gp_operand then
		      (* May be spill here *)
		      if gp_operand_is_spill gp_operand then
			let
			  val spill = gp_spill_value gp_operand
			  val spill =
			    if spill < 0 then
			      if ~spill <= param_slots then
				param_slots+stack_drop+spill
			      else
				Crash.impossible"i386_cg:move_gp_to_reg: spill (parameter) out of range"
			    else
			      spill
			  val offset =
			    if spill = 0 then
			      absent
			    else
			      SOME (I386_Assembly.SMALL spill)
			in
			  (I386_Assembly.OPCODE
			   (opcode,
			    [I386_Assembly.r32 rd,
			     I386_Assembly.r_m32
			     (I386_Assembly.INR
			      (I386_Assembly.MEM
			       {base=SOME I386Types.sp,
				index=absent,
				offset=offset}))]),
			   absent, "") :: other_code
			end
		      else
			let
			  val rs1 = lookup_gp_operand gp_operand
			in
			  if rd = rs1 then
			    [] (* Null move rn -> rn *)
			  else
			    (I386_Assembly.OPCODE
			     (opcode,
			      [I386_Assembly.r32 rd,
			       I386_Assembly.r_m32
			       (I386_Assembly.INL rs1)]),
			     absent, "") :: other_code
			end
		    else
		      case assemble_imm32 gp_operand of
			(0, 0) =>
			  (I386_Assembly.OPCODE
			   (I386_Assembly.xor,
			    [I386_Assembly.r32 rd,
			     I386_Assembly.r_m32
			     (I386_Assembly.INL rd)]),
			   absent, "") :: other_code
		      | x =>
			  (I386_Assembly.OPCODE
			   (opcode,
			    [I386_Assembly.r32 rd,
			     I386_Assembly.imm32 x]),
			   absent, "") :: other_code
		in
		  code_list
		end

	      val (result_list, opcode_list, new_blocks, new_final_result,
		   new_stack_drop, new_param_slots, stack_drop_ok) =
		(case opcode of
		  MirTypes.TBINARY(tagged_binary_op, taglist, reg_operand,
				   gp_operand, gp_operand') =>
                 let
                   val tag = case taglist of [] => NONE | a::_ => SOME a
                 in
                   if reg_equals_gp(reg_operand, gp_operand) then
		    let
		      val (opcode, cleaing_operation) = case tagged_binary_op of
			MirTypes.ADDS => (I386_Assembly.add, false)
		      | MirTypes.SUBS => (I386_Assembly.sub, false)
		      | MirTypes.MULS => (I386_Assembly.imul, false)
		      | MirTypes.DIVS => Crash.impossible"do_opcodes(TBINARY(DIVS))"
		      | MirTypes.MODS => Crash.impossible"do_opcodes(TBINARY(MODS))"
		      | MirTypes.ADD32S => (I386_Assembly.add, true)
		      | MirTypes.SUB32S => (I386_Assembly.sub, true)
		      | MirTypes.MUL32S => (*I386_Assembly.imul*)Crash.impossible"do_opcodes(TBINARY(MUL32S))"
		      | MirTypes.DIV32S => Crash.impossible"do_opcodes(TBINARY(DIV32S))"
		      | MirTypes.MOD32S => Crash.impossible"do_opcodes(TBINARY(MOD32S))"
		      | MirTypes.DIVU => Crash.impossible"do_opcodes(TBINARY(DIVU))"
		      | MirTypes.MODU => Crash.impossible"do_opcodes(TBINARY(MODU))"
		      | MirTypes.DIV32U => Crash.impossible"do_opcodes(TBINARY(DIV32U))"
		      | MirTypes.MOD32U => Crash.impossible"do_opcodes(TBINARY(MOD32U))"
		    in
		      if cleaing_operation then
			(* Just recycle the operation with the exception *)
			(* tag intercepted to do the cleaing first *)
			let
			  val clean_tag = MirTypes.new_tag()
			  val regs_to_clean = case reg_operand of
			    MirTypes.GC_REG reg => [reg]
			  | _ => []
			  val regs_to_clean = case gp_operand of
			    MirTypes.GP_GC_REG reg => reg :: regs_to_clean
			  | _ => regs_to_clean
			  val regs_to_clean = case gp_operand' of
			    MirTypes.GP_GC_REG reg => reg :: regs_to_clean
			  | _ => regs_to_clean
			  val regs_to_clean = Lists.rev_remove_dups regs_to_clean
			  val regs_to_clean =
			    Lists.filterp
			    (fn reg => reg <> MirRegisters.global)
			    regs_to_clean
			  val clean_instrs =
			    map
			    (fn reg => MirTypes.NULLARY(MirTypes.CLEAN, MirTypes.GC_REG reg))
			    regs_to_clean
			  val exn_tag = case taglist of
                            [tag] => tag
			  | _ => Crash.impossible"TBINARY: missing tag"
			  val new_op = case tagged_binary_op of
			    MirTypes.ADD32S => MirTypes.ADDS
			  | MirTypes.SUB32S => MirTypes.SUBS
			  | MirTypes.MUL32S => MirTypes.MUL32S
			  | MirTypes.DIV32S => MirTypes.DIV32S
			  | MirTypes.MOD32S => MirTypes.MOD32S
			  | _ => Crash.impossible"Converting TBINARY V type"
			in
			  ([],
			   MirTypes.TBINARY
			   (new_op, [clean_tag], reg_operand,
			    gp_operand, gp_operand') :: opcode_list,
			   MirTypes.BLOCK(clean_tag, clean_instrs @ [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)]) :: block_list,
			   final_result, stack_drop, param_slots, true)
			end
		      else
		      if reg_operand_is_spill reg_operand andalso
			gp_operand_is_spill gp_operand' then
			if tagged_binary_op = MirTypes.MULS then
			  (* Restricted to result in a register for imul *)
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG MirRegisters.global,
					  gp_operand) ::
			   MirTypes.TBINARY(tagged_binary_op, taglist,
					    MirTypes.GC_REG MirRegisters.global,
					    MirTypes.GP_GC_REG MirRegisters.global,
					    gp_operand') ::
			   MirTypes.UNARY(MirTypes.MOVE,
					  reg_operand,
					  MirTypes.GP_GC_REG MirRegisters.global) ::
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
			else
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG MirRegisters.global,
					  gp_operand') ::
			   MirTypes.TBINARY(tagged_binary_op, taglist, reg_operand,
					    gp_operand,
					    MirTypes.GP_GC_REG MirRegisters.global) ::
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      else
			if tagged_binary_op = MirTypes.MULS andalso
			  reg_operand_is_spill reg_operand then
			  (* Still need to deal with case of imul here *)
			  (* gp_operand = reg_operand *)
			  (* and gp_operand' is not a spill *)
			  (* Deal with this as for gp_operand <> reg_operand *)
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG MirRegisters.global,
					  gp_operand) ::
			   MirTypes.TBINARY(tagged_binary_op, taglist,
					    MirTypes.GC_REG MirRegisters.global,
					    MirTypes.GP_GC_REG MirRegisters.global,
					    gp_operand') ::
			   MirTypes.UNARY(MirTypes.MOVE,
					  reg_operand,
					  MirTypes.GP_GC_REG MirRegisters.global) ::
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
			else
			  let
			    val (operand1, operand2) =
			      if reg_operand_is_spill reg_operand then
				let
				  val spill = reg_spill_value reg_operand
				  val op2 =
				    if is_reg gp_operand' then
				      I386_Assembly.r32(lookup_gp_operand gp_operand')
				    else
				      assemble_sized_gp_imm gp_operand'
				in
				  (I386_Assembly.r_m32
				   (I386_Assembly.INR
				    (I386_Assembly.MEM
				     {base=SOME I386Types.sp,
				      index=absent,
				      offset=SOME(I386_Assembly.SMALL spill)})),
				   op2)
				end
			      else
				if gp_operand_is_spill gp_operand' then
				  let
				    val spill = gp_spill_value gp_operand'
				  in
				    (I386_Assembly.r32(lookup_reg_operand reg_operand),
				     I386_Assembly.r_m32
				     (I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME I386Types.sp,
					index=absent,
					offset=SOME(I386_Assembly.SMALL spill)})))
				  end
				else
				  let
				    val op1 = lookup_reg_operand reg_operand
				  in
				    if is_reg gp_operand' then
				      (* In the case of two registers *)
				      (* Use the r32 on the first *)
				      (* This is for imul's benefit *)
				      (I386_Assembly.r32 op1,
				       I386_Assembly.r_m32
				       (I386_Assembly.INL
					(lookup_gp_operand gp_operand')))
				    else
				      (I386_Assembly.r_m32
				       (I386_Assembly.INL(lookup_reg_operand reg_operand)),
				       assemble_sized_gp_imm gp_operand')
				  end
			    val operands = [operand1, operand2]
			    val extra_instrs =
			      if tagged_binary_op = MirTypes.MULS then
				(* Need to shift one argument right two *)
				(* Unless both arguments are the same *)
				(* in which case we shift right one *)
				let
				  val (shift_size, comment) =
				    case operands of
				      [I386_Assembly.r32 r,
				       I386_Assembly.r_m32(I386_Assembly.INL r')] =>
				      if r = r' then (1, "one") else (2, "two")
				    | _ => (2, "two")
				in
				[(I386_Assembly.OPCODE
				  (I386_Assembly.sar,
				   [case operand1 of
				      I386_Assembly.r32 r =>
					I386_Assembly.r_m32(I386_Assembly.INL r)
				    | I386_Assembly.r_m32(I386_Assembly.INL r) =>
					operand1
				    | _ => Crash.impossible"imul bad dest",
					I386_Assembly.imm8 shift_size]), absent,
				  "shift source right" ^ comment ^" before multiply")]
				end
			      else
				[]
			  in
			    (extra_instrs @
			     [(I386_Assembly.OPCODE(opcode, operands), absent, ""),
			      (I386_Assembly.OPCODE
			       (I386_Assembly.jcc(I386_Assembly.overflow),
				[I386_Assembly.rel8 0]),
			       tag, "branch on numeric overflow")],
			    opcode_list,
			    block_list,
			    final_result, stack_drop, param_slots, false)
			  end
		    end
		  else
		    if reg_equals_gp(reg_operand, gp_operand') then
		      let
			val can_reverse = case tagged_binary_op of
			  MirTypes.ADDS => true
			| MirTypes.SUBS => false
			| MirTypes.MULS => true
			| MirTypes.DIVS => Crash.impossible"do_opcodes(TBINARY(DIVS))"
			| MirTypes.MODS => Crash.impossible"do_opcodes(TBINARY(MODS))"
			| MirTypes.ADD32S => true
			| MirTypes.SUB32S => false
			| MirTypes.MUL32S => true
			| MirTypes.DIV32S => Crash.impossible"do_opcodes(TBINARY(DIV32S))"
			| MirTypes.MOD32S => Crash.impossible"do_opcodes(TBINARY(MOD32S))"
			| MirTypes.DIVU => Crash.impossible"do_opcodes(TBINARY(DIVU))"
			| MirTypes.MODU => Crash.impossible"do_opcodes(TBINARY(MODU))"
			| MirTypes.DIV32U => Crash.impossible"do_opcodes(TBINARY(DIV32IU))"
			| MirTypes.MOD32U => Crash.impossible"do_opcodes(TBINARY(MOD32U))"
		      in
			if can_reverse then
			  ([],
			   MirTypes.TBINARY(tagged_binary_op, taglist,
					    reg_operand, gp_operand', gp_operand) ::
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
			else
			  (* Subtract *)
			  if is_reg gp_operand then
			    (* Tricky case *)
			    ([],
			     MirTypes.UNARY(MirTypes.MOVE,
					    MirTypes.GC_REG MirRegisters.global,
					    gp_operand) ::
			     MirTypes.TBINARY(tagged_binary_op, taglist,
					      MirTypes.GC_REG MirRegisters.global,
					      MirTypes.GP_GC_REG MirRegisters.global,
					      gp_operand') ::
			     MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					    MirTypes.GP_GC_REG MirRegisters.global) ::
			     opcode_list, block_list, final_result, stack_drop, param_slots, false)
			  else
			    if assemble_imm32 gp_operand = (0, 0) then
			      ([(I386_Assembly.OPCODE
				 (I386_Assembly.neg,
				  [I386_Assembly.r_m32
				   (if reg_operand_is_spill reg_operand then
				      I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME I386Types.sp,
					index=absent,
					offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))
					})
				    else
				      I386_Assembly.INL
				      (lookup_reg_operand reg_operand))
				      ]),
				 absent, "negate for simplicity"),
				(I386_Assembly.OPCODE
				 (I386_Assembly.jcc(I386_Assembly.overflow),
				  [I386_Assembly.rel8 0]),
				 tag, "branch on numeric overflow")],
			      opcode_list, block_list, final_result, stack_drop, param_slots, false)
			    else
			      ([],
			       MirTypes.UNARY(MirTypes.MOVE,
					      MirTypes.GC_REG MirRegisters.global,
					      gp_operand') ::
			       MirTypes.TBINARY(tagged_binary_op, taglist, reg_operand,
						gp_operand,
						MirTypes.GP_GC_REG MirRegisters.global) ::
			       opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		    else
		      (* No equality between result and either argument *)
		      (* But we can still do some multiplies *)
		      if tagged_binary_op = MirTypes.MULS andalso
			reg_operand_is_spill reg_operand then
			(* We need to deal better with a three spill multiply *)
			(* because of the restriction that the *)
			(* multiplicand/result must be a register *)
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					MirTypes.GC_REG MirRegisters.global,
					gp_operand) ::
			 MirTypes.TBINARY(tagged_binary_op, taglist,
					  MirTypes.GC_REG MirRegisters.global,
					  MirTypes.GP_GC_REG MirRegisters.global,
					  gp_operand') ::
			 MirTypes.UNARY(MirTypes.MOVE,
					reg_operand,
					MirTypes.GP_GC_REG MirRegisters.global) ::
			 opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      else
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					reg_operand,
					gp_operand) ::
			 MirTypes.TBINARY(tagged_binary_op, taglist, reg_operand,
					  gp_from_reg reg_operand,
					  gp_operand') ::
			 opcode_list, block_list, final_result, stack_drop, param_slots, false)
                 end
	        | MirTypes.BINARY(binary_op, reg_operand, gp_operand,
				  gp_operand') =>
		  let
		    val (i_opcode, is_shift) = get_binary_op binary_op
		  in
		    if (is_reg gp_operand andalso
			not (gp_operand_is_spill gp_operand)) andalso
		      ((i_opcode = I386_Assembly.add andalso
			not (gp_operand_is_spill gp_operand')) orelse
		       (i_opcode = I386_Assembly.sub andalso
			not (is_reg gp_operand'))) then
		      (* Special nice cases where we can use lea *)
		      let
			val needs_move = reg_operand_is_spill reg_operand
			val dest =
			  if needs_move then
			    I386Types.global
			  else
			    lookup_reg_operand reg_operand
			val invert_gp' = i_opcode = I386_Assembly.sub
			val base = SOME (lookup_gp_operand gp_operand)
			val operand =
			  I386_Assembly.r_m32
			  (I386_Assembly.INR
			   (I386_Assembly.MEM
			    (if is_reg gp_operand' then
			       {base=base,
				index=SOME(lookup_gp_operand gp_operand', absent),
				offset=absent}
			     else
			       {base=base,
				index=absent,
				offset=
				SOME
				let
				  val offset = assemble_large_offset gp_operand'
				in
				  if invert_gp' then
				    case offset of
				      I386_Assembly.SMALL i => I386_Assembly.SMALL(~i)
				    | I386_Assembly.LARGE(i, j) =>
					I386_Assembly.LARGE
					(if j = 0 then
					   (~i, j)
					 else
					   (~i-1, 4-j))
				  else
				    offset
				end})))
		      in
			([(I386_Assembly.OPCODE
			   (I386_Assembly.lea,
			    [I386_Assembly.r32 dest, operand]),
			   absent, "implement add/sub with lea")],
			 if needs_move then
			   MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					  MirTypes.GP_GC_REG MirRegisters.global) ::
			   opcode_list
			 else
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		    else
		      (* Normal stuff *)
		      if reg_equals_gp(reg_operand, gp_operand) then
			if is_shift then
			  if is_reg gp_operand' then
			    (* Nasty, all shifts controlled by CL, part of ECX *)
			    if gp_operand_is_spill gp_operand' then
			      ([],
			       (MirTypes.UNARY(MirTypes.MOVE,
					       MirTypes.GC_REG MirRegisters.global,
					       gp_operand')) ::
			       MirTypes.BINARY(binary_op, reg_operand, gp_operand,
					       MirTypes.GP_GC_REG MirRegisters.global) ::
			       opcode_list, block_list, final_result, stack_drop, param_slots, false)
			    else
			      (* Shift amount in a register *)
			      (* Must be moved to ECX *)
			      let
				val tag2 = MirTypes.new_tag()
				val tag3 = MirTypes.new_tag()
				val operand =
				  I386_Assembly.r_m32
				  (if reg_operand_is_spill reg_operand then
				     I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.sp,
				       index=absent,
				       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
				   else
				     I386_Assembly.INL(lookup_reg_operand reg_operand))
				val continue =
				  [(I386_Assembly.OPCODE
				    (I386_Assembly.jmp,
				     [I386_Assembly.rel8 0]),
				    SOME tag3, "continue")]
				val out_of_range_shift =
				  case i_opcode of
				    I386_Assembly.shr =>
				      (if reg_operand_is_spill reg_operand then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.mov,
					   [operand, I386_Assembly.imm32(0, 0)]),
					  absent, "clear to zero for out of range shift")
				       else
					 (I386_Assembly.OPCODE
					  (I386_Assembly.xor,
					   [I386_Assembly.r32(lookup_reg_operand reg_operand),
					    I386_Assembly.r_m32(I386_Assembly.INL(lookup_reg_operand reg_operand))]),
					  absent, "clear to zero for out of range shift")) ::
					 continue
				  | I386_Assembly.sal =>
				     (if reg_operand_is_spill reg_operand then
					(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [operand, I386_Assembly.imm32(0, 0)]),
					 absent, "clear to zero for out of range shift")
				      else
					(I386_Assembly.OPCODE
					 (I386_Assembly.xor,
					  [I386_Assembly.r32(lookup_reg_operand reg_operand),
					   I386_Assembly.r_m32(I386_Assembly.INL(lookup_reg_operand reg_operand))]),
					 absent, "clear to zero for out of range shift")) ::
					continue
				  | I386_Assembly.sar =>
				      (I386_Assembly.OPCODE
				       (i_opcode,
					[operand, I386_Assembly.imm8 31]),
				       absent, "shift by immediate value") ::
				      continue
				  | _ => Crash.impossible"mach_cg: non-shift in shift case"
				val block1 =
				  (I386_Assembly.OPCODE
				   (I386_Assembly.cmp,
				    [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global),
				     I386_Assembly.imm8 31]),
				   absent, "test for shift by > 31 (unsigned)") ::
				  (I386_Assembly.OPCODE
				   (I386_Assembly.jcc(I386_Assembly.below_or_equal),
				    [I386_Assembly.rel8 0]),
				   SOME tag2, "branch if ok") ::
				  out_of_range_shift
				val block1 =
				  let
				    val reg = lookup_gp_operand gp_operand'
				  in
				    if reg = I386Types.global then
				      block1
				    else
				      (I386_Assembly.OPCODE
				       (I386_Assembly.mov,
					[I386_Assembly.r32 I386Types.global,
					 I386_Assembly.r_m32(I386_Assembly.INL reg)]),
				       absent, "put shift amount into ECX") ::
				      block1
				  end
				val block2 =
				  (I386_Assembly.OPCODE
				   (i_opcode,
				    [operand, I386_Assembly.r8 I386Types.CL]),
				   absent, "do the actual shift") :: continue
			      in
				(block1,
				 [],
				 MirTypes.BLOCK(tag3, opcode_list) :: block_list,
				 (tag2, block2) ::
				 final_result, stack_drop, param_slots, true)
			      end
			  else
			    let
			      val shift as (i, j) = assemble_imm32 gp_operand'
			      val shift =
				if i < 0 orelse i >= 8 then
				  32
				else
				  4*i+j
			      val operand =
				I386_Assembly.r_m32
				(if reg_operand_is_spill reg_operand then
				   I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.sp,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
				 else
				   I386_Assembly.INL(lookup_reg_operand reg_operand))
			    in
			      ((I386_Assembly.OPCODE
				(i_opcode,
				 [operand, I386_Assembly.imm8 shift]),
				absent, "shift by immediate value") :: [],
			       opcode_list, block_list, final_result, stack_drop, param_slots, false)
			    end
			else
			  if reg_operand_is_spill reg_operand andalso
			    gp_operand_is_spill gp_operand' then
			    ([],
			     MirTypes.UNARY(MirTypes.MOVE,
					    MirTypes.GC_REG MirRegisters.global,
					    gp_operand') ::
			     MirTypes.BINARY(binary_op, reg_operand,
					     gp_operand,
					     MirTypes.GP_GC_REG MirRegisters.global) ::
			     opcode_list, block_list, final_result, stack_drop, param_slots, false)
			  else
			    (* Not a shift, and not both spills *)
			    let
			      val operands =
				if reg_operand_is_spill reg_operand then
				  let
				    val spill = reg_spill_value reg_operand
				    val op2 =
				      if is_reg gp_operand' then
					I386_Assembly.r32(lookup_gp_operand gp_operand')
				      else
					assemble_sized_gp_imm gp_operand'
				  in
				    [I386_Assembly.r_m32
				     (I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME I386Types.sp,
					index=absent,
					offset=SOME(I386_Assembly.SMALL spill)})),
				     op2]
				  end
				else
				  if gp_operand_is_spill gp_operand' then
				    let
				      val spill = gp_spill_value gp_operand'
				    in
				      [I386_Assembly.r32(lookup_reg_operand reg_operand),
				       I386_Assembly.r_m32
				       (I386_Assembly.INR
					(I386_Assembly.MEM
					 {base=SOME I386Types.sp,
					  index=absent,
					  offset=SOME(I386_Assembly.SMALL spill)}))]
				    end
				  else
				    let
				      val op2 =
					if is_reg gp_operand' then
					  I386_Assembly.r32(lookup_gp_operand gp_operand')
					else
					  assemble_sized_gp_imm gp_operand'
				    in
				      [I386_Assembly.r_m32
				       (I386_Assembly.INL(lookup_reg_operand reg_operand)),
				       op2]
				    end
			    in
			      ([(I386_Assembly.OPCODE(i_opcode, operands),
				 absent, "binary op")],
			       opcode_list, block_list, final_result, stack_drop, param_slots, false)
			    end
		      else
			if reg_equals_gp(reg_operand, gp_operand') then
			  let
			    val can_reverse = case binary_op of
			      MirTypes.ADDU => true
			    | MirTypes.SUBU => false
			    | MirTypes.MULU =>
				Crash.unimplemented"MirTypes.MULU"
			    | MirTypes.MUL32U =>
				Crash.unimplemented"MirTypes.MUL32U"
			    | MirTypes.AND => true
			    | MirTypes.OR => true
			    | MirTypes.EOR => true
			    | MirTypes.LSR => false
			    | MirTypes.ASL => false
			    | MirTypes.ASR => false
			  in
			    if can_reverse then
			      ([],
			       MirTypes.BINARY(binary_op, reg_operand, gp_operand',
					       gp_operand) :: opcode_list,
			       block_list, final_result, stack_drop, param_slots, false)
			    else
			      (* Difficult case of a := b op a *)
			      let
				val a_is_global =
				  not(reg_operand_is_spill reg_operand) andalso
				  lookup_reg_operand reg_operand = I386Types.global
				val b_is_global =
				  is_reg gp_operand andalso
				  not(gp_operand_is_spill gp_operand) andalso
				  lookup_gp_operand gp_operand = I386Types.global
			      in
				if a_is_global orelse b_is_global then
				  Crash.unimplemented
				  ("BINARY:unreversible:reg_operand = gp_operand' in " ^
				   MirPrint.opcode opcode)
				else
				  if reg_operand_is_spill reg_operand andalso
				    gp_operand_is_spill gp_operand then
				    let
				      (* Here we know reg_operand = gp_operand' *)
				      val spill = gp_spill_value gp_operand
				      val offset =
					if spill = 0 then
					  absent
					else
					  SOME (I386_Assembly.SMALL spill)
				      val xchg_code =
					(I386_Assembly.OPCODE
					 (I386_Assembly.xchg,
					  [I386_Assembly.r32 I386Types.global,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.sp,
					      index=absent,
					      offset=offset}))
					   ]),
					 absent,
					 "swap dest (= source 2) with global")
				      val binary_code =
					(I386_Assembly.OPCODE
					 (i_opcode,
					  [I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.sp,
					      index=absent,
					      offset=offset})),
					   I386_Assembly.r32 I386Types.global]),
					 absent, "the binary operation")
				      val code_list =
					move_gp_to_reg(I386Types.global, gp_operand,
						       [xchg_code])
				    in
				      (code_list,
				       MirTypes.BINARY(binary_op, reg_operand,
						       gp_operand',
						       MirTypes.GP_GC_REG
						       MirRegisters.global) ::
				       opcode_list,
				       block_list, final_result, stack_drop, param_slots, false)
				    end
				  else
				    ([],
				     MirTypes.UNARY(MirTypes.MOVE,
						    MirTypes.GC_REG MirRegisters.global,
						    gp_operand') ::
				     MirTypes.BINARY(binary_op, reg_operand, gp_operand,
						     MirTypes.GP_GC_REG MirRegisters.global) ::
				     opcode_list,
				     block_list, final_result, stack_drop, param_slots, false)
			      end
			  end
			else
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  reg_operand,
					  gp_operand) ::
			   MirTypes.BINARY(binary_op, reg_operand,
					   gp_from_reg reg_operand,
					   gp_operand') ::
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
		  end

		| MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) =>
		  if reg_operand_is_spill reg_operand andalso
		    gp_operand_is_spill gp_operand then
		    if reg_equals_gp(reg_operand, gp_operand) then
		      ([], opcode_list, block_list, final_result, stack_drop, param_slots, false)
		    else
		      ([], MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG MirRegisters.global,
					  gp_operand) ::
		       MirTypes.UNARY(MirTypes.MOVE, reg_operand,
				      MirTypes.GP_GC_REG MirRegisters.global) ::
		       opcode_list, block_list, final_result, stack_drop, param_slots, false)
		  else
		    (* Not both spills case *)
		    if reg_operand_is_spill reg_operand then
		      let
			val opcode = I386_Assembly.mov
			val _ = doing_move := true
			val spill = reg_spill_value reg_operand
			val _ = doing_move := false (* Catch mistakes *)
			val offset =
			  if spill = 0 then absent else SOME (I386_Assembly.SMALL spill)
			(* Deal with possible parameter push here *)
			val _ =
			  if spill < 0 (* Parameter push *) andalso stack_drop > 0 then
			    Crash.impossible"i386_cg: parameter push onto dropped stack"
			  else
			    ()
			val mem_ref =
			  I386_Assembly.r_m32
			  (I386_Assembly.INR
			   (I386_Assembly.MEM
			    {base=SOME I386Types.sp,
			     index=absent,
			     offset=offset}))
			val operand =
			  if is_reg gp_operand then
			    (* Can't be spill here *)
			    let
			      val rs1 = lookup_gp_operand gp_operand
			    in
			      I386_Assembly.r32 rs1
			    end
			  else
			    I386_Assembly.imm32(assemble_imm32 gp_operand)
			val (code_list, param_slots) =
			  if spill < 0 then
			    let
			      val neg_spill = ~spill
			    in
			      if neg_spill <= param_slots then
				(* Store via sp as normal *)
				let
				  val spill = spill + param_slots
				  (* Account for parameters already stacked *)
				  val offset =
				    if spill = 0 then absent else SOME(I386_Assembly.SMALL spill)
				in
				  ([(I386_Assembly.OPCODE
				     (opcode,
				      [I386_Assembly.r_m32
				       (I386_Assembly.INR
					(I386_Assembly.MEM
					 {base=SOME I386Types.sp,
					  index=absent,
					  offset=offset})), operand]),
				     absent, "saving arg into stack")],
				   param_slots)
				end
			      else
			      if neg_spill = param_slots+4 then
				(* Just push onto stack *)
				([(I386_Assembly.OPCODE
				   (I386_Assembly.push,
				    [operand]),
				   absent, "pushing arg onto stack")],
				 neg_spill)
			      else
				(* Drop stack then push *)
				let
				  val pushes = neg_spill - param_slots - 4
				  fun push_dummies(slots, done) =
				    if slots <= 0 then
				      done
				    else
				      push_dummies
				      (slots - 4,
				       (I386_Assembly.OPCODE
					(I386_Assembly.push,
					 [I386_Assembly.r32 I386Types.callee_closure]),
					absent, "push safe filler onto stack") ::
				      done)
				in
				  (push_dummies
				   (pushes,
				    [(I386_Assembly.OPCODE
				      (I386_Assembly.push,
				       [operand]),
				      absent, "pushing arg onto stack")]),
				   neg_spill)
				end
			    end
			  else
			    ([(I386_Assembly.OPCODE
			       (opcode,
				[mem_ref, operand]),
			       absent, "")], param_slots)
		      in
			(code_list, opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		    else
		      let
(*
			val _ = doing_move := true
*)
			val rd = lookup_reg_operand reg_operand
			val code_list = move_gp_to_reg(rd, gp_operand, [])
(*
			val _ = doing_move := false
*)
		      in
			(code_list, opcode_list, block_list, final_result,
			 stack_drop, param_slots, false)
		      end

		| MirTypes.UNARY(MirTypes.NOT, reg_operand, gp_operand) =>
		    if reg_equals_gp(reg_operand, gp_operand) then
		      let
			val operand =
			  I386_Assembly.r_m32
			  (if reg_operand_is_spill reg_operand then
			     I386_Assembly.INR
			     (I386_Assembly.MEM
			      {base=SOME I386Types.sp,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
			   else
			     I386_Assembly.INL(lookup_reg_operand reg_operand))
		      in
			([(I386_Assembly.OPCODE
			   (I386_Assembly.xor,
			    [operand, I386_Assembly.imm8 ~4]),
			   absent, "invert")],
			 opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		    else
		      ([],
		       MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) ::
		       MirTypes.UNARY(MirTypes.NOT, reg_operand,
				      gp_from_reg reg_operand) :: opcode_list,
		       block_list, final_result, stack_drop, param_slots, false)

		| MirTypes.UNARY(MirTypes.NOT32, reg_operand, gp_operand) =>
		    if reg_equals_gp(reg_operand, gp_operand) then
		      let
			val operand =
			  I386_Assembly.r_m32
			  (if reg_operand_is_spill reg_operand then
			     I386_Assembly.INR
			     (I386_Assembly.MEM
			      {base=SOME I386Types.sp,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
			   else
			     I386_Assembly.INL(lookup_reg_operand reg_operand))
		      in
			([(I386_Assembly.OPCODE
			   (I386_Assembly.not,
			    [operand]),
			   absent, "invert")],
			 opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		    else
		      ([],
		       MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) ::
		       MirTypes.UNARY(MirTypes.NOT32, reg_operand,
				      gp_from_reg reg_operand) :: opcode_list,
		       block_list, final_result, stack_drop, param_slots, false)
		| MirTypes.UNARY(MirTypes.INTTAG, reg_operand, gp_operand) =>
		    if reg_equals_gp(reg_operand, gp_operand) then
		      let
			val operand =
			  I386_Assembly.r_m32
			  (if reg_operand_is_spill reg_operand then
			     I386_Assembly.INR
			     (I386_Assembly.MEM
			      {base=SOME I386Types.sp,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
			   else
			     I386_Assembly.INL(lookup_reg_operand reg_operand))
		      in
			([(I386_Assembly.OPCODE
			   (I386_Assembly.and_op,
			    [operand, I386_Assembly.imm8 0xfc]),
			   absent, "tag as int")],
			 opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		    else
		      ([],
		       MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) ::
		       MirTypes.UNARY(MirTypes.INTTAG, reg_operand,
				      gp_from_reg reg_operand) :: opcode_list,
		       block_list, final_result, stack_drop, param_slots, false)

		| MirTypes.NULLARY(MirTypes.CLEAN, reg_operand) =>
                    ([if reg_operand_is_spill reg_operand then
			(I386_Assembly.OPCODE
			 (I386_Assembly.mov,
			  [I386_Assembly.r_m32
			   (I386_Assembly.INR
			    (I386_Assembly.MEM
			     {base=SOME I386Types.sp,
			      index=absent,
			      offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})),
			   I386_Assembly.imm32(0, 0)]),
			 absent, "clean")
		      else
                        (I386_Assembly.OPCODE
			 (I386_Assembly.xor,
			  [I386_Assembly.r_m32
			   (I386_Assembly.INL(lookup_reg_operand reg_operand)),
			   I386_Assembly.r32(lookup_reg_operand reg_operand)]),
			 absent, "clean")],
                    opcode_list, block_list, final_result, stack_drop, param_slots, false)

		| MirTypes.BINARYFP(binary_fp_op, fp_operand, fp_operand',fp_operand'') =>
		  let
		    val rd = convert_fp_operand fp_operand
		    val rs1 = convert_fp_operand fp_operand'
		    val rs2 = convert_fp_operand fp_operand''
		    val operation =
                      case binary_fp_op of
                        MirTypes.FADD => I386_Assembly.fadd
                      | MirTypes.FSUB => I386_Assembly.fsub
                      | MirTypes.FMUL => I386_Assembly.fmul
                      | MirTypes.FDIV => I386_Assembly.fdiv
		  in
		    ([(I386_Assembly.OPCODE (I386_Assembly.fld, [rs1]),absent,""),
                      (I386_Assembly.OPCODE (operation, [rs2]),absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.fstp, [rd]),absent,"")],
                     opcode_list, block_list, final_result,stack_drop, param_slots, false)
		  end

	        | MirTypes.UNARYFP(unary_fp_op, fp_operand, fp_operand') =>
                    let
                      val rd = convert_fp_operand fp_operand
                      val rs = convert_fp_operand fp_operand'
                      val complex_trig =
                        case unary_fp_op of
                          MirTypes.FSIN => true
                        | MirTypes.FCOS => true
                        | _ => false
                    in
                      if not complex_trig
                        then
                          let
                            val mnemonics =
                              case unary_fp_op of
                                MirTypes.FSQRT => [I386_Assembly.fsqrt]
                              | MirTypes.FMOVE => []
                              | MirTypes.FABS => [I386_Assembly.fabs]
                              | MirTypes.FNEG => [I386_Assembly.fchs]
                              (* fpatan is actually atan2 *)
                              | MirTypes.FATAN => [I386_Assembly.fld1,I386_Assembly.fpatan]
                              | _ => Crash.impossible"Bad unary fp generated"
                          in
                            ([(I386_Assembly.OPCODE (I386_Assembly.fld, [rs]), absent, "Get unary fp arg")] @
                             (map (fn m => (I386_Assembly.OPCODE (m, []), absent, "")) mnemonics) @
                             [(I386_Assembly.OPCODE (I386_Assembly.fstp, [rd]), absent, "Write it back")],
                             opcode_list, block_list,
                             final_result,stack_drop, param_slots, false)
                          end
                      else
                        (* sin and cos only partially implemented by the 387 *)
                        (* For ridiculously big x, we make sin x = 0.0 and cos x = 1.0 *)
                        let
                          val end_tag = MirTypes.new_tag ()
                          val next_tag = MirTypes.new_tag ()
                          val (mnemonics,partial_result_op) =
                            case unary_fp_op of
                              MirTypes.FSIN => ([I386_Assembly.fsin],I386_Assembly.fldz)
                            | MirTypes.FCOS => ([I386_Assembly.fcos],I386_Assembly.fld1)
                            | _ => Crash.impossible "Bad partial unary fp op"
                          (* Once the correct value has been constructed, jump here *)
                          val final_block =
                            (end_tag,
                             [(I386_Assembly.OPCODE (I386_Assembly.fstp, [rd]), absent, "Write it back"),
                              (I386_Assembly.OPCODE (I386_Assembly.jmp, [I386_Assembly.rel8 0]), SOME next_tag, "")])
                        in
                          ([(I386_Assembly.OPCODE (I386_Assembly.fld, [rs]), absent, "Get unary fp arg")] @
                           (map (fn m => (I386_Assembly.OPCODE (m, []), absent, "")) mnemonics) @
                           [(I386_Assembly.OPCODE (I386_Assembly.push,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                            (I386_Assembly.OPCODE (I386_Assembly.fstsw_ax,[]), absent,"Get fpu status"),
                            (I386_Assembly.OPCODE (I386_Assembly.sahf,[]), absent,"Status to flags"),
                            (I386_Assembly.OPCODE (I386_Assembly.pop,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                            (* result OK if parity not set *)
                            (I386_Assembly.OPCODE (I386_Assembly.jcc I386_Assembly.not_parity,[I386_Assembly.rel8 0]), SOME end_tag,""),
                            (I386_Assembly.OPCODE (I386_Assembly.fstp, [I386_Assembly.fp_reg 0]),absent,"Pop wrong result"),
                            (I386_Assembly.OPCODE (partial_result_op,[]), absent,"Return default result"),
                            (I386_Assembly.OPCODE (I386_Assembly.jmp, [I386_Assembly.rel8 0]), SOME end_tag, "")],
                           [],MirTypes.BLOCK(next_tag,opcode_list):: block_list,
                           final_block :: final_result,stack_drop, param_slots, true)
                        end
                    end

		| MirTypes.TBINARYFP(tagged_binary_fp_op, taglist, fp_operand,
				     fp_operand', fp_operand'') =>
		  let
		    val rd = convert_fp_operand fp_operand
		    val rs1 = convert_fp_operand fp_operand'
		    val rs2 = convert_fp_operand fp_operand''
		    val operation =
                      case tagged_binary_fp_op of
                        MirTypes.FADDV => I386_Assembly.fadd
                      | MirTypes.FSUBV => I386_Assembly.fsub
                      | MirTypes.FMULV => I386_Assembly.fmul
                      | MirTypes.FDIVV => I386_Assembly.fdiv
		  in
		    ([(I386_Assembly.OPCODE (I386_Assembly.fld, [rs1]),absent,""),
                      (I386_Assembly.OPCODE (operation, [rs2]),absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.fstp, [rd]),absent,"Store fp result")],

                     opcode_list, block_list, final_result,stack_drop, param_slots, false)
		  end

		| MirTypes.TUNARYFP(tagged_unary_fp_op, taglist, fp_operand,
				    fp_operand') =>
                    let
                      val rd = convert_fp_operand fp_operand
                      val rs = convert_fp_operand fp_operand'
		      val mnemonics =
			case tagged_unary_fp_op of
			  MirTypes.FSQRTV => [I386_Assembly.fsqrt]
			| MirTypes.FABSV => [I386_Assembly.fabs]
			| MirTypes.FNEGV => [I386_Assembly.fchs]
                        | _ => Crash.impossible"Bad unary fp generated"
		    in
		      ((I386_Assembly.OPCODE (I386_Assembly.fld, [rs]), absent, "") ::
                       (map (fn m => (I386_Assembly.OPCODE (m, []), absent, "")) mnemonics) @
                       [(I386_Assembly.OPCODE (I386_Assembly.fstp, [rd]), absent, "Store fp result")],
                       opcode_list, block_list,
		       final_result,stack_drop, param_slots, false)
		    end
		| MirTypes.STACKOP(stack_op, reg_operand,
				   SOME offset) =>
		  Crash.impossible"do_everything:MirTypes.STACKOP"
		| MirTypes.STACKOP(stack_op, reg_operand, NONE) =>
		    let
		      val _ =
			if reg_operand_is_spill reg_operand then
			  Crash.impossible"push or pop of spill"
			else
			  ()
		      val (operation, stack_inc) = case stack_op of
			MirTypes.PUSH => (I386_Assembly.push, 4)
		      | MirTypes.POP => (I386_Assembly.pop, ~4)
		    in
		      ([(I386_Assembly.OPCODE
			 (operation,
			  [I386_Assembly.r32(lookup_reg_operand reg_operand)]),
			 absent, "push/pop register")],
		       opcode_list, block_list, final_result, stack_drop + stack_inc, param_slots, false)
		    end
		| opcode as MirTypes.IMMSTOREOP(store_op, gp_operand, reg_operand,
						gp_operand') =>
		  if is_reg gp_operand orelse is_load store_op then
		    Crash.impossible"IMMSTOREOP with load or register operand"
		  else
		    (case (reg_operand_is_spill reg_operand,
			   gp_operand_is_spill gp_operand') of
		       (false, false) =>
			 let
			   val r1 = lookup_reg_operand reg_operand
			   val gp_is_reg = is_reg gp_operand'
			   val operand =
			     I386_Assembly.r_m32
			     (I386_Assembly.INR
			      (I386_Assembly.MEM
			       (if gp_is_reg then
				  {base = SOME r1,
				   index = SOME (lookup_gp_operand gp_operand', absent),
				   offset = absent}
				else
				  let
				    val r1 =
				      if r1 = I386Types.stack then
					I386Types.ESP
				      else
					r1
				  in
				    {base = SOME r1,
				     index = absent,
				     offset = SOME (assemble_large_offset gp_operand')}
				  end
				)))
			 in
			   ([(I386_Assembly.OPCODE
			      (I386_Assembly.mov,
			       [operand, I386_Assembly.imm32(assemble_imm32 gp_operand)]),
			      absent, "store immediate value")],
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 end
		     | (false, true) =>
			 ([],
			  MirTypes.UNARY(MirTypes.MOVE,
					 MirTypes.GC_REG MirRegisters.global,
					 gp_operand') ::
			  MirTypes.IMMSTOREOP(store_op, gp_operand, reg_operand,
					      MirTypes.GP_GC_REG MirRegisters.global) ::
			  opcode_list,
			  block_list, final_result, stack_drop, param_slots, false)
		     | (true, false) =>
			 ([],
			  MirTypes.UNARY(MirTypes.MOVE,
					 MirTypes.GC_REG MirRegisters.global,
					 gp_from_reg reg_operand) ::
			  MirTypes.IMMSTOREOP(store_op, gp_operand,
					      MirTypes.GC_REG MirRegisters.global,
					      gp_operand') ::
			  opcode_list,
			  block_list, final_result, stack_drop, param_slots, false)
		     | (true, true) =>
		       ([],
			MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
				       gp_from_reg reg_operand) ::
			MirTypes.BINARY(MirTypes.ADDU,
					MirTypes.GC_REG MirRegisters.global,
					MirTypes.GP_GC_REG MirRegisters.global,
					gp_operand') ::
			MirTypes.IMMSTOREOP(store_op, gp_operand,
					    MirTypes.GC_REG MirRegisters.global,
					    MirTypes.GP_IMM_ANY 0) ::
			opcode_list, block_list, final_result, stack_drop, param_slots, false))
		| opcode as MirTypes.STOREOP(store_op, reg_operand, reg_operand',
					     gp_operand) =>
		  let
		    val is_a_load = is_load store_op
		    val reg_operand_is_not_global =
		      reg_operand <> MirTypes.GC_REG MirRegisters.global
		  in
		    (case (reg_operand_is_spill reg_operand,
			   reg_operand_is_spill reg_operand',
			   gp_operand_is_spill gp_operand) of
		       (false, false, true) =>
			 if is_a_load orelse reg_operand_is_not_global then
			   ([],
			    MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
					   gp_operand) ::
			    MirTypes.STOREOP(store_op, reg_operand, reg_operand',
					     MirTypes.GP_GC_REG MirRegisters.global) ::
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 else
			   if reg_operand' = MirTypes.GC_REG MirRegisters.caller_closure then
			     Crash.unimplemented"StoreOp: ST ecx, ebp, spill"
			   else
			     ([],
			      MirTypes.STACKOP(MirTypes.PUSH,
					       MirTypes.GC_REG MirRegisters.caller_closure,
					       absent) ::
			      MirTypes.UNARY(MirTypes.MOVE,
					     MirTypes.GC_REG MirRegisters.caller_closure,
					     gp_operand) ::
			      MirTypes.STOREOP(store_op, reg_operand, reg_operand',
					       MirTypes.GP_GC_REG MirRegisters.caller_closure) ::
			      MirTypes.STACKOP(MirTypes.POP,
					       MirTypes.GC_REG MirRegisters.caller_closure,
					       absent) ::
			      (* Pop back again *)
			      opcode_list, block_list, final_result, stack_drop, param_slots, false)
		     | (false, true, false) =>
			 if is_a_load orelse reg_operand_is_not_global then
			   ([],
			    MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
					   gp_from_reg reg_operand') ::
			    MirTypes.STOREOP(store_op, reg_operand,
					     MirTypes.GC_REG MirRegisters.global,
					     gp_operand) ::
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 else
			   if is_reg gp_operand andalso
			     reg_from_gp gp_operand = MirRegisters.caller_closure then
			     Crash.unimplemented"StoreOp: ST ecx, spill, ebp"
			   else
			     ([],
			      MirTypes.STACKOP(MirTypes.PUSH,
					       MirTypes.GC_REG MirRegisters.caller_closure,
					       absent) ::
			      MirTypes.UNARY(MirTypes.MOVE,
					     MirTypes.GC_REG MirRegisters.caller_closure,
					     gp_from_reg reg_operand') ::
			      MirTypes.STOREOP(store_op, reg_operand,
					       MirTypes.GC_REG MirRegisters.caller_closure,
					       gp_operand) ::
			      MirTypes.STACKOP(MirTypes.POP,
					       MirTypes.GC_REG MirRegisters.caller_closure,
					       absent) ::
			      (* Pop back again *)
			      opcode_list, block_list, final_result, stack_drop, param_slots, false)
		     | (false, true, true) =>
			 if is_a_load orelse reg_operand_is_not_global then
			   ([],
			    MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
					   gp_from_reg reg_operand') ::
			    MirTypes.BINARY(MirTypes.ADDU,
					    MirTypes.GC_REG MirRegisters.global,
					    MirTypes.GP_GC_REG MirRegisters.global,
					    gp_operand) ::
			    MirTypes.STOREOP(store_op, reg_operand,
					     MirTypes.GC_REG MirRegisters.global,
					     MirTypes.GP_IMM_ANY 0) ::
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 else
			   ([],
			    MirTypes.STACKOP(MirTypes.PUSH,
					     MirTypes.GC_REG MirRegisters.caller_closure,
					     absent) ::
			    MirTypes.UNARY(MirTypes.MOVE,
					   MirTypes.GC_REG MirRegisters.caller_closure,
					   gp_from_reg reg_operand') ::
			    MirTypes.BINARY(MirTypes.ADDU,
					    MirTypes.GC_REG MirRegisters.caller_closure,
					    MirTypes.GP_GC_REG MirRegisters.caller_closure,
					    gp_operand) ::
			    MirTypes.STOREOP(store_op, reg_operand,
					     MirTypes.GC_REG MirRegisters.caller_closure,
					     MirTypes.GP_IMM_ANY 0) ::
			    MirTypes.STACKOP(MirTypes.POP,
					      MirTypes.GC_REG MirRegisters.caller_closure,
					      absent) ::
			    (* Pop back again *)
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
		   | (true, false, false) =>
		       let
			 val load = is_load store_op
		       in
			 if load then
			   ([],
			    MirTypes.STOREOP(store_op,
					     MirTypes.GC_REG MirRegisters.global,
					     reg_operand',
					     gp_operand) ::
			    (* Load the value into global *)
			    MirTypes.UNARY(MirTypes.MOVE,
					   reg_operand,
					   MirTypes.GP_GC_REG MirRegisters.global) ::
			    (* Then put it in the spill slot *)
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 else
			   ([],
			    MirTypes.UNARY(MirTypes.MOVE,
					   MirTypes.GC_REG MirRegisters.global,
					   gp_from_reg reg_operand) ::
			    (* Get the value from the spill slot *)
			    MirTypes.STOREOP(store_op,
					     MirTypes.GC_REG MirRegisters.global,
					     reg_operand',
					     gp_operand) ::
			    (* And store it where it should be *)
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
		       end
		   | (true, false, true) =>
		       let
			 val load = is_load store_op
		       in
			 if load then
			   (* Easier case *)
			   ([],
			    MirTypes.UNARY(MirTypes.MOVE,
					   MirTypes.GC_REG MirRegisters.global,
					   gp_operand) ::
			    (* Get the value from the spill slot *)
			    MirTypes.STOREOP(store_op,
					     MirTypes.GC_REG MirRegisters.global,
					     reg_operand',
					     MirTypes.GP_GC_REG MirRegisters.global) ::
			    (* load the value into global *)
			    MirTypes.UNARY(MirTypes.MOVE,
					   reg_operand,
					   MirTypes.GP_GC_REG MirRegisters.global) ::
			    (* And store it where it should be *)
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 else
			   (* Difficult case *)
			   Crash.unimplemented"store spill, reg, spill"
		       end
		   | (true, true, false) =>
		       let
			 val load = is_load store_op
		       in
			 if load then
			   (* Easier case *)
			   ([],
			    MirTypes.UNARY(MirTypes.MOVE,
					   MirTypes.GC_REG MirRegisters.global,
					   gp_from_reg reg_operand') ::
			    (* Get the value from the spill slot *)
			    MirTypes.STOREOP(store_op,
					     MirTypes.GC_REG MirRegisters.global,
					     MirTypes.GC_REG MirRegisters.global,
					     gp_operand) ::
			    (* load the value into global *)
			    MirTypes.UNARY(MirTypes.MOVE,
					   reg_operand,
					   MirTypes.GP_GC_REG MirRegisters.global) ::
			    (* And store it where it should be *)
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
			 else
			   (* Difficult case *)
			   ([],
			    MirTypes.STACKOP(MirTypes.PUSH,
					      MirTypes.GC_REG MirRegisters.caller_closure,
					      absent) ::
			    MirTypes.UNARY(MirTypes.MOVE,
					   MirTypes.GC_REG MirRegisters.caller_closure,
					   gp_from_reg reg_operand) ::
			    (* Put the argument in caller_closure *)
			    MirTypes.STOREOP(store_op,
					      MirTypes.GC_REG MirRegisters.caller_closure,
					      reg_operand', gp_operand) ::
			    MirTypes.STACKOP(MirTypes.POP,
					      MirTypes.GC_REG MirRegisters.caller_closure,
					      absent) ::
			    (* Pop back again *)
			    opcode_list, block_list, final_result, stack_drop, param_slots, false)
		       end
		   | (true, true, true) =>
		       Crash.unimplemented"store spill, spill, spill"
		   | (false, false, false) =>
		       let
			 val rd = lookup_reg_operand reg_operand
			 val rs1 = lookup_reg_operand reg_operand'
			 val is_local_variable = rs1 = I386Types.stack
			 val (store_instr, word_size, load) = case store_op of
			   MirTypes.LD => (I386_Assembly.mov, true, true)
			 | MirTypes.ST => (I386_Assembly.mov, true, false)
			 | MirTypes.LDB => (I386_Assembly.movzx, false, true)
			 | MirTypes.STB => (I386_Assembly.mov, false, false)
			 | MirTypes.LDREF => (I386_Assembly.mov, true, true)
			 | MirTypes.STREF => (I386_Assembly.mov, true, false)
			 val r_m =
			   I386_Assembly.INR
			   (I386_Assembly.MEM
			    (if is_reg gp_operand then
			       {base=SOME rs1,
				index=SOME((lookup_gp_operand gp_operand), absent),
				offset=absent}
			     else
			       let
				 val rs1 =
				   if is_local_variable then
				     I386Types.ESP
				   else
				     rs1
			       in
				 {base=SOME rs1,
				  index=absent,
				  offset=SOME(assemble_large_offset gp_operand)}
			       end
))
			 val (con1, con2) =
			   if word_size then
			     (I386_Assembly.r32, I386_Assembly.r_m32)
			   else
			     if load then
			       (I386_Assembly.r32, I386_Assembly.r_m8)
			     else
			       (I386_Assembly.r8, I386_Assembly.r_m8)
		       in
			 if word_size orelse I386Types.has_byte_name rd orelse load then
			   let
			     val rd =
			       if word_size orelse load then
				 rd
			       else
				 I386Types.byte_reg_name rd
			     val operands =
			       if load then
				 [con1 rd, con2 r_m]
			       else
				 [con2 r_m, con1 rd]
			   in
			     ([(I386_Assembly.OPCODE(store_instr, operands), absent, "")],
			      opcode_list, block_list, final_result, stack_drop, param_slots, false)
			   end
			 else
			   (* Byte, no byte register name, store *)
			   (* Tricky, our destination may already be in global *)
			   if rs1 = I386Types.global orelse
			     (is_reg gp_operand andalso lookup_gp_operand gp_operand = I386Types.global) then
			     let
			       val operands =
				 if rs1 = I386Types.ESP orelse
				   (is_reg gp_operand andalso lookup_gp_operand gp_operand = I386Types.ESP) then
				   Crash.unimplemented"store byte relative to sp"
				 else
				   [I386_Assembly.r_m8 r_m,
				    I386_Assembly.r8(I386Types.byte_reg_name I386Types.EAX)]
			     in
			       ([(I386_Assembly.OPCODE
				  (I386_Assembly.push, [I386_Assembly.r32 I386Types.EAX]),
				  absent, "create some workspace"),
				 move_reg(I386Types.EAX, rd, "can't store byte from " ^
					  I386Types.reg_to_string rd),
				 (I386_Assembly.OPCODE
				  (store_instr, operands), absent, ""),
				 (I386_Assembly.OPCODE
				  (I386_Assembly.pop, [I386_Assembly.r32 I386Types.EAX]),
				  absent, "restore EAX")],
			       opcode_list, block_list, final_result, stack_drop, param_slots, false)
			     end
			   else
			     let
			       val operands =
				 [I386_Assembly.r_m8 r_m,
				  I386_Assembly.r8(I386Types.byte_reg_name I386Types.global)]
			     in
			       ([move_reg(I386Types.global, rd, "can't store byte from " ^
					  I386Types.reg_to_string rd),
				 (I386_Assembly.OPCODE(store_instr, operands), absent, "")],
				opcode_list, block_list, final_result, stack_drop, param_slots, false)
			     end
		       end)
		       end
		| MirTypes.STOREFPOP(store_fp_op, fp_operand, reg_operand,gp_operand) =>
                    (case (reg_operand_is_spill reg_operand,
                           gp_operand_is_spill gp_operand) of
                       (false, true) =>
                         ([],
                          MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
                                         gp_operand) ::
                          MirTypes.STOREFPOP(store_fp_op, fp_operand, reg_operand,
                                             MirTypes.GP_GC_REG MirRegisters.global) ::
                          opcode_list, block_list, final_result, stack_drop, param_slots, false)
                     | (true, false) =>
                         ([],
                          MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
                                         gp_from_reg reg_operand) ::
                          MirTypes.STOREFPOP (store_fp_op, fp_operand,
                                              MirTypes.GC_REG MirRegisters.global,
                                              gp_operand) ::
                          opcode_list, block_list, final_result, stack_drop, param_slots, false)
                     | (true, true) =>
                         ([],
                          MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG MirRegisters.global,
                                         gp_from_reg reg_operand) ::
                          MirTypes.BINARY(MirTypes.ADDU,
                                          MirTypes.GC_REG MirRegisters.global,
                                          MirTypes.GP_GC_REG MirRegisters.global,
                                          gp_operand) ::
                          MirTypes.STOREFPOP(store_fp_op, fp_operand,
                                             MirTypes.GC_REG MirRegisters.global,
                                             MirTypes.GP_IMM_ANY 0) ::
                          opcode_list, block_list, final_result, stack_drop, param_slots, false)
                     | (false, false) =>
                         (* Both values are in registers or are immediates *)
                         let
                           val rs1 = lookup_reg_operand reg_operand
			   val is_local_variable = rs1 = I386Types.stack
                           val (store_instr, is_load) =
                             case store_fp_op of
                               MirTypes.FLD => (I386_Assembly.mov, true)
                             | MirTypes.FST => (I386_Assembly.mov, false)
                             | MirTypes.FLDREF => (I386_Assembly.mov, true)
                             | MirTypes.FSTREF => (I386_Assembly.mov, false)
                           (* Make the memory operand *)
                           val operand =
                             I386_Assembly.fp_mem
                             (I386_Assembly.MEM
                              (if is_reg gp_operand then
                                 {base=SOME rs1,
                                  index=SOME((lookup_gp_operand gp_operand), absent),
                                  offset=absent}
                               else
				 let
				   val rs1 =
				     if is_local_variable then
				       I386Types.ESP
				     else
				       rs1
				 in
				   {base=SOME rs1,
				    index=absent,
				    offset=SOME(assemble_large_offset gp_operand)}
				 end))
                           val fp_operand = convert_fp_operand fp_operand
                           val new_opcodes =
                             if is_load
                               then
                                 [(I386_Assembly.OPCODE (I386_Assembly.fld, [operand]),absent,""),
                                  (I386_Assembly.OPCODE (I386_Assembly.fstp, [fp_operand]),absent,"")]
                             else
                               [(I386_Assembly.OPCODE (I386_Assembly.fld, [fp_operand]),absent,""),
                                (I386_Assembly.OPCODE (I386_Assembly.fstp, [operand]),absent,""),
                                (I386_Assembly.OPCODE (I386_Assembly.wait, []),absent,"Wait for store to be done")]
                         in
                           (new_opcodes,opcode_list, block_list, final_result,stack_drop, param_slots, false)
                         end)
		| MirTypes.REAL(int_to_float, fp_operand, gp_operand) =>
                    (* This needs to move (if necessary) the argument into a memory location *)
                    (* and then load with fild *)
		    (* Also, if the argument was on the stack, it must restore it *)
                    let
                      val rd = convert_fp_operand fp_operand
                      val (mem_operand,get_arg_code, restore_arg_code) =
                        if gp_operand_is_spill gp_operand then
			  let
			    val mem_operand =
			      I386_Assembly.MEM
			      {base=SOME I386Types.sp,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL(gp_spill_value gp_operand))}
			  in
			    (mem_operand,[],
			     [(I386_Assembly.OPCODE
			       (I386_Assembly.sal,
				[I386_Assembly.r_m32 (I386_Assembly.INR mem_operand),
				 I386_Assembly.imm8 2]), absent,"Retag")])
			  end
                        else
                          let
                            val fp_spare_loc =
                              I386_Assembly.MEM {base=SOME I386Types.sp,
                                                 index=absent,
                                                 offset=SOME(I386_Assembly.SMALL(frame_size + stack_drop + param_slots - fp_spare_offset))}
                            val source_operand =
                              case gp_operand of
                                MirTypes.GP_GC_REG rs =>
                                  I386_Assembly.r32 (lookup_gp_operand gp_operand)
                              | MirTypes.GP_IMM_INT i =>
                                  I386_Assembly.imm32(assemble_imm32 gp_operand)
                              | _ => Crash.impossible "Bad gp_operand to real"
                          in
                            (fp_spare_loc,
                             [(I386_Assembly.OPCODE
                               (I386_Assembly.mov,[I386_Assembly.r_m32 (I386_Assembly.INR fp_spare_loc),
                                                   source_operand]),
                               absent,"Use stack as temporary")], [])
                          end
                    in
                      (get_arg_code @
                       [(I386_Assembly.OPCODE(I386_Assembly.sar,[I386_Assembly.r_m32 (I386_Assembly.INR mem_operand),
                                                                  I386_Assembly.imm8 2]),
                         absent,"Untag"),
                        (I386_Assembly.OPCODE (I386_Assembly.fild,[I386_Assembly.fp_mem mem_operand]),absent,"Convert int to real"),
                        (I386_Assembly.OPCODE (I386_Assembly.fstp,[rd]),absent,"")] @
		       restore_arg_code,
                       opcode_list, block_list, final_result, stack_drop, param_slots, false)
                    end

		| MirTypes.FLOOR(float_to_int, tag, reg_operand, fp_operand) =>
                    (* This needs to push the argument onto fp stack *)
                    (* and then store with fistp to a memory location and then tag and move to destination *)
		    (* It also need to ensure that the fp stack is left clean *)
		    (* even when an exception is raised *)
                    let
                      val rs = convert_fp_operand fp_operand
                      val fp_spare_loc =
                        I386_Assembly.MEM {base=SOME I386Types.sp,
                                           index=absent,
                                           offset=SOME(I386_Assembly.SMALL(frame_size + stack_drop + param_slots - fp_spare_offset))}
                      (* mem_operand is where the FPU should put the argument *)
                      (* result_operand is for the tagging shift *)
		      (* Get two new tags for the exception raising case *)
		      (* As we must clean the stack first *)
		      val tag1 = MirTypes.new_tag()
		      val tag2 = MirTypes.new_tag()
                      val (mem_operand,result_operand,put_arg_code) =
                        if reg_operand_is_spill reg_operand then
			  let
			    val result_operand =
			      I386_Assembly.MEM
			      {base=SOME I386Types.sp,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))}
			  in
			    (I386_Assembly.fp_mem result_operand,I386_Assembly.r_m32 (I386_Assembly.INR result_operand),[])
			  end
                        else
                          let
                            val dest_operand_reg =
                              case reg_operand of
                                MirTypes.GC_REG _ => lookup_reg_operand reg_operand
                              | _ => Crash.impossible "Bad reg_operand to floor"
                          in
                            (I386_Assembly.fp_mem fp_spare_loc,
                             I386_Assembly.r_m32 (I386_Assembly.INL dest_operand_reg),
                             [(I386_Assembly.OPCODE
                               (I386_Assembly.mov,[I386_Assembly.r32 dest_operand_reg,
                                                   I386_Assembly.r_m32 (I386_Assembly.INR fp_spare_loc)]),
                               absent,"Use stack as temporary")])
                          end
		      val tag1_code =
			(tag1,
			 [(I386_Assembly.OPCODE (I386_Assembly.fstp,[I386_Assembly.fp_reg 0]),absent,"Pop fp stack"),
			  (I386_Assembly.OPCODE (I386_Assembly.jmp,[I386_Assembly.rel8 0]), SOME tag2,"")])
		      val tag2_code =
			(tag2,
			 [(I386_Assembly.OPCODE (I386_Assembly.fstp,[I386_Assembly.fp_reg 0]),absent,"Pop fp stack"),
			  (I386_Assembly.OPCODE (I386_Assembly.jmp,[I386_Assembly.rel8 0]), SOME tag,"")])

                    in
                      ([(I386_Assembly.OPCODE (I386_Assembly.fld,[rs]),absent,"Get argument to floor"),
                        (I386_Assembly.OPCODE (I386_Assembly.mov, [I386_Assembly.r_m32 (I386_Assembly.INR (fp_spare_loc)),
                                                                   I386_Assembly.imm32(Bits.lshift (1,27), 0)]),
                         absent, "Put 2**29 in fp_spare"),
                        (I386_Assembly.OPCODE (I386_Assembly.fild,[I386_Assembly.fp_mem fp_spare_loc]),
                         absent,"Convert 2**29 to real and push"),

                        (* Now we have 2**29 and x on the stack, time for some error checking *)
                        (* We should maybe try and only push AX once. *)
                        (I386_Assembly.OPCODE (I386_Assembly.fcom,[I386_Assembly.fp_reg 1]), absent,"Compare"),
                        (I386_Assembly.OPCODE (I386_Assembly.push,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.fstsw_ax,[]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.sahf,[]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.pop,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.jcc I386_Assembly.below_or_equal,[I386_Assembly.rel8 0]), SOME tag1,""),

                        (* Now have ~2**29 on stack *)
                        (I386_Assembly.OPCODE (I386_Assembly.fchs,[]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.fcomp,[I386_Assembly.fp_reg 1]), absent,"Compare and pop"),
                        (I386_Assembly.OPCODE (I386_Assembly.push,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.fstsw_ax,[]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.sahf,[]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.pop,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.jcc I386_Assembly.above,[I386_Assembly.rel8 0]), SOME tag2,""),

                        (I386_Assembly.OPCODE (I386_Assembly.fstcw,[I386_Assembly.fp_mem fp_spare_loc]),absent,"Fiddle with control word"),
                        (I386_Assembly.OPCODE (I386_Assembly.mov,
                                               [I386_Assembly.r32 I386Types.global,
                                                I386_Assembly.r_m32 (I386_Assembly.INR (fp_spare_loc))]),
                         absent,"Store previous in global -- should be 16 bit move"),
                        (I386_Assembly.OPCODE (I386_Assembly.and_op,
                                               [I386_Assembly.r_m16 (I386_Assembly.INR (fp_spare_loc)),
                                                I386_Assembly.imm16 fpu_control_rounding_bits]),
                         absent, "mask out rounding mode"),
                        (I386_Assembly.OPCODE (I386_Assembly.or,
                                               [I386_Assembly.r_m16 (I386_Assembly.INR (fp_spare_loc)),
                                                I386_Assembly.imm16 fpu_control_round_to_minus_infinity]),
                         absent, "or in round to -infinity"),
                        (I386_Assembly.OPCODE (I386_Assembly.fldcw,[I386_Assembly.fp_mem fp_spare_loc]),absent,""),
                        (I386_Assembly.OPCODE (I386_Assembly.fistp,[mem_operand]),absent,"Convert real to int"),
                        (I386_Assembly.OPCODE (I386_Assembly.wait,[]),absent,"Synchronize")] @
                       put_arg_code @
                       [(I386_Assembly.OPCODE (I386_Assembly.sal,[result_operand,I386_Assembly.imm8 2]),
                         absent,"Tag as integer"),
                        (I386_Assembly.OPCODE (I386_Assembly.mov,
                                               [I386_Assembly.r_m32 (I386_Assembly.INR (fp_spare_loc)),
                                                I386_Assembly.r32 I386Types.global]),
                         absent,"get previous from global -- should be 16 bit move"),
                        (I386_Assembly.OPCODE (I386_Assembly.fldcw,[I386_Assembly.fp_mem fp_spare_loc]),absent,"")
                        ],
                       opcode_list, block_list, tag1_code :: tag2_code :: final_result,
		       stack_drop, param_slots, false)
                    end

		| MirTypes.BRANCH(branch, bl_dest) =>
		    ((case bl_dest of
			MirTypes.REG reg =>
			  if reg_operand_is_spill reg then
			    Crash.unimplemented"branch reg operand is spill"
			  else
			    [(I386_Assembly.OPCODE
                              (I386_Assembly.jmp,
                               [I386_Assembly.r_m32
                                (I386_Assembly.INL(lookup_reg_operand reg))]),
                               absent, "branch indirect")]
		      | MirTypes.TAG tag =>
			  [(I386_Assembly.OPCODE
			    (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
			    SOME tag, "branch relative")]),
			opcode_list, block_list, final_result, stack_drop, param_slots, false)
		| MirTypes.TEST(cond_branch, test_tag, gp_operand,
				gp_operand') =>
		  if gp_operand_is_spill gp_operand andalso
		    gp_operand_is_spill gp_operand' then
		    (* Hard case, both spills *)
		    ([],
		     MirTypes.UNARY(MirTypes.MOVE,
				    MirTypes.GC_REG
				    MirRegisters.global,
				    gp_operand) ::
		     MirTypes.TEST(cond_branch, test_tag,
				   MirTypes.GP_GC_REG MirRegisters.global, gp_operand') ::
		     opcode_list, block_list, final_result, stack_drop, param_slots, false)
		  else
		    let
		      val branch = case cond_branch of
			MirTypes.BNT => I386_Assembly.jcc I386_Assembly.equal
		      | MirTypes.BTA => I386_Assembly.jcc I386_Assembly.not_equal
		      | MirTypes.BEQ => I386_Assembly.jcc I386_Assembly.equal
		      | MirTypes.BNE => I386_Assembly.jcc I386_Assembly.not_equal
		      | MirTypes.BHI => I386_Assembly.jcc I386_Assembly.above
		      | MirTypes.BLS => I386_Assembly.jcc I386_Assembly.below_or_equal
		      | MirTypes.BHS => I386_Assembly.jcc I386_Assembly.above_or_equal
		      | MirTypes.BLO => I386_Assembly.jcc I386_Assembly.below
		      | MirTypes.BGT => I386_Assembly.jcc I386_Assembly.greater
		      | MirTypes.BLE => I386_Assembly.jcc I386_Assembly.less_or_equal
		      | MirTypes.BGE => I386_Assembly.jcc I386_Assembly.greater_or_equal
		      | MirTypes.BLT => I386_Assembly.jcc I386_Assembly.less
		      val test_instr = case cond_branch of
			MirTypes.BTA => I386_Assembly.test
		      | MirTypes.BNT => I386_Assembly.test
		      | _ => I386_Assembly.cmp
		    in
		      if is_reg gp_operand orelse is_reg gp_operand' then
			let
			  val (branch, gp_op, gp_op') =
			    if is_reg gp_operand then
			      (branch, gp_operand, gp_operand')
			    else
			      (I386_Assembly.reverse_branch branch,
			       gp_operand', gp_operand)
			  (* Possibilities : *)
			  (* gp_op is a real register, gp_op' is anything *)
			  (* gp_op is a spill, gp_op' is a real register or an immediate *)
			  (* No others, we removed both spills *)
			  (* And we swapped if gp_operand was an immediate *)

			  val (rs1, reg_or_imm, convert_eq) =
			    if gp_operand_is_spill gp_op then
			      let
				val spill = gp_spill_value gp_op
			      in
				(I386_Assembly.r_m32
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME I386Types.sp,
				    index=absent,
				    offset=SOME(I386_Assembly.SMALL spill)})),
				 if is_reg gp_op' then
				   I386_Assembly.r32(lookup_gp_operand gp_op')
				 else
				   (* This case needs more work *)
				   (* Here we have either a test or a cmp *)
				   (* with an immediate value *)
				   (* The cmp can be shortened, the test can't *)
				   if test_instr = I386_Assembly.test then
				     I386_Assembly.imm32(assemble_imm32 gp_op')
				   else
				     assemble_sized_gp_imm gp_op',
				     false)
			      end
			    else
			      (* gp_op is a register *)
			      let
				val gp_r = lookup_gp_operand gp_op
			      in
				if gp_operand_is_spill gp_op' then
				  (I386_Assembly.r32 gp_r,
				   I386_Assembly.r_m32
				   (I386_Assembly.INR
				    (I386_Assembly.MEM
				     {base=SOME I386Types.sp,
				      index=absent,
				      offset=SOME(I386_Assembly.SMALL(gp_spill_value gp_op'))})),
				   false)
				else
				  (* gp_op' is not a spill *)
				  if is_reg gp_op' then
				    (I386_Assembly.r_m32
				     (I386_Assembly.INL gp_r),
				     I386_Assembly.r32(lookup_gp_operand gp_op'),
				     false)
				  else
				    (* This case needs more work *)
				    (* Here we have either a test or a cmp *)
				    (* of a real register with an immediate value *)
				    (* If it's a cmp, we can shorten the immediate *)
				    (* but use the same register name *)
				    (* If it's a test, and the immediate is short *)
				    (* we can shorten both the register and the immediate *)
				    (* possibly down to 8 bits *)
				    (* Also, if doing a comparison of a real *)
				    (* register with zero, we can use test r r *)
				    (* instead *)
				    if test_instr = I386_Assembly.cmp then
				      let
					val gp_imm = assemble_sized_gp_imm gp_op'
					val is_eq = case cond_branch of
					  MirTypes.BEQ => true
					| MirTypes.BNE => true
					| _ => false
				      in
					if is_eq andalso
					  gp_imm = I386_Assembly.imm8 0 then
					  (I386_Assembly.r_m32(I386_Assembly.INL gp_r),
					   I386_Assembly.r32 gp_r,
					   true)
					 else
					   (I386_Assembly.r_m32(I386_Assembly.INL gp_r),
					    gp_imm,
					    false)
				      end
				    else
				      let
					val (i, j) = assemble_imm32 gp_op'
				      in
					if i = 0 andalso j = 3 then
					  if I386Types.has_byte_name gp_r then
					    (I386_Assembly.r_m8
					     (I386_Assembly.INL(I386Types.byte_reg_name gp_r)),
					     I386_Assembly.imm8 3,
					     false)
					  else
					    (I386_Assembly.r_m16
					     (I386_Assembly.INL(I386Types.half_reg_name gp_r)),
					     I386_Assembly.imm16 3,
					     false)
					else
					  Crash.impossible"test instruction not with immediate 3"
				      end
			      end
			  val test_instr =
			    if convert_eq then
			      I386_Assembly.test
			    else
			      test_instr
			in
			  ([(I386_Assembly.OPCODE
			     (test_instr,
			      [rs1, reg_or_imm]),
			     absent, "do the test"),
			    (I386_Assembly.OPCODE(branch, [I386_Assembly.rel8 0]),
			     SOME test_tag, "do the branch")],
			  opcode_list, block_list, final_result, stack_drop, param_slots, false)
			end
		      else
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					MirTypes.GC_REG
					MirRegisters.global,
					gp_operand') ::
			 MirTypes.TEST(cond_branch, test_tag, gp_operand,
				       MirTypes.GP_GC_REG MirRegisters.global) ::
			 opcode_list, block_list, final_result, stack_drop, param_slots, false)
		    end

		| MirTypes.FTEST(fcond_branch, tag, fp_operand,
				 fp_operand') =>
                  let
                    val cont_tag = MirTypes.new_tag()
                    val cond =
                      (* Do these conditions map correctly? *)
                      case fcond_branch of
                        MirTypes.FBEQ => I386_Assembly.equal
                      | MirTypes.FBNE => I386_Assembly.not_equal
                      | MirTypes.FBLE => I386_Assembly.below_or_equal
                      | MirTypes.FBLT => I386_Assembly.below
                    val rs1 = convert_fp_operand fp_operand
		    val rs2 = convert_fp_operand fp_operand'
                  (* Skip the branch if the comparison comes out unordered *)
                  in
                    ([
                      (I386_Assembly.OPCODE (I386_Assembly.fld,[rs1]), absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.fcomp,[rs2]), absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.push,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.fstsw_ax,[]), absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.wait,[]), absent,"Synchronize"),
                      (I386_Assembly.OPCODE (I386_Assembly.sahf,[]), absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.pop,[I386_Assembly.r32 I386Types.EAX]), absent,""),
                      (I386_Assembly.OPCODE (I386_Assembly.jcc I386_Assembly.parity,[I386_Assembly.rel8 0]), SOME cont_tag,""),
                      (I386_Assembly.OPCODE (I386_Assembly.jcc cond,[I386_Assembly.rel8 0]), SOME tag,""),
                      (I386_Assembly.OPCODE (I386_Assembly.jmp,[I386_Assembly.rel8 0]), SOME cont_tag,"")
                      ],
		     [],MirTypes.BLOCK (cont_tag,opcode_list) :: block_list, final_result, stack_drop, param_slots, true)
                  end

		| MirTypes.BRANCH_AND_LINK
                    (_, MirTypes.REG reg_operand,debug_information, _) =>
                      if reg_operand_is_spill reg_operand then
                        Crash.impossible"register to branch and link is spill"
                      else
                        ([(I386_Assembly.AugOPCODE
                           (I386_Assembly.OPCODE
                            (I386_Assembly.lea,
                             [I386_Assembly.r32 I386Types.global,
                              I386_Assembly.r_m32
                              (I386_Assembly.INR
                               (I386_Assembly.MEM
                                {base=SOME(lookup_reg_operand reg_operand),
                                 index=absent,
                                 offset=SOME(I386_Assembly.SMALL
                                             Tags.CODE_OFFSET)}))]),
                            debug_information),
                           absent, "compute real target address"),
		        (I386_Assembly.OPCODE
			 (I386_Assembly.call,
			  [I386_Assembly.r_m32(I386_Assembly.INL
					       I386Types.global)]),
			 absent, "call to tagged value")],
                        opcode_list, block_list, final_result, stack_drop, 0, false)

		| MirTypes.BRANCH_AND_LINK(_, MirTypes.TAG tag,_, _) =>
		    ([(I386_Assembly.OPCODE
		       (I386_Assembly.call, [I386_Assembly.rel32 0]),
		      SOME tag, "call relative")],
		    opcode_list, block_list, final_result, stack_drop, 0, false)
		| MirTypes.TAIL_CALL(_, bl_dest, list) =>
		    let
		      (* One less because caller_arg isn't stacked *)
		      val output_parameters =
			let
			  val len = Lists.length list
			in
			  if len = 0 then 0 else len - 1
			end
		      val jump =
			case bl_dest of
			  MirTypes.REG reg =>
			    if reg_operand_is_spill reg then
			      Crash.impossible"reg operand to tail call is spill"
			    else
			      (* This needs work to get the offset right *)
			      [(I386_Assembly.OPCODE
				(I386_Assembly.lea,
				 [I386_Assembly.r32 I386Types.global,
				  I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME(lookup_reg_operand reg),
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL Tags.CODE_OFFSET)}))]),
				absent, "increment destination by offset to code"),
			       (I386_Assembly.OPCODE
				(I386_Assembly.jmp,
				 [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global)]),
				absent, "branch indirect(tail call)")]
			| MirTypes.TAG tag =>
			      [(I386_Assembly.OPCODE
				(I386_Assembly.jmp,
				 [I386_Assembly.rel8 0]),
				SOME tag, "branch relative(tail call)")]
(*
		      val _ = print
			("Tail call from " ^ procedure_name ^
			 "with " ^ Int.toString max_args ^
			 " input parameters and " ^
			 Int.toString output_parameters ^
			 " output parameters\n")
*)
		      val shuffle_then_jump =
			if output_parameters = max_args then
			  (* No change in parameters space above ret *)
			  jump
			else
			if output_parameters < max_args then
			  (* Less parameters than we started with *)
			  (* Easy case *)
			  let
			    val amount_to_drop =
			      (max_args - output_parameters) * 4
			    val pop_ret =
			      (I386_Assembly.OPCODE
			       (I386_Assembly.pop,
				[I386_Assembly.r_m32
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME I386Types.sp,
				    index=absent,
				    offset=SOME
				    (I386_Assembly.SMALL(amount_to_drop-4))}))]),
			       absent,
			       "pop return address into correct place on stack")
			    val rest =
			      if amount_to_drop = 4 then
				(* No stack drop necessary, the pop has done it *)
				jump
			      else
				(I386_Assembly.OPCODE
				 (I386_Assembly.add,
				  [I386_Assembly.r_m32(I386_Assembly.INL I386Types.sp),
				   I386_Assembly.imm8(amount_to_drop - 4)]),
				 absent,
				 "increment stack pointer") :: jump
			  in
			    pop_ret :: rest
			  end
			else
			  (* Hard case, some parameters to be inserted *)
			  (* Shouldn't happen *)
			  Crash.impossible("i386_cg:insufficient room for new tail parameters in " ^ procedure_name)
		      val tail_seq =
			if frame_left = 0 then
			  shuffle_then_jump
			else
			  (I386_Assembly.OPCODE
			   (I386_Assembly.add,
			    [I386_Assembly.r_m32(I386_Assembly.INL I386Types.sp),
			     if frame_left <= 127 then
			       I386_Assembly.imm8 frame_left
			     else
			       I386_Assembly.imm32
			       (frame_left div 4, frame_left mod 4)]),
			   absent, "junk spill and stack alloc area") ::
			  shuffle_then_jump
		    in
		      (if needs_preserve then
			 (I386_Assembly.OPCODE
			  (I386_Assembly.pop,
			   [I386_Assembly.r32 I386Types.callee_closure]),
			  absent, "throw away frame link") ::
			 (I386_Assembly.OPCODE
			  (I386_Assembly.pop,
			   [I386_Assembly.r32 I386Types.callee_closure]),
			  absent, "restore caller's closure") :: restore_gcs @
			 tail_seq
		       else
			 shuffle_then_jump,
			 opcode_list, block_list, final_result, stack_drop,
			 0, false)
		    end
		| MirTypes.SWITCH(computed_goto, reg_operand, tag_list) =>
		    (case opcode_list of
		       [] =>
			 (case tag_list of
			    [] => Crash.impossible"switch:empty tag list"
			  | [tag] =>
			      ([(I386_Assembly.OPCODE
				 (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
				 SOME tag, "Unconditional branch")],
			       opcode_list, block_list, final_result, stack_drop, param_slots, false)
			  | [tag1, tag2] =>
			      let
				val last_branch =
				  [(I386_Assembly.OPCODE
				    (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
				    SOME tag2, "Unconditional branch")]
				val operand =
				  I386_Assembly.r_m32
				  (if reg_operand_is_spill reg_operand then
				     I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.sp,
				       index=absent,
				       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
				   else
				     I386_Assembly.INL(lookup_reg_operand reg_operand))
			      in
				((I386_Assembly.OPCODE
				  (I386_Assembly.cmp, [operand, I386_Assembly.imm8 0]),
				  absent, "check for zero") ::
				 (I386_Assembly.OPCODE
				  (I386_Assembly.jcc(I386_Assembly.equal),
				   [I386_Assembly.rel8 0]),
				  SOME tag1, "branch if zero") ::
				 last_branch,
				 opcode_list, block_list, final_result, stack_drop, param_slots, false)
			      end
			  | _ =>
			      let
				fun make_branches([], result) = rev result
				  | make_branches(tag :: tag_list, result) =
				    make_branches(tag_list,
						  full_nop ::
						  full_nop ::
						  full_nop ::
						  (I386_Assembly.OPCODE
						   (I386_Assembly.jmp,
						    [I386_Assembly.fix_rel32 0]),
						   SOME tag,
						   "part of computed goto table") ::
						  result)
				val operand =
				  I386_Assembly.r_m32
				  (if reg_operand_is_spill reg_operand then
				     I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.sp,
				       index=absent,
				       offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))})
				   else
				     I386_Assembly.INL(lookup_reg_operand reg_operand))
				val tag = MirTypes.new_tag()
			      in
(* This could be better done with mov ecx, -1(edi), lea ecx offset(ecx, reg, 2) *)
				([(I386_Assembly.OPCODE
				   (I386_Assembly.mov,
				    [I386_Assembly.r32 I386Types.global,
				     I386_Assembly.imm32(0, Tags.CODE_OFFSET)]),
				   SOME tag,
				   "get start of table offset"),
				  (I386_Assembly.OPCODE
				   (I386_Assembly.add,
				    [I386_Assembly.r32 I386Types.global,
				     I386_Assembly.r_m32
				     (I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME I386Types.callee_closure,
					index=absent,
					offset=SOME(I386_Assembly.SMALL ~1)}))]),
				   absent, "add in start of code"),
				  (I386_Assembly.OPCODE
				   (I386_Assembly.add,
				    [I386_Assembly.r32 I386Types.global, operand]),
				   absent, "add in the switch value"),
				  (I386_Assembly.OPCODE
				   (I386_Assembly.add,
				    [I386_Assembly.r32 I386Types.global, operand]),
				   absent, "add in the switch value ( *2)"),
				  (I386_Assembly.OPCODE
				  (I386_Assembly.jmp,
				   [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global)]),
				   absent,
				   "jump into table")],
				 [],
				 block_list,
				 (tag, make_branches(tag_list, [])) :: final_result,
				 stack_drop, param_slots, false)
			      end)
			    | _ => Crash.impossible"SWITCH followed by instructions")
		| MirTypes.ALLOCATE_STACK(allocate, reg_operand, alloc_size,
					  SOME fp_offset) =>
		  let
		    val _ =
		      if alloc_size + fp_offset > gc_stack_alloc_size then
			Crash.impossible("Stack allocation of " ^
					 Int.toString alloc_size ^
					 " at offset " ^
					 Int.toString fp_offset ^
					 " requested, in total area of only " ^
					 Int.toString
					 gc_stack_alloc_size)
		      else()
		  in
		    case allocate of
		      MirTypes.ALLOC =>
			let
			  val needs_spare = reg_operand_is_spill reg_operand
			  val (rd, opcode_list) =
			    if needs_spare then
			      (I386Types.global,
			       MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					      MirTypes.GP_GC_REG MirRegisters.global) ::
			       opcode_list)
			    else
			      (lookup_reg_operand reg_operand, opcode_list)
			  val offset =
			    frame_size + stack_drop + param_slots + Tags.PAIRPTR -
			    (gc_stack_alloc_offset +
			     4 * (fp_offset + alloc_size))
			in
			  ([(I386_Assembly.OPCODE
			     (I386_Assembly.lea,
			      [I386_Assembly.r32 rd,
			       I386_Assembly.r_m32
			       (I386_Assembly.INR
				(I386_Assembly.MEM
				 {base=SOME I386Types.sp,
				  index=absent,
				  offset=SOME(I386_Assembly.SMALL offset)}))]),
			     absent, "get pointer into stack")],
			  opcode_list, block_list, final_result, stack_drop, param_slots, false)
			end
		    | _ => Crash.impossible"ALLOCATE_STACK strange allocate"
		  end
		 | MirTypes.ALLOCATE_STACK _ =>
		     Crash.impossible"ALLOCATE_STACK with no offset"
		 | MirTypes.DEALLOCATE_STACK _ =>
		     ([], opcode_list, block_list, final_result, stack_drop, param_slots, false)

		 | MirTypes.ALLOCATE(allocate, reg_operand, gp_operand) =>
		     let
		       val needs_temp = reg_operand_is_spill reg_operand
		       val rd =
			 if needs_temp then
			   I386Types.global
			 else
			   lookup_reg_operand reg_operand
                       val gc_entry =
			 4 *
                         (if needs_preserve then
			    Implicit_Vector.gc
			  else
			    Implicit_Vector.gc_leaf)

		       val tag1 = MirTypes.new_tag()
		       val tag2 = MirTypes.new_tag()
		       val tag3 = MirTypes.new_tag()
		     in
		       case gp_operand of
			 MirTypes.GP_IMM_INT size =>
			   let
			     val (bytes, primary, aligned, header) =
			       case allocate of
				 MirTypes.ALLOC =>
				   if size = 2 then
				     (8, Tags.PAIRPTR, true, 0)
				   else
				     (8 * ((size+2) div 2), Tags.POINTER,
				      size mod 2 <> 0, 64*size+Tags.RECORD)
                               | MirTypes.ALLOC_VECTOR =>
                                   (8 * ((size+2) div 2), Tags.POINTER,
                                    size mod 2 <> 0, 64*size+Tags.RECORD)
			       | MirTypes.ALLOC_STRING =>
				   (((size+11) div 8) * 8,
				    Tags.POINTER, true, 64*size+Tags.STRING)
			       | MirTypes.ALLOC_REAL =>
				   (case I386Types.fp_used
				      of I386Types.single   => Crash.unimplemented "ALLOC_REAL single"
				    | I386Types.extended => Crash.unimplemented "ALLOC_REAL extended"
				    | I386Types.double   =>
					(16, Tags.POINTER, true,
					 64*(16 - 4) + Tags.BYTEARRAY))
			       | MirTypes.ALLOC_REF  =>
				   (8 + 8*((size+2) div 2),
				    Tags.REFPTR, size mod 2 <> 0, 64*size+Tags.ARRAY)
			       | MirTypes.ALLOC_BYTEARRAY =>
				   (((size+12) div 8) * 8, Tags.REFPTR, true,
				    64*size+Tags.BYTEARRAY)
			     val header_code =
			       [(I386_Assembly.OPCODE
				 (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
				 SOME tag3, "jump to rest of code")]
			     val header_code =
			       if header = 0 then
				 header_code
			       else
				 (I386_Assembly.OPCODE
				  (I386_Assembly.mov,
				   [I386_Assembly.r_m32
				    (I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME rd,
				       index=absent,
				       offset=SOME(I386_Assembly.SMALL(~primary))})),
				    I386_Assembly.imm32(header div 4, header mod 4)]),
				  absent, "initialise header") :: header_code
			     val header_code =
			       if aligned then
				 header_code
			       else
				 (I386_Assembly.OPCODE
				  (I386_Assembly.mov,
				   [I386_Assembly.r_m32
				    (I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME rd,
				       index=absent,
				       offset=SOME(I386_Assembly.SMALL(bytes - primary - 4))})),
				    I386_Assembly.imm32(0, 0)]),
				  absent, "zero unaligned extra word") :: header_code
				
			     val decrement_imm =
			       let
				 val size = bytes-primary
			       in
				 if size <= 127 then
				   I386_Assembly.imm8 size
				 else
				   I386_Assembly.imm32(size div 4, size mod 4)
			       end
			     val opcodes1 =
				[(I386_Assembly.OPCODE
				  (I386_Assembly.jmp,
				   [I386_Assembly.rel8 0]),
				  SOME tag2,
				  "branch to continuation sequence")]
			     val opcodes1 =
			       (if rd = I386Types.global andalso primary = 1 then
				  (I386_Assembly.OPCODE
				   (I386_Assembly.inc, [I386_Assembly.r32 rd]),
				   absent,
				   "special case where we can use increment")
				else
				  (I386_Assembly.OPCODE
				   (I386_Assembly.lea,
				    [I386_Assembly.r32 rd,
				     I386_Assembly.r_m32
				     (I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME I386Types.global,
					index=absent,
					offset=SOME(I386_Assembly.SMALL primary)}))]),
				   absent, "produce the answer")) :: opcodes1
			     val opcodes1 =
			       (if rd = I386Types.global then
				  move_imm(I386Types.global, bytes, "amount requested")
				else
				  (* We have zero placed in rd, and so can use lea *)
				  (* This is shorter than mov *)
				  (* as we can get an eight bit displacement *)
				  (I386_Assembly.OPCODE
				   (I386_Assembly.lea,
				    [I386_Assembly.r32 I386Types.global,
				     I386_Assembly.r_m32
				     (I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME rd,
					index=absent,
					offset=SOME(I386_Assembly.SMALL bytes)}))]),
				   absent, "amount requested")) ::
				  (I386_Assembly.OPCODE
				   (I386_Assembly.call,
				    [I386_Assembly.r_m32
				     (I386_Assembly.INR
				      (I386_Assembly.MEM
				       {base=SOME I386Types.implicit,
					index=absent,
					offset=SOME(I386_Assembly.SMALL gc_entry)}))]),
				   absent, "call the gc") :: opcodes1
			     val opcodes1 =
			       if rd = I386Types.global then
				 opcodes1
			       else
				 (I386_Assembly.OPCODE
				  (I386_Assembly.xor,
				   [I386_Assembly.r32 rd,
				    I386_Assembly.r_m32(I386_Assembly.INL rd)]),
				  absent, "clear bad value before gc") ::
				 opcodes1
			     val opcodes1 =
			       (I386_Assembly.OPCODE
				(I386_Assembly.add,
				 [I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.implicit,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.gc_base))})),
				  if bytes <= 127 then
				    I386_Assembly.imm8 bytes
				  else
				    I386_Assembly.imm32(bytes div 4, bytes mod 4)]),
				absent,
				"increment base pointer") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.mov,
				 [I386_Assembly.r32 rd,
				  I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.implicit,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.gc_base))}))]),
				absent,
				"acquire base pointer for result") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.cmp,
				 [I386_Assembly.r32 rd,
				  I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.implicit,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.gc_limit))}))]),
				absent,
				"check for run out of store") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.lea,
				 [I386_Assembly.r32 rd,
				  I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME rd,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(primary-bytes))}))]),
				absent, "tag pointer correctly") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.jcc I386_Assembly.below,
				 [I386_Assembly.rel8 0]), SOME tag2,
				"branch if not run out of heap") ::
			       opcodes1
			     val opcodes2 =
			       [(I386_Assembly.OPCODE
				 (I386_Assembly.sub,
				  [I386_Assembly.r_m32(I386_Assembly.INL rd),
				   decrement_imm]),
				 absent, "tag pointer correctly"),
				(I386_Assembly.OPCODE
				 (I386_Assembly.jmp,
				  [I386_Assembly.rel8 0]),
				 SOME tag2,
				 "branch to continuation sequence")]
			     val opcodes3 = header_code
			     val opcode_list =
			       if needs_temp then
				 MirTypes.UNARY(MirTypes.MOVE, reg_operand,
						MirTypes.GP_GC_REG MirRegisters.global) ::
				 opcode_list
			       else
				 opcode_list
			   in
			     (opcodes1, [], MirTypes.BLOCK(tag3, opcode_list) :: block_list,
			      (tag2, opcodes3) :: final_result,
			      stack_drop, param_slots, true)
			
			   end
		       | MirTypes.GP_GC_REG reg =>
			   let
			     val size_is_spill = gp_operand_is_spill gp_operand
			     val size_reg =
			       if size_is_spill then
				 I386Types.global
			       else
				 lookup_gp_operand gp_operand
			     val eax_is_size = size_reg = I386Types.EAX
			     val (rd_operand, mod_rd_operand) =
			       if needs_temp then
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME I386Types.sp,
				    index=absent,
				    offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))}),
				  I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME I386Types.sp,
				    index=absent,
				    offset=SOME (* Offset changes from push *)
				    (I386_Assembly.SMALL(4+reg_spill_value reg_operand))}))
			       else
				 (I386_Assembly.INL(lookup_reg_operand reg_operand),
				  I386_Assembly.INL(lookup_reg_operand reg_operand))
			     val rd_operand = I386_Assembly.r_m32 rd_operand
			     val mod_rd_operand = I386_Assembly.r_m32 mod_rd_operand

			     val (primary, secondary, length_code) =
			       case allocate of
				 MirTypes.ALLOC        => Crash.unimplemented "ALLOC variable size"
                               | MirTypes.ALLOC_VECTOR =>
				   (Tags.POINTER, Tags.RECORD,
				    (if size_is_spill then
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [I386_Assembly.r32 I386Types.global,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.sp,
					      index=absent,
					      offset=SOME
					      (I386_Assembly.SMALL(gp_spill_value gp_operand))}))]),
					 absent, "get size into a register")]
				     else
				       []) @
				    (if needs_temp then
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [rd_operand,
					   I386_Assembly.r32 size_reg]),
					 absent, "move in requested length"),
					(I386_Assembly.OPCODE
					 (I386_Assembly.add,
					  [rd_operand,
					   I386_Assembly.imm8(4+7)]),
					 absent, "add in extra length for alignment")]
				     else
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.lea,
					  [I386_Assembly.r32 rd,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME size_reg,
					      index=absent,
					      offset=SOME(I386_Assembly.SMALL(4+7))}))]),
					 absent, "Calculate length of Vector")]))

			       | MirTypes.ALLOC_STRING =>
                                   (Tags.POINTER, Tags.STRING,
				    (if needs_temp andalso size_is_spill then
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [I386_Assembly.r32 I386Types.global,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.sp,
					      index=absent,
					      offset=SOME
					      (I386_Assembly.SMALL(gp_spill_value gp_operand))}))]),
					 absent, "get size into ECX"),
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [rd_operand, I386_Assembly.r32 I386Types.global]),
					absent, "and then into rd(spill)")]
				     else
				       if size_is_spill then
					 [(I386_Assembly.OPCODE
					   (I386_Assembly.mov,
					    [I386_Assembly.r32 rd,
					     I386_Assembly.r_m32
					     (I386_Assembly.INR
					      (I386_Assembly.MEM
					       {base=SOME I386Types.sp,
						index=absent,
						offset=SOME
						(I386_Assembly.SMALL(gp_spill_value gp_operand))}))]),
					   absent, "get size in rd")]
				       else
					 [(I386_Assembly.OPCODE
					   (I386_Assembly.mov,
					    [rd_operand,
					     I386_Assembly.r32
					     (lookup_gp_operand gp_operand)]),
					   absent, "get size in rd")]
				     ) @
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.shr,
					  [rd_operand, I386_Assembly.imm8 2]),
					 absent, "remove ml tag"),
					(I386_Assembly.OPCODE
					 (I386_Assembly.add,
					  [rd_operand, I386_Assembly.imm8(4+7)]),
					 absent, "allow correct number of double words")])
			       | MirTypes.ALLOC_REAL   => Crash.unimplemented "ALLOC_REAL variable size"
			       | MirTypes.ALLOC_REF    =>
				   (Tags.REFPTR, Tags.ARRAY,
				    (if size_is_spill then
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [I386_Assembly.r32 I386Types.global,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.sp,
					      index=absent,
					      offset=SOME
					      (I386_Assembly.SMALL(gp_spill_value gp_operand))}))]),
					 absent, "get size into a register")]
				     else
				       []) @
				    (if needs_temp then
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [rd_operand,
					   I386_Assembly.r32 size_reg]),
					 absent, "move in requested length"),
					(I386_Assembly.OPCODE
					 (I386_Assembly.add,
					  [rd_operand,
					   I386_Assembly.imm8(12+7)]),
					 absent, "add in extra length for alignment")]
				     else
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.lea,
					  [I386_Assembly.r32 rd,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME size_reg,
					      index=absent,
					      offset=SOME(I386_Assembly.SMALL(12+7))}))]),
					 absent, "Calculate length of Array")]))
			       | MirTypes.ALLOC_BYTEARRAY =>
				   (Tags.REFPTR, Tags.BYTEARRAY,
				    (if needs_temp andalso size_is_spill then
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.mov,
					  [I386_Assembly.r32 I386Types.global,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.sp,
					      index=absent,
					      offset=SOME
					      (I386_Assembly.SMALL(gp_spill_value gp_operand))}))]),
					 absent, "get size into ECX"),
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [rd_operand, I386_Assembly.r32 I386Types.global]),
					absent, "and then into rd(spill)")]
				     else
				       if size_is_spill then
					 [(I386_Assembly.OPCODE
					   (I386_Assembly.mov,
					    [I386_Assembly.r32 rd,
					     I386_Assembly.r_m32
					     (I386_Assembly.INR
					      (I386_Assembly.MEM
					       {base=SOME I386Types.sp,
						index=absent,
						offset=SOME
						(I386_Assembly.SMALL(gp_spill_value gp_operand))}))]),
					   absent, "get size in rd")]
				       else
					 [(I386_Assembly.OPCODE
					   (I386_Assembly.mov,
					    [rd_operand,
					     I386_Assembly.r32
					     (lookup_gp_operand gp_operand)]),
					   absent, "get size in rd")]
				     ) @
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.shr,
					  [rd_operand, I386_Assembly.imm8 2]),
					 absent, "remove ml tag"),
					(I386_Assembly.OPCODE
					 (I386_Assembly.add,
					  [rd_operand, I386_Assembly.imm8(4+7)]),
					 absent, "allow correct number of double words")])
			     val do_check =
			       (I386_Assembly.OPCODE
				(I386_Assembly.mov,
				 [I386_Assembly.r32 I386Types.global,
				  I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.implicit,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.gc_base))}))]),
				absent,
				"acquire base pointer for result") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.cmp,
				 [I386_Assembly.r32 I386Types.global,
				  I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.implicit,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.gc_limit))}))]),
				absent,
				"check for run out of store") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.jcc I386_Assembly.below,
				 [I386_Assembly.rel8 0]), SOME tag1,
				"branch if not run out of heap") ::
			       []
			     val do_check =
			       if needs_temp then
				 (I386_Assembly.OPCODE
				  (I386_Assembly.mov,
				   [I386_Assembly.r32 I386Types.global,
				    rd_operand]),
				  absent, "make length available in ECX") ::
				 (I386_Assembly.OPCODE
				  (I386_Assembly.add,
				   [I386_Assembly.r_m32
				    (I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.implicit,
				       index=absent,
				       offset=SOME
				       (I386_Assembly.SMALL(4*Implicit_Vector.gc_base))})),
				    I386_Assembly.r32 I386Types.global]),
				  absent,
				  "increment base pointer") ::
				 do_check
			       else
				 (I386_Assembly.OPCODE
				  (I386_Assembly.add,
				   [I386_Assembly.r_m32
				    (I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.implicit,
				       index=absent,
				       offset=SOME
				       (I386_Assembly.SMALL(4*Implicit_Vector.gc_base))})),
				    I386_Assembly.r32 rd]),
				  absent,
				  "increment base pointer") ::
				 do_check
			     val do_check =
			       (I386_Assembly.OPCODE
				(I386_Assembly.and_op,
				 [rd_operand, I386_Assembly.imm8 ~8]),
				absent, "clear bottom three bits") :: do_check
			     val tag2_jmp =
			       [(I386_Assembly.OPCODE
				 (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
				 SOME tag2, "jump to continuation point")]
			     val do_gc =
			       if needs_temp then
				 (I386_Assembly.OPCODE
				  (I386_Assembly.add,
				   [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global),
				    I386_Assembly.imm8 primary]),
				   absent, "tag ECX") ::
				 (I386_Assembly.OPCODE
				  (I386_Assembly.mov,
				   [rd_operand, I386_Assembly.r32 I386Types.global]),
				  absent, "store tagged pointer in spill") ::
				 tag2_jmp
			       else
				 (I386_Assembly.OPCODE
				  (I386_Assembly.lea,
				   [I386_Assembly.r32 rd,
				    I386_Assembly.r_m32
				    (I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.global,
				       index=absent,
				       offset=SOME(I386_Assembly.SMALL primary)}))]),
				  absent, "produce the answer") ::
				 tag2_jmp
			     val do_gc =
			       (I386_Assembly.OPCODE
				(I386_Assembly.mov,
				 [I386_Assembly.r32 I386Types.global, rd_operand]),
				absent, "Acquire the length in ECX") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.call,
				 [I386_Assembly.r_m32
				  (I386_Assembly.INR
				   (I386_Assembly.MEM
				    {base=SOME I386Types.implicit,
				     index=absent,
				     offset=SOME(I386_Assembly.SMALL gc_entry)}))]),
				absent, "call the gc") ::
			       do_gc
			     val opcodes1 = length_code @ do_check @ do_gc
			     val opcodes2 =
			       case rd_operand of
				 I386_Assembly.r_m32(I386_Assembly.INL reg) =>
				   (I386_Assembly.OPCODE
				    (I386_Assembly.lea,
				     [I386_Assembly.r32 reg,
				      I386_Assembly.r_m32
				      (I386_Assembly.INR
				       (I386_Assembly.MEM
					{base=SOME reg,
					 index=SOME(I386Types.global, absent),
					 offset=SOME(I386_Assembly.SMALL primary)}))]),
				    absent, "compute tagged pointer") ::
				   tag2_jmp
			       | _ =>
				   (I386_Assembly.OPCODE
				    (I386_Assembly.add,
				     [rd_operand, I386_Assembly.r32 I386Types.global]),
				    absent, "add in pointer") ::
				   (I386_Assembly.OPCODE
				    (I386_Assembly.add,
				     [rd_operand, I386_Assembly.imm8 primary]),
				    absent, "add in primary tag") ::
				   tag2_jmp
			     val opcodes2 =
			       (* Stuff to set up the pointer when no gc *)
			       (I386_Assembly.OPCODE
				(I386_Assembly.neg, [rd_operand]),
				absent, "negate size computed earlier") :: opcodes2
			     val tag3_jmp =
			       [(I386_Assembly.OPCODE
				 (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
				 SOME tag3, "branch to rest of code")]
			     (* At this point we assume the pointer *)
			     (* is set up in the destination *)
			     (* The secondary is set up in ecx *)
			     val set_secondary_and_initialise_rest =
			       case allocate of
				 MirTypes.ALLOC_REF =>
				   let
				     val (pointer, index) =
				       if needs_temp then
					 if eax_is_size then
					   (I386Types.EBX, I386Types.global)
					 else
					   (I386Types.EAX, I386Types.global)
				       else
					 (rd, I386Types.global)
				     val offset = 9
				     val tag_jmp =
				       if needs_temp then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.pop,
					   [I386_Assembly.r32 pointer]),
					  absent, "restore temporary") ::
					 tag3_jmp
				       else
					 tag3_jmp
				     val initialise_last =
				       (I386_Assembly.OPCODE
					(I386_Assembly.and_op,
					 [I386_Assembly.r_m32(I386_Assembly.INL index),
					  I386_Assembly.imm8 ~8]),
					absent, "clamp index by 8 to avoid writing off end") ::
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [I386_Assembly.r_m32
					  (I386_Assembly.INR
					   (I386_Assembly.MEM
					    {base=SOME pointer,
					     index=SOME(index, absent),
					     offset=SOME(I386_Assembly.SMALL offset)})),
					  I386_Assembly.imm32(0, 0)]),
					absent, "initialise final word in case unaligned") ::
				       tag_jmp
				     val get_index =
				       if size_is_spill then
					 let
					   val spill_value = gp_spill_value gp_operand
					   val spill_value =
					     if needs_temp then
					       spill_value+4
					     else
					       spill_value
					 in
					   (I386_Assembly.OPCODE
					    (I386_Assembly.mov,
					     [I386_Assembly.r32 index,
					      I386_Assembly.r_m32
					      (I386_Assembly.INR
					       (I386_Assembly.MEM
						{base=SOME I386Types.sp,
						 index=absent,
						 offset=SOME(I386_Assembly.SMALL spill_value)}))]),
					    absent, "get original requested size") ::
					   initialise_last
					 end
				       else
					 (I386_Assembly.OPCODE
					  (I386_Assembly.mov,
					   [I386_Assembly.r32 index,
					    I386_Assembly.r_m32
					    (I386_Assembly.INL(lookup_gp_operand gp_operand))]),
					  absent, "get original requested size") ::
					 initialise_last
				     val store_secondary =
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [I386_Assembly.r_m32
					  (I386_Assembly.INR
					   (I386_Assembly.MEM
					    {base=SOME pointer,
					     index=absent,
					     offset=SOME(I386_Assembly.SMALL(~primary))})),
					  I386_Assembly.r32 I386Types.global]),
					absent, "store the secondary tag") :: get_index
				     val get_pointer =
				       if needs_temp then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.push,
					   [I386_Assembly.r32 pointer]),
					  absent, "save temporary") ::
					 (I386_Assembly.OPCODE
					  (I386_Assembly.mov,
					   [I386_Assembly.r32 pointer, mod_rd_operand]),
					  absent, "get pointer to new store") ::
					 store_secondary
				       else
					 store_secondary
				   in
				     get_pointer
				   end
			       | MirTypes.ALLOC_VECTOR =>
				   let
				     val (pointer, index) =
				       if needs_temp then
					 if eax_is_size then
					   (I386Types.EBX, I386Types.global)
					 else
					   (I386Types.EAX, I386Types.global)
				       else
					 (rd, I386Types.global)
				     val offset = ~1
				     val tag_jmp =
				       if needs_temp then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.pop,
					   [I386_Assembly.r32 pointer]),
					  absent, "restore temporary") ::
					 tag3_jmp
				       else
					 tag3_jmp
				     val initialise_last =
				       (I386_Assembly.OPCODE
					(I386_Assembly.and_op,
					 [I386_Assembly.r_m32(I386_Assembly.INL index),
					  I386_Assembly.imm8 ~8]),
					absent, "clamp index by 8 to avoid writing off end") ::
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [I386_Assembly.r_m32
					  (I386_Assembly.INR
					   (I386_Assembly.MEM
					    {base=SOME pointer,
					     index=SOME(index, absent),
					     offset=SOME(I386_Assembly.SMALL offset)})),
					  I386_Assembly.imm32(0, 0)]),
					absent, "initialise final word in case unaligned") ::
				       tag_jmp
				     val get_index =
				       if size_is_spill then
					 let
					   val spill_value = gp_spill_value gp_operand
					   val spill_value =
					     if needs_temp then
					       spill_value+4
					     else
					       spill_value
					 in
					   (I386_Assembly.OPCODE
					    (I386_Assembly.mov,
					     [I386_Assembly.r32 index,
					      I386_Assembly.r_m32
					      (I386_Assembly.INR
					       (I386_Assembly.MEM
						{base=SOME I386Types.sp,
						 index=absent,
						 offset=SOME(I386_Assembly.SMALL spill_value)}))]),
					    absent, "get original requested size") ::
					   initialise_last
					 end
				       else
					 (I386_Assembly.OPCODE
					  (I386_Assembly.mov,
					   [I386_Assembly.r32 index,
					    I386_Assembly.r_m32
					    (I386_Assembly.INL(lookup_gp_operand gp_operand))]),
					  absent, "get original requested size") ::
					 initialise_last
				     val store_secondary =
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [I386_Assembly.r_m32
					  (I386_Assembly.INR
					   (I386_Assembly.MEM
					    {base=SOME pointer,
					     index=absent,
					     offset=SOME(I386_Assembly.SMALL(~primary))})),
					  I386_Assembly.r32 I386Types.global]),
					absent, "store the secondary tag") :: get_index
				     val get_pointer =
				       if needs_temp then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.push,
					   [I386_Assembly.r32 pointer]),
					  absent, "save temporary") ::
					 (I386_Assembly.OPCODE
					  (I386_Assembly.mov,
					   [I386_Assembly.r32 pointer, mod_rd_operand]),
					  absent, "get pointer to new store") ::
					 store_secondary
				       else
					 store_secondary
				   in
				     get_pointer
				   end
			       | _ =>
				   let
				     (* No initialisation for byte arrays *)
				     (* or strings *)
				     val (pointer, needs_push) =
				       if needs_temp then
					 if eax_is_size then
					   (I386Types.EBX, true)
					 else
					   (I386Types.EAX, true)
				       else
					 (rd, false)
				     val tag_jmp =
				       if needs_push then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.pop,
					   [I386_Assembly.r32 pointer]),
					  absent, "restore temporary") :: tag3_jmp
				       else
					 tag3_jmp
				     val store_secondary =
				       (I386_Assembly.OPCODE
					(I386_Assembly.mov,
					 [I386_Assembly.r_m32
					  (I386_Assembly.INR
					   (I386_Assembly.MEM
					    {base=SOME pointer,
					     index=absent,
					     offset=SOME(I386_Assembly.SMALL(~primary))})),
					  I386_Assembly.r32 I386Types.global]),
					absent, "store the secondary tag") ::
				       tag_jmp
				     val get_pointer =
				       if needs_temp then
					 (I386_Assembly.OPCODE
					  (I386_Assembly.push,
					   [I386_Assembly.r32 pointer]),
					  absent, "save temporary") ::
					 (I386_Assembly.OPCODE
					  (I386_Assembly.mov,
					   [I386_Assembly.r32 pointer, mod_rd_operand]),
					  absent, "get pointer to new store") ::
					 store_secondary
				       else
					 store_secondary
				   in
				     get_pointer
				   end
			     val opcodes3 =
			       (* Stuff to set the secondary tag *)
			       (I386_Assembly.OPCODE
				(I386_Assembly.mov,
				 [I386_Assembly.r32 I386Types.global,
				  I386_Assembly.r_m32
				  (if size_is_spill then
				     I386_Assembly.INR
				     (I386_Assembly.MEM
				      {base=SOME I386Types.sp,
				       index=absent,
				       offset=SOME
				       (I386_Assembly.SMALL(gp_spill_value gp_operand))})
				   else
				     I386_Assembly.INL(lookup_gp_operand gp_operand))]),
				absent, "get requested size in ECX") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.shl,
				 [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global),
				  I386_Assembly.imm8 4]),
				absent, "raw number of bytes << 6") ::
			       (I386_Assembly.OPCODE
				(I386_Assembly.add,
				 [I386_Assembly.r_m32(I386_Assembly.INL I386Types.global),
				  I386_Assembly.imm8 secondary]),
				absent, "add in secondary tag") ::
			       set_secondary_and_initialise_rest
			   in
			     (opcodes1,
			      [],
			      MirTypes.BLOCK(tag3, opcode_list) :: block_list,
			      (tag2, opcodes3) :: (tag1, opcodes2) :: final_result,
			      stack_drop, param_slots, true)
			   end
		       | _ => Crash.impossible "Strange parameter to ALLOCATE"
                     end
		 | MirTypes.ADR(adr, reg_operand, tag) =>
		     (case adr of
			MirTypes.LEA =>
			  Crash.unimplemented"MirTypes.LEA"
		      (* Note that lr points to the call instruction *)
		      (* Thus lr + 4, as computed by the ADD *)
		      (* points to the ADD instruction, which is fixed *)
		      (* up during linearisation *)
		      | MirTypes.LEO =>
			  let
			    val rd =
			      if reg_operand_is_spill reg_operand then
				I386_Assembly.r_m32
				(I386_Assembly.INR
				 (I386_Assembly.MEM
				  {base=SOME I386Types.sp,
				   index=absent,
				   offset=SOME(I386_Assembly.SMALL(reg_spill_value reg_operand))}))
			      else
				I386_Assembly.r32(lookup_reg_operand reg_operand)
			  in
			    (([(I386_Assembly.OPCODE
			       (I386_Assembly.mov, [rd, I386_Assembly.imm32(0, 0)]),
			       SOME tag,
			       "get offset of tag from procedure start")]),
			     opcode_list, block_list, final_result, stack_drop, param_slots, false)
			  end)

                | MirTypes.INTERCEPT =>
		    (trace_dummy_instructions, opcode_list, block_list, final_result, stack_drop, param_slots, false)

                | MirTypes.INTERRUPT =>
		    let
		      val continue_tag = MirTypes.new_tag() (* Normal flow *)
		      val check_instrs =
			[(I386_Assembly.OPCODE
			  (I386_Assembly.cmp,
			   [I386_Assembly.r_m32
			    (I386_Assembly.INR
			     (I386_Assembly.MEM
			      {base=SOME I386Types.implicit,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.register_stack_limit))})),
			    I386_Assembly.imm8 ~1]),
			  absent, "Check for stack_limit ~1"),
			 (I386_Assembly.OPCODE
			  (I386_Assembly.jcc I386_Assembly.not_equal,
			   [I386_Assembly.rel8 0]),
			  SOME continue_tag,
			  "branch if no interrupt")]
		      val continue =
			[(I386_Assembly.OPCODE
			  (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
			  SOME continue_tag, "continue after interrupt")]
		      val check_offset =
			if needs_preserve then
			  (* Non-leaf case *)
			  Implicit_Vector.event_check
			else
			  (* Leaf case *)
			  Implicit_Vector.event_check_leaf
		      val irupt_code =
			(I386_Assembly.OPCODE
			 (I386_Assembly.call,
			  [I386_Assembly.r_m32
			   (I386_Assembly.INR
			    (I386_Assembly.MEM
			     {base=SOME I386Types.implicit,
			      index=absent,
			      offset=SOME(I386_Assembly.SMALL(4 * check_offset))}))]),
			 absent, "do event check") :: continue
		    in
		      (check_instrs @ irupt_code, [],
		       MirTypes.BLOCK(continue_tag, opcode_list) :: block_list,
		       final_result, stack_drop, param_slots, true)
		    end
		| MirTypes.ENTER _ =>
		    if needs_preserve then
		      let
			val spare_for_tail =
			  if stack_parms >= max_tail_size then
			    0
			  else
			    max_tail_size - stack_parms
			val gc_stack_slots =
			  gc_stack_alloc_size + gc_spill_size
			(* No FP saving yet *)
			val post_overflow_tag = MirTypes.new_tag()
			val overflow_code_tag = MirTypes.new_tag()
			val real_proc_start_tag = MirTypes.new_tag()
			val post_make_stack_tag = MirTypes.new_tag()
			val overflow_jmp =
			  [(I386_Assembly.OPCODE
			    (I386_Assembly.jcc I386_Assembly.below,
			     [I386_Assembly.rel8 0]),
			    SOME overflow_code_tag,
			    "branch if stack limit exceeded"),
			   (I386_Assembly.OPCODE
			    (I386_Assembly.jmp,
			     [I386_Assembly.rel8 0]),
			    SOME post_overflow_tag,
			    "branch to normal procedure entry code")]
			val overflow_check =
			  if frame_size > 64 then
			    (* Need to check with decrement *)
			    (I386_Assembly.OPCODE
			     (I386_Assembly.lea,
			      [I386_Assembly.r32 I386Types.global,
			       I386_Assembly.r_m32
			       (I386_Assembly.INR
				(I386_Assembly.MEM
				 {base=SOME I386Types.sp,
				  index=absent,
				  offset=SOME(I386_Assembly.SMALL(~frame_size))}))]),
			     absent, "ECX = requested new sp") ::
			    (I386_Assembly.OPCODE
			     (I386_Assembly.cmp,
			      [I386_Assembly.r32 I386Types.global,
			       I386_Assembly.r_m32
			       (I386_Assembly.INR
				(I386_Assembly.MEM
				 {base=SOME I386Types.implicit,
				  index=absent,
				  offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.register_stack_limit))}))]
			      ), absent, "compare sp with limit") ::
			    overflow_jmp
			  else
			    (* Just compare sp with limit *)
			    (I386_Assembly.OPCODE
			     (I386_Assembly.cmp,
			      [I386_Assembly.r32 I386Types.sp,
			       I386_Assembly.r_m32
			       (I386_Assembly.INR
				(I386_Assembly.MEM
				 {base=SOME I386Types.implicit,
				  index=absent,
				  offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.register_stack_limit))}))]
			      ), absent, "compare sp with limit") ::
			    overflow_jmp
			val entry_seq =
			  if spare_for_tail = 0 then
			    overflow_check
			  else
			    (* Insert space need for largest tail *)
			    let
			      val push_ret_and_check =
				(I386_Assembly.OPCODE
				 (I386_Assembly.push,
				  [I386_Assembly.r32 I386Types.global]),
				 absent, "save return address") ::
				overflow_check
			      fun save_gc_safe(n, acc) =
				if n <= 0 then
				  acc
				else
				  save_gc_safe
				  (n-1,
				   (I386_Assembly.OPCODE
				    (I386_Assembly.push,
				     [I386_Assembly.r32 I386Types.callee_closure]),
				    absent, "save a gc safe value") :: acc)
			      val save_push_ret_check =
				save_gc_safe(spare_for_tail, push_ret_and_check)
			    in
			      (I386_Assembly.OPCODE
			       (I386_Assembly.pop,
				[I386_Assembly.r32 I386Types.global]),
			       absent, "acquire return address") ::
			      save_push_ret_check
			    end
			val overflow_entry_block =
			  (overflow_code_tag,
			   [(I386_Assembly.OPCODE
			     (I386_Assembly.mov,
			      [I386_Assembly.r32 I386Types.global,
			       I386_Assembly.imm32(frame_size div 4, frame_size mod 4)]),
			     absent, "put requested frame size in global"),
			   (I386_Assembly.OPCODE
			    (I386_Assembly.call,
			     [I386_Assembly.r_m32
			      (I386_Assembly.INR
			       (I386_Assembly.MEM
				{base=SOME I386Types.implicit,
				 index=absent,
				 offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.extend))}))]),
			    absent, "call stack extension code"),
			   (I386_Assembly.OPCODE
			    (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
			    SOME post_overflow_tag,
			    "continue as normal with new stack")])

                        (* Still no FP saving.  This check will catch any attempt to do so *)
                        val _ = if fp_save_size <> 0
                                  then Crash.impossible "Can't do fp saves yet"
                                else ()

                        (* And decrement sp to take account of non-gc and fp stack *)
                        val init_non_gc_stack =
                          let
                            val num_bytes = non_gc_spill_size * 4 + fp_spill_size * float_value_size
                          in
                            if num_bytes > 0
                              then [(I386_Assembly.OPCODE
                                     (I386_Assembly.sub,
                                      [I386_Assembly.r_m32(I386_Assembly.INL I386Types.sp),
                                       if num_bytes <= 127 then
                                         I386_Assembly.imm8 num_bytes
                                       else
                                         I386_Assembly.imm32
                                         (num_bytes div 4, num_bytes mod 4)]),
                                     absent, "Make room for non-gc stack area")]
                            else []
                          end

                        (* Push zeros onto stack to initialize gc stack slots *)
			val small_frame = gc_stack_slots <= 9 (* Break even point *)
			val (frame_init_a, frame_init_b) =
			  if small_frame then
			    (store_seq(gc_stack_slots-1,
				       [(I386_Assembly.OPCODE
					 (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
					 SOME post_make_stack_tag,
					 "go to gc register saving")]),
			     [])
			  else
			    store_loop(post_make_stack_tag, gc_stack_slots)

			val total_frame_size =
			  frame_size+parm_space_above_ret-4
			(* Takes account of parameters *)
			(* already on the stack *)
			val opcodes =
			  [(I386_Assembly.OPCODE
			    (I386_Assembly.push,
			     [I386_Assembly.r32 I386Types.callee_closure]),
			    absent, "save caller's closure"),
			   (I386_Assembly.OPCODE
			    (I386_Assembly.lea,
			     [I386_Assembly.r32 I386Types.global,
			      I386_Assembly.r_m32
			      (I386_Assembly.INR
			       (I386_Assembly.MEM
				{base=SOME I386Types.sp,
				 index=absent,
				 offset=SOME(I386_Assembly.SMALL total_frame_size)}))]),
			    absent, "calculate old sp"),
			   (I386_Assembly.OPCODE
			    (I386_Assembly.push,
			     [I386_Assembly.r32 I386Types.global]),
			    absent, "save old sp"),
			   move_reg(I386Types.callee_closure,
				    I386Types.caller_closure, "set up closure"),
			   (I386_Assembly.OPCODE
			    (I386_Assembly.jmp, [I386_Assembly.rel8 0]),
			    SOME real_proc_start_tag,
			    "jump to start of real code")]
		      in
			(entry_seq,
			 [],
			 MirTypes.BLOCK(real_proc_start_tag, opcode_list) :: block_list,
			 (post_overflow_tag, init_non_gc_stack @ frame_init_a) ::
			 (post_make_stack_tag, frame_init_b @ save_gcs @ opcodes) ::
			 overflow_entry_block :: final_result,
			 stack_drop, param_slots, true)
		      end
		    else
		      ([], opcode_list, block_list, final_result, stack_drop, param_slots, false)

		| MirTypes.RTS =>
		      let
			val ret_instr =
			  if max_args = 0 then
			    [(I386_Assembly.OPCODE
			      (I386_Assembly.ret, []), absent,
			      "Ordinary return")]
			  else
			    [(I386_Assembly.OPCODE
			      (I386_Assembly.ret,
			       [I386_Assembly.imm16(max_args*4)]),
			      absent,
			      "Ordinary return")]
		      in
			(if needs_preserve then
			   let
			     val ret_seq =
			       if frame_left = 0 then
				 ret_instr
			       else
				 (I386_Assembly.OPCODE
				  (I386_Assembly.add,
				   [I386_Assembly.r_m32(I386_Assembly.INL I386Types.sp),
				    if frame_left <= 127 then
				      I386_Assembly.imm8 frame_left
				    else
				      I386_Assembly.imm32
				      (frame_left div 4, frame_left mod 4)]),
				  absent, "junk spill and stack alloc area") ::
				 ret_instr
			   in
			     (I386_Assembly.OPCODE
			      (I386_Assembly.pop,
			       [I386_Assembly.r32 I386Types.global]),
			      absent, "throw away frame link") ::
			     (I386_Assembly.OPCODE
			      (I386_Assembly.pop,
			       [I386_Assembly.r32 I386Types.callee_closure]),
			      absent, "restore caller's closure") :: restore_gcs @
			     ret_seq
			   end
			 else
			   ret_instr,
			   opcode_list, block_list, final_result, stack_drop, param_slots, false)
		      end
		| MirTypes.NEW_HANDLER(frame, tag) =>
		    let
		      val needs_temp = reg_operand_is_spill frame
		      val rd =
			if needs_temp then
			  I386Types.EAX
			else
			  lookup_reg_operand frame
		      val last =
			if needs_temp then
			  [(I386_Assembly.OPCODE
			    (I386_Assembly.pop,
			     [I386_Assembly.r32 rd]),
			    absent, "pop temporary of stack")]
			 else
			   []
		      val last =
			(I386_Assembly.OPCODE
			 (I386_Assembly.mov,
			  [I386_Assembly.r_m32
			   (I386_Assembly.INR
			    (I386_Assembly.MEM
			     {base=SOME I386Types.implicit,
			      index=absent,
			      offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.handler))})),
			   I386_Assembly.r32 rd]),
			 absent, "set up new handler") :: last
		      val last =
			(I386_Assembly.OPCODE
			 (I386_Assembly.mov,
			  [I386_Assembly.r32 I386Types.global,
			   I386_Assembly.r_m32
			   (I386_Assembly.INR
			    (I386_Assembly.MEM
			     {base=SOME I386Types.implicit,
			      index=absent,
			      offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.handler))}))]),
			 absent, "get handler pointer in ECX") ::
			(I386_Assembly.OPCODE
			 (I386_Assembly.mov,
			  [I386_Assembly.r_m32
			   (I386_Assembly.INR
			    (I386_Assembly.MEM
			     {base=SOME rd,
			      index=absent,
			      offset=SOME(I386_Assembly.SMALL(~1))})),
			   I386_Assembly.r32 I386Types.global]),
			 absent, "store old handler pointer in frame") ::
			last
		      val opcodes =
			if needs_temp then
			  (I386_Assembly.OPCODE
			   (I386_Assembly.push, [I386_Assembly.r32 rd]),
			   absent, "create a temporary for the handler frame pointer") ::
			  (I386_Assembly.OPCODE
			   (I386_Assembly.mov,
			    [I386_Assembly.r32 rd,
			     I386_Assembly.r_m32
			     (I386_Assembly.INR
			      (I386_Assembly.MEM
			       {base=SOME I386Types.sp,
				index=absent,
				offset=SOME(I386_Assembly.SMALL(reg_spill_value frame + 4))}))]),
			   absent, "get handler frame pointer in register") ::
			  last
			else
			  last
		    in
		      (opcodes, opcode_list, block_list, final_result, stack_drop, param_slots, false)
		    end
		| MirTypes.OLD_HANDLER =>
		    ([(I386_Assembly.OPCODE
		       (I386_Assembly.mov,
			[I386_Assembly.r32 I386Types.global,
			 I386_Assembly.r_m32
			 (I386_Assembly.INR
			  (I386_Assembly.MEM
			   {base=SOME I386Types.implicit,
			    index=absent,
			    offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.handler))}))]),
		       absent, "get pointer to handler vector"),
		      (I386_Assembly.OPCODE
		       (I386_Assembly.mov,
			[I386_Assembly.r32 I386Types.global,
			 I386_Assembly.r_m32
			 (I386_Assembly.INR
			  (I386_Assembly.MEM
			   {base=SOME I386Types.global,
			    index=absent,
			    offset=SOME(I386_Assembly.SMALL(~1))}))]),
		       absent, "get pointer to old handler vector"),
		      (I386_Assembly.OPCODE
		       (I386_Assembly.mov,
			[I386_Assembly.r_m32
			 (I386_Assembly.INR
			  (I386_Assembly.MEM
			   {base=SOME I386Types.implicit,
			    index=absent,
			    offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.handler))})),
			 I386_Assembly.r32 I386Types.global]),
		       absent, "and set up as current handler")],
		    opcode_list, block_list, final_result, stack_drop, param_slots, false)
		| MirTypes.RAISE reg =>
		    let
		      val vector =
			4 *
			(if needs_preserve then
			   Implicit_Vector.raise_code
			 else
			   Implicit_Vector.leaf_raise_code)
		      val (arg, move_needed) =
			if reg_operand_is_spill reg then
			  let
			    val spill = reg_spill_value reg
			  in
			    (I386_Assembly.INR
			     (I386_Assembly.MEM
			      {base=SOME I386Types.sp,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL spill)}), true)
			  end
			else
			  let
			    val arg = lookup_reg_operand reg
			  in
			    if arg = I386Types.caller_arg then
			      (I386_Assembly.INL arg, false)
			    else
			      (I386_Assembly.INL arg, true)
			  end
		      val code =
			[(I386_Assembly.OPCODE
			  (I386_Assembly.call,
			   [I386_Assembly.r_m32
			    (I386_Assembly.INR
			     (I386_Assembly.MEM
			      {base=SOME I386Types.implicit,
			       index=absent,
			       offset=SOME(I386_Assembly.SMALL vector)}))]),
			  absent, "raise")]
		      val code =
			if move_needed then
			  (I386_Assembly.OPCODE
			   (I386_Assembly.mov,
			    [I386_Assembly.r32 I386Types.caller_arg,
			     I386_Assembly.r_m32 arg]),
			   absent, "get raise argument") :: code
			else
			  code
		     in
		       (code, opcode_list, block_list, final_result, stack_drop, param_slots, false)
		    end
		| MirTypes.COMMENT string =>
		    Crash.impossible"MirTypes.COMMENT not filtered out"
		| MirTypes.CALL_C =>
		    ([(I386_Assembly.OPCODE
		       (I386_Assembly.call,
			[I386_Assembly.r_m32
			 (I386_Assembly.INR
			  (I386_Assembly.MEM
			   {base=SOME I386Types.implicit,
			    index=absent,
			    offset=SOME(I386_Assembly.SMALL(4*Implicit_Vector.external))}))]),
		       absent, "Do call_c")],
		    opcode_list, block_list, final_result, stack_drop, param_slots, false)
		) handle
		   bad_spill s =>
		     Crash.impossible(s ^ " in opcode '" ^ MirPrint.opcode opcode ^
				      "'\n")
	    in
	      do_everything
	      (needs_preserve, tag, opcode_list, new_stack_drop,
	       new_param_slots,
	       Sexpr.CONS(done, Sexpr.ATOM result_list), new_blocks,
	       new_final_result, stack_drop_ok)
	    end

	in
	  do_everything(needs_preserve, tag, Lists.filter_outp is_comment opcodes, 0, 0,
			Sexpr.NIL, rest, [], false)
	end

      (* Some stuff to do with optimising unconditional branches to returns *)

      fun exit_block [] = NONE
	| exit_block((block as MirTypes.BLOCK(tag, opcode_list)) :: rest) =
	if Lists.exists
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
	    if Lists.exists
	      (fn (MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG t)) => tag = t
	      | _ => false)
	      opc_list then
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
		| get_new_opc_list _ =
		  Crash.impossible"get_new_opc fails to find proper branch"
		val new_opc = get_new_opc_list opc'
		fun rev_app([], x) = x
		  | rev_app(y, []) = y
		  | rev_app(y :: ys, x) = rev_app(ys, y :: x)
	      in
		MirTypes.BLOCK(tag', rev_app(new_opc, opcode_list))
	      end
	    else
	      block
	in
	  map do_block block_list
	end

      fun lookup_entry_block(proc_tag, []) =
	Crash.impossible"i386_cg: no entry block found"
	| lookup_entry_block(proc_tag,
			     MirTypes.BLOCK(tag, instrs) :: blocks) =
	if proc_tag = tag then
	  instrs
	else
	  lookup_entry_block(proc_tag, blocks)

      fun proc_cg(MirTypes.PROC
		  (procedure_name,
                   proc_tag, MirTypes.PROC_PARAMS
		   {spill_sizes, stack_allocated, old_spill_sizes},
		   block_list,runtime_env)) =
	let
	  fun find_stack_parms [] =
	    Crash.impossible"i386_cg: no entry block found"
	    | find_stack_parms(MirTypes.ENTER list :: _) =
	    (case list of
	       MirTypes.GC gc :: rest =>
		 if gc = MirRegisters.callee_arg then
		   rest
		 else
		   Crash.impossible("i386_cg: first arg is not callee_arg in " ^
				    procedure_name)
	     | _ => [])
	    | find_stack_parms(MirTypes.COMMENT _ :: instrs) =
	    find_stack_parms instrs
	    | find_stack_parms _ =
	    Crash.impossible"i386_cg: ENTER missing from start of entry block"

	  val exit_block = exit_block block_list

	  val block_list =
	    case exit_block of
	      NONE => block_list
	    | SOME exit_block =>
		if small_exit_block exit_block then
		  append_small_exit(exit_block, block_list)
		else
		  block_list

	  fun define_fp(map, MirTypes.FP_REG fp) =
	    case MirTypes.FP.Map.tryApply'(map, fp) of
	      NONE => MirTypes.FP.Map.define(map, fp, true)
	    | _ => map

	  fun get_fps_from_opcode(map, MirTypes.TBINARYFP(_, _, fp1, fp2, fp3)) =
	    define_fp(define_fp(define_fp(map, fp1), fp2), fp3)
	    | get_fps_from_opcode(map, MirTypes.TUNARYFP(_, _, fp1, fp2)) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(map, MirTypes.BINARYFP(_, fp1, fp2, fp3)) =
	      define_fp(define_fp(define_fp(map, fp1), fp2), fp3)
	    | get_fps_from_opcode(map, MirTypes.UNARYFP(_, fp1, fp2)) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(map, MirTypes.STOREFPOP(_, fp1, _, _)) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(map, MirTypes.REAL(_, fp1, _)) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(map, MirTypes.FLOOR(_, _, _, fp1)) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(map, MirTypes.FTEST(_, _, fp1, fp2)) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(map, _) = map

	  fun get_fps_from_block(map, MirTypes.BLOCK(_, instr_list)) =
	    Lists.reducel get_fps_from_opcode (map, instr_list)

	  val fp = MirTypes.FP.Map.domain(Lists.reducel get_fps_from_block (MirTypes.FP.Map.empty, block_list))

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

	  fun get_gcs_from_opcode(map, MirTypes.TBINARY(_, _, rd, g1, g2)) =
	    define_gp(define_gp(define_gc(map, rd), g1), g2)
	    | get_gcs_from_opcode(map, MirTypes.BINARY(_, rd, g1, g2)) =
	      define_gp(define_gp(define_gc(map, rd), g1), g2)
	    | get_gcs_from_opcode(map, MirTypes.UNARY(_, rd, g)) =
	      define_gp(define_gc(map, rd), g)
	    | get_gcs_from_opcode(map, MirTypes.NULLARY(_, rd)) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(map, MirTypes.TBINARYFP _) = map
	    | get_gcs_from_opcode(map, MirTypes.TUNARYFP _) = map
	    | get_gcs_from_opcode(map, MirTypes.BINARYFP _) = map
	    | get_gcs_from_opcode(map, MirTypes.UNARYFP _) = map
	    | get_gcs_from_opcode(map, MirTypes.STACKOP(_, rd, _)) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(map, MirTypes.STOREOP(_, rd, rs, g)) =
	      define_gp(define_gc(define_gc(map, rd), rs), g)
	    | get_gcs_from_opcode(map, MirTypes.IMMSTOREOP(_, g, rs, g')) =
	      define_gp(define_gc(define_gp(map, g'), rs), g)
	    | get_gcs_from_opcode(map, MirTypes.STOREFPOP(_, _, rs, g)) =
	      define_gp(define_gc(map, rs), g)
	    | get_gcs_from_opcode(map, MirTypes.REAL(_, _, g)) =
	      define_gp(map, g)
	    | get_gcs_from_opcode(map, MirTypes.FLOOR(_, _, rd, _)) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(map, MirTypes.BRANCH(_, dest)) =
	      define_bl_dest(map, dest)
	    | get_gcs_from_opcode(map, MirTypes.TEST(_, _, g1, g2)) =
	      define_gp(define_gp(map, g1), g2)
	    | get_gcs_from_opcode(map, MirTypes.FTEST _) = map
	    | get_gcs_from_opcode(map, MirTypes.BRANCH_AND_LINK(_, dest, _, _)) =
	      define_bl_dest(map, dest)
	    | get_gcs_from_opcode(map, MirTypes.TAIL_CALL(_, dest, _)) =
	      define_bl_dest(map, dest)
	    | get_gcs_from_opcode(map, MirTypes.CALL_C) = map
	    | get_gcs_from_opcode(map, MirTypes.SWITCH(_, rs, _)) =
	      define_gc(map, rs)
	    | get_gcs_from_opcode(map, MirTypes.ALLOCATE(_, rd, g)) =
	      define_gp(define_gc(map, rd), g)
	    | get_gcs_from_opcode(map, MirTypes.ALLOCATE_STACK(_, rd, _, _)) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(map, MirTypes.DEALLOCATE_STACK _) = map
	    | get_gcs_from_opcode(map, MirTypes.ADR(_, rd, _)) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(map, MirTypes.INTERCEPT) = map
	    | get_gcs_from_opcode(map, MirTypes.INTERRUPT) = map
	    | get_gcs_from_opcode(map, MirTypes.ENTER _) = map
	    | get_gcs_from_opcode(map, MirTypes.RTS) = map
	    | get_gcs_from_opcode(map, MirTypes.NEW_HANDLER _) = map
	    | get_gcs_from_opcode(map, MirTypes.OLD_HANDLER) = map
	    | get_gcs_from_opcode(map, MirTypes.RAISE rd) =
	      define_gc(map, rd)
	    | get_gcs_from_opcode(map, MirTypes.COMMENT _) = map

	  fun get_gcs_from_block(map, MirTypes.BLOCK(_, instr_list)) =
	    Lists.reducel get_gcs_from_opcode (map, instr_list)

	  val gc = MirTypes.GC.Map.domain(Lists.reducel get_gcs_from_block (MirTypes.GC.Map.empty, block_list))

	  val fp' =
	    Lists.reducel
	    (fn (acc, r) =>
	     case MirTypes.FP.Map.tryApply'(fp_map, r) of
	       SOME x => x :: acc
	     | _ => acc)
	    ([], fp)

	  val gc' =
	    Lists.reducel
	    (fn (acc, r) =>
	     case MirTypes.GC.Map.tryApply'(gc_map, r) of
	       SOME x => x :: acc
	     | _ => acc)
	    ([], gc)

	  val fps = Set.list_to_set fp'
	  val gcs = Set.list_to_set gc'

	  val fps_to_preserve =
	    Set.set_to_list(Set.setdiff(fps,
					#fp MachSpec.corrupted_by_callee))
	
	  val fp_save_size = length fps_to_preserve

	  exception NeedsFrame

	  fun check_instr(MirTypes.BRANCH_AND_LINK _) = true
	    | check_instr MirTypes.CALL_C = true
	    | check_instr(MirTypes.SWITCH _) = true
            | check_instr(MirTypes.NEW_HANDLER _) = true
	    | check_instr(MirTypes.ADR _) = true
(* Warning. If we ever make a leaf adr, we must ensure *)
(* handler continuations are done safely. This is not currently *)
(* true since they use o1 as the address. *)
(* This comment is incorrect for the intel, but the conclusion may still hold *)
            | check_instr(MirTypes.STACKOP _) = true
	    | check_instr(MirTypes.ALLOCATE _) = true
	    | check_instr(MirTypes.ALLOCATE_STACK _) = true
	    | check_instr _ = false

	  fun check_instr_block(MirTypes.BLOCK(_, instr_list)) =
	    Lists.exists check_instr instr_list

	  val stack_extra =
            case stack_allocated of
	    SOME stack_extra => stack_extra
	  | _ =>  Crash.impossible"Stack size missing to mach_cg"

	  fun check_reg I386Types.EAX = raise NeedsFrame
	    | check_reg I386Types.EBX = ()
	    | check_reg I386Types.ECX = ()
	    | check_reg I386Types.EDX = raise NeedsFrame
	    | check_reg I386Types.ESP = raise NeedsFrame
	    | check_reg I386Types.EBP = ()
	    | check_reg I386Types.EDI = raise NeedsFrame
	    | check_reg I386Types.ESI = ()
	    (* We let this one through because *)
	    (* it's used by the local variable debugger *)
	    | check_reg I386Types.i_arg1 = ()
	    | check_reg I386Types.i_arg2 = ()
	    | check_reg I386Types.i_arg3 = ()
	    | check_reg I386Types.i_arg4 = ()
	    | check_reg I386Types.i_arg5 = ()
	    | check_reg I386Types.i_arg6 = ()
	    | check_reg I386Types.i_arg7 = ()
	    | check_reg I386Types.o_arg1 = raise NeedsFrame
	    | check_reg I386Types.o_arg2 = raise NeedsFrame
	    | check_reg I386Types.o_arg3 = raise NeedsFrame
	    | check_reg I386Types.o_arg4 = raise NeedsFrame
	    | check_reg I386Types.o_arg5 = raise NeedsFrame
	    | check_reg I386Types.o_arg6 = raise NeedsFrame
	    | check_reg I386Types.o_arg7 = raise NeedsFrame
	    | check_reg I386Types.stack = raise NeedsFrame
	    | check_reg x = Crash.impossible("check_reg:bad register " ^
					     I386Types.reg_to_string x)

	  fun check_gc_reg r =
	    case MirTypes.GC.Map.tryApply'(gc_map, r) of
	      SOME x => check_reg x
	    | _ => raise NeedsFrame

	  fun check_non_gc_reg r =
	    case MirTypes.NonGC.Map.tryApply'(non_gc_map, r) of
	      SOME x => check_reg x
	    | _ => raise NeedsFrame

	  fun check_reg_op(MirTypes.GC_REG r) =
	    check_gc_reg r
	    | check_reg_op(MirTypes.NON_GC_REG r) =
	      check_non_gc_reg r

	  fun check_gp_op(MirTypes.GP_GC_REG r) =
	    check_gc_reg r
	    | check_gp_op(MirTypes.GP_NON_GC_REG r) =
	      check_non_gc_reg r
	    | check_gp_op(MirTypes.GP_IMM_INT _) = ()
	    | check_gp_op(MirTypes.GP_IMM_ANY _) = ()
	    | check_gp_op(MirTypes.GP_IMM_SYMB symbolic) =
	      case symbolic of
		MirTypes.GC_SPILL_SIZE => ()
	      | MirTypes.NON_GC_SPILL_SIZE => ()
	      | MirTypes.GC_SPILL_SLOT _ => raise NeedsFrame
	      | MirTypes.NON_GC_SPILL_SLOT _ => raise NeedsFrame
	      | MirTypes.FP_SPILL_SLOT _ => raise NeedsFrame

	  fun check_instr_regs(MirTypes.TBINARY(_, _, reg_op, gp_op, gp_op')) =
	    (check_reg_op reg_op;
	     check_gp_op gp_op;
	     check_gp_op gp_op')
	    | check_instr_regs(MirTypes.BINARY(_, reg_op, gp_op, gp_op')) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op;
	     check_gp_op gp_op')
	    | check_instr_regs(MirTypes.UNARY(_, reg_op, gp_op )) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.NULLARY(_, reg_op )) =
	      (check_reg_op reg_op)
	    | check_instr_regs(MirTypes.TBINARYFP _) = ()
	    | check_instr_regs(MirTypes.TUNARYFP _) = ()
	    | check_instr_regs(MirTypes.BINARYFP _) = ()
	    | check_instr_regs(MirTypes.UNARYFP _) = ()
	    | check_instr_regs(MirTypes.STACKOP _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.STOREOP(_, reg_op, reg_op', gp_op)) =
	      (check_reg_op reg_op;
	       check_reg_op reg_op';
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.IMMSTOREOP(_, gp_op, reg_op, gp_op')) =
	      (check_gp_op gp_op;
	       check_reg_op reg_op;
	       check_gp_op gp_op')
	    | check_instr_regs(MirTypes.STOREFPOP(_, _, reg_op, gp_op )) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.REAL _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.FLOOR _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.BRANCH(_, bl_dest )) =
	      (case bl_dest of
		 MirTypes.REG reg_op => (check_reg_op reg_op)
	       | _ => ())
	    | check_instr_regs(MirTypes.TEST(_, _, gp_op, gp_op')) =
	      (check_gp_op gp_op;
	     check_gp_op gp_op')
	    | check_instr_regs(MirTypes.FTEST _) = ()
	    | check_instr_regs(MirTypes.BRANCH_AND_LINK _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.TAIL_CALL(_, bl_dest, _)) =
	      (case bl_dest of
		 MirTypes.REG reg_op => (check_reg_op reg_op)
	       | _ => ())
	    | check_instr_regs(MirTypes.CALL_C) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.SWITCH _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.ALLOCATE(_, reg_op, gp_op )) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.ALLOCATE_STACK _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.DEALLOCATE_STACK _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.ADR _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.INTERCEPT) = ()
	    | check_instr_regs(MirTypes.INTERRUPT) = ()
	    | check_instr_regs(MirTypes.ENTER _) = ()
	    | check_instr_regs(MirTypes.RTS) = ()
	    | check_instr_regs(MirTypes.NEW_HANDLER _) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.OLD_HANDLER) =
	      raise NeedsFrame
	    | check_instr_regs(MirTypes.RAISE reg_op) =
	      (check_reg_op reg_op)
	    | check_instr_regs(MirTypes.COMMENT _) = ()

	  fun check_instr_block_regs(MirTypes.BLOCK(_, instr_list)) =
	    app check_instr_regs instr_list

	  (* Moved this from do_block as it's independent of block number *)
	  val spills_opt = spill_sizes

	  val (gc_spill_size, non_gc_spill_size, fp_spill_size) =
	    case spills_opt of
	      SOME{gc = gc_spill_size,
                                  non_gc = non_gc_spill_size,
                                  fp = fp_spill_size} =>
	      (gc_spill_size, non_gc_spill_size, fp_spill_size)
	     | _ => Crash.impossible"Spill sizes missing to mach_cg"

	  val needs_stack = fp_save_size <> 0 orelse fp_spill_size <> 0 orelse gc_spill_size <> 0

	  val needs_preserve =
	    (* First check that leaf optimisation is allowed *)
	    not (opt_leaf_fns) orelse
	    (* Then see if any stack has been used *)
	    stack_extra <> 0 orelse (* This should catch the big procedures easily *)
	    (* Then see if we already know about any stack usage *)
	    needs_stack orelse
	    (* Now see if any instructions force non-leaf *)
            Lists.exists check_instr_block block_list orelse
	    (* See if we use any non-leaf registers *)
	    ((app check_instr_block_regs block_list;
	      false) handle NeedsFrame => true)

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

	  fun compare_reg(r, s) = (#gc MachSpec.allocation_order)(r, s)

	  fun check_callee_save_reg I386Types.EAX = true
	    | check_callee_save_reg I386Types.EBX = false
	    | check_callee_save_reg I386Types.ECX = false
	    | check_callee_save_reg I386Types.EDX = true
	    | check_callee_save_reg I386Types.ESP = false
	    | check_callee_save_reg I386Types.EBP = false
	    | check_callee_save_reg I386Types.EDI = false
	    | check_callee_save_reg I386Types.ESI = false
	    (* We let this one through because *)
	    (* it's used by the local variable debugger *)
	    (* It's not a callee save though, it's converted into ESP *)
	    | check_callee_save_reg I386Types.stack = false
	    | check_callee_save_reg I386Types.i_arg1 = false
	    | check_callee_save_reg I386Types.i_arg2 = false
	    | check_callee_save_reg I386Types.i_arg3 = false
	    | check_callee_save_reg I386Types.i_arg4 = false
	    | check_callee_save_reg I386Types.i_arg5 = false
	    | check_callee_save_reg I386Types.i_arg6 = false
	    | check_callee_save_reg I386Types.i_arg7 = false
	    | check_callee_save_reg I386Types.o_arg1 = false
	    | check_callee_save_reg I386Types.o_arg2 = false
	    | check_callee_save_reg I386Types.o_arg3 = false
	    | check_callee_save_reg I386Types.o_arg4 = false
	    | check_callee_save_reg I386Types.o_arg5 = false
	    | check_callee_save_reg I386Types.o_arg6 = false
	    | check_callee_save_reg I386Types.o_arg7 = false
 	    | check_callee_save_reg x =
	    Crash.impossible("check_callee_save_reg:bad register " ^
					     I386Types.reg_to_string x)

	  fun block_needs_fp_spare(MirTypes.BLOCK(_, opc_list)) =
	    let
	      fun opc_needs_fp_spare [] = false
		| opc_needs_fp_spare(MirTypes.REAL _ :: _) = true
		| opc_needs_fp_spare(MirTypes.FLOOR _ :: _) = true
		| opc_needs_fp_spare(_ :: rest) = opc_needs_fp_spare rest
	    in
	      opc_needs_fp_spare opc_list
	    end

	  fun proc_needs_fp_spare [] = false
	    | proc_needs_fp_spare(block :: block_list) =
	      block_needs_fp_spare block orelse proc_needs_fp_spare block_list

	  val needs_fp_spare = proc_needs_fp_spare block_list

          (* Allow an extra slot if we need an fp_spare *)
	  val non_gc_spill_size =
	    if needs_fp_spare then non_gc_spill_size + 1
	    else non_gc_spill_size

	  val float_value_size = case I386Types.fp_used of
	    I386Types.single => 4
	  | I386Types.double => 8
	  | I386Types.extended => 16

	  val non_gc_stack_size =
	    non_gc_spill_size * 4 + (fp_spill_size + fp_save_size) * float_value_size

	  val callee_saves =
	    Lists.qsort compare_reg (Lists.filterp check_callee_save_reg (Set.set_to_list gcs))

          val number_of_saves = length callee_saves

	  val callee_save_area = number_of_saves + (if save_arg_for_debugging then 1 else 0)

	  val fp_spill_offset = frame_offset + non_gc_spill_size * 4
	  val fp_save_offset = fp_spill_offset + fp_spill_size * float_value_size
	  val gc_spill_offset  = frame_offset + non_gc_stack_size

	  val gc_stack_alloc_offset = gc_spill_offset + gc_spill_size * 4
          (* Offset (from top) to top of linkage and callee save area *)
	  val register_save_offset = gc_stack_alloc_offset + stack_extra * 4

	  val needs_preserve = needs_preserve orelse needs_fp_spare
	  val register_save_size = 4 * (linkage_size + callee_save_area)
	  val stack_layout =
	    PROC_STACK
	    {non_gc_spill_size = non_gc_spill_size,
	     fp_spill_size = fp_spill_size,
	     fp_save_size = fp_save_size,
	     gc_spill_size = gc_spill_size,
	     gc_stack_alloc_size = stack_extra,
	     register_save_size = register_save_size,
	     non_gc_spill_offset = frame_offset,
	     fp_spill_offset = fp_spill_offset,
	     fp_save_offset = fp_save_offset,
	     gc_spill_offset = gc_spill_offset,
	     gc_stack_alloc_offset = gc_stack_alloc_offset,
	     register_save_offset = register_save_offset,
	     allow_fp_spare_slot = needs_fp_spare,
	     float_value_size = float_value_size,
	     old_spill_sizes = case old_spill_sizes of
	       SOME old => old
	     | _ => {gc=0, non_gc=0, fp=0}
             }

(*
	  val _ = output(std_out, "In procedure " ^ procedure_name ^ "\n")
	  val _ = output(std_out, "non_gc_spill_size = " ^ Int.toString non_gc_spill_size ^ "\n")
	  val _ = output(std_out, "fp_spill_size = " ^ Int.toString fp_spill_size ^ "\n")
	  val _ = output(std_out, "fp_save_size = " ^ Int.toString fp_save_size ^ "\n")
	  val _ = output(std_out, "gc_spill_size = " ^ Int.toString gc_spill_size ^ "\n")
	  val _ = output(std_out, "gc_stack_alloc_size = " ^ Int.toString stack_extra ^ "\n")
	  val _ = output(std_out, "register_save_size = " ^ Int.toString register_save_size ^ "\n")
	  val _ = output(std_out, "non_gc_spill_offset = " ^ Int.toString frame_offset ^ "\n")
	  val _ = output(std_out, "fp_spill_offset = " ^ Int.toString fp_spill_offset ^ "\n")
	  val _ = output(std_out, "fp_save_offset = " ^ Int.toString fp_save_offset ^ "\n")
	  val _ = output(std_out, "gc_spill_offset = " ^ Int.toString gc_spill_offset ^ "\n")
	  val _ = output(std_out, "gc_stack_alloc_offset = " ^ Int.toString gc_stack_alloc_offset ^ "\n")
	  val _ = output(std_out, "register_save_offset = " ^ Int.toString register_save_offset ^ "\n")
*)

	  val stack_parm_list =
	    find_stack_parms(lookup_entry_block(proc_tag, block_list))

	  val max_tail_size =
	    Lists.reducel
	    (fn (max, MirTypes.BLOCK(_, instrs)) =>
	     Lists.reducel
	     (fn (max, MirTypes.TAIL_CALL(_, _, list)) =>
	      let
		val len = Lists.length list - 1
	      in
		if len > max then len else max
	      end
	      | (max, _) => max)
	     (max, instrs))
	    (0, block_list)

	  val stack_parms = Lists.length stack_parm_list

	  val max_args =
	    if stack_parms > max_tail_size then stack_parms else max_tail_size

	  val stack_args = (stack_parms, max_tail_size, max_args)

(*
	  val _ = print(procedure_name ^ " has " ^ Int.toString stack_parms ^
			" stacked parameters\n")
*)

	  fun coalesce block_list =
	    let
	      val block_map =
		Lists.reducel
		(fn (map, arg as MirTypes.BLOCK(tag, _)) =>
		 MirTypes.Map.define(map, tag, arg))
		(MirTypes.Map.empty, block_list)
	      datatype referenced = ONCE_AT_END of MirTypes.tag | MANY
	      fun is_comment list =
		Lists.forall
		(fn (MirTypes.COMMENT _) => true
		 | _ => false)
		list
	      fun process_instrs(map, block_tag, []) = map
		| process_instrs(map, block_tag, instr :: list) =
		let
		  val (tags, is_branch) =
		    case instr of
		      MirTypes.TBINARY(_, tag_list, _, _, _) =>
			(tag_list, false)
		    | MirTypes.TBINARYFP(_, tag_list, _, _, _) =>
			(tag_list, false)
		    | MirTypes.TUNARYFP(_, tag_list, _, _) =>
			(tag_list, false)
		    | MirTypes.FLOOR(_, tag, _, _) =>
			([tag], false)
		    | MirTypes.BRANCH(_, MirTypes.TAG tag) =>
			([tag], true)
		    | MirTypes.TEST(_, tag, _, _) =>
			([tag], false)
		    | MirTypes.FTEST(_, tag, _, _) =>
			([tag], false)
		    | MirTypes.SWITCH(_, _, tag_list) =>
			(tag_list, false)
		    | MirTypes.NEW_HANDLER(_, tag) =>
			([tag], false)
		    | _ => ([], false)
		in
		  case tags of
		    [] => process_instrs(map, block_tag, list)
		  | _ =>
		      if is_branch andalso is_comment list then
			Lists.reducel
			(fn (map, tag) =>
			 case MirTypes.Map.tryApply'(map, tag) of
			   NONE => MirTypes.Map.define(map, tag, ONCE_AT_END block_tag)
		         | _ => MirTypes.Map.define(map, tag, MANY))
			(map, tags)
		      else
			process_instrs
			(Lists.reducel
			 (fn (map, tag) =>
			  MirTypes.Map.define(map, tag, MANY))
			 (map, tags), block_tag, list)
		end

	      val ref_map =
		Lists.reducel
		(fn (map, MirTypes.BLOCK(tag, instrs)) =>
		 process_instrs(map, tag, instrs))
		(MirTypes.Map.empty, block_list)

	      fun rev_app([], x) = x
		| rev_app(y :: ys, x) = rev_app(ys, y :: x)

	      fun coalesce(instrs1, instrs2) =
		case instrs1 of
		  [] => Crash.impossible"i386_cg:colaesce: empty block"
		| (MirTypes.COMMENT _ :: rest) => coalesce(rest, instrs2)
		| (MirTypes.BRANCH(_, MirTypes.TAG tag) :: rest) =>
		    rev_app(rest, instrs2)
		| opcode :: _ =>
		    Crash.impossible("i386_cg:coalesce: opcode " ^
				     MirPrint.opcode opcode ^
				     " found at end of first coalesce block")

	      fun follow_fwd_map(arg as (map, tag)) =
		case MirTypes.Map.tryApply' arg of
		  NONE => tag
		| SOME tag' =>
		    ((*print("Following forwarding map for tag " ^
			   MirTypes.print_tag tag ^ " to " ^
			   MirTypes.print_tag tag' ^ "\n");*)
		     follow_fwd_map(map, tag'))

	      val (block_map, _) =
		MirTypes.Map.fold
		(fn ((map, fwd_map), tag, ONCE_AT_END block_tag) =>
		 let
		   val block_tag' = follow_fwd_map(fwd_map, block_tag)
(*
		   val _ =
		     print("Coalescing block " ^
			   MirTypes.print_tag block_tag ^ " and block " ^
			   MirTypes.print_tag tag ^ "\n")
*)
		   val MirTypes.BLOCK(_, instrs1) =
		     case MirTypes.Map.tryApply'(map, block_tag') of
		       SOME block => block
		     | _ => Crash.impossible("i386_cg:coalesce: block " ^
					     MirTypes.print_tag block_tag ^
					     " not in block_map")
		   val MirTypes.BLOCK(_, instrs2) =
		     case MirTypes.Map.tryApply'(map, tag) of
		       SOME block => block
		     | _ => Crash.impossible("i386_cg:coalesce: block " ^
					     MirTypes.print_tag tag ^
					     " not in block_map")

		   val new_instrs = coalesce(rev instrs1, instrs2)
		   val new_map =
		     MirTypes.Map.define(map, block_tag',
					 MirTypes.BLOCK(block_tag', new_instrs))
		   val fwd_map =
		     MirTypes.Map.define(fwd_map, tag, block_tag')
		 in
		   (MirTypes.Map.undefine(new_map, tag), fwd_map)
		 end
	         | (maps, tag, _) => maps)
		((block_map, MirTypes.Map.empty), ref_map)
	    in
	      MirTypes.Map.range block_map
	    end

	  val block_list = coalesce block_list

	  val code =
	    move_first proc_tag ([], do_blocks(needs_preserve,
                                               block_list,
                                               stack_layout,
                                               fps_to_preserve,
                                               callee_saves,
					       stack_args,
					       procedure_name))

	  val code_len =
	    Lists.reducel op +
	    (0, map (fn (_, opcodes) => length opcodes) code)

          val padded_name =
            let
              fun generate_nulls 0 = ""
                | generate_nulls n = "\000" ^ generate_nulls (n-1)
              fun normalise_to_four_bytes (x) =
                x ^ generate_nulls((4 - ((size x) mod 4)) mod 4)
            in
              normalise_to_four_bytes(procedure_name ^ "\000")
            end
	in
	  {code=(proc_tag, code),
	   non_gc_area_size=non_gc_stack_size,
           name=procedure_name,
           padded_name=padded_name,
	   leaf=not needs_preserve,
           saves=number_of_saves,
	   parms=max_args}
	end

      fun list_proc_cg proc_list =
	let
	  fun print_unscheduled_code((tag, block_list),name) =
	    let
	      fun print_block(tag, opcode_list) =
		let
		  fun print_opcode(opcode, tag_opt, comment) =
		    Print.print(
			  I386_Assembly.print opcode ^
			  (case tag_opt of
			    SOME tag =>
			       " tag " ^ MirTypes.print_tag tag
			  | NONE => " no tag") ^
			     " ; " ^ comment ^ "\n")
		in
		  (Print.print("Block tag " ^ MirTypes.print_tag tag ^ "\n");
		   map print_opcode opcode_list)
		end
	    in
	      (Print.print("Procedure entry tag " ^ MirTypes.print_tag tag ^
                           " " ^ name ^
			   "\n");
	       map print_block block_list)
	    end

	  val temp_code_list =
	    Timer.xtime
	    ("main proc_cg stage", !do_timings,
	     fn () => map proc_cg proc_list)

	  val code_list = map #code temp_code_list
          val procedure_name_list = map #name temp_code_list
	  val leaf_list = map #leaf temp_code_list
	  val stack_parameters = map #parms temp_code_list

	  val code_list' = code_list

	  val _ = diagnostic_output 3
	    (fn _ => ["Unscheduled code\n"])

	  val _ = diagnostic_output 3
	    (fn _ => (app (ignore o print_unscheduled_code)
                      (Lists.zip(code_list',procedure_name_list)) ;
		      []))

	  fun do_reschedule code_list =
	    let
	      val code_list' =
		Timer.xtime
		("rescheduling blocks", !do_timings,
		 fn () =>
		 map
		 (fn (proc_tag, proc) =>
		  (proc_tag, map
		   (fn (tag, x) => (tag, I386_Schedule.reschedule_block x))
		   proc))
		 code_list)

	      val _ = diagnostic_output 3 (fn _ => ["Rescheduled at block level, now doing proc level\n"])
	      val _ = diagnostic_output 3 (fn _ => ["Result so far\n"])
	      val _ = diagnostic_output 3 (fn _ => (app (ignore o print_unscheduled_code)
                                                    (Lists.zip(code_list',procedure_name_list)) ;
						    []))

	      val code_list'' =
		Timer.xtime
		("rescheduling procs", !do_timings,
		 fn () => map I386_Schedule.reschedule_proc code_list')
	    in
	      code_list''
	    end

	  fun print_scheduled_code (code_list) =
	    let
	      fun print_proc((proc_tag, proc),name) =
		let
		  fun print_block(tag, opcode_list) =
		    let
		      fun print_opcode(opcode, tag_opt, comment) =
			Print.print(
			      I386_Assembly.print opcode ^
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

	  val _ = diagnostic_output 3 (fn _ => (["Rescheduling code\n"]))

	  val new_code_list' =
	    Timer.xtime
	    ("rescheduling", !do_timings,
	     fn () => do_reschedule code_list')

	  val _ = diagnostic_output 3 (fn _ => ["Rescheduled code\n"])
	  val _ = diagnostic_output 3 (fn _ => (ignore(print_scheduled_code (Lists.zip(new_code_list',procedure_name_list))) ;
						 []))
	  val _ = diagnostic_output 3 (fn _ => ["Linearising\n"])

	  val linear_code' =
	    Timer.xtime
	    ("linearising", !do_timings,
	     fn () => linearise_list new_code_list')

	  val nop_offsets = map find_nop_offsets linear_code'
	  val _ = diagnostic_output 3 (fn _ => ["Linearised\n"])

	  val nop_instruction =
	    I386_Opcodes.output_opcode
	    (I386_Assembly.assemble (I386_Assembly.nop_code))

	  val assemble = I386_Assembly.assemble

	  fun make_tagged_code linear_code =
            (map
	     (fn ((tag, code),{non_gc_area_size, padded_name, saves, ...}) =>
		{a_clos=Lists.assoc(tag, loc_refs),
		 b_spills=non_gc_area_size,
		 c_saves=saves,
		 d_code=
		 let
                   fun annotation_points ([],_,res) = rev res
                     | annotation_points ((inst,_)::t,count,res) =
                       (case inst of
                          I386_Assembly.AugOPCODE(_,Debugger_Types.NOP) => ()
                        | I386_Assembly.AugOPCODE (_,debug) =>
                            let
                              val unpadded_name =
                                let
                                  val s = size padded_name
                                  fun check_index to =
                                    if MLWorks.String.ordof(padded_name,to) = 0
                                      then check_index(to-1)
                                    else MLWorks.String.substring(padded_name,0,to+1)
                                in
                                  check_index (s-1)
                                  handle MLWorks.String.Substring => ""
                                       | MLWorks.String.Ord => ""
                                end
			     in
                               debug_map := Debugger_Types.add_annotation
                               (unpadded_name, count, debug,
                                !debug_map)
                            end
                        | _ => ();
                            let val outpt = I386_Opcodes.output_opcode
                                                             (assemble inst)
                             in
                               annotation_points(t,count+(size outpt),
                                                 outpt::res)
                            end)

                   val code =
                     if generate_debug_info
                       then concat (annotation_points (code,0,[]))
                     else
                       concat
                       (map
                        (fn (x, _) =>
                         I386_Opcodes.output_opcode(assemble x))
                        code)

		   fun make_nops(0, nops) = nops
		     | make_nops(n, nops) = make_nops(n-1, nop_instruction :: nops)

                   val padded_code =
                     if size code mod 8 <> 0 then
		       concat(code :: make_nops(8 - size code mod 8, []))
                     else
		       code
		 in
                   padded_code
		 end})
	       (Lists.zip(linear_code,temp_code_list)))
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
	   Lists.zip(linear_code', procedure_name_list))
	end

      val (proc_elements, code_list) = Lists.unzip(map list_proc_cg proc_list_list)

      val _ =
        if ! print_code_size then
	  print("Normalised code size is " ^
		Int.toString
		(Lists.reducel
		 (fn(x,Code_Module.WORDSET(Code_Module.WORD_SET{b=tagged_code', ...})) =>
		  (Lists.reducel (fn (x,{d_code=y, ...}) => (size y) + x) (x,tagged_code'))
	       | _ => Crash.impossible "what the ?")
		 (0,proc_elements)) ^ "\n")
        else ()

      fun make_external_refs(con, list) =
	map (fn (x, y) => con(y, x)) list

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
