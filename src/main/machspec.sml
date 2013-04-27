(*   ==== MACHINE SPECIFICATION ====
 *             SIGNATURE
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Description
 * -----------
 * This module contains all the information necessary to generate MIR code
 * suitable for the machine code generator.  For example, it specifies the
 * register model and which pervasives can be generated as in-line code.
 * Inlining of pervasives now moved to machperv
 *
 * Revision Log
 * ------------
 * $Log: machspec.sml,v $
 * Revision 1.19  1998/08/27 12:13:11  jont
 * [Bug #70040]
 * Modify register colourer to use stack colourer only if requested from machspec
 *
 * Revision 1.18  1997/05/13  13:35:42  jont
 * [Bug #20038]
 * Add referenced_by_alloc
 *
 * Revision 1.17  1997/05/01  12:44:14  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.16  1997/04/18  12:58:15  jont
 * [Bug #20007]
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.15  1997/03/25  10:21:48  matthew
 * Adding mach_type value
 *
 * Revision 1.14  1997/01/16  16:59:16  jont
 * Add in corrupted_by_alloc and leaf_regs
 *
 * Revision 1.13  1996/12/03  14:02:09  matthew
 * Addin fp_arg_regs
 *
 * Revision 1.12  1995/12/20  12:47:15  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 * Revision 1.11  1995/08/14  11:48:48  jont
 * Add bits_per_word to backend specification
 *
 * Revision 1.10  1995/07/25  10:21:30  jont
 * Add largest_word machine limit
 *
 * Revision 1.9  1995/05/30  12:52:40  matthew
 * Adding debugger_reserved register set
 *
 * Revision 1.8  1994/11/11  13:56:45  jont
 * Add has_immediate_store flag
 *
 * Revision 1.7  1994/09/21  16:06:11  jont
 * Add do_unspill value to control register allocator
 *
 * Revision 1.6  1994/09/15  17:52:06  jont
 * Add chr and ord to signature
 * Also add Chr and Ord
 *
 * Revision 1.5  1994/07/29  11:27:50  matthew
 * More work on multiple argument passing
 *
 * Revision 1.4  1994/07/25  11:43:00  matthew
 * Adding extra arg register
 *
 * Revision 1.3  1994/05/10  14:46:37  jont
 * Remove lr, gc1, gc2, stack_limit from register interface
 *
 * Revision 1.2  1994/03/08  17:23:54  jont
 * Move digits_in_real here
 *
 * Revision 1.1  1994/03/04  17:24:54  jont
 * new file
 *
 * Revision 1.21  1993/05/28  14:42:01  nosa
 * Changed Option.T to Option.opt.
 *
 * Revision 1.20  1992/11/21  19:33:07  jont
 * Removed is_inline to machperv in order to remove dependence of entire
 * mir stage on pervasives
 *
 * Revision 1.19  1992/10/02  17:02:08  clive
 * Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 * Revision 1.18  1992/06/08  15:21:17  richard
 * Added allocation_order.
 *
 * Revision 1.17  1992/06/03  16:27:49  richard
 * The reserved registers are now complete sets rather than a list
 * of preferences.
 *
 * Revision 1.16  1992/04/07  10:11:10  richard
 * Partitioned corrupted_by_callee according to register type to
 * avoid naming clashes.
 *
 * Revision 1.15  1992/02/06  10:55:52  richard
 * Added `temporary'.
 *
 * Revision 1.14  1992/01/07  09:17:03  clive
 * Added stack limit register definitions
 *
 * Revision 1.13  1992/01/03  15:44:00  richard
 * Added the zero register.
 *
 * Revision 1.12  1991/12/04  13:08:29  richard
 * Tidied up the documentation.
 *
 * Revision 1.11  91/11/29  11:47:12  richard
 * Added `reserved' to prevent register allocation from very special
 * registers.
 * 
 * Revision 1.10  91/11/25  15:33:05  jont
 * Added fp_global as a temporary for conversions from fp to int
 * 
 * Revision 1.9  91/11/14  10:56:54  richard
 * Removed references to fp_double registers.
 * 
 * Revision 1.8  91/11/12  16:54:28  jont
 * Added is_inline function to the signature
 * 
 * Revision 1.7  91/10/29  14:16:08  jont
 * Added values indicating existence on machin level multiply, divide
 * and modulus
 * 
 * Revision 1.6  91/10/24  15:29:01  davidt
 * Now knows about the `implicit' register.
 * 
 * Revision 1.5  91/10/15  15:14:58  richard
 * Changed corrupted_by_callee to a set rather than a list.
 * 
 * Revision 1.4  91/10/14  14:31:33  richard
 * Added corrupted_by_callee.
 * 
 * Revision 1.3  91/10/10  14:28:50  richard
 * indicates allocation preferences. after_preserve and after_restore
 * discarded.
 * 
 * Revision 1.2  91/10/09  14:27:05  richard
 * Added some new register definitions
 * 
 * Revision 1.1  91/10/07  11:22:56  richard
 * Initial revision
 *)


require "../utils/set";

signature MACHSPEC =

  sig

    structure Set	 : SET

    (* === What sort of machine is it? === *)

    datatype MachType = SPARC | MIPS | I386

    val mach_type : MachType

    (*  === MACHINE REGISTERS ===  *)

    eqtype register


    (*  == General registers ==
     *
     *  These are the general purpose allocatable registers for the
     *  different types of virtual register.  The order is significant:
     *  earlier registers should be used in preference to later ones.
     *
     *  gcs:		int/ptr visible to garbage collector
     *  non_gcs:	int/ptr not visible to garbage collector
     *  fps:		floating point registers
     *)

    val gcs		: register list
    val non_gcs		: register list
    val fps		: register list


    (*  == Special purpose reserved registers ==  *)

    val caller_arg 	: register	(* function argument from caller *)
    val callee_arg	: register 	(* ditto to callees (may be same) *)
    val caller_arg_regs : register list
    val callee_arg_regs	: register list
    val caller_closure	: register	(* closure pointer from caller *)
    val callee_closure	: register	(* ditto to callees (may be same) *)
    val fp_arg_regs     : register list
    val fp		: register	(* frame pointer *)
    val sp		: register	(* stack pointer *)
    val handler		: register	(* pointer to exception handler code *)
    val global		: register	(* not affected by PRESERVE/RESTORE *)
    val fp_global	: register	(* spare for fp temporaries *)
    val implicit	: register	(* Always holds the implicit vector *)
    val zero		: register option
    					(* Register which is always zero *)

    val tail_arg        : register      (* Where to put the arg for a tail call *)
    val tail_closure    : register      (* Where to out the closure for a tail call *)

    (*  == Calling conventions ==  *)

    val corrupted_by_callee : {gc     : register Set.Set,
                               non_gc : register Set.Set,
                               fp     : register Set.Set}


    val corrupted_by_alloc :  {gc     : register Set.Set,
                               non_gc : register Set.Set,
                               fp     : register Set.Set}

    val referenced_by_alloc : {gc     : register Set.Set,
                               non_gc : register Set.Set,
                               fp     : register Set.Set}

    val defined_on_entry :    {gc     : register Set.Set,
                               non_gc : register Set.Set,
                               fp     : register Set.Set}

    (*  == Reserved registers ==
     *
     *  These can never be used for anything except their special purpose,
     *  they can't even be temporarily spilled.
     *)

    val reserved : {gc : register Set.Set, non_gc : register Set.Set, fp : register Set.Set}
    (* and another set of reserved registers for when we want debuggable code *)
    val debugging_reserved : {gc : register Set.Set, non_gc : register Set.Set, fp : register Set.Set}
    val reserved_but_preferencable : {gc : register list, non_gc : register list, fp : register list}
    (* and another set of reserved registers for when we want debuggable code *)
    val debugging_reserved_but_preferencable : {gc : register list, non_gc : register list, fp : register list}


    (*  == Temporary registers ==
     *
     *  These are the recommended registers to use for temporaries when
     *  spilling.  They are in order of preference.
     *)

    val temporary : {gc     : register list,
                     non_gc : register list,
                     fp     : register list}


    (*  == Allocation order ==
     *
     *  Given two registers this determines the order in which they should
     *  be allocated.  If LESS the first should be allocated in preference
     *  to the second, the other way if GREATER.  If EQUAL they should be
     *  allocated equally and will be selected at random.
     *)

    val allocation_order :
      {gc     : register * register -> bool,
       non_gc : register * register -> bool,
       fp     : register * register -> bool}

    val allocation_equal :
      {gc     : register * register -> bool,
       non_gc : register * register -> bool,
       fp     : register * register -> bool}

    (*  == Spill handling == *)

    val do_unspilling : bool

    (*  == Register printing ==  *)

    val print_register	: register -> string

    (* Immediate stores for CISCs *)

    val has_immediate_stores : bool

    (*  === MACHINE LIMITS ===  *)

    val digits_in_real : int
    val bits_per_word : int
    val leaf_regs : int (* Number of registers available before a stack frame is required *)

    (* === REGISTER ALLOCATION STRATEGY === *)

    val use_stack_colourer : bool

    (*  === MACHINE FUNCTIONS === *)

    exception Ord
    exception Chr

    val ord: string -> int
    val chr: int -> string

  end
