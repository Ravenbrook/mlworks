(*  ==== MIR VIRTUAL REGISTER MODEL ===
 *               FUNCTOR
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Revision Log
 *  ------------
 *  $Log: _mirregisters.sml,v $
 *  Revision 1.45  1998/02/19 14:49:01  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 * Revision 1.44  1997/05/20  17:20:53  jont
 * [Bug #30076]
 * Sort out problems when caller_arg_regs and callee_arg_regs have
 * some but not all values in common
 *
 * Revision 1.43  1997/05/13  14:26:05  jont
 * [Bug #20038]
 * Add referenced_by_alloc
 *
 * Revision 1.42  1997/04/24  15:39:53  jont
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.41  1997/01/21  16:21:46  jont
 * Add corrupted_by_alloc
 *
 * Revision 1.40  1996/12/16  17:35:49  matthew
 * Removing references to MLWorks.Option
 *
 * Revision 1.39  1996/03/28  10:44:03  matthew
 * Adding where type clause
 *
 * Revision 1.38  1995/12/20  12:46:13  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.37  1995/05/30  11:55:23  matthew
 *  No reason?
 *
 *  Revision 1.36  1994/10/24  11:38:03  matthew
 *  Added info to "Failed to find real register" crash
 *
 *  Revision 1.35  1994/09/29  15:53:55  jont
 *  Remove handler register concept
 *
 *  Revision 1.34  1994/08/15  10:46:37  matthew
 *  Changed *_arg2 reg to *_arg_regs
 *
 *  Revision 1.33  1994/07/26  10:40:28  matthew
 *  Fix for problem with special asssigment of second arg reg.
 *
 *  Revision 1.32  1994/07/25  11:44:27  matthew
 *  Added extra argument register.
 *
 *  Revision 1.31  1994/07/15  13:46:26  jont
 *  Ensure caller_arg and callee_arg reflect machine values
 *
 *  Revision 1.30  1994/07/13  10:52:15  jont
 *  Fix to avoid lr unspilling alloc
 *
 *  Revision 1.29  1994/03/04  12:33:15  jont
 *  Changes for automatic_callee mechanism removal
 *  and moving machspec from machine to main
 *
 *  Revision 1.28  1993/08/05  10:22:47  richard
 *  Removed unnecessary defined_by_raise.
 *
 *  Revision 1.27  1992/11/02  17:28:19  jont
 *  Reworked in terms of mononewmap
 *
 *  Revision 1.26  1992/10/29  17:45:20  jont
 *  Removed some name clashes caused by open statements by remvoing the
 *  offending opens
 *
 *  Revision 1.25  1992/10/05  09:42:39  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.24  1992/08/26  14:08:29  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.23  1992/06/22  11:47:52  richard
 *  Added defined_by_raise.
 *
 *  Revision 1.22  1992/06/08  15:00:40  richard
 *  Added allocation_order function.
 *
 *  Revision 1.21  1992/06/03  16:34:50  richard
 *  The temporary registers are now complete sets of temporaries, and
 *  are also reserved registers.
 *
 *  Revision 1.20  1992/05/27  12:13:56  richard
 *  Changed virtual register Sets to Packs.
 *  Preallocated registers are now packed small positive integers.
 *
 *  Revision 1.19  1992/04/07  10:11:09  richard
 *  MachSpec.corrupted_by_callee is now partitioned according to
 *  the register type.  This was causing naming confusion.
 *
 *  Revision 1.18  1992/03/31  15:09:30  jont
 *  Added require newmap
 *
 *  Revision 1.17  1992/02/27  16:14:31  richard
 *  Changed the way virtual registers are handled.  See MirTypes.
 *
 *  Revision 1.16  1992/02/10  10:47:11  richard
 *  Large scale reorganization, including addition of `reserved' and
 *  change of type of `corrupted_by_callee'.
 *
 *  Revision 1.15  1992/01/21  12:21:57  clive
 *  Added implicit
 *
 *  Revision 1.14  1992/01/03  16:36:11  richard
 *  Added the zero register, if present on the target machine.
 *
 *  Revision 1.13  1991/12/04  13:09:24  richard
 *  Added ordered_general_purpose, but didn't implement it.
 *  (It is initialized as empty at the moment.)
 *
 *  Revision 1.12  91/11/29  11:59:47  richard
 *  Corrected the definition of general_purpose and removed the
 *  useless definition of machine_register_aliases.
 *
 *  Revision 1.11  91/11/21  19:49:33  jont
 *  Added some brackets to keep njml 0.75 happy
 *
 *  Revision 1.10  91/11/14  10:41:24  richard
 *  Removed references to fp_double registers.
 *
 *  Revision 1.9  91/11/04  15:15:51  richard
 *  Added general_purpose.
 *
 *  Revision 1.8  91/10/16  09:28:42  richard
 *  Recommented, and added corrupted_by_callee.
 *
 *  Revision 1.7  91/10/15  15:06:42  richard
 *  Moved register assignments here from the register allocator functor.
 *
 *  Revision 1.6  91/10/10  12:49:17  richard
 *  Fixed defined_on_entry and defined_on_exit to mention callee rather
 *  than caller registers on machines with register windows.
 *
 *  Revision 1.5  91/10/09  13:49:00  richard
 *  Added various new register definitions.
 *
 *  Revision 1.4  91/10/02  11:06:20  jont
 *  Removed real register options, these are being done elsewhere
 *
 *  Revision 1.3  91/10/01  14:52:23  richard
 *  Added global register.
 *
 *  Revision 1.2  91/09/20  13:13:53  jont
 *  Removed temp_sp, not required
 *
 *  Revision 1.1  91/09/18  11:55:45  jont
 *  Initial revision
 *)

require "../utils/crash";
require "../utils/lists";
require "../main/machspec";
require "mirtypes";
require "mirregisters";


functor MirRegisters(

  structure MirTypes	: MIRTYPES where type GC.T = int where type NonGC.T = int where type FP.T = int
  structure MachSpec	: MACHSPEC
  structure Lists	: LISTS
  structure Crash	: CRASH

) : MIRREGISTERS =

  struct

    structure MirTypes = MirTypes
    structure MachSpec = MachSpec
    structure Set = MachSpec.Set

    fun crash message = Crash.impossible ("MirRegisters: " ^ message)


    fun ++r = let val n = !r in r:=n+1; n end

    val next_gc     = ref 0
    val next_non_gc = ref 0
    val next_fp     = ref 0

    fun new_gc ()     = (++next_gc)
    fun new_non_gc () = (++next_non_gc)
    fun new_fp ()     = (++next_fp)


    (*  === SPECIAL PURPOSE REGISTERS ===
     *
     *  These are simply assigned uniques here, and included in
     *  preassigned (see below) to ensure that they are mapped on to
     *  the correct real machine registers.
     *)

    val caller_equal_callee = MachSpec.caller_arg_regs = MachSpec.callee_arg_regs

    val caller_arg_regs = map (fn _ => new_gc ()) MachSpec.caller_arg_regs

    val caller_arg =
      case caller_arg_regs of
        (r::_) => r
      | _ => Crash.impossible "No caller arg reg"

    val callee_arg_regs =
      if caller_equal_callee then
	caller_arg_regs
      else
	let
	  fun assoc([], el) = NONE
	    | assoc((x, y) :: rest, el) =
	    if y = el then SOME x else assoc(rest, el)
	  val callee_arg_regs =
	    map
	    (fn _ => new_gc ())
	    MachSpec.callee_arg_regs
	  val assoc1 = Lists.zip(caller_arg_regs, MachSpec.caller_arg_regs)
	  val assoc2 = Lists.zip(callee_arg_regs, MachSpec.callee_arg_regs)
	  val callee_arg_regs =
	    map
	    (fn reg =>
	     case assoc(assoc1, reg) of
	       SOME x => x
	     | NONE =>
		 case assoc(assoc2, reg) of
		   SOME x => x
		 | NONE => Crash.impossible"MirRegisters: assoc")
	    MachSpec.callee_arg_regs
	in
	  callee_arg_regs
	end

    val callee_arg =
      case callee_arg_regs of
        (r::_) => r
      | _ => Crash.impossible "No callee arg reg"

    val fp_arg_regs = map (fn _ => new_fp ()) MachSpec.fp_arg_regs
    val caller_closure = 	new_gc ()
    val callee_closure = 	new_gc ()
    val fp = 			new_gc ()
    val sp = 			new_gc ()
    val global = 		new_gc ()
    val fp_global = 		new_fp ()
    val implicit =              new_gc ()

    val zero_virtual =		new_gc ()
    val zero =
      case MachSpec.zero
        of SOME _ => SOME zero_virtual
         | NONE => NONE

    (* Now set up tail_arg and tail_closure *)
    val tail_arg_regs =
      if MachSpec.tail_arg = MachSpec.callee_arg
        then callee_arg_regs
      else
        caller_arg_regs

    val tail_arg =
      case tail_arg_regs of
        (r::_) => r
      | _ => Crash.impossible "No tail arg reg"

    val tail_closure =
      if MachSpec.tail_closure = MachSpec.callee_closure then
	callee_closure
      else
	caller_closure

    (* These association lists define the real registers onto which the *)
    (* special purpose registers will map. *)
    local
	type alist = (int * MachSpec.register) list
	type special_assignments = {gc : alist,
				    non_gc : alist,
				    fp : alist}
    in
    val special_assignments : special_assignments =
      let
	val callers = Lists.zip (caller_arg_regs, MachSpec.caller_arg_regs)
	val callees = Lists.zip (callee_arg_regs, MachSpec.callee_arg_regs)
	val callees = Lists.difference(callees, callers)
      in
	{gc = callers @
	 callees @
	 [(caller_closure, MachSpec.caller_closure),
	  (callee_closure, MachSpec.callee_closure),
	  (fp, MachSpec.fp),
	  (sp, MachSpec.sp),
	  (global, MachSpec.global),
	  (implicit,MachSpec.implicit)] @
	 (case MachSpec.zero
	    of SOME zero_real => [(zero_virtual, zero_real)]
	  | NONE            => []),
	 non_gc = [],
	 fp = Lists.zip (fp_global :: fp_arg_regs, MachSpec.fp_global :: MachSpec.fp_arg_regs)}
      end
    end

    (*  === REAL REGISTER ASSIGNMENTS ===  *)

    (* Generate association lists relating MIR virtual registers to real *)
    (* registers.  Note that the special purpose registers are mapped to *)
    (* their special purpose real-register counterparts.  Other registers *)
    (* are simply generated uniques. *)

    (* Ensure that we don't reassign anything that has already been given *)
    (* a special assignment *)

    val assignments =
      {gc     = (#gc special_assignments) @
                (map (fn r => (new_gc (), r))
                 (Lists.difference (MachSpec.gcs,map #2 (#gc special_assignments)))),
       non_gc = (#non_gc special_assignments) @
                (map (fn r => (new_non_gc (), r))
                 (Lists.difference (MachSpec.non_gcs,map #2 (#non_gc special_assignments)))),
       fp =     (#fp special_assignments) @
                (map (fn r => (new_fp (), r))
                 (Lists.difference (MachSpec.fps,map #2 (#fp special_assignments))))}

    val preassigned =
      {gc     = MirTypes.GC.Pack.from_list    (map (fn(v,r)=>v) (#gc assignments)),
       non_gc = MirTypes.NonGC.Pack.from_list (map (fn(v,r)=>v) (#non_gc assignments)),
       fp     = MirTypes.FP.Pack.from_list    (map (fn(v,r)=>v) (#fp assignments))}


    (* Build the exported tables from the association lists. *)

(*
    val _ =
      Lists.iterate
      (fn (v, r) =>
       print(MirTypes.GC.to_string v ^ " maps to " ^ MachSpec.print_register r ^ "\n"))
      (#gc assignments)
*)

    val gc_assignments = MirTypes.GC.Map.from_list (#gc assignments)
    val non_gc_assignments = MirTypes.NonGC.Map.from_list (#non_gc assignments)
    val fp_assignments = MirTypes.FP.Map.from_list (#fp assignments)

    val machine_register_assignments =
      {gc     = gc_assignments,
       non_gc = non_gc_assignments,
       fp     = fp_assignments}

    val machine_to_virtual =
      let
	fun rassoc list real =
	  let
	    fun find [] = crash ("Failed to find virtual register for " ^ MachSpec.print_register real)
	      | find ((virtual, real')::rest) = if real = real' then virtual else find rest
	  in
	    find list
	  end
      in
	{gc     = rassoc (#gc assignments),
	 non_gc = rassoc (#non_gc assignments),
	 fp     = rassoc (#fp assignments)}
      end

    local
      fun separate (convert, reserved, registers) =
        let
          fun separate' (g, []) = convert g
            | separate' (g, (virtual,real) ::rest) =
              if Set.is_member (real,reserved) then
                separate' (g, rest)
              else
                separate' (virtual::g, rest)
        in
          separate' ([], registers)
        end

      val gc_general =
        separate (MirTypes.GC.Pack.from_list, #gc MachSpec.reserved, #gc assignments)

      val non_gc_general =
        separate (MirTypes.NonGC.Pack.from_list, #non_gc MachSpec.reserved, #non_gc assignments)

      val fp_general =
        separate (MirTypes.FP.Pack.from_list, #fp MachSpec.reserved, #fp assignments)

      val debugging_gc_general =
        separate (MirTypes.GC.Pack.from_list, #gc MachSpec.debugging_reserved, #gc assignments)

      val debugging_non_gc_general =
        separate (MirTypes.NonGC.Pack.from_list, #non_gc MachSpec.debugging_reserved, #non_gc assignments)

      val debugging_fp_general =
        separate (MirTypes.FP.Pack.from_list, #fp MachSpec.debugging_reserved, #fp assignments)
      val gc_general_for_preferencing =
        MirTypes.GC.Pack.from_list(map (#gc machine_to_virtual) (#gc MachSpec.reserved_but_preferencable))

      val non_gc_general_for_preferencing =
	MirTypes.NonGC.Pack.from_list(map (#non_gc machine_to_virtual) (#non_gc MachSpec.reserved_but_preferencable))

      val fp_general_for_preferencing =
        MirTypes.FP.Pack.from_list(map (#fp machine_to_virtual) (#fp MachSpec.reserved_but_preferencable))

      val debugging_gc_general_for_preferencing =
        MirTypes.GC.Pack.from_list(map (#gc machine_to_virtual) (#gc MachSpec.debugging_reserved_but_preferencable))

      val debugging_non_gc_general_for_preferencing =
        MirTypes.NonGC.Pack.from_list(map (#non_gc machine_to_virtual) (#non_gc MachSpec.debugging_reserved_but_preferencable))

      val debugging_fp_general_for_preferencing =
        MirTypes.FP.Pack.from_list(map (#fp machine_to_virtual) (#fp MachSpec.debugging_reserved_but_preferencable))
    in

      val general_purpose = {gc     = gc_general,
                             non_gc = non_gc_general,
                             fp     = fp_general}

      val debugging_general_purpose =
        {gc     = debugging_gc_general,
         non_gc = debugging_non_gc_general,
         fp     = debugging_fp_general}

      val gp_for_preferencing =
	{gc     = gc_general_for_preferencing,
	 non_gc = non_gc_general_for_preferencing,
	 fp     = fp_general_for_preferencing}

      val debugging_gp_for_preferencing =
        {gc     = debugging_gc_general_for_preferencing,
         non_gc = debugging_non_gc_general_for_preferencing,
         fp     = debugging_fp_general_for_preferencing}
    end

    local
      val gc     = MirTypes.GC.Map.apply gc_assignments
      val non_gc = MirTypes.NonGC.Map.apply non_gc_assignments
      val fp     = MirTypes.FP.Map.apply fp_assignments
      val {gc = gc_order, non_gc = non_gc_order, fp = fp_order} = MachSpec.allocation_order
    in
      val allocation_order =
        {gc     = fn (r,r') => gc_order (gc r, gc r'),
         non_gc = fn (r,r') => non_gc_order (non_gc r, non_gc r'),
         fp     = fn (r,r') => fp_order (fp r, fp r')}
    end

    local
      val gc     = MirTypes.GC.Map.apply gc_assignments
      val non_gc = MirTypes.NonGC.Map.apply non_gc_assignments
      val fp     = MirTypes.FP.Map.apply fp_assignments
      val {gc = gc_equal, non_gc = non_gc_equal, fp = fp_equal} = MachSpec.allocation_equal
    in
      val allocation_equal =
        {gc     = fn (r,r') => gc_equal (gc r, gc r'),
         non_gc = fn (r,r') => non_gc_equal (non_gc r, non_gc r'),
         fp     = fn (r,r') => fp_equal (fp r, fp r')}
    end

    (* The machine registers which are corrupted by the callee are *)
    (* defined in MachSpec. Filter out the aliases which map to them. *)

    local
      fun corrupt set (done, []) = done
	| corrupt set (done, (virtual, real)::rest) =
	if Set.is_member (real, set) then
	  corrupt set (virtual::done, rest)
	else
	  corrupt set (done, rest)
    in
      val corrupted_by_callee =
        {gc =
	 MirTypes.GC.Pack.from_list
	 (corrupt (#gc MachSpec.corrupted_by_callee) ([], #gc assignments)),
         non_gc =
	 MirTypes.NonGC.Pack.from_list
	 (corrupt (#non_gc MachSpec.corrupted_by_callee) ([], #non_gc assignments)),
         fp =
	 MirTypes.FP.Pack.from_list
	 (corrupt (#fp MachSpec.corrupted_by_callee) ([], #fp assignments))}
      val corrupted_by_alloc =
        {gc =
	 MirTypes.GC.Pack.from_list
	 (corrupt (#gc MachSpec.corrupted_by_alloc) ([], #gc assignments)),
         non_gc =
	 MirTypes.NonGC.Pack.from_list
	 (corrupt (#non_gc MachSpec.corrupted_by_alloc) ([], #non_gc assignments)),
         fp =
	 MirTypes.FP.Pack.from_list
	 (corrupt (#fp MachSpec.corrupted_by_alloc) ([], #fp assignments))}
      val referenced_by_alloc =
        {gc =
	 MirTypes.GC.Pack.from_list
	 (corrupt (#gc MachSpec.referenced_by_alloc) ([], #gc assignments)),
         non_gc =
	 MirTypes.NonGC.Pack.from_list
	 (corrupt (#non_gc MachSpec.referenced_by_alloc) ([], #non_gc assignments)),
         fp =
	 MirTypes.FP.Pack.from_list
	 (corrupt (#fp MachSpec.referenced_by_alloc) ([], #fp assignments))}
    end


    (* The machine registers for temporary use are defined in MachSpec. *)
    (* Filter out the aliases which map to them. *)

    val temporary =
      {gc     =    (map (#gc     machine_to_virtual) (#gc     MachSpec.temporary)),
       non_gc =    (map (#non_gc machine_to_virtual) (#non_gc MachSpec.temporary)),
       fp     =    (map (#fp     machine_to_virtual) (#fp     MachSpec.temporary))}

    (* On entry to a procedure the argument and closure are assumed to be *)
    (* passed by the caller, and the fp, and sp registers are *)
    (* required by the call mechanism. *)

    val defined_on_entry =
      {gc =
         MirTypes.GC.Pack.from_list
         ((callee_closure :: map (#gc     machine_to_virtual) (Set.set_to_list(#gc MachSpec.defined_on_entry))) @
           (case zero
              of SOME virtual_zero => [virtual_zero]
               | NONE => []) @
           [fp, sp, implicit]),
       non_gc = MirTypes.NonGC.Pack.empty,
       fp = MirTypes.FP.Pack.empty}


    (* On exit from a procedure the argument contains the return value for *)
    (* the caller, and the fp and sp registers must contain the *)
    (* same values as they did on entry. *)

    val defined_on_exit =
      {gc =
         MirTypes.GC.Pack.from_list
         ((callee_arg) ::
           [fp, sp, implicit]),
       non_gc = MirTypes.NonGC.Pack.empty,
       fp = MirTypes.FP.Pack.empty}

    val pack_next = {gc = !next_gc,
                     non_gc = !next_non_gc,
                     fp = !next_fp}

  end
