(*  ==== STATIC STACK ALLOCATOR ====
 *              FUNCTOR
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Two passes are made over the procedure.  The first pass determines the
 *  total amount of static stack required by the procedure and the stack
 *  position on entry to each block.  This is accomplished by tracing all
 *  the possible control flow paths (while also ensuring that the stack use
 *  in a loop is consistent).  In the second pass, the blocks are remade
 *  with the stack offsets added to any stack operations.
 *
 *  Notes
 *  -----
 *  1.  There is no way that this module can cope with stack allocation
 *      determined at run-time.
 *
 *  Revision Log
 *  ------------
 *  $Log: _stackallocator.sml,v $
 *  Revision 1.31  1997/05/01 12:36:48  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 * Revision 1.30  1995/12/20  13:51:54  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.29  1995/05/31  11:15:16  matthew
 *  Changing instruction datatype
 *
 *  Revision 1.28  1995/05/15  10:33:44  jont
 *  Modify to use a tree instead of an association list when determining stack requirements
 *
 *  Revision 1.27  1994/10/13  11:16:41  matthew
 *  Use pervasive Option.option for return values in NewMap
 *
 *  Revision 1.26  1994/08/30  13:11:24  matthew
 *  Efficiency improvements
 *
 *  Revision 1.25  1994/08/25  13:55:09  matthew
 *  Changes to procedurure and block annotations.
 *
 *  Revision 1.24  1994/05/12  12:52:43  richard
 *  Add field to MirTypes.PROC_PARAMS.
 *
 *  Revision 1.23  1993/08/17  14:58:11  richard
 *  Changed the annotation of raise instructions to model the fact that
 *  the raise might reach _any_ of the nexted continuation blocks.
 *
 *  Revision 1.22  1993/07/29  15:19:43  nosa
 *  structure Option.
 *
 *  Revision 1.21  1993/05/18  14:53:35  jont
 *  Removed Integer parameter
 *
 *  Revision 1.20  1993/03/10  17:59:21  matthew
 *  Map substructure is now MirTypes.Map
 *  Signature revisions
 *
 *  Revision 1.19  1992/11/03  14:50:02  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.18  1992/09/22  09:48:38  clive
 *  Got rid of some handles using tryApply and co
 *
 *  Revision 1.17  1992/08/28  15:07:59  davidt
 *  Removed some unncesessary intermediate lists which
 *  were being built.
 *
 *  Revision 1.16  1992/08/26  15:40:16  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.15  1992/08/04  18:53:09  jont
 *  Removed various uses of NewMap.to_list in favour of fold and union
 *
 *  Revision 1.14  1992/06/09  15:49:17  richard
 *  Added registers annotation to procedures.
 *
 *  Revision 1.13  1992/06/01  11:24:47  richard
 *  Improved use of Map.
 *
 *  Revision 1.12  1992/04/13  15:21:23  clive
 *  First version of the profiler
 *
 *  Revision 1.11  1992/04/09  15:45:18  richard
 *  Changed code to take advantage of uses_stack.  No analysis is performed
 *  if the procedure does not contain stacking instruction.
 *
 *  Revision 1.10  1992/04/03  13:06:33  richard
 *  Corrected calculation of stack required in the presence of exceptions.
 *
 *  Revision 1.9  1992/03/05  11:03:15  richard
 *  Rewrote in terms of MirProcedure annotated procedures and corrected
 *  the algorithm so that it is no longer exponential on depth of block
 *  nesting.
 *
 *  Revision 1.8  1992/01/31  10:02:50  richard
 *  Changed stack allocation to cope with jumping to the exception
 *  continuation block with the correct stack state.
 *
 *  Revision 1.7  1991/12/12  13:46:05  richard
 *  A complete rewrite.  See documentation at the start of the file.
 *
 *  Revision 1.6  91/12/05  14:57:19  richard
 *  Added extra documentation and a safeguard against procedures with
 *  no exits points.
 *  
 *  Revision 1.5  91/11/26  12:52:07  richard
 *  Added offsets to POP instructions as well as PUSH instructions.
 *  I'm not sure why I didn't do this before.
 *  
 *  Revision 1.4  91/11/19  16:05:50  richard
 *  Changed debugging output to use the Diagnostic module, which
 *  prevents the debugging output strings being constructed even
 *  if they aren't printed.
 *  
 *  Revision 1.3  91/11/08  16:06:28  richard
 *  Added offset argument to STACKOPs.
 *  
 *  Revision 1.2  91/11/07  16:10:46  richard
 *  The ProcedureMap structure is built inside this functor, so that extra
 *  processing can take place. Also added debugging output.
 *  
 *  Revision 1.1  91/10/29  16:41:57  richard
 *  Initial revision
 *)


require "../utils/diagnostic";
require "../utils/lists";
require "../utils/crash";
require "mirprocedure";
require "mirprint";
require "stackallocator";


functor StackAllocator (
  structure MirPrint		: MIRPRINT
  structure Crash		: CRASH
  structure Lists		: LISTS
  structure MirProcedure	: MIRPROCEDURE
  structure Diagnostic		: DIAGNOSTIC

  sharing MirProcedure.MirTypes = MirPrint.MirTypes

) : STACKALLOCATOR =

  struct

    structure MirProcedure = MirProcedure
    structure Diagnostic = Diagnostic
    structure MirTypes = MirProcedure.MirTypes
    structure Map = MirTypes.Map

    (*  == Diagnostic output ==  *)

    infix ^^
    val op^^ = Diagnostic.Text.concatenate
    val $ = Diagnostic.Text.from_string
    fun diagnostic (level, output_function) =
      Diagnostic.output_text level
      (fn verbosity =>
       $"Stack Allocator: " ^^ output_function verbosity)

    fun crash message = Crash.impossible ("Stack Allocator: " ^ message)

    val do_diagnostics = false

    (*  === STACK EFFECT OF AN OPCODE ===
     *
     *  This function returns the change to the stack pointer caused by an
     *  opcode.
     *)

    local
      open MirTypes

      val message =
        "Stack Allocator: I don't know how to deal with non-word stack allocation."
    in
      fun stack_effect (STACKOP (PUSH, _, _)) = 1
        | stack_effect (STACKOP (POP, _, _)) = ~1
        | stack_effect (ALLOCATE_STACK (ALLOC, _, amount, _)) = amount
        | stack_effect (ALLOCATE_STACK _) = Crash.unimplemented message
        | stack_effect (DEALLOCATE_STACK (ALLOC, amount)) = ~amount
        | stack_effect (DEALLOCATE_STACK _) = Crash.unimplemented  message
        | stack_effect _ = 0
    end



    (*  === FIRST PASS: ANALYSE STACK USAGE OF A PROCEDURE ===
     *
     *  Returns a pair containing the maximum number of words required by
     *  the procedure for its stack allocation and an association lists of
     *  blocks and their stack positions on entry.
     *)

    fun used_by_procedure (MirProcedure.P (_, _,start_tag, block_map)) =
      let

        val _ = if do_diagnostics 
                  then diagnostic (1, fn _ => $"analysing stack usage of procedure " ^^
                                   $(MirTypes.print_tag start_tag))
                else ()

        val block_map_fn = Map.tryApply block_map

        (*  == Analyse stack usage of a block ==
         *
         *  Returns a pair containing the maximum amount of stack required
         *  by a block AND its successors for stack allocation, and the
         *  alist of blocks visited and their stack positions on entry.  The
         *  following parameters are *  required:
         *    visited    An association list of other blocks passed through
         *               on the way to this one with their stack positions
         *               on entry.
         *    stack_position
         *               The position of the stack pointer on entry to the
         *               block.
         *    exception_stack_positions
         *               A list of stack positions.  The topmost position is
         *               that which was current when the topmost exception
         *               hander was set up, and must therefore be restored
         *               when that exception is raised.
         *    maximum_used
         *               The largest value of the stack pointer before
         *               entering the block.
         *    tag        The tag of the block to process.
         *)

        fun used_by_block (visited, stack_position, maximum_used, exception_stack_positions, tag) =

          (* If the block has already been visited then check that the stack *)
          (* pointer was in the same position last time.  If the block has *)
          (* been visited then its maximum usage has already been looked at, *)
          (* so return zero. *)

         (case MirTypes.Map.tryApply'(visited, tag) of
            SOME previous_position =>
              if previous_position = stack_position then
		(0, visited)
              else
                crash ("The block tagged " ^ MirTypes.print_tag tag ^
                       " has been reached with inconsistent stack positions.")
          | _ =>

          (* If the block hasn't been visited before then run through its *)
          (* opcodes calculating their effect on the stack.  If the flow of *)
          (* control leaves the block then call used_by_block on the blocks *)
          (* reached and take the maximum stack used by them into account. *)

          let
            fun used_by_opcodes (visited, _, maximum_used, _, []) = (maximum_used, visited)
              | used_by_opcodes (visited, stack_position, maximum_used, exception_stack_positions,
                                 MirProcedure.I {branches, excepts, opcode, ...} ::instructions) =
                let
                  val stack_position_after =
                    let
                      val new = stack_position + (stack_effect opcode)
                    in
                      if new >= 0 then
                        new
                      else
                        crash ("The stack position has gone negative in block " ^
                               MirTypes.print_tag tag ^
                               ".  There must be badly nested stack operations somewhere.")
                    end

                  val exception_stack_positions' =
		    case opcode of
		      MirTypes.NEW_HANDLER _ =>
			stack_position_after :: exception_stack_positions
                         | MirTypes.OLD_HANDLER =>
			     (case exception_stack_positions of
				_::rest => rest
			      | [] =>
				  crash ("Badly nested OLD_HANDLER in block " ^
					 MirTypes.print_tag tag ^ "."))
                         | _ => exception_stack_positions

                  val maximum_used_after =
                    if stack_position_after > maximum_used then stack_position_after else maximum_used

                  val (maximum_used_after', visited') =
                    Lists.reducel
                    (fn ((maximum, visited), tag) =>
                     let
                       val (used, visited') =
                         used_by_block (visited,
                                        stack_position_after,
                                        maximum_used_after,
                                        exception_stack_positions',
                                        tag)
                     in
                       (if used > maximum then used else maximum, visited')
                     end)
                    ((maximum_used_after, visited), MirTypes.Set.set_to_list branches)

                  val (maximum_used_after'', visited'') =
                    case excepts of
                      [] => (maximum_used_after', visited')
                    | _ => 
                      let
                        fun reach (maximum, visited, [], []) = (maximum, visited)
                          | reach (maximum, visited, cont::conts, exception_stack_positions as sp::sps) =
                            let
                              val (used, visited') =
                                used_by_block (visited, sp, maximum, exception_stack_positions, cont)
                            in
                              reach (if used > maximum then used else maximum,
                                     visited',
                                     conts, sps)
                            end
                          | reach _ =
                            crash ("The exception block " ^ MirTypes.print_tag tag ^ " was reached " ^
                                   "without a stack position in force.")
                      in
                        reach (maximum_used_after', visited', excepts, exception_stack_positions')
                      end
                in
                  used_by_opcodes (visited'',
                                   stack_position_after,
                                   maximum_used_after'',
                                   exception_stack_positions',
                                   instructions)
                end

            val MirProcedure.B (annotation, instructions) = 
              case block_map_fn tag of
                SOME x => x
              | _ =>
                  crash ("Block " ^ MirTypes.print_tag tag ^ " was reached but not found.")
          in
            used_by_opcodes (MirTypes.Map.define(visited, tag, stack_position),
                             stack_position,
                             maximum_used,
                             exception_stack_positions,
                             instructions)
          end)

      in

        (* Analyse the whole procedure by analysing the first block. *)

        used_by_block (MirTypes.Map.empty, 0, 0, [], start_tag)

      end



    (*  === PASS 2: ADD OFFSETS TO PROCEDURE ===
     *
     *  This function adds the stack offset positions to the stack operation
     *  opcodes.  It is passed a Map.T of blocks and a mapping function from
     *  blocks to stack positions on entry and returns an updated Map.T of
     *  blocks.
     *)

    fun add_offsets (positions, block_map) =
      let
        fun add_to_block (tag, MirProcedure.B (annotation, instructions)) =
          let
            fun add_to_opcodes (done, _, []) = rev done
              | add_to_opcodes (done, position, MirProcedure.I {defined,referenced,branches,excepts,opcode}::instructions) =
                let
                  val position_after = position + (stack_effect opcode)

                  local
                    open MirTypes
                  in
                    val opcode_with_offset =
                      case opcode
                        of STACKOP(PUSH, reg, _) =>
                           STACKOP(PUSH, reg, SOME position)
                         | STACKOP(POP, reg, _) => 
                           STACKOP(POP, reg, SOME position_after)
                         | ALLOCATE_STACK(oper, reg, amount, _) => 
                           ALLOCATE_STACK(oper, reg, amount, SOME position)
                         | other_opcode => other_opcode
                  end
                in
                  add_to_opcodes (MirProcedure.I {defined = defined,
                                                  referenced = referenced,
                                                  branches = branches,
                                                  excepts = excepts,
                                                  opcode = opcode_with_offset} :: done,
                                  position_after,
                                  instructions)
                end

            val new_instructions =
              add_to_opcodes ([], positions tag, instructions)
          in
            MirProcedure.B (annotation, new_instructions)
          end

      in
	Map.map add_to_block block_map
	handle Map.Undefined => crash ("Block does not have a starting stack position.")
      end




    (*  === STACK ALLOCATE A PROCEDURE ===
     *
     *  Applies the two passes to the procedure and fills in the procedure
     *  parameters.
     *)

    fun allocate (procedure as MirProcedure.P (annotation, name, start, block_map)) =
      let
        val (used, block_map') =
          if #uses_stack annotation then
            let
              val (used, positions) = used_by_procedure procedure
              val positions = Map.apply positions
              val block_map' = add_offsets (positions, block_map)
            in
              (used, block_map')
            end
          else
            (0, block_map)

        val annotation' =
          let
            val {uses_stack,
                 nr_registers,
                 parameters = MirTypes.PROC_PARAMS
                   {spill_sizes, ...}} = annotation
          in
            {nr_registers = nr_registers,
             uses_stack = uses_stack,
             parameters = MirTypes.PROC_PARAMS {spill_sizes = spill_sizes,
						old_spill_sizes = NONE,
                                                stack_allocated = SOME used}}
          end
                               
      in
        MirProcedure.P (annotation', name, start, block_map')
      end


  end
