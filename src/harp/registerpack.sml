(*  ==== PACK REGISTERS IN A PROCEDURE ====
 *                SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module analyses a procedure in order to pack the virtual registers
 *  such that they may be used in `packed sets' which have nice properties.
 *  (See virtual register signature.) 
 *
 *  Revision Log
 *  ------------
 *  $Log: registerpack.sml,v $
 *  Revision 1.4  1992/06/18 14:25:06  jont
 *  Added require diagnostic
 *
 *  Revision 1.3  1992/06/16  13:00:35  richard
 *  Added Diagnostic structure to signature.
 *
 *  Revision 1.2  1992/06/09  10:08:51  richard
 *  Exported substitute function for use elsewhere.
 *
 *  Revision 1.1  1992/05/27  10:52:17  richard
 *  Initial revision
 *
 *)


require "../utils/diagnostic";
require "mirtypes";


signature REGISTERPACK =
  sig

    structure MirTypes : MIRTYPES
    structure Diagnostic : DIAGNOSTIC


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

 

    (*  === ANALYSE A PROCEDURE ===
     *
     *  This function analyses a procedure and produces a record containing:
     *    nr_registers  the number of each type of register present
     *    substitute    a function to substitute packed registers in any
     *                  opcode of the procedure.
     *
     *  The packed registers are such that calling the relevant `unpack'
     *  function from the virtual register structure produces an integer in
     *  the range 0 to nr_registers-1.
     *
     *  N.B. The identity of the special registers from MirRegisters is
     *  preserved.
     *)

    val f : MirTypes.procedure ->
            {nr_registers : {gc : int, non_gc : int, fp : int},
             substitute   : MirTypes.opcode -> MirTypes.opcode}

  end
