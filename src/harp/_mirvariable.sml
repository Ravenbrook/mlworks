(*  ==== LIVE VARIABLE ANALYSIS ====
 *		FUNCTOR
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  The live variables of an arbitrary network of blocks are found using an
 *  iterative algorithm.  Firstly, the flow of control of the procedure is
 *  traced in order to build a map of blocks to the blocks that reach them,
 *  and also build a queue of blocks in postorder.  The postordered blocks are
 *  then repeatedly scanned, recomputing live variable sets until a fixed point
 *  is reached.  Postorder ensures that this is done in a small number of passes.
 *
 *  Revision Log
 *  ------------
 *  $Log: _mirvariable.sml,v $
 *  Revision 1.53  1999/02/02 16:01:14  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.52  1997/05/02  16:27:14  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.51  1996/11/06  11:08:43  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.50  1996/08/09  16:55:06  daveb
 * [Bug #1534]
 * Updated a comment.
 *
 * Revision 1.49  1996/05/07  11:07:31  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.48  1996/04/29  14:48:16  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.47  1996/03/28  11:07:03  matthew
 * Adding where type clause
 *
 * Revision 1.46  1995/05/31  11:13:48  matthew
 * Changing instruction datatype
 * /
 *
 *  Revision 1.45  1995/05/15  10:52:34  jont
 *  Use a tree instead of an assoc list in scan
 *  Remove gratuitous use of refs in scan (procedure parameters used instead)
 *
 *  Revision 1.44  1994/10/13  11:16:06  matthew
 *  Use pervasive Option.option for return values in NewMap
 *
 *  Revision 1.43  1994/09/13  16:33:38  matthew
 *  Use inthashtables for efficiency
 *
 *  Revision 1.42  1994/08/25  13:09:52  matthew
 *  Simplifications to annotations
 *  Changed the way the blocks are scanned in live variable
 *  analysis (see comments).
 *
 *  Revision 1.41  1994/07/19  10:31:59  matthew
 *  Extending loop entry points
 *
 *  Revision 1.40  1994/07/11  11:58:55  matthew
 *  Sometimes we get a loop entry point without a corresponding block (which
 *  presumably has been optimised away).  Check for this in analyse.
 *
 *  Revision 1.39  1994/05/12  12:58:47  richard
 *  Fixed analysis of infinite loops by importing the loop entry
 *  point from _mir_cg.
 *
 *  Revision 1.38  1993/08/17  11:20:11  richard
 *  Changed the annotation of raise instructions to model the fact that
 *  the raise might reach _any_ of the nexted continuation blocks.
 *
 *  Revision 1.37  1993/08/06  13:29:16  richard
 *  Split the analysis of an instruction into a before and after phase
 *  to ensure that registers defined by branching instructions are properly
 *  clashed.
 *
 *  Revision 1.36  1993/03/10  18:04:04  matthew
 *  Map substructure is now MirTypes.Map
 *
 *  Revision 1.35  1993/01/21  16:34:21  jont
 *  Changed handle Map.Undefined constructs for case statements thus
 *  allowing tail recursion to work proprely
 *
 *  Revision 1.34  1992/12/08  19:56:00  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.33  1992/11/03  14:57:08  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.32  1992/09/22  09:37:54  clive
 *  Got rid of some handles using tryApply and co
 *
 *  Revision 1.31  1992/08/26  15:30:53  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.30  1992/06/22  11:51:52  richard
 *  Corrected dataflow between exception raising instructions and
 *  continuation code.
 *
 *  Revision 1.28  1992/06/11  10:17:16  richard
 *  Changed call to graph clasher to include referenced register
 *  information.
 *
 *  Revision 1.27  1992/06/04  15:03:13  richard
 *  The variable analyser now updates the register clash graph
 *  directly rather than producing a list of clashes.
 *
 *  Revision 1.26  1992/06/03  09:03:18  richard
 *  Utilized mutable register sets (packs) and new Map operations.
 *
 *  Revision 1.26  1992/06/01  10:08:19  richard
 *  Utilized mutable register sets (packs) and new Map operations.
 *
 *  Revision 1.25  1992/05/19  11:05:45  richard
 *  Improved use of Map.apply.
 *
 *  Revision 1.24  1992/05/12  10:50:50  richard
 *  Moved operations on triples of register sets to MirProcedure.
 *
 *  Revision 1.23  1992/04/13  15:16:24  clive
 *  First version of the profiler
 *
 *  Revision 1.22  1992/03/02  12:15:41  richard
 *  Completely rewritten to use dependencies between blocks to determine
 *  the order of analysis.  This allows the module to cope with arbitrary
 *  networks of blocks.  The module now uses virtual register sets rather
 *  than the polymorphic set implementation and constructs the register
 *  clash information directly for use by the register allocator rather
 *  than annotating the procedure with it.  It also makes use of the new
 *  MirProcedure module for annotation purposes.
 *
 *)


require "../utils/diagnostic";
require "../utils/crash";
require "../utils/lists";
require "../utils/inthashtable";
require "registerallocator";
require "mirtables";
require "mirprint";
require "mirregisters";
require "mirvariable";


functor MirVariable(include
                    sig 
                      structure Diagnostic		: DIAGNOSTIC
                      structure Crash		: CRASH
                      structure Lists		: LISTS
                      structure IntHashTable        : INTHASHTABLE
                      structure MirPrint		: MIRPRINT
                      structure MirTables		: MIRTABLES
                      structure MirRegisters	: MIRREGISTERS
                      structure RegisterAllocator	: REGISTERALLOCATOR

                      sharing MirPrint.MirTypes = MirTables.MirTypes =
                        RegisterAllocator.MirProcedure.MirTypes = MirRegisters.MirTypes
                      sharing Diagnostic.Text = MirRegisters.MirTypes.GC.Set.Text
                    end
                    where type MirPrint.MirTypes.tag = int
                    ) : MIRVARIABLE =

  struct

    structure MirProcedure = RegisterAllocator.MirProcedure
    structure MirTypes = MirRegisters.MirTypes
    structure Set = MirTypes.Set
    structure RegisterAllocator = RegisterAllocator
    structure Diagnostic = Diagnostic
    structure Map = MirTypes.Map

    (*  == Switches ==
     *
     *  See signature for documentation.  The default behaviour is to
     *  eliminate apparently useless instructions.
     *)

    val eliminate = ref true


    (*  == Diagnostic output and crashes ==  *)

    val $ = Diagnostic.Text.from_string
    val ^^ = Diagnostic.Text.concatenate
    infix ^^

    val do_diagnostics = false

    fun diagnostic (level, output_function) =
      Diagnostic.output_text level
      (fn verbosity => $"MirVariable: " ^^ output_function verbosity)

    fun diagnostic_set (level, prefix_function, {gc, non_gc, fp}) =
      diagnostic (level, fn _ =>
                  prefix_function () ^^ $"  " ^^
                  MirTypes.GC.Pack.to_text gc ^^ $" " ^^
                  MirTypes.NonGC.Pack.to_text non_gc ^^ $" " ^^
                  MirTypes.FP.Pack.to_text fp)

    fun crash message =
      Crash.impossible ("MirVariable: " ^ message)


    (* Tag maps *)
    fun empty_tag_map () = IntHashTable.new 4
    fun lookup_tag (tag,map) = IntHashTable.tryLookup (map,tag)

    fun tagmap_from_list l =
      let
        val result = empty_tag_map ()
      in
        Lists.iterate (fn (tag,x) => IntHashTable.update (result,tag,x)) l;
        result
      end

    (*  === BUILD REACH MAP ===
     *
     *  This function analyses a list of (tag, block) pairs and produces a
     *  Map.T from block tags to the list of tags of those blocks which
     *  might reach them.
     *
     *  For the sake of the efficiency of this function the map is of
     *  references to lists rather than lists, but there is no reason to
     *  update the map returned by the function.
     *)

    fun reach_map blocks =
      let
        val result = tagmap_from_list (map (fn (tag, _) => (tag, ref [])) blocks)
        fun result_fn tag = lookup_tag (tag,result)

        fun block [] = ()
          | block ((from, MirProcedure.B ({reached, ...}, _))::rest) =
            let
              fun reach [] = ()
                | reach (to::rest) =
                  let
                    val to_list = 
                      case result_fn to of
                        SOME x => x
                      | NONE =>
                          crash ("Block " ^ MirTypes.print_tag to ^ 
                                 " was reached but isn't in the list of blocks.")
                  in
                    to_list := from::(!to_list);
                    reach rest
                  end
            in
              reach (Set.set_to_list reached);
              block rest
            end
      in
        block blocks;
        result
      end

    (* Do a dfs on the call graph *)
    fun dfs (block_fn,start) =
      let

	fun scan(arg as (seen, result), tag) =
	  case MirTypes.Map.tryApply'(seen, tag) of
	    NONE =>
	      let
		val MirProcedure.B({reached,...},_) = block_fn tag
		val seen = MirTypes.Map.define(seen, tag, true)
		val (seen, result) =
		  Lists.reducel
		  scan
		  ((seen, result), Set.set_to_list reached)
	      in
		(seen, tag :: result)
	      end
	  | _ => arg
	val (_, result) = scan((MirTypes.Map.empty, []), start)
      in
        (* And return in postorder *)
        rev result
      end

    (*  === ANALYSE A PROCEDURE ===
     *
     *  A procedure is analysed in two passes.  The first uses an iterative
     *  method to determine which registers are live on entry to each block,
     *  and the second uses this information to generate the register clash
     *  lists and discard useless instructions.
     *)

    fun analyse (procedure as MirProcedure.P (annotation as {parameters, ...},
                                              name, start, block_map), graph) =
      let
        val _ = 
          if do_diagnostics
            then diagnostic (1, fn _ => $"procedure " ^^ $(MirTypes.print_tag start) ^^ $" " ^^ $name)
          else ()

        val clash = RegisterAllocator.clash graph
        val blocks = Map.to_list block_map

        local
          val reach_map = reach_map blocks
          val live_map =
            tagmap_from_list (map (fn (tag, _) => (tag, ref MirProcedure.empty)) blocks)
          val block_table = tagmap_from_list blocks
        in

          fun reach_map_fn tag = 
          (case lookup_tag (tag,reach_map) of
             SOME (ref new_tags) => new_tags
           | _ => crash ("Block " ^ MirTypes.print_tag tag ^ " was found but is not in the reached map."))

          fun live_map_fn tag =
            case IntHashTable.tryLookup (live_map,tag) of
              SOME x => x
            | _ => crash ("Block " ^ MirTypes.print_tag tag ^ " is not in the live map.")

          fun block_fn tag = 
            case IntHashTable.tryLookup (block_table,tag) of
              SOME x => x
            | _ => crash ("Block " ^ MirTypes.print_tag tag ^ " is not in the procedure.")
        end

        (*  == Calculate registers live after an instruction ==
         *
         *  Given an annotated instruction and a set of registers live
         *  before the next instruction, this function calculates the set of
         *  live registers immediately after the instruction, including
         *  registers referenced from other blocks reached by branches and
         *  exceptions.
         *
         *  The live parameter may be mutated by this operation.
         *)

        fun after (MirProcedure.I {branches, excepts, opcode, ...}, live) =
          let
            fun reach (live, []) = live
              | reach (live, tag::tags) =
                reach (MirProcedure.union' (live, !(live_map_fn tag)), tags)

            val live' = reach (live, excepts)
            val live'' = reach (live', Set.set_to_list branches)
          in
            if do_diagnostics
              then
                diagnostic_set (4, fn () => $"live after " ^^ $(MirPrint.opcode opcode) ^^ $":", live'')
            else ();
            live''
          end


        (*  == Calculate registers live before an instruction ==
         *
         *  Given an annotated instruction and a set of registers live
         *  immediately after it, this function calculates the set of live
         *  registers before it using the formula:
         *
         *    live before = live after - defined + referenced
         *
         *  The live parameter may be mutated by this operation.
         *)

        nonfix before 

        fun before (MirProcedure.I {defined, referenced, opcode, ...}, live) =
          let
            val live' = MirProcedure.union' (MirProcedure.difference' (live, defined),referenced)
          in
            if do_diagnostics
              then diagnostic_set (4, fn () => $"live before " ^^ $(MirPrint.opcode opcode) ^^ $":", live')
            else ();
            live'
          end


        (*  == FIRST PASS: Analyse a single block ==
         *
         *  Given an annotated block this function scans it backwards
         *  calculating the sets of live registers before each
         *  instruction. The function returns the set of variables live on
         *  entry to the block.
         *)

        fun block (MirProcedure.B (_, instructions)) =
          Lists.reducer
          (fn (instruction, live) => before (instruction, after (instruction, live)))
          (instructions, MirProcedure.empty)


        (*  == FIRST PASS: Analyse blocks until a fixed point is reached ==
         *
         * Iterate repeatedly down the array of blocks recalculating live
         * sets.  When a live set changes, the blocks reachable from the
         * current block are marked for recomputation.  Eventually a fixed
         * point is reached, detected by a full scan through the block
         * without any recomputation .  The number of iterations is usually
         * 1 + the maximum number of back arcs an acyclic path of the call
         * graph. 
         *)

        val ordered_blocks = dfs (block_fn,start)
        val num_blocks = Lists.length ordered_blocks
        val block_array = MLWorks.Internal.Array.arrayoflist ordered_blocks
        val todo = MLWorks.Internal.Array.array (num_blocks,true)

        local 
          fun number ([],n,acc) = rev acc
            | number (a::rest,n,acc) = number (rest,n+1,(a,n)::acc)
          val block_index_map = tagmap_from_list (number (ordered_blocks,0,[]))
        in
          fun block_index tag =
            (case IntHashTable.tryLookup (block_index_map,tag) of
               SOME n => n
             | _ => crash "block index failure")
        end

        (* Iterate through the array of blocks to do *)
        fun iterate num_passes =
          let
            fun aux (changed,n) =
              (* Finished this pass *)
              if n = num_blocks
                then changed
              else
                (* Don't need to do this one *)
                if not (MLWorks.Internal.Array.sub (todo,n))
                  then aux (changed,n+1)
                else
                  let
                    val tag = MLWorks.Internal.Array.sub (block_array,n)
                    val old_live = live_map_fn tag
                    val new_live = block (block_fn tag)
                    val _ = MLWorks.Internal.Array.update (todo,n,false)
                  in
                    if MirProcedure.equal (!old_live, new_live)
                      then aux (true,n+1)
                    else
                      (old_live := new_live;
                       let
                         val new_tags = reach_map_fn tag
                       in
                         Lists.iterate
                         (fn tag => MLWorks.Internal.Array.update (todo,block_index tag,true))
                         new_tags;
                         aux (true,n+1)
                       end)
                  end
            val changed = aux (false,0)
          in
            (* Changed will be true if some blocks were recalculated *)
            if changed 
              then iterate (num_passes + 1)
            else ((* output(std_out,"Terminated after " ^ Int.toString num_passes ^ " passes\n" )*))
          end

        val _ = iterate 0

(* Old version *)
(*
        fun iterate [] = ()
          | iterate (tag::tags) =
            let
              (* val _ = output (std_out,MirTypes.print_tag tag ^ " ") *)
              val _ = 
                if do_diagnostics
                  then diagnostic (3, fn _ => $"analysing block " ^^ $(MirTypes.print_tag tag))
                else ()

              val old_live = live_map_fn tag

              val new_live = block (block_fn tag)

            in
              if MirProcedure.equal (!old_live, new_live) then
                iterate tags
              else
                (if do_diagnostics
                   then diagnostic_set (3, fn _ => $"new live", new_live)
                 else ();
                 old_live := new_live;
		 let
		   val new_tags = case reach_map_fn tag of
		     SOME (ref new_tags) => new_tags
		   | _ =>
		       crash ("Block " ^ MirTypes.print_tag tag ^
			      " was queued but is not in the reached map.")
		 in
		   iterate (tags @ Lists.difference (new_tags, tags))
		 end)
            end
*)
(* Since we analyse all blocks reachable from the start, we don't need this *)
(* anymore *)
(*
        (* The analysis starts at the exit points of the procedure. *)

        val _ = iterate (Set.set_to_list exits)

        (* If there's a loop entry point, analyse from there as well.  This *)
        (* will catch any cycles which don't reach exits. *)

        val _ =
          case parameters of
            MirTypes.PROC_PARAMS {loop_entry = [], ...} => ()
          | MirTypes.PROC_PARAMS {loop_entry = [tag], ...} =>
              (case Map.tryApply block_map tag of
                 SOME x => iterate [tag]
               | _ => ())
          | MirTypes.PROC_PARAMS {loop_entry = taglist, ...} =>
              crash "Mirvariable can't cope with multiple entry points yet"

        val _ =
          if do_diagnostics
            then
              diagnostic
              (2,
               fn _ =>
               Lists.reducel
               (fn (text, (tag, ref {gc, non_gc, fp})) =>
                text ^^ $"\n  block " ^^ $(MirTypes.print_tag tag) ^^
                $" live: " ^^ MirTypes.GC.Pack.to_text gc ^^
                $" "    ^^ MirTypes.NonGC.Pack.to_text non_gc ^^
                $" "       ^^ MirTypes.FP.Pack.to_text fp)
               ($"Live map:", Map.to_list live_map))
          else ()
*)

        (* Consistency check:  There should be no registers live on entry to *)
        (* the procedure. *)
        (* This catches many errors *)
        val _ =
          let
            val live_at_start as {gc, non_gc, fp} = !(live_map_fn start)
          in
            if MirProcedure.is_empty live_at_start then () else
              crash (Lists.reducel (fn (s, r) => s ^ " " ^ MirTypes.GC.to_string r)
                     (Lists.reducel (fn (s, r) => s ^ " " ^ MirTypes.NonGC.to_string r)
                      (Lists.reducel (fn (s, r) => s ^ " " ^ MirTypes.FP.to_string r)
                       ("The following registers are used undefined in procedure " ^ 
                        MirTypes.print_tag start ^ " " ^ name ^ ":",
                        MirTypes.FP.Pack.to_list fp),
                       MirTypes.NonGC.Pack.to_list non_gc),
                      MirTypes.GC.Pack.to_list gc))
          end


        (*  == SECOND PASS: Generate clashes and optimise a block ==
         *
         *  This runs through the blocks using the resolved live_map to
         *  determine which instructions define dead registers and have no
         *  side effects.  These are eliminated if `eliminate' is set to
         *  true.  The register clashes are also added to the graph.
         *)

        fun modify (MirProcedure.B (annotation, instructions)) =
          let
            val instructions' =
              let
                fun modify' (live, done, []) = done
                  | modify' (live, done,
                             (instruction as MirProcedure.I {defined, referenced, opcode, ...})::instructions) =
                    if !eliminate andalso
                      not (MirTables.has_side_effects opcode) andalso
                      MirProcedure.is_empty (MirProcedure.intersection (defined, live)) then
                      (if do_diagnostics
                         then
                           diagnostic_set (3, fn () => $"eliminating " ^^ $(MirPrint.opcode opcode) ^^ $" in context ", live)
                       else ();
                       modify' (live, done, instructions))
                    else
                      let
                        val live' = after (instruction, live)
                      in
                        clash (defined, referenced, live');
                        modify' (before (instruction, live'), instruction::done, instructions)
                      end
              in
                modify' (MirProcedure.empty, [], rev instructions)
              end
          in
            MirProcedure.B (annotation, instructions')
          end

        val blocks' =
          Lists.reducel
          (fn (blocks, (tag, block)) =>
           (if do_diagnostics
              then diagnostic (3, fn _ => $"modifying block " ^^ $(MirTypes.print_tag tag))
            else ();
            (tag, modify block)::blocks))
          ([], blocks)

        val block_map' = Map.from_list blocks'
        val procedure' = MirProcedure.P (annotation, name,start, block_map')
      in
        procedure'
      end

  end
