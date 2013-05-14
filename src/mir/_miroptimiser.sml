(*  ==== MIR OPTIMISER ====
 *          FUNCTOR
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
 *  This functor doesn't do any optimisation itself, it just invokes other
 *  optimisation phases and generates diagnostic output.
 *
 *  Revision Log
 *  ------------
 *  $Log: _miroptimiser.sml,v $
 *  Revision 1.48  1996/12/16 15:05:05  matthew
 *  Removing references to MLWorks.Option
 *
 * Revision 1.47  1995/12/22  12:52:54  jont
 * Removing Option in favour of MLWorks.Option
 *
 *  Revision 1.46  1995/05/30  11:37:08  matthew
 *  Adding debug flag to RegisterAllocator.analyse
 *
 *  Revision 1.45  1994/09/19  16:06:51  matthew
 *  Reinstated call to MirExpr.simple_transform before colouring
 *
 *  Revision 1.44  1994/08/26  13:59:26  matthew
 *  Added and commented out call to MirExpr.simple_transform
 *  Experiment is needed for this.
 *
 *  Revision 1.43  1994/04/12  11:05:47  jont
 *  Adding expression analysis
 *
 *  Revision 1.42  1993/07/30  14:45:30  nosa
 *  Debugger Environments and extra stack spills for local and closure
 *  variable inspection in the debugger.
 *
 *  Revision 1.41  1992/12/08  20:03:01  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.40  1992/11/02  18:04:39  jont
 *  Reworked in terms of mononewmap
 *
 *  Revision 1.39  1992/08/26  15:42:57  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.38  1992/06/17  10:51:17  richard
 *  Removed the redundant preallocator.  The work of the preallocator
 *  is now done by the annotator (RegisterPack, in fact).  There is no
 *  longer any need to pass hints to the graph.
 *
 *  Revision 1.37  1992/06/04  14:23:15  richard
 *  Changed order of stages.  The Preallocator stage is now done before
 *  variable analysis, as it produces information used in building the
 *  register clash graph.  The graph is now updated directly by the
 *  MirVariable analyser, greatly reducing garbage and increasing
 *  efficiency.
 *
 *  Revision 1.36  1992/05/21  11:51:06  richard
 *  Added diagnostic to print names of procedures.
 *
 *  Revision 1.35  1992/04/28  14:23:02  richard
 *  Added register preallocator.
 *
 *  Revision 1.34  1992/04/23  11:12:45  jont
 *  Changed all instances of timer_ to timer
 *
 *  Revision 1.33  1992/04/13  15:29:55  richard
 *  Removed available expression analysis.  Temporarily, I hope.
 *
 *  Revision 1.32  1992/03/05  15:46:15  richard
 *  MirExpression now uses MirProcedure annotated procedures so the
 *  MirOptTypes and MirFlow modules can finally be abolished.
 *
 *  Revision 1.31  1992/03/02  12:13:55  richard
 *  Changes to reflect version 2.1 of MirVariable and new procedure annotation
 *  method.  Added timings.
 *
 *  Revision 1.30  1992/02/17  17:26:56  richard
 *  Moved register assignments to the top level of this structure.
 *
 *  Revision 1.29  1992/02/10  13:06:23  richard
 *  Abolished the second pass of optimization.  It wasn't acheiving much.
 *  
 *  Revision 1.28  1992/01/28  12:18:19  richard
 *  Changed diagnostic output to reflect changes in MirOptTypes.
 *  
 *  Revision 1.27  1991/11/18  16:47:59  richard
 *  Changed debugging output to use the Diagnostic module.
 *  
 *  Revision 1.26  91/11/08  11:26:48  richard
 *  Added a debugging function.
 *  
 *  Revision 1.25  91/11/07  11:38:20  richard
 *  Added a second pass of optimisation to clean up after register
 *  substitution and spill instruction insertion.
 *  
 *  Revision 1.24  91/10/29  09:45:00  richard
 *  Added StackAllocator to optimisations.
 *  
 *  Revision 1.23  91/10/28  14:13:43  richard
 *  Removed redundant requires which I left in by mistake after a
 *  debugging session.
 *  
 *  Revision 1.22  91/10/25  14:46:54  richard
 *  Removed explicit dependency on the representation of MirOptTypes.procedure.
 *  
 *  Revision 1.21  91/10/21  14:14:09  richard
 *  Added Print to dependencies.
 *  
 *  Revision 1.20  91/10/17  11:32:35  richard
 *  Added Switches structure. Removed redundant MirDataFlow module.
 *  
 *  Revision 1.19  91/10/16  14:37:23  richard
 *  Removed procedure parameters to reflect changes in MirTypes.
 *  
 *  Revision 1.18  91/10/15  13:50:34  richard
 *  Deleted register assignments. These can now be found in the
 *  MirRegisters structure.
 *  
 *  Revision 1.17  91/10/11  09:56:14  richard
 *  Slight alterations to cope with new MirTypes.
 *  
 *  Revision 1.16  91/10/10  14:56:03  richard
 *  The loader block is now allocated.
 *  
 *  Revision 1.14  91/10/07  11:55:33  richard
 *  Changed dependency on MachRegisters to MachSpec.
 *  
 *  Revision 1.13  91/10/04  14:08:05  richard
 *  Optimisation and register allocation of the loader setup block.
 *  
 *  Revision 1.12  91/10/04  13:26:39  richard
 *  Rewrote the optimiser top level to use the new MirTypes code structure,
 *  with significant benefits for code size and speed! Also, the functor
 *  now exports the register assignment tables for the target machine.
 *  
 *  Revision 1.11  91/10/03  15:37:35  richard
 *  Added a quick fix to allow register allocation to return some extra
 *  stuff. The extra stuff is ignored at the moment.
 *  
 *  Revision 1.10  91/09/30  10:16:10  richard
 *  Added register allocator to optimiser module.
 *  
 *  Revision 1.9  91/09/24  11:31:50  richard
 *  Modified to use a table of blocks rather than a simple list. This allows
 *  procedure blocks to be in _any_ order, they will all be caught by
 *  control flow analysis. See also MirOptTypes.
 *  
 *  Revision 1.8  91/09/18  18:39:31  richard
 *  Fixed the squish function, which didn't cope with single-block
 *  procedures.
 *  
 *  Revision 1.7  91/09/17  15:37:01  richard
 *  Code to annotate and deannotate blocks moved here from MirDataflow
 *  module. Also minor changes related to the break-up of MirDataflow
 *  (see log for that file).
 *  
 *  Revision 1.6  91/09/16  12:43:10  richard
 *  Rewrote separate function to cope with nested procedures produced
 *  by the code generator.
 *  
 *  Revision 1.5  91/09/10  10:22:04  richard
 *  Minor changes to invocation of dataflow analyser to prevent
 *  inexhaustive binding.
 *  
 *  Revision 1.4  91/09/09  10:42:55  richard
 *  Changed filename of mirpeep to mirpeepholer.
 *  Removed some redundant debugging code.
 *  
 *  Revision 1.3  91/09/05  16:46:46  richard
 *  Removed redundant dataflow data structure (to MirDataFlow module),
 *  otherwise just test modifications to do with data flow.
 *  
 *  Revision 1.2  91/09/04  15:28:19  richard
 *  Early version of code to split up MIR code ready for
 *  dataflow analysis.
 *  
 *  Revision 1.1  91/09/02  12:05:16  richard
 *  Initial revision
 *)


require "../utils/diagnostic";
require "mirvariable";
require "mirregisters";
require "mirexpr";
require "stackallocator";
require "miroptimiser";


functor MirOptimiser(
  structure MirVariable		: MIRVARIABLE
  structure StackAllocator	: STACKALLOCATOR
  structure MirRegisters	: MIRREGISTERS
  structure MirExpr		: MIREXPR
  structure Diagnostic		: DIAGNOSTIC

  sharing
    MirRegisters.MirTypes =
    MirVariable.RegisterAllocator.MirProcedure.MirTypes =
    MirExpr.MirTypes

  sharing Diagnostic.Text = MirVariable.RegisterAllocator.MirProcedure.Text

  sharing MirVariable.RegisterAllocator.MirProcedure =
    StackAllocator.MirProcedure

) : MIROPTIMISER =

  struct
    structure RegisterAllocator = MirVariable.RegisterAllocator
    structure MirProcedure = RegisterAllocator.MirProcedure
    structure MirTypes = MirProcedure.MirTypes
    structure Diagnostic = Diagnostic
    structure MachSpec = MirRegisters.MachSpec


    (*  == Diagnostic output functions ==  *)

    infix ^^
    val (op^^) = Diagnostic.Text.concatenate
    val $ = Diagnostic.Text.from_string

    fun listing (level, message, procedure) =
      Diagnostic.output_text level
      (fn _ =>
       $"MirOptimiser: " ^^ $message ^^ $"\n" ^^
       MirProcedure.to_text procedure)

    val machine_register_assignments = MirRegisters.machine_register_assignments



    (*  === OPTIMISE MIR CODE ===
     *
     *  A simple application of each of the optimisation passes.
     *)

    fun optimise (MirTypes.CODE(refs, values, proc_sets),make_debugging_code) =
      let
        fun optimise' (procedure as MirTypes.PROC (name, tag,proc as MirTypes.PROC_PARAMS{spill_sizes=spill_sizes', ...},blocks,runtime_env)) =
          let
            (* This may or may not be a good thing to do *)
            (* This stuff is done by the preferencer and unless we can eliminate unused registers ... *)
            (* Though code size does decrease with this *)
            (* Need to investigate the tradeoffs *)

            val procedure =
              MirTypes.PROC (name,tag,proc, MirExpr.simple_transform blocks,runtime_env)

            val _ =
              Diagnostic.output 1 (fn _ => ["MirOptimiser: procedure ", MirTypes.print_tag tag, ": ", name])

            val annotated as MirProcedure.P (annotation, _, _, _) =
              MirProcedure.annotate procedure

            val _ = listing (2, "after annotation", annotated)

            val graph =
              RegisterAllocator.empty (#nr_registers annotation,make_debugging_code)

            val varied = MirVariable.analyse (annotated, graph)

            val _ = listing (2, "after variable analysis", varied)

            val spill_sizes = 
              case #spill_sizes((fn MirTypes.PROC_PARAMS params=>params)
                                (#parameters(annotation))) of
                NONE => {gc = 0, non_gc = 0, fp = 0}
              | SOME(spill_sizes) => spill_sizes

            val registered =
              RegisterAllocator.analyse (varied, graph,spill_sizes,make_debugging_code)

            val _ = listing (2, "after register allocation", registered)

            val stacked = StackAllocator.allocate registered

            val _ = listing (2, "after stack allocation", stacked)

            val MirTypes.PROC (name, tag, proc, block,_) = MirProcedure.unannotate stacked
	    val block = MirExpr.transform block
	    val proc = case proc of
	      MirTypes.PROC_PARAMS{spill_sizes, stack_allocated, ...} =>
		MirTypes.PROC_PARAMS
		{spill_sizes = spill_sizes,
		 old_spill_sizes = spill_sizes',
		 stack_allocated = stack_allocated}
          in
            MirTypes.PROC (name, tag, proc, block,runtime_env)
          end
      in
        MirTypes.CODE(refs, values, map (map optimise') proc_sets)
      end


  end
