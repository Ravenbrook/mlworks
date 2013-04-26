(*  ==== REGISTER ALLOCATOR ====
 *           SIGNATURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  The register allocator modifies a procedure from using registers drawn
 *  from an infinite set of `virtual' registers to a finite set of `real
 *  register aliases' which correspond to registers on the actual target
 *  processor.  (A mapping from real register aliases to machine registers
 *  is supplied in the MirRegisters module.)  Extra instructions may be
 *  added to the procedure to read and write values in `spill slots' in
 *  order to reduce the number of registers in use at any one time.  The
 *  number of spill slots required is entered in to the procedure parameters
 *  record (see MirTypes).
 *
 *  Diagnostic output levels
 *  ------------------------
 *   0  none
 *   1  procedure tags
 *   2  messages about activities
 *   3  register assignments
 *   4  graphs
 *
 *  Revision Log
 *  ------------
 *  $Log: registerallocator.sml,v $
 *  Revision 1.22  1995/05/30 11:41:04  matthew
 *  Adding debug flag to analyse
 *
 *  Revision 1.21  1993/02/22  16:27:32  nosa
 *  Extra stack spills for local and closure variable inspection
 *  in the debugger.
 *
 *  Revision 1.20  1992/12/08  19:47:54  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.19  1992/06/17  10:08:54  richard
 *  Hints are no longer passed to the graphs.
 *
 *  Revision 1.18  1992/06/11  10:33:31  richard
 *  Added `referenced' parameter to clasher.
 *
 *  Revision 1.17  1992/06/03  16:40:47  richard
 *  The register allocator now exports a mutable graph type which is
 *  acted on directly by the variable analyser.
 *
 *  Revision 1.16  1992/05/27  13:36:59  richard
 *  Changed register Sets to Packs.
 *
 *  Revision 1.15  1992/04/29  13:38:23  richard
 *  Added register merge hints to parameters to register allocator.
 *
 *  Revision 1.14  1992/04/16  13:08:59  richard
 *  Added show_timings.
 *
 *  Revision 1.13  1992/04/09  16:01:12  richard
 *  Removed obsolete Switches structure.
 *
 *  Revision 1.12  1992/03/05  11:39:52  richard
 *  Now returns an annotated procedure rather than a plain one.  This is
 *  to make it easy to feed the results to the stack allocator.
 *
 *  Revision 1.11  1992/02/27  17:13:01  richard
 *  Changed the way virtual registers are handled.  See MirTypes.
 *
 *  Revision 1.10  1992/02/13  11:00:49  richard
 *  Added missing require of mirtypes.
 *
 *  Revision 1.9  1992/02/07  14:29:38  richard
 *  Changed the type of `analyse' to return an unannotated procedure.
 *  See new version (2.1) of functor.
 *
 *  Revision 1.8  1991/11/25  11:11:01  richard
 *  Tidied up.
 *
 *  Revision 1.7  91/11/19  15:37:31  richard
 *  Changed debugging output to use the Diagnostic module, which
 *  prevents the debugging output strings being constructed even
 *  if they aren't printed.
 *  
 *  Revision 1.6  91/10/17  12:37:50  richard
 *  Added Switches structure.
 *  
 *  Revision 1.5  91/10/15  13:28:32  richard
 *  Moved register assignment tables to MirRegisters.
 *  
 *  Revision 1.4  91/10/07  11:53:41  richard
 *  Changed dependency on MachRegisters to MachSpec.
 *  
 *  Revision 1.3  91/10/04  11:24:40  richard
 *  Mappings from virtual to real registers are now exported.
 *  
 *  Revision 1.2  91/10/03  15:28:01  richard
 *  The analyse function now returns four tables which map virtual to
 *  real registers along with the modified code. These should be used to
 *  generate the target machine code.
 *  
 *  Revision 1.1  91/09/27  15:01:26  richard
 *  Initial revision
 *)


require "../utils/diagnostic";
require "mirprocedure";


signature REGISTERALLOCATOR =

  sig

    structure MirProcedure	: MIRPROCEDURE
    structure Diagnostic	: DIAGNOSTIC

    type Graph

    val empty : {gc : int, non_gc : int, fp : int} * bool -> Graph

    val clash :
      Graph ->
      {gc     : MirProcedure.MirTypes.GC.Pack.T,
       non_gc : MirProcedure.MirTypes.NonGC.Pack.T,
       fp     : MirProcedure.MirTypes.FP.Pack.T} *
      {gc     : MirProcedure.MirTypes.GC.Pack.T,
       non_gc : MirProcedure.MirTypes.NonGC.Pack.T,
       fp     : MirProcedure.MirTypes.FP.Pack.T} *
      {gc     : MirProcedure.MirTypes.GC.Pack.T,
       non_gc : MirProcedure.MirTypes.NonGC.Pack.T,
       fp     : MirProcedure.MirTypes.FP.Pack.T} ->
      unit



    (*  === ALLOCATE REGISTERS ===
     *
     *  This module takes a procedure, lists of live register clashes (see
     *  MirVariable signature), and hints as to which registers may be
     *  coloured the same, and returns a procedure which uses virtual
     *  registers which are mapped to real registers by the maps in
     *  MirRegisters.machine_register_assignments.
     *
     *  NOTE: The register annotations in the returned procedure will be
     *  incorrect, but the control flow annotations are preserved.
     *)

    val analyse : 
      MirProcedure.procedure * Graph * {fp:int,gc:int,non_gc:int} * bool ->
      MirProcedure.procedure

  end
