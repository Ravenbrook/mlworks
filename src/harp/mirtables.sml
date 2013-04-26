(* mirtables.sml the signature *)

(* $Log: mirtables.sml,v $
 * Revision 1.13  1993/11/01 16:31:15  jont
 * Changes for automatic_callee mechanism removal
 * and moving machspec from machine to main
 *
Revision 1.12  1993/11/01  16:31:15  nickh
Merging in structure simplification.

Revision 1.11.1.2  1993/11/01  16:24:11  nickh
Removed unused substructures of MirTables

Revision 1.11.1.1  1993/08/05  10:22:43  jont
Fork for bug fixing

Revision 1.11  1993/08/05  10:22:43  richard
Removed bogus successors function.

Revision 1.10  1993/06/01  14:56:29  nosa
Changed Option.T to Option.opt.

Revision 1.9  1992/05/26  12:44:33  richard
Changed referenced_by and defined_by to return triples of register sets
rather than polymorphic sets of any_registers.

Revision 1.8  1992/02/17  17:18:27  richard
Removed obsolete `substitute' function.

Revision 1.7  1992/01/31  09:25:03  richard
Changed successors to distinguish between normal branches and exceptions.

Revision 1.6  1991/12/05  14:48:17  richard
Added exits return from successors function.

Revision 1.5  91/11/14  11:41:48  richard
Removed symbol substitution code.

Revision 1.4  91/11/14  10:50:13  richard
Removed references to fp_double registers.

Revision 1.3  91/10/25  14:47:19  richard
Added a parameter to the NoMapping exception to ease debugging.
Added a generalized successors function to follow flow control.

Revision 1.2  91/10/15  14:17:08  richard
Added substitute_registers.

Revision 1.1  91/10/09  13:07:24  richard
Initial revision

Copyright (C) 1991 Harlequin Ltd
*)

require "mirtypes";

signature MIRTABLES =

  sig

    structure MirTypes	: MIRTYPES

    (*  === LOOK UP SETS OF REGISTERS DEFINED AND REFERENCED ===
     *
     *  Given a MirTypes.opcode this function returns a tuple of two
     *  sets: the registers defined and the registers referenced.
     *)

    val referenced_by	: MirTypes.opcode -> {gc     : MirTypes.GC.Set.T,
                                              non_gc : MirTypes.NonGC.Set.T,
                                              fp     : MirTypes.FP.Set.T}
    val defined_by	: MirTypes.opcode -> {gc     : MirTypes.GC.Set.T,
                                              non_gc : MirTypes.NonGC.Set.T,
                                              fp     : MirTypes.FP.Set.T}


    (*  === DOES AN OPCODE HAVE SIDE EFFECTS? ===
     *
     *  Returns true if the opcode does more than just define a
     *  register.
     *)

    val has_side_effects : MirTypes.opcode -> bool

  end
