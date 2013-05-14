(*  ==== MIR ANNOTATED PROCEDURE TYPE ====
 *               SIGNATURE
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
 *  $Log: _mirprocedure.sml,v $
 *  Revision 1.46  1997/01/15 13:00:26  matthew
 *  Have tag list in tagged operations
 *
 * Revision 1.45  1996/11/22  12:13:00  matthew
 * Removing references to MLWorks.Option
 *
 * Revision 1.44  1996/11/06  11:08:27  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.43  1996/05/02  14:59:40  jont
 * floor doesn't need to be in raises table
 * as it contains the handler reference in the instruction
 *
 * Revision 1.42  1996/05/02  12:37:42  jont
 * raises function didn't know call_c could raise
 * also didn't know floor could raise. Both added.
 *
 * Revision 1.41  1996/04/29  14:47:49  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.40  1995/12/20  13:24:13  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.39  1995/05/31  11:10:43  matthew
 *  Removing call to xtime
 *
 *  Revision 1.38  1994/10/13  11:15:44  matthew
 *  Use pervasive Option.option for return values in NewMap
 *
 *  Revision 1.37  1994/09/30  12:50:34  jont
 *  Remove handler register concept
 *
 *  Revision 1.36  1994/09/13  14:51:52  matthew
 *  Abstraction of debug information
 *
 *  Revision 1.35  1994/08/25  13:49:42  matthew
 *  Removed various unnecessary annotations
 *
 *  Revision 1.34  1994/05/12  12:47:33  richard
 *  Add field to MirTypes.PROC_PARAMS.
 *
 *  Revision 1.33  1994/03/09  15:09:08  jont
 *  Adding load offset instruction
 *
 *  Revision 1.32  1994/02/11  15:57:20  nickh
 *  checkout -com MLWharp _mirprocedure.sml -and -com MLWsparc _pervasives.sml
 *  Fix handling of trapping operations.
 *
 *  Revision 1.31  1994/01/17  18:33:52  daveb
 *  Removed unnecessary exceptions from closures.
 *
 *  Revision 1.30  1993/11/01  16:32:06  nickh
 *  Merging in structure simplification.
 *
 *  Revision 1.29.1.2  1993/11/01  16:25:58  nickh
 *  Removed unused substructures of MirTables
 *
 *  Revision 1.29.1.1  1993/08/17  11:55:31  jont
 *  Fork for bug fixing
 *
 *  Revision 1.29  1993/08/17  11:55:31  richard
 *  Changed the annotation of raise instructions to model the fact that
 *  the raise might reach _any_ of the nexted continuation blocks.
 *
 *  Revision 1.28  1993/08/06  13:51:36  richard
 *  Added a hack to remove LEA instructions which reference nonexistent
 *  blocks.
 *
 *  Revision 1.27  1993/06/01  15:01:31  nosa
 *  Debugger Environments for local and closure variable inspection
 *  in the debugger;
 *  changed Option.T to Option.opt.
 *
 *  Revision 1.26  1993/05/18  14:33:53  jont
 *  Removed Integer parameter
 *
 *  Revision 1.25  1993/04/27  13:44:02  richard
 *  The PROFILER instruction has been removed.  It's replacement,
 *  INTERCEPT, does not force a function to be non-leaf.
 *
 *  Revision 1.24  1993/03/10  18:12:47  matthew
 *  changed Map substructure now MirTypes.Map
 *  Signature revisions
 *
 *  Revision 1.23  1993/01/21  15:34:06  jont
 *  Changed handle Map.Undefined constructs for case statements thus
 *  allowing tail recursion to work proprely
 *
 *  Revision 1.22  1992/11/03  14:30:09  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.21  1992/08/28  14:43:01  davidt
 *  Removed some unncesessary intermediate lists which
 *  were being built.
 *
 *  Revision 1.20  1992/08/26  15:16:49  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.19  1992/08/04  18:26:46  jont
 *  Removed various uses of NewMap.to_list in favour of fold and union
 *
 *  Revision 1.18  1992/07/14  13:57:59  richard
 *  Temporary fix to prevent exception continuation blocks disappearing.
 *
 *  Revision 1.17  1992/06/18  16:21:12  richard
 *  Added parameter to RAISE once again.
 *
 *  Revision 1.16  1992/06/17  10:09:09  richard
 *  Added show_timings.
 *
 *  Revision 1.15  1992/06/09  14:30:59  richard
 *  Added total registers used as an annotation on procedures.
 *
 *  Revision 1.14  1992/06/04  09:07:04  richard
 *  Added copy' and changed is_empty to take advantage of new
 *  functions in MONOSET signature.
 *
 *  Revision 1.13  1992/06/01  10:18:16  richard
 *  Changed virtual register Sets to Packs.
 *  Added mutating union, intersection, etc.
 *  Added RegisterPack invocation.
 *  Utilized mutable set operations to provide block-wise packs of
 *  defined and referenced registers.
 *
 *  Revision 1.12  1992/05/12  10:45:45  richard
 *  Moved set operations on triples of register sets to here.
 *  Corrected print routine slightly.
 *
 *  Revision 1.11  1992/05/05  13:57:46  richard
 *  Added calculation of leaf procedure flag.
 *
 *  Revision 1.9  1992/04/27  12:46:40  richard
 *  Added register annotations to blocks and `first definition' annotation to
 *  instructions.
 *
 *  Revision 1.8  1992/04/21  11:08:44  jont
 *  Added require "text"
 *
 *  Revision 1.7  1992/04/14  09:25:27  clive
 *  First version of the profiler
 *
 *  Revision 1.6  1992/04/09  15:15:47  richard
 *  Added uses_stack annotation.
 *
 *  Revision 1.5  1992/03/05  15:52:05  richard
 *  Added side_effects annotation to instructions.
 *
 *  Revision 1.4  1992/03/04  14:28:00  richard
 *  Annotation no longer traces TAIL_CALLs even when the tag is explicit
 *  since they may leave the procedure.
 *
 *  Revision 1.3  1992/03/03  13:58:30  richard
 *  Added missing branch case for FLOOR instructions.
 *
 *  Revision 1.2  1992/02/28  14:08:09  richard
 *  Changed the way virtual registers are handled.  See MirTypes.
 *
 *  Revision 1.1  1992/02/20  16:29:24  richard
 *  Initial revision
 *
 *)

require "../basis/__int";

require "../utils/lists";
require "../utils/crash";
require "../utils/diagnostic";
require "registerpack";
require "mirprint";
require "mirtables";
require "mirprocedure";


functor MirProcedure (
  structure Lists	 : LISTS
  structure Crash	 : CRASH                      
  structure MirTables	 : MIRTABLES
  structure MirPrint	 : MIRPRINT
  structure RegisterPack : REGISTERPACK
  structure Diagnostic	 : DIAGNOSTIC

  sharing MirTables.MirTypes = MirPrint.MirTypes = RegisterPack.MirTypes
) : MIRPROCEDURE =

  struct
    structure MirTypes = MirTables.MirTypes
    structure Map = MirTypes.Map
    structure Set = MirTypes.Set
    structure Diagnostic = Diagnostic
    structure Text = MirTypes.GC.Set.Text
    structure RuntimeEnv = MirTypes.Debugger_Types.RuntimeEnv

    fun crash message =
      Crash.impossible ("MirProcedure: " ^ message)

    fun union ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Pack.union (gc, gc'),
       non_gc = MirTypes.NonGC.Pack.union (non_gc, non_gc'),
       fp     = MirTypes.FP.Pack.union (fp, fp')}

    fun union' ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Pack.union' (gc, gc'),
       non_gc = MirTypes.NonGC.Pack.union' (non_gc, non_gc'),
       fp     = MirTypes.FP.Pack.union' (fp, fp')}

    fun intersection ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Pack.intersection (gc, gc'),
       non_gc = MirTypes.NonGC.Pack.intersection (non_gc, non_gc'),
       fp     = MirTypes.FP.Pack.intersection (fp, fp')}

    fun intersection' ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Pack.intersection' (gc, gc'),
       non_gc = MirTypes.NonGC.Pack.intersection' (non_gc, non_gc'),
       fp     = MirTypes.FP.Pack.intersection' (fp, fp')}

    fun difference ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Pack.difference (gc, gc'),
       non_gc = MirTypes.NonGC.Pack.difference (non_gc, non_gc'),
       fp     = MirTypes.FP.Pack.difference (fp, fp')}

    fun difference' ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Pack.difference' (gc, gc'),
       non_gc = MirTypes.NonGC.Pack.difference' (non_gc, non_gc'),
       fp     = MirTypes.FP.Pack.difference' (fp, fp')}

    fun equal ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      MirTypes.GC.Pack.equal (gc, gc') andalso
      MirTypes.NonGC.Pack.equal (non_gc, non_gc') andalso
      MirTypes.FP.Pack.equal (fp, fp')

    fun pack {gc, non_gc, fp} =
      {gc     = MirTypes.GC.pack_set gc,
       non_gc = MirTypes.NonGC.pack_set non_gc,
       fp     = MirTypes.FP.pack_set fp}

    fun unpack {gc, non_gc, fp} =
      {gc     = MirTypes.GC.unpack_set gc,
       non_gc = MirTypes.NonGC.unpack_set non_gc,
       fp     = MirTypes.FP.unpack_set fp}

    fun copy' {gc, non_gc, fp} =
      {gc     = MirTypes.GC.Pack.copy' gc,
       non_gc = MirTypes.NonGC.Pack.copy' non_gc,
       fp     = MirTypes.FP.Pack.copy' fp}

    val empty = {gc = MirTypes.GC.Pack.empty,
                 non_gc = MirTypes.NonGC.Pack.empty,
                 fp = MirTypes.FP.Pack.empty}

    val empty_set = {gc = MirTypes.GC.Set.empty,
                     non_gc = MirTypes.NonGC.Set.empty,
                     fp = MirTypes.FP.Set.empty}

    fun is_empty {gc, non_gc, fp} =
      MirTypes.GC.Pack.is_empty gc andalso
      MirTypes.NonGC.Pack.is_empty non_gc andalso
      MirTypes.FP.Pack.is_empty fp


    fun pack_set_union'  ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Set.reduce MirTypes.GC.Pack.add' (gc,gc'),
       non_gc = MirTypes.NonGC.Set.reduce MirTypes.NonGC.Pack.add' (non_gc,non_gc'),
       fp     = MirTypes.FP.Set.reduce MirTypes.FP.Pack.add' (fp,fp')}

    (* Remove the elements of a set from the elements of a packed set *)
    fun pack_set_difference'  ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      {gc     = MirTypes.GC.Set.reduce MirTypes.GC.Pack.remove' (gc,gc'),
       non_gc = MirTypes.NonGC.Set.reduce MirTypes.NonGC.Pack.remove' (non_gc,non_gc'),
       fp     = MirTypes.FP.Set.reduce MirTypes.FP.Pack.remove' (fp,fp')}

    fun gcforall f set = MirTypes.GC.Set.reduce (fn (t,i) => t andalso f i) (true,set)
    fun nongcforall f set = MirTypes.NonGC.Set.reduce (fn (t,i) => t andalso f i) (true,set)
    fun fpforall f set = MirTypes.FP.Set.reduce (fn (t,i) => t andalso f i) (true,set)

    fun set_pack_disjoint  ({gc, non_gc, fp}, {gc = gc', non_gc = non_gc', fp = fp'}) =
      (gcforall (fn r => not (MirTypes.GC.Pack.member (gc',r))) gc) andalso
      (nongcforall (fn r => not (MirTypes.NonGC.Pack.member (non_gc',r))) non_gc) andalso
      (fpforall (fn r => not (MirTypes.FP.Pack.member (fp',r))) fp)

    val substitute = RegisterPack.substitute

    datatype instruction =
      I of {defined	: {gc     : MirTypes.GC.Pack.T,
                           non_gc : MirTypes.NonGC.Pack.T,
                           fp     : MirTypes.FP.Pack.T},
            referenced	: {gc     : MirTypes.GC.Pack.T,
                           non_gc : MirTypes.NonGC.Pack.T,
                           fp     : MirTypes.FP.Pack.T},
            branches	: MirTypes.tag Set.Set,
            excepts	: MirTypes.tag list,
            opcode      : MirTypes.opcode}

    datatype block =
      B of {reached	: MirTypes.tag Set.Set,
            excepts	: MirTypes.tag list,
            length	: int} *
           instruction list

    datatype procedure =
      P of {uses_stack	 : bool,
            nr_registers : {gc : int, non_gc : int, fp : int},
            parameters   : MirTypes.procedure_parameters} *
           string * MirTypes.tag * (block) Map.T



    (*  == Extract Branches from Opcode ==
     *
     *  `branches' takes an opcode to a list of the tags to which it
     *  might branch, a boolean indicating whether the next instruction
     *  is reached, and a possibly optimised opcode.
     *
     *  `raises' is a predicate indicating whether an instruction can raise
     *  an exception.
     *)

    local
      open MirTypes
    in
      fun branches (opcode as TBINARY (_, tags, _, _, _)) =
          {next = true, branches = tags, opcode = opcode}
        | branches (opcode as TBINARYFP (_, tags, _, _, _)) =
          {next = true, branches = tags, opcode = opcode}
        | branches (opcode as TUNARYFP (_, tags, _, _)) =
          {next = true, branches = tags, opcode = opcode}
        | branches (opcode as BRANCH (_, TAG tag)) =
          {next = false, branches = [tag], opcode = opcode}
        | branches (opcode as BRANCH (_, REG _)) =
          {next = false, branches = [], opcode = opcode}
        | branches (opcode as TEST (_, tag, _, _)) =
          {next = true, branches = [tag], opcode = opcode}
        | branches (opcode as FTEST (_, tag, _, _)) =
          {next = true, branches = [tag], opcode = opcode}
        | branches (opcode as TAIL_CALL _) =
          {next = false, branches = [], opcode = opcode}
        | branches (opcode as SWITCH (_, _, tags as [tag])) =
          {next = false, branches = tags, opcode = BRANCH(BRA, TAG tag)}
        | branches (opcode as SWITCH (_, _, tags)) =
          {next = false, branches = tags, opcode = opcode}
        | branches (opcode as RTS) =
          {next = false, branches = [], opcode = opcode}
        | branches (opcode as RAISE _) =
          {next = false, branches = [], opcode = opcode}
        | branches (opcode as FLOOR(_, tag, _, _)) =
          {next = true, branches = [tag], opcode = opcode}
        | branches opcode =
          {next = true, branches = [], opcode = opcode}

      fun raises (RAISE _) = true
        | raises (BRANCH_AND_LINK _) = true	(* A subroutine may raise an exception *)
	| raises (TBINARY (_, [],_,_,_)) = true
	| raises (TBINARYFP (_, [],_,_,_)) = true
	| raises (TUNARYFP (_, [],_,_)) = true
	| raises CALL_C = true
        | raises _ = false

    end



    (*  === ANNOTATE A PROCEDURE ===
     *
     *  The annotation algorithm analyses the flow of control using two
     *  mutually recursive functions and builds a Map.T of tags to annotated
     *  blocks.  `next' takes the map so far and a list of blocks to be
     *  processed with the exception handlers active on entry.  If the first
     *  block on the list *)


    fun annotate (procedure as MirTypes.PROC (name,start_tag, parameters, block_list,_)) =
      let
        val {nr_registers, substitute} = RegisterPack.f procedure

        (* Build a function mapping tags to blocks in the original *)
        (* procedure. *)

	val old_block_map =
	  (Lists.reducel (fn (res, MirTypes.BLOCK(x,y)) =>
			  Map.define(res, x, y))
	   (Map.empty, block_list))
        fun old_block x = Map.tryApply'(old_block_map, x)

        (*  == Annotate a list of opcodes ==
         *
         *  Given a list of unannotated opcodes and a stack (list) of active
         *  exception blocks, this function constructs an annotated block
         *  and returns a list of other blocks reached with the exception
         *  block stack active at the time of branching.  It also returns 
         *  booleans indicating whether there were any non-leaf instructions, and whether
         *  the block uses stack.
         *)

        fun block (excepts, opcodes) =
          let
            fun block' (done, defined, length, reached, stack, _, []) =
                (rev done, defined, length, reached, stack)
              | block' (done, defined, length, reached, stack, excepts, opcode::opcodes) =
                let

                  val opcode' = substitute opcode

                  (* add or remove exceptions from the exception stack. *)
                  val excepts' =
                    case opcode'
                      of MirTypes.NEW_HANDLER(_, tag) => tag::excepts
                       | MirTypes.OLD_HANDLER =>
                         (case excepts
                            of _::rest => rest
                             | [] =>
                               crash ("Too many OLD_HANDLERs in procedure " ^ MirTypes.print_tag start_tag ^ "."))
                       | _ => excepts

                  (* Check whether the opcode uses any stack at all. *)
                  val stack' =
                    case opcode'
                      of MirTypes.STACKOP _ => true
                       | MirTypes.ALLOCATE_STACK _ => true
                       | MirTypes.DEALLOCATE_STACK _ => true
                       | _ => stack

                  (* Find out where the opcode might possible go to. *)
                  val {next, branches, opcode = opcode''} = branches opcode'
                  val reached' = (map (fn tag => (excepts', tag)) branches) @ reached

                  (* Find out if the opcode might raise an exception.  If it *)
                  (* does, then it might reach any exception continuation in *)
                  (* the current stack. *)
                  val (excepts, reached'') =
                    if raises opcode'' then
                      let
                        fun reach (reached, []) = reached
                          | reach (reached, excepts as cont::conts) =
                            reach ((excepts, cont)::reached, conts)

                        val reached'' = reach (reached',excepts)
                      in
                        (excepts, reached'')
                      end
                    else
                      ([], reached')

                  (* Build an annotated instruction with the information. *)
                  val defined_here = pack (MirTables.defined_by opcode'')
                  val referenced_here = pack (MirTables.referenced_by opcode'')
                  val instruction =
                    I {defined      = defined_here,
                        referenced   = referenced_here,
                        branches     = Set.list_to_set branches,
                        excepts       = excepts,
                        opcode = opcode''}
                in
                  block' (instruction::done,
                          union' (defined, defined_here),
                          case opcode'' of MirTypes.COMMENT _ => length | _ => length+1,
                          reached'',
                          stack',
                          excepts',
                          if next then opcodes else [])
                end

            val (instructions, defined, length, reached, stack) =
              block' ([], empty, 0, [], false, excepts, opcodes)
          in
            (B ({reached = Set.list_to_set (map #2 reached),
                 length = length,
                 excepts = excepts}, 
                instructions),
             defined,
             reached,
             stack)
          end

        (*  == Iteratively Annotate Blocks Until Done ==
         *
         *  This function runs through a list of (exception stack, block
         *  tag) pairs and, if the block has not already been processed,
         *  builds an annotated block for each, adding it to a Map.T of
         *  processed blocks.  The blocks reached by annotating the
         *  procedure are added to the list for the next iteration.
         *)

        fun next (map, stack, []) = (map,stack)
          | next (map, stack, (excepts, tag)::rest) =
	    (case Map.tryApply'(map, tag) of
	       SOME (B ({excepts = excepts', ...}, _)) =>
		 if excepts = excepts' then
		   next (map, stack, rest)
		 else
		   crash ("Block " ^ MirTypes.print_tag tag ^ " has been reached with inconsistent exception blocks.  " ^
			  "The first time round they were " ^ Lists.to_string MirTypes.print_tag excepts' ^
			  " but this time they were " ^ Lists.to_string MirTypes.print_tag excepts ^ ".")
	     | _ =>
		 (case old_block tag of
		    SOME opcodes =>
		      let
			val (new_block, defined, reached, stack') = block (excepts, opcodes)
			val map' = Map.define (map, tag, new_block)
		      in
			next (map',
                              stack orelse stack',
                              reached @ rest)
		      end
		  | _ =>
		      crash ("Block " ^ MirTypes.print_tag tag ^
			     " has been reached but cannot be found in the original " ^
			     "procedure.")))

        (* Cause all reachable blocks to be processed by starting with the *)
        (* initial block reachable. *)

        val (map, stack) =
          next (Map.empty, false, [([], start_tag)])

      in

        P ({nr_registers = nr_registers,
            uses_stack = stack,
            parameters = parameters},
           name,start_tag, map)

      end



    (*  === UNANNOTATE ===
     *
     *  This is far simple than annotation.  It simply strips off the extra
     *  information.
     *
     *  NOTE: There is an extra hack here which looks for LEA instructions
     *  to nonexistent blocks and replaces them with safe MOVEs.  This is
     *  because the optimizer can throw away exception continuations but not
     *  the LEA which references them.  This should be fixed when a HANDLE
     *  directive is introduced - richard.
     *)

    fun unannotate (P({parameters, ...}, name, start_tag, block_map)) =
      let
        fun unannotate_block (tag, B(_, instructions)) =
          let
            local
              open MirTypes
            in
              fun unannotate_instruction (I {opcode = opcode as ADR (_, reg, tag),...}) =
                  (case Map.tryApply' (block_map, tag) of
                     SOME _ => opcode
                   | _ => UNARY (MOVE, reg, GP_IMM_ANY 0))
                | unannotate_instruction (I {opcode,...}) = opcode
            end
          in
            MirTypes.BLOCK(tag, map unannotate_instruction instructions)
          end
      in
        MirTypes.PROC(name,start_tag, parameters, map unannotate_block
		      (Map.to_list block_map),RuntimeEnv.EMPTY)
      end


    (*  === CONVERT ANNOTATED PROCEDURE TO PRINTABLE TEXT ===  *)

    fun to_text (P(annotation, name, start_tag, block_map)) =
      let
        nonfix ^^
        val ^^ = Text.concatenate
        val $ = Text.from_string
        infix ^^

        fun list printer (leader, []) = $""
          | list printer (leader, [t]) = leader ^^ $(printer t) ^^ $"\n"
          | list printer (leader, t::ts) =
            leader ^^
            Lists.reducel (fn (text, t) => $(printer t) ^^ $", " ^^ text) 
            ($(printer t), ts) ^^
            $"\n"

        val tags = list MirTypes.print_tag

        fun registers (leader, {gc, non_gc, fp}) =
          leader ^^ MirTypes.GC.Pack.to_text gc ^^
          $" " ^^ MirTypes.NonGC.Pack.to_text non_gc ^^
          $" " ^^ MirTypes.FP.Pack.to_text fp ^^
          $"\n"

        val header =
          $"Procedure " ^^ $(MirTypes.print_tag start_tag) ^^ $": " ^^ $name ^^ $"\n"

        fun block (text, tag, B(annotation, instructions)) =
          let
            val header =
              $"    Block " ^^ $(MirTypes.print_tag tag) ^^ $"\n" ^^
              tags      ($"      reached: ", Set.set_to_list (#reached annotation)) ^^
              tags      ($"      exceptions: ", #excepts annotation) ^^
                         $"      length: " ^^ $(Int.toString (#length annotation)) ^^ $"\n"

            fun opcode (text, I {defined,referenced,branches,excepts,opcode}) =
              let
                val trailer =
                  registers ($"          defined: ", defined) ^^
                  registers ($"          referenced: ", referenced) ^^
                  tags      ($"          branches: ", Set.set_to_list branches) ^^
                  tags	    ($"          exceptions: ", excepts) 
              in
                text ^^
                $"        " ^^ $(MirPrint.opcode opcode) ^^ $"\n" ^^
                trailer
              end
          in
            text ^^ Lists.reducel opcode (header, instructions)
          end
      in
        Map.fold block (header, block_map)
      end

  end
