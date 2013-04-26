(*  ==== MIR ANNOTATED PROCEDURE TYPE ====
 *               SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides a datatype similar in structure to
 *  MirTypes.procedure but parameterised with additional types attached to
 *  each procedure, block, and instruction.  Tools are provided for
 *  contructing and printing annotated procedures.
 *
 *  Revision Log
 *  ------------
 *  $Log: mirprocedure.sml,v $
 *  Revision 1.21  1995/12/20 13:23:03  jont
 *  Add extra field to procedure_parameters to contain old (pre register allocation)
 *  spill sizes. This is for the i386, where spill assignment is done in the backend
 *
 *  Revision 1.20  1995/05/31  11:08:55  matthew
 *  Removing show_timings
 *
 *  Revision 1.19  1994/08/25  13:34:14  matthew
 *  Simplified annotations
 *
 *  Revision 1.18  1993/08/17  11:20:14  richard
 *  Changed the annotation of raise instructions to model the fact that
 *  the raise might reach _any_ of the nexted continuation blocks.
 *
 *  Revision 1.17  1993/06/01  14:59:20  nosa
 *  Changed Option.T to Option.opt.
 *
 *  Revision 1.16  1992/11/03  14:29:56  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.15  1992/08/26  15:34:20  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.14  1992/06/17  10:26:24  richard
 *  Added show_timings.
 *
 *  Revision 1.13  1992/06/09  14:17:57  richard
 *  Added registers annotation to procedures.
 *
 *  Revision 1.12  1992/06/04  09:03:25  richard
 *  Added copy'.
 *
 *  Revision 1.11  1992/06/01  10:18:59  richard
 *  Added mutable union, intersection, etc.
 *  Added sets of registers defined and referenced on a per-block
 *  basis.  Added nr_registers annotation to procedures.
 *
 *  Revision 1.10  1992/05/12  10:44:52  richard
 *  Moved set operations on triples of register sets here.
 *
 *  Revision 1.9  1992/05/05  09:50:10  richard
 *  Removed block-wise defined and referenced annotations as they were
 *  taking far too long to calculate.  This also removes the `first'
 *  annotation from instructions, but it wasn't used anyway.
 *
 *  Revision 1.8  1992/04/27  12:43:46  richard
 *  Added register annotations to blocks and `first definition' annotation to
 *  instructions.
 *
 *  Revision 1.7  1992/04/21  10:57:46  jont
 *  Added require "diagnostic"
 *
 *  Revision 1.6  1992/04/14  09:27:33  clive
 *  First version of the profiler
 *
 *  Revision 1.5  1992/04/09  14:55:27  richard
 *  Added uses_stack annotation.
 *
 *  Revision 1.4  1992/03/05  15:52:10  richard
 *  Added side_effects annotation.
 *
 *  Revision 1.3  1992/03/04  14:27:24  richard
 *  Added unannotate.
 *
 *  Revision 1.2  1992/02/27  17:15:14  richard
 *  Changed the way virtual registers are handled.  See MirTypes.
 *
 *  Revision 1.1  1992/02/20  16:42:48  richard
 *  Initial revision
 *
 *)

require "../utils/text";
require "../utils/diagnostic";
require "mirtypes";


signature MIRPROCEDURE =

  sig

    structure MirTypes		: MIRTYPES
    structure Diagnostic	: DIAGNOSTIC
    structure Text		: TEXT

    (*  == Operations on packed register sets ==
     *
     *  The register set annotations take the form of records with one entry
     *  for each of the register types.  These functions perform set
     *  operations on these records.
     *)

    val empty : {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T}

    val empty_set : {gc     : MirTypes.GC.Set.T,
                     non_gc : MirTypes.NonGC.Set.T,
                     fp     : MirTypes.FP.Set.T}

    val equal : {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T} *
                {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T} -> bool

    val is_empty : {gc     : MirTypes.GC.Pack.T,
                    non_gc : MirTypes.NonGC.Pack.T,
                    fp     : MirTypes.FP.Pack.T} -> bool

    val union : {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T} *
                {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T} ->
                {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T}

    val union' : {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T} *
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T} ->
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T}

    val pack_set_union' :
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T} *
                 {gc     : MirTypes.GC.Set.T,
                  non_gc : MirTypes.NonGC.Set.T,
                  fp     : MirTypes.FP.Set.T} ->
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T}

    val pack_set_difference' :
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T} *
                 {gc     : MirTypes.GC.Set.T,
                  non_gc : MirTypes.NonGC.Set.T,
                  fp     : MirTypes.FP.Set.T} ->
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T}

    (* check if a set and a packed set are disjoint *)
    val set_pack_disjoint :
                 {gc     : MirTypes.GC.Set.T,
                  non_gc : MirTypes.NonGC.Set.T,


                  fp     : MirTypes.FP.Set.T} *
                 {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T} ->
                 bool

    val intersection : {gc     : MirTypes.GC.Pack.T,
                        non_gc : MirTypes.NonGC.Pack.T,
                        fp     : MirTypes.FP.Pack.T} *
                       {gc     : MirTypes.GC.Pack.T,
                        non_gc : MirTypes.NonGC.Pack.T,
                        fp     : MirTypes.FP.Pack.T} ->
                       {gc     : MirTypes.GC.Pack.T,
                        non_gc : MirTypes.NonGC.Pack.T,
                        fp     : MirTypes.FP.Pack.T}

    val intersection' : {gc     : MirTypes.GC.Pack.T,
                         non_gc : MirTypes.NonGC.Pack.T,
                         fp     : MirTypes.FP.Pack.T} *
                        {gc     : MirTypes.GC.Pack.T,
                         non_gc : MirTypes.NonGC.Pack.T,
                         fp     : MirTypes.FP.Pack.T} ->
                        {gc     : MirTypes.GC.Pack.T,
                         non_gc : MirTypes.NonGC.Pack.T,
                         fp     : MirTypes.FP.Pack.T}

    val difference : {gc     : MirTypes.GC.Pack.T,
                      non_gc : MirTypes.NonGC.Pack.T,
                      fp     : MirTypes.FP.Pack.T} *
                     {gc     : MirTypes.GC.Pack.T,
                      non_gc : MirTypes.NonGC.Pack.T,
                      fp     : MirTypes.FP.Pack.T} ->
                     {gc     : MirTypes.GC.Pack.T,
                      non_gc : MirTypes.NonGC.Pack.T,
                      fp     : MirTypes.FP.Pack.T}

    val difference' : {gc     : MirTypes.GC.Pack.T,
                       non_gc : MirTypes.NonGC.Pack.T,
                       fp     : MirTypes.FP.Pack.T} *
                      {gc     : MirTypes.GC.Pack.T,
                       non_gc : MirTypes.NonGC.Pack.T,
                       fp     : MirTypes.FP.Pack.T} ->
                      {gc     : MirTypes.GC.Pack.T,
                       non_gc : MirTypes.NonGC.Pack.T,
                       fp     : MirTypes.FP.Pack.T}

    val pack : {gc     : MirTypes.GC.Set.T,
                non_gc : MirTypes.NonGC.Set.T,
                fp     : MirTypes.FP.Set.T} ->
               {gc     : MirTypes.GC.Pack.T,
                non_gc : MirTypes.NonGC.Pack.T,
                fp     : MirTypes.FP.Pack.T}

    val unpack : {gc     : MirTypes.GC.Pack.T,
                  non_gc : MirTypes.NonGC.Pack.T,
                  fp     : MirTypes.FP.Pack.T} ->
                 {gc     : MirTypes.GC.Set.T,
                  non_gc : MirTypes.NonGC.Set.T,
                  fp     : MirTypes.FP.Set.T}

    val copy' : {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T} ->
                {gc     : MirTypes.GC.Pack.T,
                 non_gc : MirTypes.NonGC.Pack.T,
                 fp     : MirTypes.FP.Pack.T}



    (*  == Substitute registers in a procedure ==
     *
     *  Given functions which substitute GC, non GC and FP registers this
     *  function substitutes registers in MIR opcodes.  Lift this function
     *  where possible.
     *)

    val substitute :
      {gc     : MirTypes.GC.T    -> MirTypes.GC.T,
       non_gc : MirTypes.NonGC.T -> MirTypes.NonGC.T,
       fp     : MirTypes.FP.T    -> MirTypes.FP.T} ->
      MirTypes.opcode -> MirTypes.opcode

    (*  == Annotated Instruction ==
     *
     *  referenced	The set of registers required as input to the opcode.
     *  defined		The set of registers which have values stored in
     *			them by this opcode.
     *  branches	The set of other blocks that may be reached by
     *			executing this opcode via normal branching
     *			operations.
     *  except		A stack of exception continuation blocks that might
     *  		be reached via an exception handler if this
     *  		instruction is executed.
     *)

    datatype instruction =
      I of {defined	: {gc     : MirTypes.GC.Pack.T,
                           non_gc : MirTypes.NonGC.Pack.T,
                           fp     : MirTypes.FP.Pack.T},
            referenced	: {gc     : MirTypes.GC.Pack.T,
                           non_gc : MirTypes.NonGC.Pack.T,
                           fp     : MirTypes.FP.Pack.T},
            branches	: MirTypes.tag MirTypes.Set.Set,
            excepts	: MirTypes.tag list,
            opcode      : MirTypes.opcode}

    (*  == Annotated Block ==
     *
     *  reached		The set of tags of the blocks that can be reached by
     *			executing this block, including via exceptions.
     *  excepts		The stack (list) of exception blocks active on entry
     *			to the block.  The first tag is that of the current
     *			exception block.
     *  length		The number of instructions in the block (excluding 
     *                  comments).
     *)

    datatype block =
      B of {reached	: MirTypes.tag MirTypes.Set.Set,
            excepts	: MirTypes.tag list,
            length	: int} *
           instruction list

    (*  == Annotated Procedure ==
     *
     *  uses_stack	True if the procedure contains stack operations.
     *  nr_registers    The number of registers of each type used in the
     *                  procedure.  (Actually one greater than the higest
     *                  number returned by the pack function for the
     *                  register.)
     *  registers	The sets of registers actually used in the
     *                  procedure.
     *  parameters	The MirTypes.procedure_parameters (see MirTypes).
     *)

    datatype procedure =
      P of {uses_stack	 : bool,
            nr_registers : {gc : int, non_gc : int, fp : int},
            parameters   : MirTypes.procedure_parameters} *
      string * MirTypes.tag * (block) MirTypes.Map.T



    (*  === ANNOTATE AN MIR PROCEDURE ===
     *
     *  Maps a plain MIR procedure onto an annotated one, and may perform
     *  some optimisations in the process.  The annotated procedure may be
     *  changed using the constructors above, but care must be taken to
     *  preserve the validity of the annotations.  Adding or removing
     *  control flow instructions will probably muck them up.
     *)

    val annotate	: MirTypes.procedure -> procedure


    (*  === UNANNOTATE AN MIR PROCEDURE ===
     *
     *  Performs the opposite function to annotate, removing annotations.
     *  (It doesn't remove optimisations, however!)
     *)

    val unannotate	: procedure -> MirTypes.procedure



    (*  === CONVERT ANNOTATED PROCEDURE TO TEXT ===
     *
     *  The Text.T produced is suitable for output using the Diagnostic
     *  module.
     *)

    val to_text		: procedure -> Text.T

  end

