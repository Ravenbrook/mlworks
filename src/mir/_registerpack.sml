(*  ==== PACK REGISTERS IN A PROCEDURE ====
 *                FUNCTOR
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
 *
 *  Revision Log
 *  ------------
 *  $Log: _registerpack.sml,v $
 *  Revision 1.29  1998/02/19 14:52:06  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 * Revision 1.28  1997/05/19  10:00:49  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.27  1997/05/01  13:11:23  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.26  1997/01/03  13:30:33  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.25  1996/12/18  11:59:47  jont
 * [Bug #1857]
 * Fix problems where last sue of a register is a definition
 *
 * Revision 1.24  1996/11/06  11:09:04  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.23  1996/05/07  11:01:58  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.22  1996/04/29  14:48:47  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.21  1996/03/28  11:02:12  matthew
 * Adding where type clause
 *
 * Revision 1.20  1994/11/11  14:20:12  jont
 * Add immediate store operations
 *
 *  Revision 1.19  1994/10/11  12:11:46  matthew
 *  Use inthashtables for efficiency
 *
 *  Revision 1.18  1994/09/30  12:49:00  jont
 *  Remove handler register concept
 *
 *  Revision 1.17  1994/08/25  10:27:51  matthew
 *  Simplifications.
 *
 *  Revision 1.16  1994/07/22  15:43:59  matthew
 *  Added function argument register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER
 *
 *  Revision 1.15  1994/06/08  11:38:04  richard
 *  Fix deep recursion in scan routine.
 *
 *  Revision 1.14  1993/11/05  10:27:54  jont
 *  Added handling of INTERRUPT instruction
 *
 *  Revision 1.13  1993/05/20  21:03:06  nosa
 *  Debugger Environments for local and closure variable inspection
 *  in the debugger.
 *
 *  Revision 1.12  1993/05/18  14:49:20  jont
 *  Removed Integer parameter
 *
 *  Revision 1.11  1993/04/27  13:43:59  richard
 *  Changed PROFILE instruction to INTERCEPT.
 *
 *  Revision 1.10  1993/03/10  17:58:32  matthew
 *  Map substructure is now MirTypes.Map
 *
 *  Revision 1.9  1992/11/03  16:26:58  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.8  1992/10/29  17:55:57  jont
 *  Removed some name clashes caused by open statements by remvoing the
 *  offending opens
 *
 *  Revision 1.7  1992/09/22  09:46:41  clive
 *  Got rid of some handles using tryApply and co
 *
 *  Revision 1.6  1992/08/26  15:09:00  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.5  1992/08/24  13:36:37  richard
 *  Added NULLARY opcode type and ALLOC_BYTEARRAY.
 *
 *  Revision 1.4  1992/06/29  09:54:18  clive
 *  Added type annotation information at application points
 *
 *  Revision 1.3  1992/06/18  16:19:17  richard
 *  Added parameter to RAISE once again.
 *
 *  Revision 1.2  1992/06/17  13:23:01  richard
 *  Merged this module with the preallocator.  The module now does some
 *  preliminary register allocation in order to reduce the number of
 *  virtual registers knocking about and hence improve the performance
 *  of the rest of the optimiser.
 *
 *  Revision 1.1  1992/05/27  14:11:37  richard
 *  Initial revision
 *
 *)

require "../basis/__int";

require "../utils/diagnostic";
require "../utils/crash";
require "../utils/lists";
require "../utils/inthashtable";
require "mirprint";
require "mirtables";
require "mirregisters";
require "registerpack";


functor RegisterPack (
  include sig
  structure Diagnostic   : DIAGNOSTIC
  structure Crash        : CRASH
  structure Lists        : LISTS
  structure IntHashTable : INTHASHTABLE
  structure MirTables    : MIRTABLES
  structure MirRegisters : MIRREGISTERS
  structure MirPrint	 : MIRPRINT

  val full_analysis_threshold : int

  (* Keep this type sharing here for abstraction of VirtualRegister *)
  sharing MirTables.MirTypes = MirRegisters.MirTypes = MirPrint.MirTypes
  sharing MirRegisters.MirTypes.GC.Set.Text = Diagnostic.Text
  end where type MirTables.MirTypes.GC.T = int 
      where type MirTables.MirTypes.NonGC.T = int
      where type MirTables.MirTypes.FP.T = int
    ) : REGISTERPACK =
  struct
    structure MirTypes = MirRegisters.MirTypes
    structure Diagnostic = Diagnostic
    structure Map = MirTypes.Map

    val do_diagnostics = false

    val $ = Diagnostic.Text.from_string
    val ^^ = Diagnostic.Text.concatenate
    infix ^^
    fun diagnostic (level, output_function) =
      Diagnostic.output_text level
      (fn verbosity => $"RegisterPack: " ^^ (output_function verbosity))

    fun crash message = Crash.impossible ("RegisterPack: " ^ message)

    fun reducel f = 
      let
        fun red (acc, []) = acc
          | red (acc, x::xs) = red (f(acc,x), xs)
      in 
        red
      end

    fun assignment_to_text assignment =
      reducel (fn (text, (reg, r)) => text ^^ $"\n" ^^ MirTypes.GC.to_text reg ^^ $" -> " ^^ $(Int.toString r))
      ($"GC assignments", IntHashTable.to_list assignment)

    fun fp_assignment_to_text assignment =
      reducel (fn (text, (reg, r)) => text ^^ $"\n" ^^ MirTypes.FP.to_text reg ^^ $" -> " ^^ $(Int.toString r))
      ($"FP assignments", IntHashTable.to_list assignment)

    fun table_update (map,x,y) = (IntHashTable.update (map,x,y);map)

    fun table_from_list l =
      let
        val table = IntHashTable.new (Lists.length l)
        fun aux [] = ()
          | aux ((i,x)::l) =
            (IntHashTable.update (table,i,x);
             aux l)
        val _ = aux l
      in
        table
      end

    fun substitute {gc, non_gc, fp} =
      let
        open MirTypes

        fun any (GC r) = GC (gc r)
          | any (NON_GC r) = NON_GC (non_gc r)
          | any (FLOAT r) = FLOAT (fp r)

        val gp = fn GP_GC_REG r     => GP_GC_REG (gc r)
                  | GP_NON_GC_REG r => GP_NON_GC_REG (non_gc r)
                  | other => other

        val reg = fn GC_REG r     => GC_REG (gc r)
                   | NON_GC_REG r => NON_GC_REG (non_gc r)

        val fp = fn FP_REG r => FP_REG (fp r)

      in
        fn TBINARY   (operator, tag, reg1, gp1, gp2) => TBINARY   (operator, tag, reg reg1, gp gp1, gp gp2)
         | BINARY    (operator, reg1, gp1, gp2)      => BINARY    (operator, reg reg1, gp gp1, gp gp2)
         | UNARY     (operator, reg1, gp1)           => UNARY     (operator, reg reg1, gp gp1)
         | NULLARY   (operator, reg1)                => NULLARY   (operator, reg reg1)
         | TBINARYFP (operator, tag, fp1, fp2, fp3)  => TBINARYFP (operator, tag, fp fp1, fp fp2, fp fp3)
         | TUNARYFP  (operator, tag, fp1, fp2)       => TUNARYFP  (operator, tag, fp fp1, fp fp2)
         | BINARYFP  (operator, fp1, fp2, fp3)       => BINARYFP  (operator, fp fp1, fp fp2, fp fp3)
         | UNARYFP   (operator, fp1, fp2)            => UNARYFP   (operator, fp fp1, fp fp2)
         | STACKOP   (operator, reg1, offset)        => STACKOP   (operator, reg reg1, offset)
         | STOREOP   (operator, reg1, reg2, gp1)     => STOREOP   (operator, reg reg1, reg reg2, gp gp1)
         | IMMSTOREOP(operator, gp1, reg2, gp3)      => IMMSTOREOP(operator, gp gp1, reg reg2, gp gp3)
         | STOREFPOP (operator, fp1, reg1, gp1)      => STOREFPOP (operator, fp fp1, reg reg1, gp gp1)
         | REAL      (operator, fp1, gp1)            => REAL      (operator, fp fp1, gp gp1)
         | FLOOR     (operator, tag, reg1, fp1)      => FLOOR     (operator, tag, reg reg1, fp fp1)
         | BRANCH    (operator, REG reg1)            => BRANCH    (operator, REG (reg reg1))
         | TEST      (operator, tag, gp1, gp2)       => TEST      (operator, tag, gp gp1, gp gp2)
         | FTEST     (operator, tag, fp1, fp2)       => FTEST     (operator, tag, fp fp1, fp fp2)
         | TAIL_CALL (operator, REG reg1,regs)       => TAIL_CALL (operator, REG (reg reg1),map any regs)
         | TAIL_CALL (operator, x, regs)             => TAIL_CALL (operator, x, map any regs)
         | SWITCH    (operator, reg1, tags)          => SWITCH    (operator, reg reg1, tags)
         | ALLOCATE  (operator, reg1, gp1)           => ALLOCATE  (operator, reg reg1, gp gp1)
         | ADR       (operator, reg1, tag)           => ADR       (operator, reg reg1, tag)
         | RAISE     reg1                            => RAISE     (reg reg1)
         | ALLOCATE_STACK  (operator, reg1, amount, offset) => ALLOCATE_STACK (operator, reg reg1, amount, offset)
         | BRANCH_AND_LINK (operator, REG reg1,debug,regs)  => BRANCH_AND_LINK (operator, REG (reg reg1),debug,map any regs)
         | BRANCH_AND_LINK (operator,x,debug,regs)  => BRANCH_AND_LINK (operator,x,debug,map any regs)
         | opcode as INTERCEPT 		=> opcode
         | opcode as INTERRUPT 		=> opcode
         | opcode as ENTER regs         => ENTER (map any regs)
         | opcode as RTS                => opcode
         | opcode as NEW_HANDLER(frame, tag)      =>
	     NEW_HANDLER(reg frame, tag)
         | opcode as OLD_HANDLER        => opcode
         | opcode as DEALLOCATE_STACK _ => opcode
         | opcode as CALL_C             => opcode
         | opcode as BRANCH _           => opcode
         | opcode as COMMENT _          => opcode
      end



    (*  === SCAN OPCODES TO DETERMINE REGISTER USAGE ===
     *
     *  There are two sorts of register usage to consider: whether registers
     *  are confined to a single block, and the lifespans of registers.  The
     *  function `scan' determines both of these.
     *
     *  The confining information is stored in a map called `uses' which
     *  contains ONCE of the register has been used in a single block, MANY
     *  if it has been used in more than one, and FIXED for registers which
     *  can't be renamed anyway.  It is updated and augmented by scan.
     *
     *  The lifespan information is produced in a list of the form
     *   [(first, last), (first, last), ...]
     *  where first and last are the lists of first-used and last-used GC
     *  registers corresponding to the opcode list passed to scan.
     *)

    datatype uses = ONCE of MirTypes.tag | MANY | FIXED

    (* The preassigned registers may not be renamed, and so are defined as *)
    (* FIXED in the uses maps. *)

    local
      val fix =
        let
          val fixed = ref FIXED
        in
          map (fn reg => (reg, fixed))
        end
      val gc = fix (MirTypes.GC.Pack.to_list (#gc MirRegisters.preassigned))
      val non_gc = fix (MirTypes.NonGC.Pack.to_list (#non_gc MirRegisters.preassigned))
      val fp = fix (MirTypes.FP.Pack.to_list (#fp MirRegisters.preassigned))
    in
      fun make_initial_uses () =
        {gc     = table_from_list gc,
         non_gc = table_from_list non_gc,
         fp     = table_from_list fp}
    end

    fun scan ((uses, lifespans), MirTypes.BLOCK (tag, opcodes)) =
      let
        local
          val count_gc = MirTypes.GC.Set.reduce
            (fn (uses, reg) =>
             (case IntHashTable.tryLookup (uses, reg) of
                SOME x => 
                  ((case x of 
                      ref MANY  => ()
                    | ref FIXED => ()
                    | other as ref (ONCE tag') => if tag=tag' then () else other := MANY);
                   uses)
              | _ =>
                  table_update (uses, reg, ref (ONCE tag))))

          val count_non_gc = MirTypes.NonGC.Set.reduce
            (fn (uses, reg) =>
             (case IntHashTable.tryLookup (uses, reg) of
                SOME x => 
                  ((case x of 
                      ref MANY  => ()
                    | ref FIXED => ()
                    | other as ref (ONCE tag') => if tag=tag' then () else other := MANY);
                   uses)
              | _ =>
                  table_update (uses, reg, ref (ONCE tag))))

          val count_fp = MirTypes.FP.Set.reduce
            (fn (uses, reg) =>
             (case IntHashTable.tryLookup (uses, reg) of
                SOME x => 
                  ((case x of 
                      ref MANY  => ()
                    | ref FIXED => ()
                    | other as ref (ONCE tag') => if tag=tag' then () else other := MANY);
                   uses)
              | _ =>
                  table_update(uses, reg, ref (ONCE tag))))
        in
          fun count ({gc = gc_uses, non_gc = non_gc_uses, fp = fp_uses},
                     {gc = gc_touched, non_gc = non_gc_touched, fp = fp_touched}) =
            {gc = count_gc (gc_uses, gc_touched),
             non_gc = count_non_gc (non_gc_uses, non_gc_touched),
             fp = count_fp (fp_uses, fp_touched)}
        end

        fun union_diff (map, set) =
          MirTypes.GC.Set.reduce
          (fn ((map, new), reg) =>
           (case IntHashTable.tryLookup (map, reg) of
              SOME () => (map, new) 
            | _ => (table_update (map, reg, ()), reg::new)))
          ((map, []), set)

        fun backward (uses, lifespans, referenced, []) = (uses, lifespans)
          | backward (uses, lifespans, referenced, (opcode, first)::rev_opcodes_firsts) =
            let
              val referenced_here as {gc = gc_referenced_here, ...} =
		MirTables.referenced_by opcode
	      (* We want to treat definitions as references *)
	      (* in order to avoid problems with definitions that are never used *)
	      (* but whose instructions cause side effects, eg clean or add *)
	      (* We only update gc_referenced_here as this is *)
	      (* the only value used by the lifespans stuff *)
	      (* The uses stuff actually counts all occurrences *)
	      val defined_here as {gc = gc_defined_here, ...} =
		MirTables.defined_by opcode
	      val gc_referenced_here =
		MirTypes.GC.Set.union(gc_referenced_here, gc_defined_here)
              val (referenced, last) = union_diff (referenced, gc_referenced_here)
              val uses = count (uses, referenced_here)
            in
              backward (uses,
                        case (first, last) of
                          ([], []) => lifespans
                        | _ => (first, last)::lifespans,
                        referenced,
                        rev_opcodes_firsts)
            end

        fun forward (rev_opcodes_firsts, uses, defined, []) =
	  backward (uses, lifespans, IntHashTable.new 8, rev_opcodes_firsts)
          | forward (rev_opcodes_firsts, uses, defined, opcode::opcodes) =
            let
              val defined_here as {gc = gc_defined_here, ...} = MirTables.defined_by opcode
              val (defined, first) = union_diff (defined, gc_defined_here)
              val uses = count (uses, defined_here)
            in
              forward ((opcode, first)::rev_opcodes_firsts, uses, defined, opcodes)
            end

      in
        forward ([], uses, IntHashTable.new 8, opcodes)
      end

    (*  === ASSIGN PACKED REGISTERS ===
     *
     *  The information computed by scanning the blocks is used to produce
     *  packed virtual registers from the registers in the opcodes
     *  passed to this module.
     *)

    (* The preassigned registers are already assigned to themselves. *)

    local 
      fun double r = (r,r)
      val gc = (map double (MirTypes.GC.Pack.to_list (#gc MirRegisters.preassigned)))
      val non_gc = (map double (MirTypes.NonGC.Pack.to_list (#non_gc MirRegisters.preassigned)))
      val fp = (map double (MirTypes.FP.Pack.to_list (#fp MirRegisters.preassigned)))
    in
      fun make_initial_assignments () =
        {gc     = table_from_list gc,
         non_gc = table_from_list non_gc,
         fp     = table_from_list fp}
    end

    fun assign (uses, lifespans) =
      let
        val _ = 
          if do_diagnostics
            then
              diagnostic (4, fn _ =>
                          let
                            val reduce = reducel (fn (text, reg) => text ^^ $" " ^^ MirTypes.GC.to_text reg)
                          in
                            reducel
                            (fn (text, (first, last)) => reduce (reduce (text ^^ $"\n", first) ^^ $" / ", last))
                            ($"assigning for lifespans", lifespans)
                          end)
          else ()

        val initial_assignments = make_initial_assignments ()

        (* Assign the registers used across blocks naively, giving each a *)
        (* new packed register.  Assign _all_ the non GC and FP registers *)
        (* this way, as it is not worth doing any further analysis on them. *)
        (* nr_packable is the number of GC registers which are confined to a *)
        (* single block, and threshold is the first packing number available *)
        (* after the naive assignment. *)

        val (nr_packable, threshold, nr_registers, assignments) =
          let
            fun assign' (assignment, next, map) =
              reducel
              (fn ((assignment, next, others), (reg, ref MANY))     =>
	       (table_update (assignment, reg, next), next+1, others)
                | ((assignment, next, others), (reg, ref (ONCE _))) =>
		    (assignment, next, others+1)
                | ((assignment, next, others), (reg, ref FIXED))    =>
		    (assignment, next, others))
              ((assignment, next, 0), IntHashTable.to_list map)

            fun assign_simple_non_gc' (assignment, next, map) =
              (reducel
               (fn ((assignment, next), (reg, ref FIXED)) => (assignment,next)
                 | ((assignment, next), (reg, _)) =>
		(table_update (assignment, reg, next), next+1))
               ((assignment, next), IntHashTable.to_list map))

            fun assign_simple_fp' (assignment, next, map) =
              (reducel
               (fn ((assignment, next), (reg, ref FIXED)) => (assignment,next)
                 | ((assignment, next), (reg, _)) =>
		(table_update (assignment, reg, next), next+1))
               ((assignment, next), IntHashTable.to_list map))

            val {gc = gc_uses, non_gc = non_gc_uses, fp = fp_uses} = uses

            val (gc_assignment, next, nr_packable) =
              assign' (#gc initial_assignments, #gc MirRegisters.pack_next, gc_uses)

            val (non_gc_assignment, nr_non_gc) =
              assign_simple_non_gc' (#non_gc initial_assignments, #non_gc MirRegisters.pack_next, non_gc_uses)

            val (fp_assignment, nr_fp) =
              assign_simple_fp' (#fp initial_assignments, #fp MirRegisters.pack_next, fp_uses)
          in
            (nr_packable, next,
             {gc = next, non_gc = nr_non_gc, fp = nr_fp},
             {gc = gc_assignment, non_gc = non_gc_assignment, fp = fp_assignment})
          end

        (* Now use the lifespan information on the GC registers to merge *)
        (* them together and so reduce their total number. *)

        val (nr_registers', assignments') =
          let
            val alive = MLWorks.Internal.Array.array (threshold + nr_packable, false)

            fun merge (assignment, next, []) = (next, assignment)
              | merge (assignment, next, (first,last)::rest) =
                let
                  (* For each first-use register look for a dead register *)
                  (* above the packing threshold which it can be merged *)
                  (* with, and resurrect it. *)

                  val (assignment', next') =
                    reducel
                    (fn ((assignment, next), reg) =>
                     (case IntHashTable.tryLookup (assignment, reg) of
                        SOME _ => (assignment, next)
                      | _ =>
                          let
                            fun find_dead n =
                              if n = next then
                                (MLWorks.Internal.Array.update (alive, next, true);
                                 (table_update
				  (assignment, reg, next), next+1))
                              else
                                if MLWorks.Internal.Array.sub (alive, n) then
                                  find_dead (n+1)
                                else
                                  (MLWorks.Internal.Array.update (alive, n, true);
                                   (table_update
				    (assignment, reg, n), next))
                          in
                            find_dead threshold
                          end))
                    ((assignment, next), first)
                  (* Mark all last-use registers as dead. *)

                  val _ =
                    Lists.iterate
                    (fn reg =>
                     MLWorks.Internal.Array.update (alive, 
                                   IntHashTable.lookup (assignment, reg), false)
                     handle IntHashTable.Lookup   =>
		       crash ("The unassigned register " ^
			      MirTypes.GC.to_string reg ^ " has died.")
                          | MLWorks.Internal.Array.Subscript =>
			      crash ("Register " ^ MirTypes.GC.to_string reg ^
				     " was assigned outside " ^
				     "the alive array."))
                    last
                in
                  merge (assignment', next', rest)
                end

            val {gc, non_gc, fp} = assignments
            val {non_gc = nr_non_gc, fp = nr_fp, ...} = nr_registers
            val (nr_gc, gc_assign) = merge (gc, threshold, lifespans)

            val _ = 
              if do_diagnostics
                then 
                  diagnostic (2, fn _ =>
                              $"originally " ^^ $(Int.toString (threshold + nr_packable)) ^^ $" GC registers")
              else ()
          in
            ({gc = nr_gc,     non_gc = nr_non_gc, fp = nr_fp},
             {gc = gc_assign, non_gc = non_gc,    fp = fp})
          end

      in
        (nr_registers', assignments')
      end



    (*  === PACK REGISTERS SIMPLY ===
     *
     *  For small procedures the complex analysis above is probably
     *  overkill.  This function scans the blocks and simply assigns
     *  distinct virtual registers to distinct packed registers.
     *)

    local
      fun assign_gc ((next, map), reg) =
        (case IntHashTable.tryLookup (map, reg) of
           SOME _ => (next, map)
         | _ =>
             (next+1, table_update (map, reg, next)))
      fun assign_non_gc ((next, map), reg) =
        (case IntHashTable.tryLookup (map, reg) of
           SOME _ => (next, map)
         | _ => (next+1, table_update (map, reg, next)))
      fun assign_fp ((next, map), reg) =
        (case IntHashTable.tryLookup (map, reg) of
           SOME _ => (next, map)
         | _ => (next+1, table_update (map, reg, next)))

      val gc_assign     = MirTypes.GC.Set.reduce    assign_gc
      val non_gc_assign = MirTypes.NonGC.Set.reduce assign_non_gc
      val fp_assign     = MirTypes.FP.Set.reduce    assign_fp
    in

      fun pack_simply ((nr_registers, assignments), MirTypes.BLOCK (_, opcodes)) =
        let
          fun scan (nr_registers, assignments, []) = (nr_registers, assignments)
            | scan ({gc = gc_nr, non_gc = non_gc_nr, fp = fp_nr},
                    {gc = gc_map, non_gc = non_gc_map, fp = fp_map},
                    opcode::opcodes) =
              let
                val {gc, non_gc, fp} = MirTables.defined_by opcode

                val (gc_nr',     gc_map')     = gc_assign     ((gc_nr,     gc_map),     gc)
                val (non_gc_nr', non_gc_map') = non_gc_assign ((non_gc_nr, non_gc_map), non_gc)
                val (fp_nr',     fp_map')     = fp_assign     ((fp_nr,     fp_map),     fp)
              in
                scan ({gc = gc_nr', non_gc = non_gc_nr', fp = fp_nr'},
                      {gc = gc_map', non_gc = non_gc_map', fp = fp_map'},
                      opcodes)
              end
        in
          scan (nr_registers, assignments, opcodes)
        end

    end


    fun f (MirTypes.PROC (name, start_tag, _, blocks,_)) =
      let
        val _ = 
          if do_diagnostics
            then diagnostic (1, fn _ => $"procedure " ^^ $(MirTypes.print_tag start_tag) ^^ $": " ^^ $name)
          else ()

        val longest =
          reducel (fn (longest, MirTypes.BLOCK (_, opcodes)) =>
                         let
                           val length = Lists.length opcodes
                         in
                           if length > longest then length else longest
                         end) (0, blocks)

        val _ = 
          if do_diagnostics
            then diagnostic (2, fn _ => $"longest block " ^^ $(Int.toString longest))
          else ()

        val do_full_analysis = longest > full_analysis_threshold

        val _ = if do_full_analysis andalso do_diagnostics
                  then diagnostic (2,
                                   fn _ =>
                                   $"Full analysis for " ^^ $ name ^^ $":" ^^
                                   $(Int.toString longest))
                else ()

        val (nr_registers, assignments) =
          if do_full_analysis 
            then (assign (reducel scan ((make_initial_uses(), []), blocks)))
          else
            (reducel pack_simply ((MirRegisters.pack_next, make_initial_assignments()), blocks))

        val _ = 
          if do_diagnostics
            then diagnostic (2, fn _ => $(Int.toString (#gc nr_registers)) ^^ $" GC registers")
          else ()

        val _ = 
          if do_diagnostics
            then diagnostic (3, fn _ => assignment_to_text (#gc assignments))
          else ()

        val _ = 
          if do_diagnostics
            then diagnostic (3, fn _ => fp_assignment_to_text (#fp assignments))
          else ()

        val register_mappings =
          let
            val {gc, non_gc, fp} = assignments
            val gc'     = fn r => case IntHashTable.tryLookup (gc,r) of SOME g => g | _ => crash ("GC lookup failed for " ^ MirTypes.GC.to_string r)
            val non_gc' = fn r => case IntHashTable.tryLookup (non_gc,r) of SOME g => g | _ => crash ("Non-GC lookup failed for " ^ MirTypes.NonGC.to_string r)
            val fp'     = fn r => case IntHashTable.tryLookup (fp,r) of SOME g => g | _ => crash ("FP lookup failed for " ^ MirTypes.FP.to_string r)
          in
            {gc     = fn reg => gc' reg,
             non_gc = fn reg => non_gc' reg,
             fp     = fn reg => fp' reg}
          end
      in
        {nr_registers = nr_registers,
         substitute = substitute register_mappings}
      end

  end
