(* mirtables.sml the functor *)
(*
$Log: _mirtables.sml,v $
Revision 1.51  1997/05/13 13:06:08  jont
[Bug #20038]
Add referenced_by_alloc

 * Revision 1.50  1997/01/17  12:56:08  jont
 * Add in use of corrupted_by_alloc on ALLOCATE, SWITCH and ADR
 *
Revision 1.49  1995/05/23  09:53:16  matthew
Improving dynamic allocation

Revision 1.48  1994/11/11  14:17:48  jont
Add immediate store operations

Revision 1.47  1994/09/30  13:09:03  jont
Remove handler register concept

Revision 1.46  1994/08/08  10:09:59  matthew
Change to registers defined by call etc.

Revision 1.45  1994/07/22  10:27:37  matthew
Added function argument register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER
These are used to calculate referenced_by and defined_by

Revision 1.44  1994/04/26  09:52:37  jont
Add handler to referenced set of RAISE

Revision 1.43  1994/03/04  12:31:54  jont
Changes for automatic_callee mechanism removal
and moving machspec from machine to main

Revision 1.42  1993/11/04  18:01:44  jont
Added handling of INTERRUPT instruction

Revision 1.41  1993/11/01  16:31:32  nickh
Merging in structure simplification.

Revision 1.40.1.2  1993/11/01  16:23:55  nickh
Removed unused substructures of MirTables

Revision 1.40.1.1  1993/08/05  10:22:46  jont
Fork for bug fixing

Revision 1.40  1993/08/05  10:22:46  richard
Remove bofus successors function.

Revision 1.39  1993/07/29  11:32:21  richard
Fixed RAISE to define the registers defined by calls, since
raising an exception will call a handler before continuing.

Revision 1.38  1993/04/30  15:42:32  richard
INTERCEPT defines the callee argument.

Revision 1.37  1993/04/28  15:52:26  richard
Changed PROFILE instruction to INTERCEPT.
INTERCEPT references the callee argument.

Revision 1.36  1992/08/26  15:04:47  jont
Removed some redundant structures and sharing

Revision 1.35  1992/08/24  13:35:46  richard
Added NULLARY opcode type and ALLOC_BYTEARRAY.

Revision 1.34  1992/07/27  09:53:47  richard
Changed calls to C to pass a single argument.

Revision 1.33  1992/06/29  09:53:04  clive
Added type annotation information at application points

Revision 1.32  1992/06/18  16:12:43  richard
Added parameter to RAISE once again.

Revision 1.31  1992/06/12  17:20:53  jont
Made PROFILER reference only the explicit register mentioned

Revision 1.30  1992/05/27  13:22:29  richard
Rewrote defined_by and referenced_by to return a triple of register
sets rather than a set of any_registers.

Revision 1.29  1992/04/13  15:13:43  clive
First version of the profiler

Revision 1.28  1992/03/18  15:21:36  clive
ALLOCATE may now take a register argument, added to referenced_by
Added global as defined_by ALLOCATE

Revision 1.27  1992/02/12  13:59:53  richard
Changed register types to reflect changes in MirTypes.
Removed obsolote `substitute' function.

Revision 1.26  1992/02/10  15:56:34  richard
Abolished PREVIOUS_ENVIRONMENT and PRESERVE_ALL_REGS.
Made defined_by more efficient in the case of call instructions.

Revision 1.26  1992/02/05  16:40:56  richard
Abolished PREVIOUS_ENVIRONMENT and PRESERVE_ALL_REGS.
Added corrupted_by.

Revision 1.25  1992/01/31  10:03:02  richard
Changed successors function to distinguish between normal branches
and exception raising.

Revision 1.24  1992/01/16  11:22:37  clive
Alloc may now have a register argument for allocating arrays

Revision 1.23  1992/01/14  14:22:46  jont
Raise no longer has a parameter

Revision 1.22  1991/12/20  11:06:16  richard
Added TBINARYFP to the defined_by function, and made this function
an exhaustive list of cases rather than having a catch-all clause.

Revision 1.21  91/12/05  14:53:19  richard
Added `exits' return from the successors function to show
whether an opcode might exit the procedure.

Revision 1.20  91/12/03  15:12:04  richard
Added successor case for FLOOR.  Added side effects = true for
tagged operations.

Revision 1.19  91/12/02  16:50:56  jont
Added successor information on TAIL_CALL

Revision 1.18  91/12/02  14:28:36  jont
Added tail call operation

Revision 1.17  91/11/20  14:24:50  jont
Added exception generating fp opcodes to tables.
Made matches explicitly exhaustive

Revision 1.16  91/11/19  14:29:12  richard
Changed debugging output to use the Diagnostic module, which
prevents the debugging output strings being constructed even
if they aren't printed.

Revision 1.15  91/11/18  16:22:48  jont
Fixed bug whereby tags in FTEST instructions weren't being followed

Revision 1.14  91/11/14  15:18:10  richard
Removed symbol substitution from substitute_registers.  Added code
for the new CALL_C opcode.

Revision 1.13  91/11/14  10:41:54  richard
Removed references to fp_double registers.

Revision 1.12  91/11/08  16:26:38  richard
Added offset argument to STACKOPs.

Revision 1.11  91/11/07  16:36:34  richard
Removed the assumption that POP has no side effects.

Revision 1.10  91/10/28  15:23:06  richard
Changed the form of the allocation instructions yet again.

Revision 1.9  91/10/28  12:09:04  davidt
ALLOCATE doesn't have a scratch register or a proc_ref any more.

Revision 1.8  91/10/25  14:48:32  richard
Added parameter to NoMapping exception to ease debugging.
Added generalized successors function to trace flow of control.

Revision 1.8  91/10/25  14:48:32  richard
Added a parameter to the NoMapping exception to ease debugging.

Revision 1.7  91/10/21  13:23:48  richard
Added missing BRANCH_AND_LINK clause to referenced_by.

Revision 1.6  91/10/17  15:18:33  jont
New style ALLOC opcodes

Revision 1.5  91/10/16  14:20:36  jont
Updated to reflect extra parameter on ALLOCATEs

Revision 1.4  91/10/15  14:17:04  richard
Moved substitute_registers here from the register allocator functor.

Revision 1.3  91/10/11  10:06:35  richard
Slight alterations to cope with new MirTypes.

Revision 1.2  91/10/10  13:42:45  richard
Removed RESTORE_REGS and PRESERVE_REGS and replaced by
PREVIOUS_ENVIRONMENT and parameterized ENTER. Added
parameterized RAISE.

Revision 1.1  91/10/10  10:25:14  richard
Initial revision

Revision 1.1  91/10/09  15:13:43  richard
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../utils/lists";
require "../utils/crash";
require "mirregisters";
require "mirtables";

functor MirTables (
  structure MirRegisters: MIRREGISTERS
  structure Lists	: LISTS
  structure Crash	: CRASH
) : MIRTABLES =

  struct

    structure MirTypes = MirRegisters.MirTypes

    (*  === LOOK UP SETS OF REGISTERS DEFINED AND REFERENCED ===
     *
     *  Takes an opcode and generates the sets. It's basically a big
     *  look-up table. Some short-hand functions are used to reduce the
     *  size of the table.
     *
     *  NOTE: This table is now complete, I think.
     *)

    local
      open MirTypes

      fun pack {gc, non_gc, fp} =
        {gc     = MirTypes.GC.pack_set gc,
         non_gc = MirTypes.NonGC.pack_set non_gc,
         fp     = MirTypes.FP.pack_set fp}
        
      fun unpack {gc, non_gc, fp} =
        {gc     = MirTypes.GC.unpack_set gc,
         non_gc = MirTypes.NonGC.unpack_set non_gc,
         fp     = MirTypes.FP.unpack_set fp}
        
      val caller_arg = MirRegisters.caller_arg
      val callee_arg = MirRegisters.callee_arg
      val caller_closure = MirRegisters.caller_closure
      val callee_closure = MirRegisters.callee_closure
      val stack = MirRegisters.sp
      val frame = MirRegisters.fp
      val global = MirRegisters.global

      fun reg ({gc, non_gc, fp}, GC_REG r) =
          {gc = GC.Set.add (gc, r), non_gc = non_gc, fp = fp}
        | reg ({gc, non_gc, fp}, NON_GC_REG r) =
          {gc = gc, non_gc = NonGC.Set.add (non_gc, r), fp = fp}

      fun single_reg (GC_REG r) =
          {gc = GC.Set.singleton r, non_gc = NonGC.Set.empty, fp = FP.Set.empty}
        | single_reg (NON_GC_REG r) =
          {gc = GC.Set.empty, non_gc = NonGC.Set.singleton r, fp = FP.Set.empty}

      fun gp ({gc, non_gc, fp}, GP_GC_REG r) =
          {gc = GC.Set.add (gc, r), non_gc = non_gc, fp = fp}
        | gp ({gc, non_gc, fp}, GP_NON_GC_REG r) =
          {gc = gc, non_gc = NonGC.Set.add (non_gc, r), fp = fp}
        | gp (sets, _) = sets

      fun fp ({gc, non_gc, fp}, FP_REG r) =
          {gc = gc, non_gc = non_gc, fp = FP.Set.add (fp, r)}

      fun single_fp (FP_REG r) =
          {gc = GC.Set.empty, non_gc = NonGC.Set.empty, fp = FP.Set.singleton r}

      val empty = {gc = GC.Set.empty, non_gc = NonGC.Set.empty, fp = FP.Set.empty}

      val defined_by_call = reg (unpack MirRegisters.corrupted_by_callee, GC_REG caller_arg)

      val defined_by_alloc = unpack MirRegisters.corrupted_by_alloc
      val referenced_by_alloc = unpack MirRegisters.referenced_by_alloc

      fun merge_any_registers ([],acc) = acc
        | merge_any_registers (GC reg::rest, {gc,non_gc,fp}) =
          merge_any_registers (rest,{gc=GC.Set.add (gc,reg),non_gc=non_gc,fp=fp})
        | merge_any_registers (NON_GC reg::rest, {gc,non_gc,fp}) =
          merge_any_registers (rest,{gc=gc,non_gc=NonGC.Set.add (non_gc,reg),fp=fp})
        | merge_any_registers (FLOAT reg::rest, {gc,non_gc,fp}) =
          merge_any_registers (rest,{gc=gc,non_gc=non_gc,fp=FP.Set.add (fp,reg)})

      val always_referenced_by_call =
        {gc = GC.Set.from_list [caller_closure, stack, frame],
         non_gc = NonGC.Set.empty,
         fp = FP.Set.empty}

      fun referenced_by_call regs =
        merge_any_registers (regs,always_referenced_by_call)

      val always_referenced_by_tail =
        {gc = GC.Set.from_list [MirRegisters.tail_closure,
                                stack, frame],
         non_gc = NonGC.Set.empty,
         fp = FP.Set.empty}

      fun referenced_by_tail regs =
        merge_any_registers (regs,always_referenced_by_tail)

      val always_defined_on_entry = unpack MirRegisters.defined_on_entry

      fun defined_on_entry regs =
        merge_any_registers (regs,always_defined_on_entry)

      val defined_on_exit = unpack MirRegisters.defined_on_exit
    in

      fun defined_by (ENTER regs)                    = defined_on_entry regs
	| defined_by INTERCEPT                       = single_reg (GC_REG callee_arg)
	| defined_by INTERRUPT                       = empty
	| defined_by (UNARY(_, reg1, _))             = single_reg reg1
	| defined_by (NULLARY(_, reg1))              = single_reg reg1
	| defined_by (BINARY(_, reg1, _, _))         = single_reg reg1
	| defined_by (TBINARY(_, _, reg1, _, _))     = single_reg reg1
	| defined_by (BINARYFP(_, fp1, _, _))        = single_fp fp1
	| defined_by (TBINARYFP(_, _, fp1, _, _))    = single_fp fp1
	| defined_by (UNARYFP(_, fp1, _))            = single_fp fp1
	| defined_by (TUNARYFP(_, _, fp1, _))        = single_fp fp1
	| defined_by (STACKOP(POP, reg1, _))         = single_reg reg1
	| defined_by (STACKOP(PUSH, _, _))           = empty
	| defined_by (STOREOP(LD, reg1, _, _))       = single_reg reg1
        | defined_by (STOREOP(ST, _, _, _))          = empty
        | defined_by (IMMSTOREOP(ST, _, _, _))       = empty
	| defined_by (STOREFPOP(FLD, fp1, _, _))     = single_fp fp1
        | defined_by (STOREFPOP(FST, _, _, _))       = empty
	| defined_by (STOREFPOP(FLDREF, fp1, _, _))  = single_fp fp1
        | defined_by (STOREFPOP(FSTREF, _, _, _))    = empty
	| defined_by (STOREOP(LDREF, reg1, _, _))    = single_reg reg1
        | defined_by (STOREOP(STREF, _, _, _))       = empty
        | defined_by (IMMSTOREOP(STREF, _, _, _))    = empty
	| defined_by (STOREOP(LDB, reg1, _, _))      = single_reg reg1
        | defined_by (STOREOP(STB, _, _, _))         = empty
        | defined_by (IMMSTOREOP(STB, _, _, _))      = empty
        | defined_by (IMMSTOREOP _)                  =
	  Crash.impossible"STORE immediate without a store"
	| defined_by (REAL(ITOF, fp1, _))            = single_fp fp1
	| defined_by (FLOOR(FTOI, _, reg1, _))       = single_reg reg1
        (* Adding gp1 is a sort of hack to prevent reg1 and gp1 being coloured together *)
	| defined_by (ALLOCATE(_, reg1,gp1))         = reg (reg (gp (defined_by_alloc, gp1), GC_REG global), reg1)
	| defined_by (ALLOCATE_STACK(_, reg1, _, _)) = single_reg reg1
	| defined_by (ADR(_, reg1, _))               = reg(defined_by_alloc, reg1)
	| defined_by (BRANCH_AND_LINK _)             = defined_by_call
	| defined_by CALL_C                          = defined_by_call
        | defined_by (BRANCH _)                      = empty
        | defined_by (TEST _)                        = empty
        | defined_by (FTEST _)                       = empty
        | defined_by (TAIL_CALL _)                   = empty
        | defined_by (SWITCH _)                      = defined_by_alloc
        | defined_by (DEALLOCATE_STACK _)            = empty
        | defined_by RTS                             = empty
        | defined_by (NEW_HANDLER _)                 = empty
        | defined_by OLD_HANDLER                     = empty
        | defined_by (RAISE _)                       = defined_by_call
        | defined_by (COMMENT _)                     = empty


      fun referenced_by RTS                                 = defined_on_exit
	| referenced_by (BRANCH_AND_LINK(_,REG reg1,_,args))= reg (referenced_by_call args, reg1)
	| referenced_by (BRANCH_AND_LINK(_,_,_,args))       = referenced_by_call args
	| referenced_by (TAIL_CALL(_, REG reg1,args))       = reg (referenced_by_tail args, reg1)
	| referenced_by (TAIL_CALL (_,_,args))              = referenced_by_tail args
	| referenced_by (UNARY(_, _, gp2))                  = gp (empty, gp2)
	| referenced_by (UNARYFP(_, _, fp2))                = single_fp fp2
	| referenced_by (TUNARYFP(_, _, _, fp2))            = single_fp fp2
	| referenced_by (BINARY(_, _, gp2, gp3))            = gp (gp (empty, gp2), gp3)
	| referenced_by (BINARYFP(_, _, fp2, fp3))          = fp (single_fp fp2, fp3)
	| referenced_by (TBINARYFP(_, _, _, fp2, fp3))      = fp (single_fp fp2, fp3)
	| referenced_by (TBINARY(_, _, _, gp2, gp3))        = gp (gp (empty, gp2), gp3)
	| referenced_by (STACKOP(PUSH, reg1, _))            = single_reg reg1
	| referenced_by (STACKOP(POP, _, _))                = empty
	| referenced_by (STOREOP(ST, reg1, reg2, gp3))      = gp (reg (single_reg reg1, reg2), gp3)
	| referenced_by (IMMSTOREOP(ST, gp1, reg2, gp3))    = gp (reg (gp(empty, gp1), reg2), gp3)
	| referenced_by (STOREOP(LD, _, reg2, gp3))         = gp (single_reg reg2, gp3)
	| referenced_by (STOREOP(STREF, reg1, reg2, gp3))   = gp (reg (single_reg reg1, reg2), gp3)
	| referenced_by (IMMSTOREOP(STREF, gp1, reg2, gp3)) = gp (reg (gp(empty, gp1), reg2), gp3)
	| referenced_by (STOREOP(LDREF, _, reg2, gp3))      = gp (single_reg reg2, gp3)
	| referenced_by (STOREOP(STB, reg1, reg2, gp3))     = gp (reg (single_reg reg1, reg2), gp3)
	| referenced_by (IMMSTOREOP(STB, gp1, reg2, gp3))   = gp (reg (gp(empty, gp1), reg2), gp3)
	| referenced_by (STOREOP(LDB, _, reg2, gp3))        = gp (single_reg reg2, gp3)
	| referenced_by (IMMSTOREOP _)                      =
	  Crash.impossible"STORE immediate without a store"
	| referenced_by (STOREFPOP(FST, fp1, reg2, gp3))    = gp (fp (single_reg reg2, fp1), gp3)
	| referenced_by (STOREFPOP(FSTREF, fp1, reg2, gp3)) = gp (fp (single_reg reg2, fp1), gp3)
	| referenced_by (STOREFPOP(FLD, _, reg2, gp3))      = gp (single_reg reg2, gp3)
	| referenced_by (STOREFPOP(FLDREF, _, reg2, gp3))   = gp (single_reg reg2, gp3)
	| referenced_by (REAL(ITOF, _, gp2))                = gp (empty, gp2)
	| referenced_by (FLOOR(FTOI, _, _, fp1))            = single_fp fp1
	| referenced_by (BRANCH(_, REG reg1))               = single_reg reg1
	| referenced_by (BRANCH _)                          = empty
	| referenced_by (TEST(_, _, gp1, gp2))              = gp (gp (empty, gp2), gp1)
	| referenced_by (FTEST(_, _, fp1, fp2))             = fp (single_fp fp1, fp2)
	| referenced_by (SWITCH(_, reg1, _))                = single_reg reg1
	| referenced_by (COMMENT _)                         = empty
	| referenced_by (ENTER _)                           = empty
	| referenced_by INTERCEPT                           = single_reg (GC_REG callee_arg)
	| referenced_by INTERRUPT                           = empty
	| referenced_by (NEW_HANDLER(frame, _)) =
	  single_reg frame
	| referenced_by OLD_HANDLER                         = empty
        | referenced_by (ALLOCATE (_, _, gp1))              = gp (referenced_by_alloc, gp1)
	| referenced_by (ALLOCATE_STACK _)                  = empty
	| referenced_by (DEALLOCATE_STACK _)                = empty
	| referenced_by (ADR _)                             = empty
	| referenced_by (NULLARY _)                         = empty
	| referenced_by CALL_C =
          {gc = GC.Set.from_list [caller_arg, stack, frame],
           non_gc = NonGC.Set.empty,
           fp = FP.Set.empty}
	| referenced_by (RAISE reg1) =
          reg ({gc = GC.Set.from_list [stack, frame],
                non_gc = NonGC.Set.empty,
                fp = FP.Set.empty}, reg1)

    end



    (*  === DOES AN OPCODE HAVE SIDE EFFECTS? ===
     *
     *  Returns true if the opcode does more than just define a
     *  register.
     *)

    local
      open MirTypes
    in

      fun has_side_effects (BINARY _) = false
	| has_side_effects (UNARY _) = false
	| has_side_effects (BINARYFP _) = false
	| has_side_effects (UNARYFP _) = false
	| has_side_effects (STOREOP(LD, _, _, _)) = false
	| has_side_effects (STOREOP(LDB, _, _, _)) = false
	| has_side_effects (STOREOP(LDREF, _, _, _)) = false
	| has_side_effects (REAL _) = false
	| has_side_effects (ALLOCATE _) = false
	| has_side_effects (ALLOCATE_STACK _) = false
	| has_side_effects (ADR _) = false
	| has_side_effects _ = true
    end

  end
