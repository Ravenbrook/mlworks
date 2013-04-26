(*   ==== MACHINE SPECIFICATION ====
 *              FUNCTOR
 *
 *  $Log: _i386spec.sml,v $
 *  Revision 1.23  1998/08/27 12:13:50  jont
 *  [Bug #70040]
 *  Modify register colourer to use stack colourer only if requested from machspec
 *
 * Revision 1.22  1997/05/27  09:55:37  jont
 * [Bug #30076]
 * Adding argument passing pseudo registers for multiple argument passing work.
 *
 * Revision 1.21  1997/05/13  13:38:14  jont
 * [Bug #20038]
 * Add referenced_by_alloc
 *
 * Revision 1.20  1997/05/06  09:59:50  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.19  1997/04/25  12:27:43  jont
 * [Bug #20018]
 * Make sure fp_global is reserved
 *
 * Revision 1.18  1997/04/24  15:46:08  jont
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.17  1997/03/25  10:22:50  matthew
 * Adding mach_type value
 *
 * Revision 1.16  1997/01/21  16:08:09  jont
 * [Bug #0]
 * Add in corrupted_by_alloc and leaf_regs
 *
 * Revision 1.15  1996/12/18  13:12:12  matthew
 * Adding fp_arg_regs
 *
 * Revision 1.14  1996/03/20  14:38:18  matthew
 * Changes for new language definition
 *
 * Revision 1.13  1995/12/20  12:50:31  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.12  1995/08/14  12:15:06  jont
Add bits_per_word
Remove smallest_int, largest_int, largest_word

Revision 1.11  1995/07/25  15:58:44  jont
Add largest_word

Revision 1.10  1995/05/30  12:54:53  matthew
Adding debugging_reserved register list

Revision 1.9  1994/11/18  15:10:17  jont
Modify to new register assignment

Revision 1.8  1994/11/11  13:57:07  jont
Add has_immediate_store flag

Revision 1.7  1994/10/12  13:57:59  jont
Add callee_closure to reserved register list

Revision 1.6  1994/10/06  13:39:13  jont
Get tail_closure right (cf MIPS, not SPARC)

Revision 1.5  1994/09/21  16:11:32  jont
Add do_unspill value to control register allocator

Revision 1.4  1994/09/19  10:34:12  jont
Prevent list of special assignments clashing with gcs

Revision 1.3  1994/09/16  10:30:02  jont
Get register preference order unique for callee saves

Revision 1.2  1994/09/15  17:55:03  jont
Add chr and ord
Also add Chr and Ord

Revision 1.1  1994/09/15  12:32:21  jont
new file

 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *)


require "../utils/set";
require "../utils/crash";
require "../main/machspec";
require "i386types";


functor I386Spec (
  structure I386Types	: I386TYPES
  structure Set		: SET
  structure Crash       : CRASH
) : MACHSPEC =

struct

  structure Set = Set


  (* === What sort of machine is it? === *)

  datatype MachType = SPARC | MIPS | I386

  val mach_type : MachType = I386

  (*  === MACHINE REGISTERS ===  *)


  type register = I386Types.I386_Reg



  local
    open I386Types
  in

    (*  == Special registers ==  *)

    val caller_arg =		caller_arg
    val callee_arg =		callee_arg
    val caller_arg_regs =	[caller_arg, o_arg1, o_arg2, o_arg3, o_arg4, o_arg5, o_arg6, o_arg7]
    val callee_arg_regs =	[callee_arg, i_arg1, i_arg2, i_arg3, i_arg4, i_arg5, i_arg6, i_arg7]
    val caller_closure =	caller_closure
    val callee_closure =	callee_closure
    val fp_arg_regs =           []
    val tail_arg =		callee_arg
    val tail_closure = 		caller_closure
    val fp =			stack (* Not using this *)
    val sp =			sp
    val handler =		heap (* This one in store *)
    val global =		global
    val implicit =		implicit
    val fp_global =		stack (* Shouldn't be needed *)

    val zero = NONE


    (*  == General registers ==
     *
     *  gcs:		int/ptr visible to garbage collector
     *  non_gcs:	int/ptr not visible to garbage collector
     *  fps:		floating point registers
     *)
    
    val gcs = [EAX, EDX]

    val non_gcs = []

    val fps : register list = case I386Types.fp_used of
      I386Types.single =>
        Crash.impossible "i386spec not configured for single-float case"
    | I386Types.double =>
        []
    | I386Types.extended =>
        Crash.impossible "i386spec not configured for extended-float case"

    val empty_register_set : register Set.Set = Set.empty_set
    val corrupted_by_callee =
      {gc = Set.list_to_set(caller_closure :: implicit :: caller_arg_regs),
       non_gc = empty_register_set,
       fp = empty_register_set}

    val corrupted_by_alloc =
      {gc = empty_register_set,
       non_gc = empty_register_set,
       fp = empty_register_set }

    val defined_on_entry =
      {gc = Set.list_to_set [caller_closure],
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

    val reserved =
      {gc = Set.list_to_set [sp, fp, global,
                             implicit,
                             handler, callee_closure,
			     o_arg1, o_arg2, o_arg3, o_arg4, o_arg5, o_arg6, o_arg7,
			     i_arg1, i_arg2, i_arg3, i_arg4, i_arg5, i_arg6, i_arg7],
       non_gc = empty_register_set,
       fp = Set.list_to_set[fp_global]}

    val debugging_reserved = reserved

    val reserved_but_preferencable =
      {gc = [callee_closure, global, i_arg1, i_arg2, i_arg3, i_arg4, i_arg5, i_arg6, i_arg7],
       non_gc = [],
       fp = []}

    (* For debugging code, no extra preferencing *)
    val debugging_reserved_but_preferencable =
      {gc = [],
       non_gc = [],
       fp = []}

    (*  == Temporary registers ==
     *
     *  These are the registers reserved for use as temporaries for the
     *  register allocator.  None are required for the PC.
     *)

    val temporary =
      {gc = [],
       non_gc = [],
       fp = []}


    (*  == Allocation order ==
     *
     *)

    local
      fun rank EAX = 2
        | rank EBX = 0
        | rank ECX = 5
        | rank EDX = 3
        | rank EBP = 1
        | rank ESP = 5
        | rank EDI = 4
        | rank ESI = 5
        | rank _ = 5

      (* Note that EAX is preferenced ahead of EDX *)
      (* This order (one preference level for each callee save) *)
      (* is required for stack unwinding during exception handling *)
      (* Also, we preference EBX before EBP as allocating EBP forces non-leaf *)

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

      fun fp_equal (reg, reg') =
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

  val do_unspilling = false

  (*  == Register printing ==  *)

  val print_register = I386Types.reg_to_string

  (* Immediate stores for CISCs *)

  val has_immediate_stores = true

  (*  === MACHINE LIMITS ===  *)

  val digits_in_real = I386Types.digits_in_real
  val bits_per_word = I386Types.bits_per_word
  val leaf_regs = 0

  (* === REGISTER ALLOCATION STRATEGY === *)

  val use_stack_colourer = false

  (*  === MACHINE FUNCTIONS === *)

  exception Ord = I386Types.Ord
  exception Chr = I386Types.Chr

  val ord = I386Types.ord
  val chr = I386Types.chr

end
