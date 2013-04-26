(*  ==== MIR VIRTUAL REGISTER MODEL ===
 *              SIGNATURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines the register use model for procedures in MIR code.
 *  It also defines sets of unique MIR registers and tables to map them onto
 *  real machine registers; these uniques can be used as _aliases_ for the
 *  real registers, allowing register allocation to take place entirely
 *  within the MIR environment.
 *
 *  Revision Log
 *  ------------
 *  $Log: mirregisters.sml,v $
 *  Revision 1.37  1997/05/13 13:03:16  jont
 *  [Bug #20038]
 *  Add referenced_by_alloc
 *
 * Revision 1.36  1997/05/01  12:37:21  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.35  1997/04/24  15:39:28  jont
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.34  1997/01/16  18:20:10  jont
 * Add corrupted_by_alloc
 *
 * Revision 1.33  1996/12/03  14:20:54  matthew
 * Adding fp_arg_regs
 *
 * Revision 1.32  1995/12/20  12:45:07  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.31  1995/05/30  11:09:35  matthew
 *  Simplifications
 *
 *  Revision 1.30  1994/09/29  15:52:29  jont
 *  Remove handler register concept
 *
 *  Revision 1.29  1994/08/08  09:54:08  matthew
 *  Changed *_arg2 reg to *_arg_regs
 *
 *  Revision 1.28  1994/07/25  11:44:41  matthew
 *  Added extra argument register.  A more general solution would be desirable.
 *
 *  Revision 1.27  1994/07/13  10:49:23  jont
 *  Fix to avoid lr unspilling alloc
 *
 *  Revision 1.26  1994/03/04  12:28:03  jont
 *  Changes for automatic_callee mechanism removal
 *  and moving machspec from machine to main
 *
 *  Revision 1.25  1993/08/05  10:22:48  richard
 *  Removed unnecessary defined_by_raise.
 *
 *  Revision 1.24  1993/05/28  14:43:06  nosa
 *  Changed Option.T to Option.opt.
 *
 *  Revision 1.23  1993/02/01  16:24:50  matthew
 *  Added sharing
 *
 *  Revision 1.22  1992/11/02  17:13:24  jont
 *  Reworked in terms of mononewmap
 *
 *  Revision 1.21  1992/10/02  17:05:58  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.20  1992/08/26  13:53:29  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.19  1992/06/22  11:47:54  richard
 *  Added defined_by_raise.
 *
 *  Revision 1.18  1992/06/08  10:40:16  richard
 *  Added allocation_order.
 *
 *  Revision 1.17  1992/06/03  16:05:45  richard
 *  Temporaries are now sets of registers which are also reserved.
 *
 *  Revision 1.16  1992/05/27  12:10:40  richard
 *  Changed register Sets to Packs.
 *
 *  Revision 1.15  1992/02/27  16:03:42  richard
 *  Changed the way virtual registers are handled.  See MirTypes.
 *
 *  Revision 1.14  1992/02/10  10:47:16  richard
 *  Major changes to accommodate new version (2.1) of register allocator.
 *
 *  Revision 1.13  1992/01/21  12:22:19  clive
 *  Added implicit
 *
 *  Revision 1.12  1992/01/03  15:54:39  richard
 *  Added the zero register.
 *
 *  Revision 1.11  1991/12/04  12:59:42  richard
 *  Added ordered_general_purpose.
 *
 *  Revision 1.10  91/11/29  11:57:06  richard
 *  Corrected the definition of general_purpose and removed the
 *  useless definition of machine_register_aliases.
 *  
 *  Revision 1.9  91/11/14  10:49:59  richard
 *  Removed references to fp_double registers.
 *  
 *  Revision 1.8  91/11/04  15:20:50  richard
 *  Added general_purpose.
 *  
 *  Revision 1.7  91/10/16  09:12:45  richard
 *  Recommented and added corrupted_by_callee.
 *  
 *  Revision 1.6  91/10/15  15:06:43  richard
 *  Moved register assignments here from the register allocator functor.
 *  
 *  Revision 1.5  91/10/09  16:13:23  richard
 *  Added various new register definitions.
 *  
 *  Revision 1.4  91/10/02  11:05:17  jont
 *  Removed real register options, these are being done elsewhere
 *  
 *  Revision 1.3  91/10/01  14:51:43  richard
 *  Added global register.
 *  
 *  Revision 1.2  91/09/20  13:13:34  jont
 *  Removed temp_sp, not required
 *  
 *  Revision 1.1  91/09/18  11:46:22  jont
 *  Initial revision
 *)

require "../main/machspec";
require "mirtypes";


signature MIRREGISTERS =

  sig

    structure MirTypes	: MIRTYPES
    structure MachSpec	: MACHSPEC

    (*  === MACHINE REGISTER ALIASES ===
     *
     *  These tables map unique virtual (MIR) registers onto their machine
     *  register counterparts.  The virtual registers can then be used to do
     *  register allocation wholly within MIR.
     *)

    val machine_register_assignments :
      {gc	: (MachSpec.register) MirTypes.GC.Map.T,
       non_gc	: (MachSpec.register) MirTypes.NonGC.Map.T,
       fp	: (MachSpec.register) MirTypes.FP.Map.T}


    (*  === CALL MODEL ===
     *
     *  The following values define the way in which MIR registers are used
     *  inter- and intra-procedurally.
     *
     *  general_purpose
     *    sets of registers which can be used to hold general purpose values
     *    during a procedure: the registers available for register
     *    allocation.  These registers may be spilled onto the stack.
     *
     *  reserved
     *    sets of registers distinct from general_purpose which may not be
     *    used to hold any value except that assigned by the original code
     *    from the code generator (for example, the frame pointer).  These
     *    registers may not be spilled onto the stack.
     *
     *  preassigned
     *    sets of registers which should not be allocated to new virtual
     *    registers.  These are registers which have been effectively
     *    allocated by the code generator.  NOTE: These be general purpose
     *    or reserved registers.
     *
     *  temporary
     *    sets of reserved registers which can be used as temporaries when
     *    spilling.
     *
     *  Special purpose registers
     *
     *  caller_arg	The register used to pass an argument to a
     *  		procedure.
     *  callee_arg	The argument
     *  		from the caller is found in this register.
     *  caller_closure	The register used to pass the closure to a
     *  		procedure.
     *  callee_closure  As for callee_arg.
     *  tail_arg        The register used to pass an argument to a tail call.
     *                  Will be either caller_arg or callee_arg as appropriate
     *  tail_closure    As for tail_arg
     *
     *  fp		The pointer to the procedure stack frame.
     *  sp		The stack pointer.
     *  global		A scratch register which is unaffected by the
     *  		PREVIOUS_ENVIRONMENT instruction.
     *
     *  defined_on_entry
     *    The set of registers which contain values on entry to the
     *    procedure.  These will be the registers defined as arguments to
     *    the procedure or necessary to the call mechanism.
     *
     *  defined_on_exit
     *    The set of registers which must contain values on exit to the
     *    procedure.  These will be registers returned to the caller or
     *    necessary to the call mechanism.
     *
     *  corrupted_by_callee
     *    The set of registers which may be overwritten by a procedure.
     *    These are sets of virtual registers --- they are the ones which
     *    map on to the real registers which are corrupted under the
     *    machine_register_assignments (see above).  They are therefore
     *    in preassigned.
     *
     *  zero
     *    This register is present if target machine has a `zero' register
     *    which can be used instead of a literal zero and as a data sink.
     *)

    val general_purpose :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val debugging_general_purpose :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val gp_for_preferencing :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val debugging_gp_for_preferencing :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val allocation_order :
      {gc	: MirTypes.GC.T * MirTypes.GC.T -> bool,
       non_gc	: MirTypes.NonGC.T * MirTypes.NonGC.T -> bool,
       fp	: MirTypes.FP.T * MirTypes.FP.T -> bool}

    val allocation_equal :
      {gc	: MirTypes.GC.T * MirTypes.GC.T -> bool,
       non_gc	: MirTypes.NonGC.T * MirTypes.NonGC.T -> bool,
       fp	: MirTypes.FP.T * MirTypes.FP.T -> bool}

    val preassigned :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val temporary :
      {gc	: MirTypes.GC.T list,
       non_gc	: MirTypes.NonGC.T list,
       fp	: MirTypes.FP.T list}
      
    val caller_arg :		MirTypes.GC.T
    val callee_arg :		MirTypes.GC.T
    val caller_arg_regs :       MirTypes.GC.T list
    val callee_arg_regs :	MirTypes.GC.T list
    val caller_closure :	MirTypes.GC.T
    val callee_closure :	MirTypes.GC.T
    val tail_arg :		MirTypes.GC.T
    val tail_arg_regs :    	MirTypes.GC.T list
    val tail_closure :		MirTypes.GC.T
    val fp :	 		MirTypes.GC.T
    val sp :			MirTypes.GC.T
    val global :		MirTypes.GC.T
    val implicit :		MirTypes.GC.T
    val zero :			MirTypes.GC.T option

    val fp_arg_regs:            MirTypes.FP.T list

    val defined_on_entry :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val defined_on_exit :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val corrupted_by_callee :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val corrupted_by_alloc :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val referenced_by_alloc :
      {gc	: MirTypes.GC.Pack.T,
       non_gc	: MirTypes.NonGC.Pack.T,
       fp	: MirTypes.FP.Pack.T}

    val pack_next : {gc : int, non_gc : int, fp : int}

  end
