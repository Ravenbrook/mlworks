(*  ==== REGISTER ALLOCATOR ====
 *           FUNCTOR
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
 *  Implementation
 *  --------------
 *  WARNING: THIS FILE CONTAINS SOME HIGHLY IMPERATIVE ML AND MAY OFFEND
 *  YOUR SENSIBILITIES.  ENTER AT YOUR OWN RISK.  It's also a bit wide.
 *
 *  The register colourer uses an array of adjacency lists to represent the
 *  clash graphs, and generates hash tables mapping virtual registers to
 *  contiguous integers to index this array and others.  Colours and spill
 *  slots are allocated at the same time, and both are used as colours, so
 *  more than one value may share a spill slot if they do not clash.
 *
 *  Revision Log
 *  ------------
 *  $Log: _registerallocator.sml,v $
 *  Revision 1.77  1997/05/19 10:39:49  matthew
 *  Generate better code for moves from FP spills to FP registers
 *
 * Revision 1.76  1997/05/01  13:10:47  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.75  1997/01/27  16:46:44  jont
 * [Bug #0]
 * Pass name of function to colourer so we don't try too hard on setups and functors
 *
 * Revision 1.74  1997/01/16  12:12:54  matthew
 * Renaming MIR arithmetic primitives
 *
 * Revision 1.73  1996/12/18  12:53:09  matthew
 * Adding fp_preferences
 *
 * Revision 1.72  1996/11/06  11:08:51  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.71  1996/05/07  11:05:58  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.70  1996/04/29  14:48:27  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.69  1995/12/20  13:39:05  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.68  1995/05/31  11:21:01  matthew
 *  Adding debugging reserved registers
 *
 *  Revision 1.67  1994/11/11  14:24:16  jont
 *  Add immediate store operations
 *
 *  Revision 1.66  1994/09/30  12:50:11  jont
 *  Remove handler register concept
 *
 *  Revision 1.65  1994/09/23  14:47:05  jont
 *  Control unspill behaviour with MachSpec.do_unspilling
 *
 *  Revision 1.64  1994/09/13  11:40:14  matthew
 *  Abstraction of debug information
 *
 *  Revision 1.63  1994/09/05  14:50:44  jont
 *  Reduce spill requirement to two registers.
 *
 *  Revision 1.62  1994/08/25  13:37:50  matthew
 *  Simplified annotations
 *
 *  Revision 1.61  1994/07/21  16:23:46  matthew
 *  Added function argument register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER
 *
 *  Revision 1.60  1994/07/13  10:50:03  jont
 *  Fix to avoid lr unspilling alloc
 *
 *  Revision 1.59  1994/05/12  12:51:10  richard
 *  Add field to MirTypes.PROC_PARAMS.
 *
 *  Revision 1.58  1993/11/05  10:27:50  jont
 *  Added handling of INTERRUPT instruction
 *
 *  Revision 1.57  1993/11/03  09:42:05  matthew
 *  Removed erroneous sharing constraint
 *
 *  Revision 1.56  1993/08/17  12:11:46  richard
 *  Changed the annotation of raise instructions to model the fact that
 *  the raise might reach _any_ of the nexted continuation blocks.
 *
 *  Revision 1.55  1993/08/03  14:47:10  richard
 *  Added some extra diagnostics.
 *
 *  Revision 1.54  1993/07/29  15:16:33  nosa
 *  Extra stack spills for local and closure variable inspection
 *  in the debugger;
 *  structure Option.
 *
 *  Revision 1.53  1993/04/27  13:44:01  richard
 *  Changed PROFILE instruction to INTERCEPT.
 *
 *  Revision 1.52  1993/03/10  18:26:36  matthew
 *  Map substructure is now MirTypes.Map
 *
 *  Revision 1.51  1992/11/03  15:00:11  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.50  1992/09/01  14:10:46  richard
 *  Added missing resiter substitution for PROFILER opcode
 *
 *  Revision 1.49  1992/08/28  15:20:03  davidt
 *  Removed some unncesessary intermediate lists which
 *  were being built.
 *
 *  Revision 1.48  1992/08/26  15:36:40  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.47  1992/08/24  13:37:29  richard
 *  Added NULLARY opcode type and ALLOC_BYTEARRAY.
 *
 *  Revision 1.46  1992/06/29  09:56:53  clive
 *  Added type annotation information at application points
 *
 *  Revision 1.45  1992/06/19  10:21:54  richard
 *  Added parameter to RAISE once again.
 *
 *  Revision 1.44  1992/06/17  10:08:50  richard
 *  Hints are no longer passed to the graphs.
 *
 *  Revision 1.43  1992/06/15  12:02:38  richard
 *  Rewrote spill generating code for speed.
 *
 *  Revision 1.42  1992/06/10  15:07:11  richard
 *  TENTATIVE CHECKIN.  Reworked spill slot allocation.
 *  Needs testing and revising.
 *
 *  Revision 1.41  1992/06/09  15:34:38  richard
 *  Calculated the sets of registers used properly.
 *
 *  Revision 1.40  1992/06/04  13:22:55  richard
 *  Removed register graph and colouring code to a general register
 *  colouring functor.
 *
 *  Revision 1.39  1992/05/27  13:38:00  richard
 *  Changed register Sets to Packs.  There is scope for the elimination
 *  of register hash tables using packed registers.
 *
 *  Revision 1.38  1992/05/05  11:57:25  richard
 *  Removed `first' annotation from instructions.
 *
 *  Revision 1.37  1992/04/29  13:24:04  richard
 *  Hints provided by the register preallocator are now used when building
 *  the register hash tables to reduce the size of the matrices.
 *
 *  Revision 1.36  1992/04/16  14:13:35  richard
 *  Changed the adjacency matrix to an array of adjacency lists.  This
 *  speeds up colouring for the sparse case (which is quite common) at the
 *  slight cost of building the lists.  This is often a big win.
 *  Added show_timings.
 *
 *  Revision 1.35  1992/04/13  15:19:12  clive
 *  First version of the profiler
 *
 *  Revision 1.34  1992/04/09  16:01:18  richard
 *  Removed obsolete Switches structure.
 *
 *  Revision 1.33  1992/04/09  14:42:18  richard
 *  Removed a left-over diagnostic message.
 *
 *  Revision 1.32  1992/03/05  16:10:06  richard
 *  Changed to return an annotated procedure as well as taking one as
 *  parameter.  This is to make it easier to pass the result to
 *  the stack allocator.
 *
 *  Revision 1.31  1992/03/02  11:35:54  richard
 *  The functor now uses MirProcedure annotated procedures rather than the
 *  MirOptTypes version.  It also takes the register clash lists as
 *  parameters instead of working them out from the procedure annotations.
 *  (They are now generated by MirVariable, see revision 1.29.)  Also, a
 *  new assignment class, RESERVED, has been added to cope with reserved
 *  registers more elegantly.
 *
 *  Revision 1.30  1992/02/21  13:31:55  richard
 *  Corrected spill slot counting.
 *
 *  Revision 1.29  1992/02/10  16:55:24  richard
 *  Complete rewrite using imperative ML features to gain efficiency.
 *
 *)


require "../basis/__int";

require "../utils/diagnostic";
require "../utils/lists";
require "../utils/crash";
require "mirtables";
require "mirprint";
require "mirprocedure";
require "mirregisters";
require "registercolourer";
require "registerallocator";


functor RegisterAllocator (
  structure MirProcedure	: MIRPROCEDURE
  structure Diagnostic		: DIAGNOSTIC
  structure MirRegisters	: MIRREGISTERS
  structure MirTables		: MIRTABLES
  structure MirPrint		: MIRPRINT
  structure Lists		: LISTS
  structure Crash		: CRASH

  structure GCColourer		: REGISTERCOLOURER
  sharing GCColourer.Register = MirRegisters.MirTypes.GC
  structure NonGCColourer	: REGISTERCOLOURER
  sharing NonGCColourer.Register = MirRegisters.MirTypes.NonGC
  structure FPColourer		: REGISTERCOLOURER
  sharing FPColourer.Register = MirRegisters.MirTypes.FP

  sharing MirProcedure.MirTypes = MirPrint.MirTypes = MirRegisters.MirTypes = MirTables.MirTypes
  sharing MirProcedure.Text = Diagnostic.Text

) : REGISTERALLOCATOR =

  struct
    structure MirTypes = MirRegisters.MirTypes
    structure Set = MirTypes.Set
    structure MirProcedure = MirProcedure
    structure Diagnostic = Diagnostic
    structure Map = MirTypes.Map
    structure MachSpec = MirRegisters.MachSpec

    val do_unspilling = MachSpec.do_unspilling

    val do_diagnostics = false

    fun diagnostic (level, output_function) =
      if do_diagnostics then 
        Diagnostic.output level
        (fn verbosity => "RegisterAllocator: " :: (output_function verbosity))
      else ()

    fun crash message = Crash.impossible ("RegisterAllocator: " ^ message)

    type Graph =
      {gc     : GCColourer.Graph,
       non_gc : NonGCColourer.Graph,
       fp     : FPColourer.Graph}

    fun empty ({gc = nr_gc,    non_gc = nr_non_gc,    fp = nr_fp},make_debugging_code) =
      {gc     = GCColourer.empty (nr_gc,make_debugging_code),
       non_gc = NonGCColourer.empty (nr_non_gc,make_debugging_code),
       fp     = FPColourer.empty (nr_fp,make_debugging_code)}

    fun clash {gc, non_gc, fp} ({gc = gc_defined, non_gc = non_gc_defined, fp = fp_defined},
                                {gc = gc_referenced, non_gc = non_gc_referenced, fp = fp_referenced},
                                {gc = gc_live,    non_gc = non_gc_live,    fp = fp_live}) =
      (GCColourer.clash    (gc,     gc_defined,     gc_referenced,     gc_live);
       NonGCColourer.clash (non_gc, non_gc_defined, non_gc_referenced, non_gc_live);
       FPColourer.clash    (fp,     fp_defined,     fp_referenced,     fp_live))



    (*  === SUBSTITUTE COLOURS FOR REGISTERS IN A PROCEDURE ===
     *
     *  This function rewrites the procedure in terms of the colours (real
     *  register aliases) assigned to the virtual registers by the colouring
     *  algorithm.  It also inserts code to load and store values in spill
     *  slots as necessary.  It is quite long because it needs to match
     *  against many of the possible instruction patterns and identify which
     *  registers are inputs and which outputs.
     *)

    local

      val frame = MirTypes.GC_REG MirRegisters.fp
      
      val gc_temporaries     = MLWorks.Internal.Array.arrayoflist (#gc MirRegisters.temporary)
      val non_gc_temporaries = MLWorks.Internal.Array.arrayoflist (#non_gc MirRegisters.temporary)
      val fp_temporaries     = MLWorks.Internal.Array.arrayoflist (#fp MirRegisters.temporary)

      fun generate_spills (instructions, []) = instructions
        | generate_spills (instructions, f::fs) =
          generate_spills (MirProcedure.I {defined      = MirProcedure.empty,
                                           referenced   = MirProcedure.empty,
                                           branches     = Set.empty_set,
                                           excepts      = [],
                                           opcode = f ()} :: 
                           instructions, fs)
    in
      
      fun substitute ({gc = gc_assign, non_gc = non_gc_assign, fp = fp_assign},
                      {gc = gc_spills, non_gc = non_gc_spills, fp = fp_spills},
                      {gc = gc_spills', non_gc = non_gc_spills', fp = fp_spills'}) =

        if gc_spills + non_gc_spills + fp_spills + gc_spills' + non_gc_spills' + fp_spills' = 0 then

          let

            val message =
              "The register colourers said that there were no spills, but I've found one."

            val substitute_opcode =
              MirProcedure.substitute
              {gc     = fn r => case gc_assign r
                                  of GCColourer.REGISTER r => r
                                   | GCColourer.SPILL _ => crash message,
               non_gc = fn r => case non_gc_assign r
                                  of NonGCColourer.REGISTER r => r
                                   | NonGCColourer.SPILL _ => crash message,
               fp     = fn r => case fp_assign r
                                  of FPColourer.REGISTER r => r
                                   | FPColourer.SPILL _ => crash message}
          in

            fn (tag, MirProcedure.B (annotation, instructions)) =>
            (MirProcedure.B
             (annotation,
              Lists.reducer
              (fn (MirProcedure.I {defined, referenced, branches, excepts, opcode}, instructions) =>
               let
                 val instruction =
                   MirProcedure.I {defined      = MirProcedure.empty,
                                   referenced   = MirProcedure.empty,
                                   branches     = branches,
                                   excepts       = excepts,
                                   opcode       = substitute_opcode opcode}
               in
                 instruction :: instructions
               end)
              (instructions, [])))
          end

        else

          let
            val gc_slots     = MLWorks.Internal.Array.array (gc_spills, MirTypes.GC.new ())
            val non_gc_slots = MLWorks.Internal.Array.array (non_gc_spills, MirTypes.NonGC.new ())
            val fp_slots     = MLWorks.Internal.Array.array (fp_spills, MirTypes.FP.new ())

            local
              open MirTypes
              open MLWorks.Internal.Array nonfix sub
            in
	      fun bad_spill () = crash "spill found to be register or other problem"

              fun gc_in (instructions, r, t) =
                case gc_assign r
                  of GCColourer.REGISTER _ => instructions
                   | GCColourer.SPILL slot =>
                     (update (gc_slots, slot, sub (gc_temporaries, t));
                      (fn () => STOREOP (LDREF, GC_REG (sub (gc_slots, slot)),
                        frame, GP_IMM_SYMB (GC_SPILL_SLOT (MirTypes.SIMPLE (slot+gc_spills'))))) 
                      :: instructions)

              fun non_gc_in (instructions, r, t) =
                case non_gc_assign r
                  of NonGCColourer.REGISTER _ => instructions
                   | NonGCColourer.SPILL slot =>
                     (update (non_gc_slots, slot, sub (non_gc_temporaries, t));
                      (fn () => STOREOP (LDREF, NON_GC_REG (sub (non_gc_slots, slot)),
                       frame, GP_IMM_SYMB (NON_GC_SPILL_SLOT (MirTypes.SIMPLE (slot+non_gc_spills'))))) 
                      :: instructions)

              fun fp_in (instructions, FP_REG r, t) =
                case fp_assign r
                  of FPColourer.REGISTER _ => instructions
                   | FPColourer.SPILL slot =>
                     (update (fp_slots, slot, sub (fp_temporaries, t));
                      (fn () => STOREFPOP (FLDREF, FP_REG (sub (fp_slots, slot)),
                        frame, GP_IMM_SYMB (FP_SPILL_SLOT (MirTypes.SIMPLE (slot+fp_spills'))))) 
                      :: instructions)

	      fun gc_spill r =
		case gc_assign r of
		  GCColourer.REGISTER _ => bad_spill()
		| GCColourer.SPILL slot => slot

	      fun reg_spill(GC_REG r) = gc_spill r
		| reg_spill _ = bad_spill()

	      fun gp_spill(GP_GC_REG r) = gc_spill r
		| gp_spill _ = bad_spill()

	      fun add_spill(instructions, r, s, t) =
		let
		  val slot1 = reg_spill r
		  val slot2 = reg_spill s
		  val slot3 = gp_spill t
		in
		  (fn () => BINARY(ADDU, GC_REG(sub(gc_slots, slot1)),
				   GP_GC_REG(sub(gc_slots, slot2)),
				   GP_GC_REG(sub(gc_slots, slot3)))) :: instructions
		end

	      fun reg_in (instructions, GC_REG r, t) = gc_in (instructions, r, t)
		| reg_in (instructions, NON_GC_REG r, t) = non_gc_in (instructions, r, t)

              fun gp_in (instructions, GP_GC_REG r, t) = gc_in (instructions, r, t)
                | gp_in (instructions, GP_NON_GC_REG r, t) = non_gc_in (instructions, r, t)
                | gp_in (instructions, _, t) = instructions

              fun gc_out (instructions, r, t) =
                case gc_assign r
                  of GCColourer.REGISTER _ => instructions
                   | GCColourer.SPILL slot =>
                     (update (gc_slots, slot, sub (gc_temporaries, t));
                      (fn () => STOREOP (STREF, GC_REG (sub (gc_slots, slot)),
                          frame, GP_IMM_SYMB (GC_SPILL_SLOT (MirTypes.SIMPLE (slot+gc_spills'))))) 
                      :: instructions)

              fun non_gc_out (instructions, r, t) =
                case non_gc_assign r
                  of NonGCColourer.REGISTER _ => instructions
                   | NonGCColourer.SPILL slot =>
                     (update (non_gc_slots, slot, sub (non_gc_temporaries, t));
                      (fn () => STOREOP (STREF, NON_GC_REG (sub (non_gc_slots, slot)),
                       frame, GP_IMM_SYMB (NON_GC_SPILL_SLOT (MirTypes.SIMPLE (slot+non_gc_spills'))))) 
                      :: instructions)

              fun fp_out (instructions, FP_REG r, t) =
                case fp_assign r
                  of FPColourer.REGISTER _ => instructions
                   | FPColourer.SPILL slot =>
                     (update (fp_slots, slot, sub (fp_temporaries, t));
                      (fn () => STOREFPOP (FSTREF, FP_REG (sub (fp_slots, slot)),
                       frame, GP_IMM_SYMB (FP_SPILL_SLOT (MirTypes.SIMPLE (slot+fp_spills'))))) 
                      :: instructions)

              fun reg_out (instructions, GC_REG r, t) = gc_out (instructions, r, t)
                | reg_out (instructions, NON_GC_REG r, t) = non_gc_out (instructions, r, t)

              fun gp_out (instructions, GP_GC_REG r, t) = gc_out (instructions, r, t)
                | gp_out (instructions, GP_NON_GC_REG r, t) = non_gc_out (instructions, r, t)
                | gp_out (instructions, _, t) = instructions

	    end

	    val substitute_opcode =
	      MirProcedure.substitute
              {gc     = fn r => case gc_assign r
                                  of GCColourer.REGISTER r => r
                                   | GCColourer.SPILL n => MLWorks.Internal.Array.sub (gc_slots, n),
               non_gc = fn r => case non_gc_assign r
                                  of NonGCColourer.REGISTER r => r
                                   | NonGCColourer.SPILL n => MLWorks.Internal.Array.sub (non_gc_slots, n),
               fp     = fn r => case fp_assign r
                                  of FPColourer.REGISTER r => r
                                   | FPColourer.SPILL n => MLWorks.Internal.Array.sub (fp_slots, n)}

            local
              open MirTypes
            in
	      val ref_opcode = ref (COMMENT "")

	      fun is_gc_spill r =
		case gc_assign r
                  of GCColourer.REGISTER _ => false
                   | GCColourer.SPILL _ => true

	      fun is_non_gc_spill r =
                case non_gc_assign r
                  of NonGCColourer.REGISTER _ => false
                   | NonGCColourer.SPILL _ => true

	      fun is_reg_spill(GC_REG r) = is_gc_spill r
		| is_reg_spill(NON_GC_REG r) = is_non_gc_spill r

	      fun is_gp_spill(GP_GC_REG r) = is_gc_spill r
		| is_gp_spill(GP_NON_GC_REG r) = is_non_gc_spill r
		| is_gp_spill _ = false

	      fun same_reg_and_gp_spill(r, g) =
		is_reg_spill r andalso is_gp_spill g andalso
		reg_spill r = gp_spill g

	      fun do_store_spill(LD, _, _, _) = bad_spill()
		| do_store_spill(LDREF, _, _, _) = bad_spill()
		| do_store_spill(LDB, _, _, _) = bad_spill()
		| do_store_spill(store, in0, in1, in2) =
		  if is_reg_spill in0 then
		    if is_reg_spill in1 then
		      if is_gp_spill in2 then
			((*output(std_out, "STOREOP with three real spills\n");*)
			 ref_opcode :=
			 STOREOP(store, in0, in1, GP_IMM_INT 0);
			 (reg_in(gp_in (add_spill(reg_in([], in0, 1), in1, in1, in2), in2, 1), in1, 0),
			  [
			   let
			     val slot = reg_spill in1
			   in
			     fn () => NULLARY(CLEAN, GC_REG(MLWorks.Internal.Array.sub(gc_slots, slot)))
			   end]))
		      else
			(reg_in (reg_in (gp_in ([], in2, 1), in1, 1), in0, 0), [])
		    else
		      (reg_in (reg_in (gp_in ([], in2, 1), in1, 1), in0, 0), [])
		  else
		    (reg_in (reg_in (gp_in ([], in2, 1), in1, 0), in0, 0), [])

              fun spill (TBINARY (_, _, out0, in1, in2))     =
		if same_reg_and_gp_spill(out0, in2) then
		  ((*output(std_out, "Found reg_out and gp_in in same spill slot (TBINARY)\n");*)
		   (gp_in (gp_in ([], in2, 0), in1, 1), reg_out ([], out0, 0)))
		else
		  (gp_in (gp_in ([], in2, 1), in1, 0), reg_out ([], out0, 0))
                | spill (BINARY (_, out0, in1, in2))         =
		  if same_reg_and_gp_spill(out0, in2) then
		    ((*output(std_out, "Found reg_out and gp_in in same spill slot (BINARY)\n");*)
		     (gp_in (gp_in ([], in2, 0), in1, 1), reg_out ([], out0, 0)))
		  else
		    (gp_in (gp_in ([], in2, 1), in1, 0), reg_out ([], out0, 0))
                | spill (TBINARYFP (_, _, out0, in1, in2))   = (fp_in (fp_in ([], in2, 2), in1, 1), fp_out ([], out0, 0))
                | spill (BINARYFP (_, out0, in1, in2))       = (fp_in (fp_in ([], in2, 2), in1, 1), fp_out ([], out0, 0))
                | spill (UNARY (_, out0, in1))               = (gp_in ([], in1, 1), reg_out ([], out0, 0))
                | spill (NULLARY (_, out0))                  = ([], reg_out ([], out0, 0))
                (* Special treatment for FP moves *)
                | spill (UNARYFP (FMOVE, out0 as FP_REG r1, in1 as FP_REG r2))         = 
                    (case (fp_assign r1, fp_assign r2) of
                       (FPColourer.REGISTER r, FPColourer.SPILL n) => 
                         (* Put a spill into a register *)
                         (ref_opcode :=
                          STOREFPOP (FLDREF, FP_REG r, frame, GP_IMM_SYMB (FP_SPILL_SLOT (MirTypes.SIMPLE (n + fp_spills'))));
                          ([],[]))
                     | (FPColourer.SPILL n, FPColourer.REGISTER r) =>
                         (ref_opcode :=
                          STOREFPOP (FSTREF, FP_REG r, frame, GP_IMM_SYMB (FP_SPILL_SLOT (MirTypes.SIMPLE (n + fp_spills'))));
                          ([],[]))
                     | _ => (fp_in ([], in1, 1), fp_out ([], out0, 0)))
                | spill (UNARYFP (_, out0, in1))             = (fp_in ([], in1, 1), fp_out ([], out0, 0))
                | spill (TUNARYFP (_, _, out0, in1))         = (fp_in ([], in1, 1), fp_out ([], out0, 0))
                | spill (STACKOP (PUSH, in0, _))             = (reg_in ([], in0, 0), [])
                | spill (STACKOP (POP, out0, _))             = ([], reg_out ([], out0, 0))
                | spill (STOREOP (store as (ST, in0, in1, in2)))        =
		  do_store_spill store
                | spill (STOREOP (store as (STREF, in0, in1, in2)))     =
		  do_store_spill store
                | spill (STOREOP (store as (STB, in0, in1, in2)))       =
		  do_store_spill store
                | spill (STOREOP (LD, out0, in1, in2))       =
		  if same_reg_and_gp_spill(out0, in2) then
		    ((*output(std_out, "Found reg_out and gp_in in same spill slot (LD)\n");*)
		     (reg_in (gp_in ([], in2, 0), in1, 1), reg_out ([], out0, 0)))
		  else
		    (reg_in (gp_in ([], in2, 1), in1, 0), reg_out ([], out0, 0))
                | spill (STOREOP (LDREF, out0, in1, in2))    =
		  if same_reg_and_gp_spill(out0, in2) then
		    ((*output(std_out, "Found reg_out and gp_in in same spill slot (LDREF)\n");*)
		     (reg_in (gp_in ([], in2, 0), in1, 1), reg_out ([], out0, 0)))
		  else
		    (reg_in (gp_in ([], in2, 1), in1, 0), reg_out ([], out0, 0))
                | spill (STOREOP (LDB, out0, in1, in2))      =
		  if same_reg_and_gp_spill(out0, in2) then
                    ((*output(std_out, "Found reg_out and gp_in in same spill slot (LDB)\n");*)
		     (reg_in (gp_in ([], in2, 0), in1, 1), reg_out ([], out0, 0)))
		  else (reg_in (gp_in ([], in2, 1), in1, 0), reg_out ([], out0, 0))
                | spill (IMMSTOREOP _)                       = Crash.impossible"Immediate store on spilling architecture"
                | spill (STOREFPOP (FST, in0, in1, in2))     = (fp_in (reg_in (gp_in ([], in2, 1), in1, 0), in0, 0), [])
                | spill (STOREFPOP (FSTREF, in0, in1, in2))  = (fp_in (reg_in (gp_in ([], in2, 1), in1, 0), in0, 0), [])
                | spill (STOREFPOP (FLD, out0, in1, in2))    = (reg_in (gp_in ([], in2, 1), in1, 0), fp_out ([], out0, 0))
                | spill (STOREFPOP (FLDREF, out0, in1, in2)) = (reg_in (gp_in ([], in2, 1), in1, 0), fp_out ([], out0, 0))
                | spill (REAL (_, out0, in1))                = (gp_in ([], in1, 1), fp_out ([], out0, 0))
                | spill (FLOOR (_, _, out0, in1))            = (fp_in ([], in1, 1), reg_out ([], out0, 0))
                | spill (BRANCH (_, REG in0))                = (reg_in ([], in0, 0), [])
                | spill (BRANCH (_, TAG _))                  = ([], [])
                | spill (TEST (_, _, in0, in1))              = (gp_in (gp_in ([], in0, 0), in1, 1), [])
                | spill (FTEST (_, _, in0, in1))             = (fp_in (fp_in ([], in0, 0), in1, 1), [])
                | spill (BRANCH_AND_LINK (_, REG in0,_,_))   = (reg_in ([], in0, 0), [])
                | spill (BRANCH_AND_LINK (_, TAG _,_,_))     = ([], [])
                | spill (TAIL_CALL (_, REG in0,_))           = (reg_in ([], in0, 0), [])
                | spill (TAIL_CALL (_, TAG _,_))             = ([], [])
                | spill (CALL_C)                             = ([], [])
                | spill (SWITCH (_, in0, _))                 = (reg_in ([], in0, 0), [])
                | spill (ALLOCATE (_, out0, in1))            = (gp_in ([], in1, 1), reg_out ([], out0, 0))
                | spill (ALLOCATE_STACK (_, out0, _, _))     = ([], reg_out ([], out0, 0))
                | spill (DEALLOCATE_STACK _)                 = ([], [])
                | spill (ADR (_, out0, _))                   = ([], reg_out ([], out0, 0))
                | spill (INTERCEPT)                          = ([], [])
                | spill (INTERRUPT)                          = ([], [])
                | spill (ENTER _)                              = ([], [])
                | spill (RTS)                                = ([], [])
                | spill (NEW_HANDLER(frame, tag))            = (reg_in([], frame, 0), [])
                | spill (OLD_HANDLER)                        = ([], [])
                | spill (RAISE in0)                          = (reg_in ([], in0, 0), [])
                | spill (COMMENT _)                          = ([], [])

            end
            (* Simple check here if we have a move of something to itself *)
            fun is_null_move (MirTypes.UNARYFP (MirTypes.FMOVE, MirTypes.FP_REG r1, MirTypes.FP_REG r2)) =
              fp_assign r1 = fp_assign r2
              | is_null_move (MirTypes.UNARY (MirTypes.MOVE, MirTypes.GC_REG r1, MirTypes.GP_GC_REG r2)) =
              gc_assign r1 = gc_assign r2
              | is_null_move _ = false

          in
	    if do_unspilling then
	      fn (tag, MirProcedure.B (annotation, instructions)) =>
	      (MirProcedure.B
	       (annotation,
		Lists.reducer
		(fn (MirProcedure.I {defined, referenced, branches, excepts, opcode}, instructions) =>
                 if is_null_move opcode then instructions
                 else
		 let
		   val _ = ref_opcode := opcode
		   val (loads, stores) = spill opcode

		   val instruction =
		     MirProcedure.I {defined      = MirProcedure.empty,
                                     referenced   = MirProcedure.empty,
                                     branches     = branches,
                                     excepts      = excepts,
                                     opcode       = substitute_opcode (!ref_opcode)}
		 in
		   generate_spills (instruction :: generate_spills (instructions, stores), loads)
		 end)
		(instructions, [])))
	    else
	      let
		val substitute_opcode =
		  MirProcedure.substitute
		  {gc     =
		   fn r => case gc_assign r of
		     GCColourer.REGISTER r => r
		   | GCColourer.SPILL n =>
		       MirTypes.GC.pack((#gc MirRegisters.pack_next)+n),
		   non_gc =
		   fn r => case non_gc_assign r of
		     NonGCColourer.REGISTER r => r
		   | NonGCColourer.SPILL n =>
		       MirTypes.NonGC.pack((#non_gc MirRegisters.pack_next)+n),
		   fp     =
		   fn r => case fp_assign r of
		     FPColourer.REGISTER r => r
		   | FPColourer.SPILL n =>
		       MirTypes.FP.pack((#fp MirRegisters.pack_next)+n)}
	      in
		fn (tag, MirProcedure.B (annotation, instructions)) =>
		(MirProcedure.B
		 (annotation,
		  Lists.reducer
		  (fn (MirProcedure.I {defined, referenced, branches, excepts, opcode}, instructions) =>
                   if is_null_move opcode then instructions
                   else
                     let
                       val instruction =
                         MirProcedure.I {defined      = MirProcedure.empty,
                                         referenced   = MirProcedure.empty,
                                         branches     = branches,
                                         excepts      = excepts,
                                         opcode       = substitute_opcode opcode}
                     in
                       instruction :: instructions
                     end)
		  (instructions, [])))
	      end
          end

    end

    fun block_preferences (MirProcedure.B (_,instructions),acc) =
      Lists.reducel
      (fn ((acc1,acc2), MirProcedure.I {opcode = MirTypes.UNARY (MirTypes.MOVE,
                                                                 MirTypes.GC_REG r1,
                                                                 MirTypes.GP_GC_REG r2),
                                ...}) =>
       ((r1,r2) :: acc1,acc2)
        | ((acc1,acc2), MirProcedure.I {opcode = MirTypes.UNARYFP (MirTypes.FMOVE,
                                                                   MirTypes.FP_REG r1,
                                                                   MirTypes.FP_REG r2),
                                        ...}) =>
       (acc1, (r1,r2) :: acc2)
        | (acc,_) => acc)
      (acc,instructions)

    (*  === PERFORM REGISTER ALLOCATION ===
     *
     *  This is the top level exported function.  Details inside.
     *)

    fun analyse (procedure as MirProcedure.P (annotation, name, start, block_map),
                 {gc = gc_graph, non_gc = non_gc_graph, fp = fp_graph},
                 {gc = gc_spills', non_gc = non_gc_spills', fp = fp_spills'},
                 make_debug_code) =
      let
        val _ = diagnostic (1, fn _ => ["procedure ", MirTypes.print_tag start, ": ", name])

        val {uses_stack,
             nr_registers,
             parameters = MirTypes.PROC_PARAMS {stack_allocated, ...}} = annotation

        (* Find all the register pairs involved in moves *)
        (* Reversing seems to give better results *)
        local
          val (gcs,fps) =
            (Map.fold 
             (fn (acc,_,block) =>
              block_preferences (block,acc))
             (([],[]),block_map))
        in
          val gc_preferences = rev gcs
          val fp_preferences = rev fps
        end

        val ({assign = gc_assign,     nr_spills = gc_spills},
             {assign = non_gc_assign, nr_spills = non_gc_spills},
             {assign = fp_assign,     nr_spills = fp_spills}) =
          (GCColourer.colour (gc_graph,gc_preferences,make_debug_code, name),
           NonGCColourer.colour (non_gc_graph,[],make_debug_code, name),
           FPColourer.colour (fp_graph,fp_preferences,make_debug_code, name))

        val _ = diagnostic (2, fn _ => ["rewriting procedure"])

        val substitute = 
          let
            val num_spills = gc_spills + non_gc_spills + fp_spills
            val _ = 
              if num_spills > 0 
                then
                  diagnostic (2, fn _ => [Int.toString num_spills,
                                          " spills for ", name])
              else ()
          in
              substitute ({gc = gc_assign, non_gc = non_gc_assign, fp = fp_assign},
                          {gc = gc_spills, non_gc = non_gc_spills, fp = fp_spills},
                          {gc = gc_spills', non_gc = non_gc_spills', fp = fp_spills'})
          end

        val blocks =
          Map.map substitute block_map

        val spill_sizes = SOME {gc = gc_spills+gc_spills', 
                                                   non_gc = non_gc_spills+non_gc_spills', 
                                                   fp = fp_spills+fp_spills'}
      in

        MirProcedure.P ({nr_registers = nr_registers,
                         uses_stack = uses_stack,
                         parameters = MirTypes.PROC_PARAMS
                                      {stack_allocated = stack_allocated,
				       old_spill_sizes = NONE,
				       (* This will be filled in later *)
                                       spill_sizes = spill_sizes}},
                        name,
                        start,
                        blocks)
      end

  end
