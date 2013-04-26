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

 based on Revision 1.43

 Revision Log
 ------------
 $Log: _machspec.sml,v $
 Revision 1.36  1998/08/27 12:14:19  jont
 [Bug #70040]
 Modify register colourer to use stack colourer only if requested from machspec

 * Revision 1.35  1997/05/14  14:18:54  matthew
 * [Bug #30028]
 * Removing caller_closure from reserved_but_preferenceable
 *
 * Revision 1.34  1997/05/13  15:05:12  jont
 * [Bug #20038]
 * Add referenced_by_alloc
 *
 * Revision 1.33  1997/05/01  13:15:52  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.32  1997/04/24  15:45:26  jont
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.31  1997/03/25  11:52:57  matthew
 * Adding mach_type value
 *
 * Revision 1.30  1997/01/21  16:06:42  jont
 * [Bug #0]
 * Add in corrupted_by_alloc and leaf_regs
 *
 * Revision 1.29  1996/12/16  17:09:46  matthew
 * Addin fp_arg_regs
 *
 * Revision 1.28  1996/11/01  13:41:04  jont
 * [Bug #1683]
 * Make all fp registers caller save
 *
 * Revision 1.27  1996/03/20  12:33:53  matthew
 * Changes for value polymorphism
 *
 * Revision 1.26  1995/12/22  13:15:02  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.25  1995/08/14  12:05:56  jont
Add bits_per_word
Remove smallest_int, largest_int, largest_word

Revision 1.24  1995/07/25  15:44:48  jont
Add largest_word

Revision 1.23  1995/06/19  15:49:49  jont
Extend number of floating point tempoaries to 3 as required by the register allocator

Revision 1.22  1995/05/30  12:58:30  matthew
Adding debugging_reserved register list

Revision 1.21  1994/12/09  12:10:27  nickb
Change floating-point callee-saves.

Revision 1.20  1994/11/15  13:53:34  jont
Add has_immediate_store flag

Revision 1.19  1994/11/10  10:15:59  matthew
Fixing FP temporaries.

Revision 1.18  1994/10/25  14:16:28  matthew
Reserve caller_closure to prevent it getting overwritten in leaf tail calls

Revision 1.17  1994/10/24  14:28:52  matthew
Various things:
Changed for multiple argument passing`
Added caller_arg and lr to corrupted_by_callee
Removed callee_arg from reserved list
Use R16 and lr as the only 2 spill temporaries
Changed the ranking of registers so caller_saves are allocated first

Revision 1.16  1994/09/21  16:11:22  jont
Add do_unspill value to control register allocator

Revision 1.15  1994/09/15  17:54:37  jont
Add chr and ord
Also add Chr and Ord

Revision 1.14  1994/08/25  12:13:21  matthew
Replaced *_arg2 with *_arg_regs

Revision 1.13  1994/07/25  14:01:50  matthew
Added dummy definition of arg2.  This won't work but should fail badly enough to notice.

Revision 1.12  1994/07/19  15:37:05  jont
Modify register preference order on callee saves

Revision 1.11  1994/07/12  13:49:51  jont
Change register ranking to preference for callee saves

Revision 1.10  1994/07/12  11:30:54  jont
Ensure tables of reserved, corrupted_by_callee and temporary are ok

Revision 1.9  1994/06/14  13:05:01  io
simplifying callee_arg and caller_arg

Revision 1.8  1994/05/10  14:46:23  jont
Remove lr, gc1, gc2, stack_limit from register interface

Revision 1.7  1994/03/08  17:23:38  jont
Move digits_in_real here

Revision 1.6  1994/03/04  12:57:47  jont
Changes for automatic_callee mechanism removal
and moving machspec from machine to main

Revision 1.5  1994/02/25  12:07:33  io
again

Revision 1.4  1994/02/24  21:28:59  io
Changed register conventions to nickh's conventions doc

Revision 1.3  1994/02/23  17:45:09  jont
Changes to register preferences for allocation

Revision 1.2  1993/11/16  16:50:30  io
Deleted old SPARC comments and fixed type errors

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

  val mach_type : MachType = MIPS

  (*  === MACHINE REGISTERS ===  *)


  type register = MachTypes.Mips_Reg



  local
    open MachTypes
  in

    (*  == Special registers ==  *)

    val caller_arg =		MachTypes.arg
    val callee_arg =		MachTypes.arg
    (* MLA Now have 8 argument registers *)
    val caller_arg_regs =	[MachTypes.arg,R17,R18,R19,R20,R21,R22,R23]
    val callee_arg_regs =       caller_arg_regs
    val caller_closure =	MachTypes.caller_closure
    val callee_closure =	MachTypes.callee_closure
    val tail_arg =		caller_arg
    val tail_closure = 		caller_closure
    val fp_arg_regs =           [F8,F10,F12,F14,F16,F18,F20,F22]
    val fp =			MachTypes.fp
    val sp =			MachTypes.sp
    val handler =		MachTypes.handler
    val global =		MachTypes.global
    val implicit =		MachTypes.implicit
    val fp_global =		MachTypes.fp_global

    val zero = SOME R0


    (*  == General registers ==
     *
     *  gcs:		int/ptr visible to garbage collector
     *  non_gcs:	int/ptr not visible to garbage collector
     *  fps:		floating point registers
     *)

    (* MLA Don't include arg regs here *)
    val gcs = 
      [R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25,lr]

    val non_gcs = []

    (* All the fps except for F4 which is fp_global *)
    (* F0 and F2 are spill temporaries and are reserved *)

    val fps = case MachTypes.fp_used of
      MachTypes.single =>
        Crash.impossible "machspec not configured for single-float case"
    | MachTypes.double =>
        [F0, F2, F6, F8, F10, F12, F14, F16, F18, F20, F22, F24, F26, F28, F30]
    | MachTypes.extended =>
        Crash.impossible "machspec not configured for extended-float case"

    val empty_register_set : Mips_Reg Set.Set = Set.empty_set

    (* MLA added caller_arg register and lr *)

    val corrupted_by_callee =
      {gc = Set.list_to_set [caller_arg,caller_closure, global,lr,
			     R16, R17, R18, R19, R20, R21, R22, R23],
       non_gc = empty_register_set,
       fp = Set.list_to_set[F0, F2, F4, F6, F8, F10, F12, F14, 
                            F16, F18, F20, F22, F24, F26, F28, F30] }

    val corrupted_by_alloc =
      {gc = Set.list_to_set [lr],
       non_gc = empty_register_set,
       fp = empty_register_set }

    val defined_on_entry =
      {gc = Set.list_to_set [caller_closure],
       non_gc = empty_register_set,
       fp = empty_register_set }

    val referenced_by_alloc =
      {gc = Set.list_to_set [callee_closure, caller_closure],
       (* This is to prevent callee_closure and caller_closure from being updated *)
       (* before an alloc which would then break the gc *)
       non_gc = empty_register_set,
       fp = empty_register_set }

    (*  == Reserved registers ==
     *
     *  These can never be used for anything except their special purpose,
     *  they can't even be temporarily spilled.  This list includes the
     *  temporary registers.
     *)

    (* Need to add caller_closure to prevent it getting overwritten in leaf tail calls *)

    val reserved =
      {gc = Set.list_to_set [R0, R1, gc1, gc2, handler, global, implicit,
			     stack_limit, sp, lr, fp, callee_closure,caller_closure,
			     R26, R27, R16],
       non_gc = empty_register_set,
       fp = Set.list_to_set [fp_global,F0, F2, F6]}

    val debugging_reserved = reserved

    val reserved_but_preferencable =
      {gc = [callee_closure, global, lr],
       non_gc = [],
       fp = [fp_global]}

    (* For debugging code, reserve callee_arg *)
    val debugging_reserved_but_preferencable =
      {gc = [],
       non_gc = [],
       fp = []}

    (*  == Temporary registers ==
     *
     *  These are the registers reserved for use as temporaries for the
     *  register allocator.  Currently, two are required for each used
     *  register type.  It's best to use the caller save registers first for
     *  temporaries as these tend to be corrupted by subroutine calls in any
     *  case. Or is it? In that case, we get almost no chance at leaf functions.
     *  Using callee_save registers is probably better here.
     *)
      
    (* Let's try using the link register as a spill temporary *)
    val temporary =
      {gc = [R16,lr],
       non_gc = [],
       fp = [F0, F2, F6]}


    (*  == Allocation order ==
     *
     *  On the SPARC the I registers should be allocated randomly, since
     *  they cost nothing to save.  After that, the O registers should be
     *  used in preference to the L registers because this will tend to
     *  leave the L's free for variables which _need_ to be preserved across
     *  calls.
     *)
    (* on the mips, things are simpler *)
    (*
     * No they aren't. We should rank the caller saves first, to maximise
     * the possibility of leaf procedures.
     *)

    local
      local
	open MachTypes
      in
	fun rank R10 = 1
	  | rank R11 = 2
	  | rank R12 = 3
	  | rank R13 = 4
	  | rank R14 = 5
	  | rank R15 = 6
	  | rank R16 = 0
	  | rank R17 = 0
	  | rank R18 = 0
	  | rank R19 = 0
	  | rank R20 = 0
	  | rank R21 = 0
	  | rank R22 = 0
	  | rank R23 = 0
	  | rank R24 = 7
	  | rank R25 = 8
	  | rank _ = 9
      end

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
  val leaf_regs = 9

  (* === REGISTER ALLOCATION STRATEGY === *)

  val use_stack_colourer = true

  (*  === MACHINE FUNCTIONS === *)

  exception Ord = MachTypes.Ord
  exception Chr = MachTypes.Chr

  val ord = MachTypes.ord
  val chr = MachTypes.chr

end
