(*   ==== MACHINE SPECIFICATION ====
 *              FUNCTOR
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: _machspec.sml,v $
 *  Revision 1.72  1998/08/27 12:14:04  jont
 *  [Bug #70040]
 *  Modify register colourer to use stack colourer only if requested from machspec
 *
 * Revision 1.71  1997/05/13  13:37:01  jont
 * [Bug #20038]
 * Add referenced_by_alloc
 *
 * Revision 1.70  1997/05/01  13:17:54  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.69  1997/04/24  15:47:03  jont
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.68  1997/03/25  13:46:51  matthew
 * Adding mach_type value
 *
 * Revision 1.67  1997/03/25  10:09:56  matthew
 * Adding F4 to corrupted_by_callee FP registers
 *
 * Revision 1.66  1997/01/21  16:17:30  jont
 * Add in corrupted_by_alloc and leaf_regs
 *
 * Revision 1.65  1997/01/02  12:33:25  matthew
 * Adding fp_arg_regs
 *
 * Revision 1.64  1996/11/01  13:28:15  jont
 * [Bug #1683]
 * Make all fp registers caller save
 *
 * Revision 1.63  1996/03/20  14:31:28  matthew
 * Changes for new language definition
 *
 * Revision 1.62  1995/12/22  12:55:26  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.61  1995/08/14  16:15:53  jont
 *  Remove bignum_inf stuff, not needed
 *
 *  Revision 1.60  1995/08/14  11:48:58  jont
 *  Add bits_per_word
 *
 *  Revision 1.59  1995/07/25  10:25:18  jont
 *  Add largest_word machine limit
 *
 *  Revision 1.58  1995/05/31  10:04:31  matthew
 *  Adding debugger_reserved register set
 *
 *  Revision 1.57  1994/11/15  13:49:08  jont
 *  Add has_immediate_store flag
 *
 *  Revision 1.56  1994/11/15  12:53:31  matthew
 *  Moved fp_global from gc reserved to fp reserved
 *
 *  Revision 1.55  1994/10/06  11:32:10  matthew
 *  Make callee_arg reserved so backtraces have a chance of working.
 *  This is not a real solution -- we need to make the set of reserved registers
 *  depend on the compiler options in force.
 *
 *  Revision 1.54  1994/09/21  16:07:45  jont
 *  Add do_unspill value to control register allocator
 *
 *  Revision 1.53  1994/09/15  17:54:23  jont
 *  Add chr and ord
 *  Also add Chr and Ord
 *
 *  Revision 1.52  1994/09/02  11:35:07  jont
 *  Reducing to two gc temporaries
 *  The two temporaries are L4 and O7
 *
 *  Revision 1.51  1994/08/12  13:04:46  matthew
 *  Removed caller_arg2 and tidied up
 *  Now have lists, caller_arg_regs and callee_arg_regs
 *
 *  Revision 1.50  1994/07/25  11:43:55  matthew
 *  Added some new argument registers.
 *
 *  Revision 1.49  1994/07/13  10:28:14  jont
 *  Add annotation about temporary register ordering
 *
 *  Revision 1.48  1994/06/24  10:48:35  jont
 *  Updates to use lr as unspill register
 *
 *  Revision 1.47  1994/05/27  16:55:07  jont
 *  Added floating point temporaries to the reserved list
 *
 *  Revision 1.46  1994/05/10  14:46:29  jont
 *  Remove lr, gc1, gc2, stack_limit from register interface
 *
 *  Revision 1.45  1994/03/08  18:14:34  jont
 *  Add digits_in_real
 *
 *  Revision 1.44  1994/03/04  12:58:22  jont
 *  Moved machspec into main
 *
 *  Revision 1.43  1992/11/21  19:33:38  jont
 *  Removed is_inline to machperv in order to remove dependence of entire
 *  mir stage on pervasives
 *
 *  Revision 1.42  1992/10/02  17:05:26  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.41  1992/09/15  11:05:20  clive
 *  Checked and corrected the specification for the floating point registers
 *
 *  Revision 1.40  1992/08/20  18:20:37  richard
 *  Added ByteArray primitives.
 *
 *  Revision 1.39  1992/08/19  12:14:25  richard
 *  Added UNSAFE_SUB and UNSAFE_UPDATE to the pervasives.
 *
 *  Revision 1.38  1992/08/17  13:56:42  jont
 *  Added inline ordof
 *
 *  Revision 1.37  1992/08/10  13:03:48  richard
 *  Changed the set of corruptible floating point registers to make
 *  calling C easier.
 *
 *  Revision 1.36  1992/07/28  15:20:38  jont
 *  Added fp registers corrupted and allocation preference
 *
 *  Revision 1.35  1992/06/19  15:51:44  jont
 *  Added ML_REQUIRE builtin for interpreter to get builtin library
 *
 *  Revision 1.34  1992/06/18  16:45:43  jont
 *  Added new builtin ML_OFFSET for computing pointers into middles of
 *  letrec code vectors
 *
 *  Revision 1.33  1992/06/17  09:40:18  jont
 *  Made call_ml_value inline
 *
 *  Revision 1.32  1992/06/15  17:29:55  jont
 *  Added various builtins for interpreter
 *
 *  Revision 1.31  1992/06/15  15:53:53  richard
 *  Added extra temporary for GC and FP registers.
 *
 *  Revision 1.30  1992/06/11  09:21:26  clive
 *  Save argument for the debugger to use
 *
 *  Revision 1.29  1992/06/10  17:09:08  richard
 *  Improved register ordering for allocation.
 *
 *  Revision 1.29  1992/06/10  12:02:30  richard
 *  Improved register colouring order.
 *
 *  Revision 1.28  1992/06/08  15:25:12  richard
 *  Added allocation_order.
 *
 *  Revision 1.27  1992/06/03  16:26:07  richard
 *  The temporary registers are now complete sets rather than preferences.
 *  They are also reserved registers.
 *
 *  Revision 1.26  1992/05/20  10:30:09  clive
 *  Added arithmetic right shift
 *
 *  Revision 1.25  1992/05/13  11:09:34  clive
 *  Added the Bits structure
 *
 *  Revision 1.24  1992/04/07  10:09:24  richard
 *  Partitioned corrupted_by_callee according to register type to
 *  avoid naming clashes.
 *
 *  Revision 1.23  1992/03/06  12:23:55  clive
 *  G7 missed off the corrupted by callee list
 *
 *  Revision 1.22  1992/03/02  15:22:33  richard
 *  Added EQFUN pervasive (not inline) and changed EQ to be inline.
 *  See Mir_Cg.
 *
 *  Revision 1.21  1992/02/11  10:45:19  clive
 *  New pervasive library
 *
 *  Revision 1.20  1992/02/06  16:16:46  richard
 *  Added temporary.
 *
 *  Revision 1.19  1992/01/23  09:35:47  clive
 *  Added the EXSUBSCRIPTVAL and EXSIZEVAL
 *
 *  Revision 1.18  1992/01/21  12:23:50  clive
 *  Added some code to support the ref_chain
 *
 *  Revision 1.17  1992/01/16  09:32:40  clive
 *  Added arrays and made most of the functions in this structure inline coded
 *
 *  Revision 1.16  1992/01/10  11:49:54  richard
 *  Added substring pervasive as a temporary measure until compiler is bootstrapped.
 *
 *  Revision 1.15  1992/01/07  09:29:44  clive
 *  Added stack limit register definitions
 *
 *  Revision 1.14  1992/01/03  16:36:12  richard
 *  Added the zero register.  Added exception values to the is_inline
 *  function.  Tidied up documentation.
 *
 *  Revision 1.13  1991/12/04  13:30:48  richard
 *  Added the callee_closure to the reserved registers so that the
 *  garbage collector can always find the closure.
 *
 *  Revision 1.12  91/11/29  15:28:49  richard
 *  Added `reserved' to prevent register allocation from very special
 *  registers.
 *  
 *  Revision 1.11  91/11/25  15:49:13  jont
 *  Added fp_global as a temporary for conversions from fp to int
 *  
 *  Revision 1.10  91/11/14  14:34:41  richard
 *  Added is_inline clause for CALL_C and SYSTEM.
 *  
 *  Revision 1.9  91/11/14  10:55:57  richard
 *  Removed references to fp_double registers.
 *  
 *  Revision 1.8  91/11/12  16:50:55  jont
 *  Added is_inline function on the pervasives, this is where it should be
 *  Removed specific subfunctions to do with multiply etc capability
 *  
 *  Revision 1.7  91/10/29  14:16:37  jont
 *  Added values indicating existence on machin level multiply, divide
 *  and modulus
 *  
 *  Revision 1.6  91/10/24  15:28:13  davidt
 *  Now knows about the `implicit' register.
 *  
 *  Revision 1.5  91/10/15  15:14:58  richard
 *  Changed corrupted_by_callee to a set rather than a list.
 *  
 *  Revision 1.4  91/10/14  14:37:58  richard
 *  Added corrupted_by_callee and fixed the gc register list.
 *  
 *  Revision 1.3  91/10/10  14:29:52  richard
 *  indicates allocation preferences. after_preserve and after_restore
 *  discarded.
 *  
 *  Revision 1.2  91/10/09  14:28:07  richard
 *  Added some new register definitions
 *  
 *  Revision 1.1  91/10/07  11:44:56  richard
 *  Initial revision
 *)


require "../utils/set";
require "../utils/crash";
require "../main/machspec";
require "machtypes";


functor MachSpec (

  structure MachTypes	: MACHTYPES
  structure Set		: SET
  structure Crash       : CRASH
) : MACHSPEC =

struct

  structure Set = Set


  (* === What sort of machine is it? === *)

  datatype MachType = SPARC | MIPS | I386

  val mach_type : MachType = SPARC

  (*  === MACHINE REGISTERS ===  *)


  type register = MachTypes.Sparc_Reg



  local
    open MachTypes
  in

    (*  == Special registers ==  *)

    val caller_arg =		MachTypes.caller_arg
    val callee_arg =		MachTypes.callee_arg
    val caller_arg_regs =	MachTypes.caller_arg_regs
    val callee_arg_regs =	MachTypes.callee_arg_regs
    val caller_closure =	MachTypes.caller_closure
    val callee_closure =	MachTypes.callee_closure
    (* No F4 here as this is fp_global *)
    val fp_arg_regs =           [F0,F2,F6,F8,F10,F12,F14,F16]
    val tail_arg =		callee_arg
    val tail_closure = 		callee_closure
    val fp =			MachTypes.fp
    val sp =			MachTypes.sp
    val handler =		MachTypes.handler
    val global =		MachTypes.global
    val implicit =		MachTypes.implicit
    val fp_global =		MachTypes.fp_global

    val zero = SOME G0


    (*  == General registers ==
     *
     *  gcs:		int/ptr visible to garbage collector
     *  non_gcs:	int/ptr not visible to garbage collector
     *  fps:		floating point registers
     *)
    
    (* Version for new lambda optimiser -- I2 and O2 are for argument passing *)
    val gcs = [I0,I2,I3, I4, I5,
	       L0, L1, L2, L3, L4, L5, L6, L7,
               O0,O2,O3, O4, O5, lr, G7]

    val non_gcs = []

    val fps = case MachTypes.fp_used of
      MachTypes.single =>
        Crash.impossible "machspec not configured for single-float case"
    | MachTypes.double =>
        [F24,F26,F28,F30, F16,F18,F20,F22, F8,F10,F12,F14, F0,F2,F6]
    | MachTypes.extended =>
        Crash.impossible "machspec not configured for extended-float case"

    val empty_register_set = Set.empty_set : register Set.Set
    (* Until problems with restoring callee-save fp registers on exception raise *)
    (* is sorted out, we make all fp registers be caller-save *)
    val corrupted_by_callee =
      {gc = Set.list_to_set [O1, O2, O3, O4, O5, lr, G4, G5, G7],
       non_gc = empty_register_set,
       fp = Set.list_to_set[F0, F2, F4, F6, F8, F10, F12, F14, 
                            F16, F18, F20, F22, F24, F26, F28, F30] }

    val corrupted_by_alloc =
      {gc = Set.list_to_set [lr],
       non_gc = empty_register_set,
       fp = empty_register_set }

    val defined_on_entry =
      {gc = empty_register_set,
       non_gc = empty_register_set,
       fp = empty_register_set }

    val referenced_by_alloc =
      {gc = Set.list_to_set [callee_closure],
       (* This is to prevent callee_closure from being updated before an alloc *)
       (* which would then break the gc *)
       non_gc = empty_register_set,
       fp = empty_register_set }

    (*  == Reserved registers ==
     *
     *  These can never be used for anything except their special purpose,
     *  they can't even be temporarily spilled.  This list includes the
     *  temporary registers.
     *)

    (* Want to be able to experiment with this set *)
    val normal_temporaries = [L5]

    val reserved =
      {gc = Set.list_to_set ([callee_closure, sp, fp, global,
                             lr, gc1, gc2, implicit,
                             G0, stack_limit, handler] @ normal_temporaries),
       non_gc = empty_register_set,
       fp = Set.list_to_set [fp_global, F24, F26, F28]}

    (* For debugging code, reserve callee_arg *)
    val debugging_reserved =
      {gc = Set.list_to_set([callee_arg] @ [callee_closure, sp, fp, global,
					    lr, gc1, gc2, implicit,
					    G0, stack_limit, handler] @ normal_temporaries),
       non_gc = empty_register_set,
       fp = Set.list_to_set[fp_global, F24, F26, F28]}

    val reserved_but_preferencable =
      {gc = [callee_closure, global, lr],
       non_gc = [],
       fp = [fp_global]}

    (* For debugging code, no extra preferencing *)
    val debugging_reserved_but_preferencable =
      {gc = [],
       non_gc = [],
       fp = []}

    (*  == Temporary registers ==
     *
     *  These are the registers reserved for use as temporaries for the
     *  register allocator.  Currently, two are required for each used
     *  register type.  It's best to use the O registers first for
     *  temporaries as these tend to be corrupted by subroutine calls in any
     *  case.
     *  The use of temporaries is preferenced, such that instruction requiring only
     *  one temporary will use the first in the list, etc. The ordering should be
     *  preserved in order to ensure that lr is not used as the destination of ALLOC
     *
     *)

    val temporary =
      {gc = normal_temporaries @ [lr],
       non_gc = [] : register list,
       fp = [F24,F26,F28]}


    (*  == Allocation order ==
     *
     *  On the SPARC the I registers should be allocated randomly, since
     *  they cost nothing to save.  After that, the O registers should be
     *  used in preference to the L registers because this will tend to
     *  leave the L's free for variables which _need_ to be preserved across
     *  calls.
     *)

    local
      fun rank I0 = 0
        | rank I1 = 0
        | rank I2 = 0
        | rank I3 = 0
        | rank I4 = 0
        | rank I5 = 0
        | rank I6 = 0
        | rank I7 = 0
        | rank G0 = 0
        | rank G1 = 0
        | rank G2 = 0
        | rank G3 = 0
        | rank G4 = 0
        | rank G5 = 0
        | rank G6 = 0
        | rank G7 = 0
        | rank O0 = 1
        | rank O1 = 1
        | rank O2 = 1
        | rank O3 = 1
        | rank O4 = 1
        | rank O5 = 1
        | rank O6 = 1
        | rank O7 = 1
        | rank L0 = 2
        | rank L1 = 2
        | rank L2 = 2
        | rank L3 = 2
        | rank L4 = 2
        | rank L5 = 2
        | rank L6 = 2
        | rank L7 = 2
        | rank _ = 3

      fun order (reg, reg') =
        let
          val r = rank reg
          val r' = rank reg'
        in
          r < r' 
        end
 
     fun equal (reg, reg') =
        let
          val r = rank reg
          val r' = rank reg'
        in
          r = r' 
        end

      fun fp_order(reg, reg') =
	let
	  val b1 = Set.is_member(reg, #fp corrupted_by_callee)
	  val b2 = Set.is_member(reg', #fp corrupted_by_callee)
	in
          b1 andalso not b2
	end

     fun fp_equal(reg, reg') =
	let
	  val b1 = Set.is_member(reg, #fp corrupted_by_callee)
	  val b2 = Set.is_member(reg', #fp corrupted_by_callee)
	in
          b1 = b2
	end

    in
      val allocation_order =
        {gc = order,
         non_gc = order,
         fp = fp_order}
     val allocation_equal =
        {gc = equal,
         non_gc = equal,
         fp = fp_equal}
    end

  end


  (*  == Spill handling == *)

  val do_unspilling = true

  (*  == Register printing ==  *)

  val print_register = MachTypes.reg_to_string

  (* Immediate stores for CISCs *)

  val has_immediate_stores = false

  (*  === MACHINE LIMITS ===  *)

  val digits_in_real = MachTypes.digits_in_real
  val bits_per_word = MachTypes.bits_per_word
  val leaf_regs = 6

  (* === REGISTER ALLOCATION STRATEGY === *)

  val use_stack_colourer = true

  (*  === MACHINE FUNCTIONS === *)

  exception Ord = MachTypes.Ord
  exception Chr = MachTypes.Chr

  val ord = MachTypes.ord
  val chr = MachTypes.chr

end
