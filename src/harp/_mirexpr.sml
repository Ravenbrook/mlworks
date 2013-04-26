(*  ==== MIR Expression analyser ====
 *          FUNCTOR
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *  $Log: _mirexpr.sml,v $
 *  Revision 1.25  1999/02/02 16:01:11  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.24  1997/12/23  11:51:29  jont
 * [Bug #70038]
 * Make sure we don't prefer stack based virtual registers to real ones
 *
 * Revision 1.23  1997/01/15  13:02:49  matthew
 * Tagged ops have a tag list
 *
 * Revision 1.22  1996/12/04  17:30:11  matthew
 * Removing references to MLWorks.Option
 *
 * Revision 1.21  1996/11/06  11:08:15  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.20  1996/04/29  14:47:22  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.19  1995/12/20  13:46:16  jont
 * Removing Option in favour of MLWorks.Option
 *
 * Revision 1.18  1995/04/28  09:32:49  matthew
 * Improving handling of ANY 0
 *
Revision 1.17  1995/01/05  11:23:54  matthew
Rationalizing debugger

Revision 1.16  1994/11/22  12:12:47  jont
Fix problems with potential branches out of floor etc.
Also handle TBINARY, TFPBINARY, TFPUNARY

Revision 1.15  1994/11/18  10:29:15  jont
Fix bug whereby non-constants got into store immediates

Revision 1.14  1994/11/16  17:28:51  jont
Do store immediate formation after copy propagation

Revision 1.13  1994/11/16  14:03:54  jont
Fix deletion of wrong instructions when the one targetted is side-effecting

Revision 1.12  1994/11/16  12:02:50  jont
Add immediate store operations

Revision 1.11  1994/11/15  16:48:30  matthew
Added check of side-effect freeness before removing instructions in analyse_proc3

Revision 1.10  1994/10/13  11:15:03  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.9  1994/09/30  12:51:37  jont
Remove handler register concept

Revision 1.8  1994/09/20  09:46:50  matthew
Added special function for copy-propagation before register colouring.  This ignores moves to
preassigned registers as this makes colouring preferencing harder.

Revision 1.7  1994/08/08  09:54:14  matthew
Added zero register optimization
Added simple_transform function

Revision 1.6  1994/07/21  16:21:11  matthew
Added function argument register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER

Revision 1.5  1994/06/28  10:55:29  jont
Prevent spill retention across alloc

Revision 1.4  1994/06/17  11:34:28  jont
Removed function with inexhaustive match, it wasn't used anyway

Revision 1.3  1994/06/10  09:48:53  jont
Fix incorrect register discarding before floating point comparisons

Revision 1.2  1994/04/26  09:50:48  jont
Changed handling of RAISE to be more like BRANCH, as there may be
local handlers and register allocation across them

Revision 1.1  1994/04/12  14:43:48  jont
new file

 *)

require "../utils/lists";
require "../utils/crash";
require "mirtables";
require "mirregisters";
require "mirprint";
require "../main/machspec";
require "mirexpr";


functor MirExpr(
  structure Lists		: LISTS
  structure Crash               : CRASH
  structure MirTables		: MIRTABLES
  structure MirRegisters	: MIRREGISTERS
  structure MirPrint		: MIRPRINT
  structure MachSpec            : MACHSPEC

  sharing
    MirTables.MirTypes = MirPrint.MirTypes = MirRegisters.MirTypes
) : MIREXPR =

  struct
    structure MirTypes = MirTables.MirTypes

    val defined_by_call =
      #gc
      (MirTables.defined_by
       (MirTypes.BRANCH_AND_LINK
	(MirTypes.BLR, MirTypes.TAG (MirTypes.new_tag()), MirTypes.Debugger_Types.NOP,[])))

    fun gp_from_reg(MirTypes.GC_REG reg) = MirTypes.GP_GC_REG reg
      | gp_from_reg(MirTypes.NON_GC_REG reg) = MirTypes.GP_NON_GC_REG reg

    fun rev_app([], acc) = acc
      | rev_app(x :: xs, acc) = rev_app(xs, x :: acc)

    datatype result =
      REMOVE
    | LEAVE
    | REPLACE of MirTypes.opcode

    fun reverse_assoc(_, []) = NONE
      | reverse_assoc(x, (y, z) :: rest) =
	if x = z then SOME y else reverse_assoc(x, rest)
	  
    fun remove_reg(rn, regs) =
      Lists.filter_outp (fn (reg, _) => reg = rn) regs
      
    fun remove_gp(gp, regs) =
      Lists.filter_outp (fn (_, g) => g = gp) regs
      
    fun remove_reg_and_tuple(rn, regs) =
      (remove_reg(rn, regs), LEAVE)
      
    fun remove_call_defined_regs regs =
      MirTypes.GC.Set.reduce
      (fn (regs, reg) => remove_reg(MirTypes.GC_REG reg, regs))
      (regs, defined_by_call)

    fun analyse_instr(regs, MirTypes.TBINARY(_, _, rn, _, _)) = remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.BINARY(_, rn, _, _)) = remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.UNARY(_, rn, _)) = remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.NULLARY(_, rn)) = remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.TBINARYFP _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.TUNARYFP _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.BINARYFP _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.UNARYFP _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.STACKOP(stack_op, rn, _)) =
	(case stack_op of
	   MirTypes.POP => remove_reg_and_tuple(rn, regs)
	 | _ => (regs, LEAVE))
      | analyse_instr(regs, MirTypes.STOREOP(store_op, rn, rm, gp)) =
	(case store_op of
	   MirTypes.STREF =>
	     if rm = MirTypes.GC_REG(MirRegisters.fp) then
	       (case gp of
		  MirTypes.GP_IMM_SYMB(MirTypes.GC_SPILL_SLOT(MirTypes.SIMPLE i)) =>
		    ((rn, gp) :: remove_gp(gp, remove_reg(rn, regs)), LEAVE)
		| _ => (regs, LEAVE))
	     else
	       (regs, LEAVE)
	 | MirTypes.LDREF =>
	     if rm = MirTypes.GC_REG(MirRegisters.fp) then
	       if Lists.member((rn, gp), regs) then
		 ((*output(std_out, "Found redundant reload of spill slot " ^
		   Int.toString(case gp of MirTypes.GP_IMM_SYMB(MirTypes.GC_SPILL_SLOT(MirTypes.SIMPLE i)) => i) ^ "\n");*)
		  (regs, REMOVE) (* We've found a reload of a spill *))
	       else
		 (* This is a potential unspill definition *)
		 (case gp of
		    MirTypes.GP_IMM_SYMB(MirTypes.GC_SPILL_SLOT(MirTypes.SIMPLE i)) =>
		      let
			val x = reverse_assoc(gp, regs)
		      in
			case x of
			  NONE => ((rn, gp) :: remove_reg(rn, regs), LEAVE)
			| SOME rm =>
			    ((*output(std_out, "Found reload of spill " ^
			      Int.toString i ^
			      ", replacing by MOVE\n");*)
			     ((rn, gp) :: remove_reg(rn, regs),
			      REPLACE(MirTypes.UNARY(MirTypes.MOVE, rn, gp_from_reg rm))))
		      end
		  | _ => (regs, LEAVE))
	     else
	       remove_reg_and_tuple(rn, regs)
	 | MirTypes.LD => remove_reg_and_tuple(rn, regs)
	 | MirTypes.LDB => remove_reg_and_tuple(rn, regs)
	 | _ => (regs, LEAVE))
      | analyse_instr(regs, MirTypes.IMMSTOREOP _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.STOREFPOP _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.REAL _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.FLOOR(_, _, rn, _)) = remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.BRANCH _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.TEST _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.FTEST _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.BRANCH_AND_LINK _) =
	(remove_call_defined_regs regs, LEAVE) (* All bets off now (not quite) *)
      | analyse_instr(regs, MirTypes.TAIL_CALL _) =
	([], LEAVE) (* All bets off now *)
      | analyse_instr(regs, MirTypes.CALL_C) =
	(remove_call_defined_regs regs, LEAVE) (* All bets off now (not quite) *)
      | analyse_instr(regs, MirTypes.SWITCH _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.ALLOCATE(_, rn, _)) =
	(remove_call_defined_regs regs, LEAVE) (* All bets off now (not quite) *)
(* Could improve to delete registers corrupted by call
 * Similarly for BRANCH_AND_LINK
	remove_reg_and_tuple(rn, regs)
*)
      | analyse_instr(regs, MirTypes.ALLOCATE_STACK(_, rn, _, _)) =
	remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.DEALLOCATE_STACK _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.ADR(_, rn, _)) = remove_reg_and_tuple(rn, regs)
      | analyse_instr(regs, MirTypes.INTERCEPT) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.INTERRUPT) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.ENTER _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.RTS) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.NEW_HANDLER _) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.OLD_HANDLER) = (regs, LEAVE)
      | analyse_instr(regs, MirTypes.RAISE _) =
	([], LEAVE) (* All bets off now *)
      | analyse_instr(regs, MirTypes.COMMENT _) = (regs, LEAVE)
	
    fun analyse_block([], done, regs) = rev done
      | analyse_block(instr :: instrs, done, regs) =
	let
	  val (regs, result) = analyse_instr(regs, instr)
	  val done =
	    case result of
	      LEAVE => instr :: done
	    | REMOVE => done
	    | REPLACE instr => instr :: done
	in
	  analyse_block(instrs, done, regs)
	end
      
    fun analyse_proc1 block_list =
      map
      (fn (MirTypes.BLOCK(tag, instrs)) => MirTypes.BLOCK(tag, analyse_block(instrs, [], [])))
      block_list
      
    fun forward_assoc(_, []) = NONE
      | forward_assoc(x, (y, z) :: rest) =
	if x = y then SOME z else forward_assoc(x, rest)
	  
    fun remove_def_and_use(rn, regs) =
      Lists.filter_outp
      (fn (x, y) => x = rn orelse y = rn)
      regs
      
(*Not used anyway
    fun get_gc(MirTypes.GC_REG r) = r
*)
    fun update_regs_table(regs, new, old) =
      if new = old then
	((*output(std_out, "Found move to self of " ^
	  MirTypes.GC.to_string(get_gc old) ^ " to " ^
	  MirTypes.GC.to_string(get_gc new) ^ "\n");*)
	 regs)
      else
	(new, old) :: remove_def_and_use(new, regs)
	
    fun print_gc_reg(MirTypes.GC_REG rn) =
      MirTypes.GC.to_string rn
      | print_gc_reg _ = Crash.impossible"print_gc_reg applied to non-GC"

    val gc_assignemnts = #gc MirRegisters.machine_register_assignments

    fun alloc_order(a, b) =
      let
	val mach_a = MirTypes.GC.Map.tryApply'(gc_assignemnts, a)
	val mach_b = MirTypes.GC.Map.tryApply'(gc_assignemnts, b)
      in
	case (mach_a, mach_b) of
	  (NONE, _) => false
	| (SOME _, NONE) => true
	| _ => (#gc MirRegisters.allocation_order)(a, b)
      end

    (* We put effort into using the registers we want to allocate most *)
    (* On the Intel, this avoids us propagating stack based virtual registers *)
    (* in favour of register based ones *)

    fun better(best as MirTypes.GC_REG r1, current as MirTypes.GC_REG rn) =
      ((*print("Applying alloc_order to " ^ print_gc_reg best ^ " and " ^ print_gc_reg current ^
	     ", choosing " ^ print_gc_reg(if alloc_order(r1, rn) then best else current) ^ "\n");*)
      if alloc_order(r1, rn) then best else current)
      | better _ = Crash.impossible"MirExpr:better: called on non GC regs"

    fun follow(best, rn, regs) =
      case forward_assoc(rn, regs) of
	SOME rm => follow(better(best, rm), rm, regs)
      | _ => SOME best
	  
    fun lookup_first(rn, regs) =
      case forward_assoc(rn, regs) of
	SOME rm => follow(better(rn, rm), rm, regs)
      | x => x
	  
    fun replace_reg(rn, regs) =
      case lookup_first(rn, regs) of
	SOME rm => rm
      | _ => rn
	  
    fun replace_gp(gp, regs) =
      case gp of
	MirTypes.GP_GC_REG r =>
	  (case lookup_first(MirTypes.GC_REG r, regs) of
	     SOME s => gp_from_reg s
	   | _ => gp)
      | _ => gp
	  
    fun analyse_instr(regs, MirTypes.TBINARY(opcode, tag, rn, gp1, gp2)) =
      let
	val instr = MirTypes.TBINARY(opcode, tag, rn, replace_gp(gp1, regs), replace_gp(gp2, regs))
      in
	(remove_def_and_use(rn, regs), instr)
      end
      | analyse_instr(regs, MirTypes.BINARY(opcode, rn, gp1, gp2)) =
	let
	  val instr = MirTypes.BINARY(opcode, rn, replace_gp(gp1, regs), replace_gp(gp2, regs))
	in
	  (remove_def_and_use(rn, regs), instr)
	end
      | analyse_instr(regs, MirTypes.UNARY(opcode, rn, gp)) =
	(case (opcode, gp) of
	   (MirTypes.MOVE, MirTypes.GP_GC_REG r) =>
	     (* Special case, defines a in terms of b *)
	     (update_regs_table(regs, rn, MirTypes.GC_REG r),
	      MirTypes.UNARY(opcode, rn, replace_gp(gp, regs)))
         | (MirTypes.MOVE, MirTypes.GP_IMM_INT 0) => 
             (case MirRegisters.zero of
                (SOME r) => 
                  (update_regs_table(regs, rn, MirTypes.GC_REG r),
                   MirTypes.UNARY (MirTypes.MOVE, rn, MirTypes.GP_GC_REG r))
              | _ => 
                  let
                    val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
                  in
                    (remove_def_and_use(rn, regs), instr)
                  end)
         | (MirTypes.MOVE, MirTypes.GP_IMM_ANY 0) => 
             (case MirRegisters.zero of
                (SOME r) => 
                  (update_regs_table(regs, rn, MirTypes.GC_REG r),
                   MirTypes.UNARY (MirTypes.MOVE, rn, MirTypes.GP_GC_REG r))
              | _ => 
                  let
                    val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
                  in
                    (remove_def_and_use(rn, regs), instr)
                  end)
	 | _ =>
	     let
	       val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
	     in
	       (remove_def_and_use(rn, regs), instr)
	     end)
      | analyse_instr(regs, instr as MirTypes.NULLARY(_, rn)) =
	(remove_def_and_use(rn, regs), instr)
      | analyse_instr(regs, instr as MirTypes.TBINARYFP _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.TUNARYFP _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.BINARYFP _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.UNARYFP _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.STACKOP(stack_op, rn, _)) =
	(case stack_op of
	   MirTypes.POP => (remove_def_and_use(rn, regs), instr)
	 | _ => (regs, instr))
      | analyse_instr(regs, MirTypes.STOREOP(store_op, rn, rm, gp)) =
	let
	  val is_load = case store_op of
	    MirTypes.STREF => false
	  | MirTypes.ST => false
	  | MirTypes.STB => false
	  | _ => true
	  val regs = if is_load then remove_def_and_use(rn, regs) else regs
	  val rm = replace_reg(rm, regs)
	  val gp = replace_gp(gp, regs)
	  val rn = if is_load then rn else replace_reg(rn, regs)
	in
	  (regs, MirTypes.STOREOP(store_op, rn, rm, gp))
	end
      | analyse_instr(regs, MirTypes.IMMSTOREOP(opcode, gp1, reg, gp2)) =
	(regs, MirTypes.IMMSTOREOP(opcode, replace_gp(gp1, regs), replace_reg(reg, regs), replace_gp(gp2, regs)))
      | analyse_instr(regs, MirTypes.STOREFPOP(opcode, fp, rn, gp)) =
	(regs, MirTypes.STOREFPOP(opcode, fp, replace_reg(rn, regs), replace_gp(gp, regs)))
      | analyse_instr(regs, MirTypes.REAL(opcode, fp, gp)) =
	(regs, MirTypes.REAL(opcode, fp, replace_gp(gp, regs)))
      | analyse_instr(regs, instr as MirTypes.FLOOR(_, _, rn, _)) =
	(remove_def_and_use(rn, regs), instr)
      | analyse_instr(regs, instr as MirTypes.BRANCH _) = (regs, instr)
      | analyse_instr(regs, MirTypes.TEST(opcode, tag, gp1, gp2)) =
	(regs, MirTypes.TEST(opcode, tag, replace_gp(gp1, regs), replace_gp(gp2, regs)))
      | analyse_instr(regs, instr as MirTypes.FTEST _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.BRANCH_AND_LINK _) =
	([], instr) (* All bets off now *)
      | analyse_instr(regs, instr as MirTypes.TAIL_CALL _) =
	([], instr) (* All bets off now *)
      | analyse_instr(regs, instr as MirTypes.CALL_C) =
	([], instr) (* All bets off now *)
      | analyse_instr(regs, MirTypes.SWITCH(opcode, rn, tags)) =
	(regs, MirTypes.SWITCH(opcode, replace_reg(rn, regs), tags))
      | analyse_instr(regs, MirTypes.ALLOCATE(opcode, rn, gp)) =
	let
	  val instr = MirTypes.ALLOCATE(opcode, rn, replace_gp(gp, regs))
	in
	  (remove_def_and_use(rn, regs), instr)
	end
      | analyse_instr(regs, instr as MirTypes.ALLOCATE_STACK(_, rn, _, _)) =
	(remove_def_and_use(rn, regs), instr)
      | analyse_instr(regs, instr as MirTypes.DEALLOCATE_STACK _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.ADR(_, rn, _)) =
	(remove_def_and_use(rn, regs), instr)
      | analyse_instr(regs, instr as MirTypes.INTERCEPT) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.INTERRUPT) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.ENTER _) = (regs, instr)
      | analyse_instr(regs, instr as MirTypes.RTS) = (regs, instr)
      | analyse_instr(regs, MirTypes.NEW_HANDLER(frame, tag)) =
	(regs, MirTypes.NEW_HANDLER(replace_reg(frame, regs), tag))
      | analyse_instr(regs, instr as MirTypes.OLD_HANDLER) = (regs, instr)
      | analyse_instr(regs, MirTypes.RAISE rn) =
	([], MirTypes.RAISE(replace_reg(rn, regs))) (* All bets off now *)
      | analyse_instr(regs, instr as MirTypes.COMMENT _) = (regs, instr)
	
    fun analyse_block([], done, regs) = rev done
      | analyse_block(instr :: instrs, done, regs) =
	let
	  val (regs, instr) = analyse_instr(regs, instr)
	in
	  analyse_block(instrs, instr :: done, regs)
	end
      
    fun analyse_proc2 block_list =
      map
      (fn (MirTypes.BLOCK(tag, instrs)) => MirTypes.BLOCK(tag, analyse_block(instrs, [], [])))
      block_list
      
    fun ref_gp(reg_table, MirTypes.GP_GC_REG r) =
      (case MirTypes.GC.Map.tryApply'(reg_table, r) of
	 SOME _ => MirTypes.GC.Map.undefine(reg_table, r)
       | _ => reg_table)
      | ref_gp(reg_table, _) = reg_table

    (* reg_table is a table of registers defined but not used *)
    (* Referencing a register removes it from the table *)
    fun ref_reg(reg_table, MirTypes.GC_REG r) =
      (case MirTypes.GC.Map.tryApply'(reg_table, r) of
	 SOME _ => MirTypes.GC.Map.undefine(reg_table, r)
       | _ => reg_table)
      | ref_reg(reg_table, _) = reg_table
	
    (* Defining a register adds an old unused definition to the deletes list *)
    fun def_reg(reg_table, deletes, reg as MirTypes.GC_REG r) =
      (case MirTypes.GC.Map.tryApply'(reg_table, r) of
	 SOME n => (ref_reg(reg_table, reg), n :: deletes)
       | _ => (reg_table, deletes))
      | def_reg(reg_table, deletes, _) = (reg_table, deletes)
	  
    fun analyse_instr(reg_table, delete, n, MirTypes.TBINARY(opcode, tag, rn, gp1, gp2)) =
      (case tag of
	 [] =>
	   let
	     val reg_table = ref_gp(ref_gp(reg_table, gp1), gp2)
	   in
	     def_reg(reg_table, delete, rn)
	   end
       | _ =>
	   (MirTypes.GC.Map.empty, delete))
      | analyse_instr(reg_table, delete, n, MirTypes.BINARY(opcode, rn, gp1, gp2)) =
	let
	  val reg_table = ref_gp(ref_gp(reg_table, gp1), gp2)
	  val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	in
	  case rn of
	    MirTypes.GC_REG r =>
	      (MirTypes.GC.Map.define(reg_table, r, n), delete)
	  | _ => result
	end
      | analyse_instr(reg_table, delete, n, MirTypes.UNARY(opcode, rn, gp)) =
	let
	  val reg_table = ref_gp(reg_table, gp)
	  val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	in
	  case rn of
	    MirTypes.GC_REG r =>
	      (MirTypes.GC.Map.define(reg_table, r, n), delete)
	  | _ => result
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.NULLARY(_, rn)) =
	let
	  val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	in
	  case rn of
	    MirTypes.GC_REG r =>
	      (MirTypes.GC.Map.define(reg_table, r, n), delete)
	  | _ => result
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.TBINARYFP _) =
	(MirTypes.GC.Map.empty, delete)
      (* This may branch to another block *)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.TUNARYFP _) =
	(MirTypes.GC.Map.empty, delete)
      (* This may branch to another block *)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.BINARYFP _) =
	(reg_table, delete)
      (* We should probably have a whole barrage of FP optimizations *)
      | analyse_instr(reg_table,delete,n,instr as MirTypes.UNARYFP (MirTypes.FMOVE,r1,r2)) =
         if r1 = r2 then (reg_table,n::delete)
         else (reg_table,delete)
      | analyse_instr(reg_table,delete,n,instr as MirTypes.UNARYFP _) =
	(reg_table, delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.STACKOP(stack_op, rn, _)) =
	(case stack_op of
	   MirTypes.POP =>
	     let
	       val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	     in
	       case rn of
		 MirTypes.GC_REG r =>
		   (MirTypes.GC.Map.define(reg_table, r, n), delete)
	       | _ => result
       	     end
	 | MirTypes.PUSH => (ref_reg(reg_table, rn), delete))
      | analyse_instr(reg_table, delete, n, MirTypes.STOREOP(store_op, rn, rm, gp)) =
	let
	  val reg_table = ref_reg(ref_gp(reg_table, gp), rm)
	  val is_load = case store_op of
	    MirTypes.STREF => false
	  | MirTypes.ST => false
	  | MirTypes.STB => false
	  | _ => true
	in
	  if is_load then
	    let
	      val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	    in
	      case rn of
		MirTypes.GC_REG r =>
		  (MirTypes.GC.Map.define(reg_table, r, n), delete)
	      | _ => result
	    end
	  else
	    (ref_reg(reg_table, rn), delete)
	end
      | analyse_instr(reg_table, delete, n, MirTypes.IMMSTOREOP(store_op, gp1, rm, gp2)) =
	let
	  val reg_table = ref_reg(ref_gp(reg_table, gp2), rm)
	in
	  (ref_gp(reg_table, gp1), delete)
	end
      | analyse_instr(reg_table, delete, n, MirTypes.STOREFPOP(opcode, fp, rn, gp)) =
	(ref_reg(ref_gp(reg_table, gp), rn), delete)
      | analyse_instr(reg_table, delete, n, MirTypes.REAL(opcode, fp, gp)) =
	(ref_gp(reg_table, gp), delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.FLOOR(_, _, rn, _)) =
	(MirTypes.GC.Map.empty, delete)
      (* This may branch to another block *)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.BRANCH _) =
	(MirTypes.GC.Map.empty, delete)
      (* Assume everything referenced by destination *)
      | analyse_instr(reg_table, delete, n, MirTypes.TEST(opcode, tag, gp1, gp2)) =
	(MirTypes.GC.Map.empty, delete)
      (* Assume everything referenced by destination *)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.FTEST _) =
	(MirTypes.GC.Map.empty, delete)
      (* Assume everything referenced by destination *)
(*
	(reg_table, delete)
*)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.BRANCH_AND_LINK _) =
	(* Reference everything used by call *)
	(* Define everything produced by call *)
	let
	  val {gc=gc_ref, ...} = MirTables.referenced_by instr
	  val {gc=gc_def, ...} = MirTables.defined_by instr
	  val reg_table =
	    MirTypes.GC.Set.reduce
	    (fn (reg_table, r) => ref_reg(reg_table, MirTypes.GC_REG r))
	    (reg_table, gc_ref)
	in
	  MirTypes.GC.Set.reduce
	  (fn ((reg_table, delete), r) => def_reg(reg_table, delete, MirTypes.GC_REG r))
	  ((reg_table, delete), gc_def)
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.TAIL_CALL _) =
	(* Reference everything used by tail *)
	(* Delete everything else *)
	let
	  val {gc=gc_ref, ...} = MirTables.referenced_by instr
	  val reg_table =
	    MirTypes.GC.Set.reduce
	    (fn (reg_table, r) => ref_reg(reg_table, MirTypes.GC_REG r))
	    (reg_table, gc_ref)
	in
	  (MirTypes.GC.Map.empty, MirTypes.GC.Map.range reg_table @ delete)
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.CALL_C) =
	(* Reference everything used by CALL_C *)
	(* Define everything produced by CALL_C *)
	let
	  val {gc=gc_ref, ...} = MirTables.referenced_by instr
	  val {gc=gc_def, ...} = MirTables.defined_by instr
	  val reg_table =
	    MirTypes.GC.Set.reduce
	    (fn (reg_table, r) => ref_reg(reg_table, MirTypes.GC_REG r))
	    (reg_table, gc_ref)
	in
	  MirTypes.GC.Set.reduce
	  (fn ((reg_table, delete), r) => def_reg(reg_table, delete, MirTypes.GC_REG r))
	  ((reg_table, delete), gc_def)
	end
      | analyse_instr(reg_table, delete, n, MirTypes.SWITCH(opcode, rn, tags)) =
	(MirTypes.GC.Map.empty, delete)
      (* Assume everything referenced by destination *)
      | analyse_instr(reg_table, delete, n, MirTypes.ALLOCATE(opcode, rn, gp)) =
	let
	  val reg_table = ref_gp(reg_table, gp)
	  val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	in
	  case rn of
	    MirTypes.GC_REG r =>
	      (MirTypes.GC.Map.define(reg_table, r, n), delete)
	  | _ => result
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.ALLOCATE_STACK(_, rn, _, _)) =
	let
	  val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	in
	  case rn of
	    MirTypes.GC_REG r =>
	      (MirTypes.GC.Map.define(reg_table, r, n), delete)
	  | _ => result
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.DEALLOCATE_STACK _) =
	(reg_table, delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.ADR(_, rn, _)) =
	let
	  val result as (reg_table, delete) = def_reg(reg_table, delete, rn)
	in
	  case rn of
	    MirTypes.GC_REG r =>
	      (MirTypes.GC.Map.define(reg_table, r, n), delete)
	  | _ => result
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.INTERCEPT) =
	(reg_table, delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.INTERRUPT) =
	(reg_table, delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.ENTER _) =
	(reg_table, delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.RTS) =
	(* Reference everything used by rts *)
	(* Delete everything else *)
	let
	  val {gc=gc_ref, ...} = MirTables.referenced_by instr
	  val reg_table =
	    MirTypes.GC.Set.reduce
	    (fn (reg_table, r) => ref_reg(reg_table, MirTypes.GC_REG r))
	    (reg_table, gc_ref)
	in
	  (MirTypes.GC.Map.empty, MirTypes.GC.Map.range reg_table @ delete)
	end
      | analyse_instr(reg_table, delete, n,
		      instr as MirTypes.NEW_HANDLER(frame, _)) =
	let
	  val reg_table = ref_reg(reg_table, frame)
	in
	  (reg_table, delete)
	end
      | analyse_instr(reg_table, delete, n, instr as MirTypes.OLD_HANDLER) =
	(reg_table, delete)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.RAISE rn) =
	(MirTypes.GC.Map.empty, delete)
	(* Assume everything referenced by destination which might be a local handler *)
      | analyse_instr(reg_table, delete, n, instr as MirTypes.COMMENT _) =
	(reg_table, delete)
	
    fun analyse_block(_, delete, n, []) = delete
      | analyse_block(reg_table, delete, n, instr :: instrs) =
	let
	  val (reg_table, delete) = analyse_instr(reg_table, delete, n, instr)
	in
	  analyse_block(reg_table, delete, n+1, instrs)
	end
      
    fun filter_n([], _, _, done) = rev done
      | filter_n(x, [], _, done) = rev_app(done, x)
      | filter_n(instr :: instrs, dels as (n :: dels'), n', done) =
	if n > n' then
	  filter_n (instrs, dels, n'+1, instr :: done)
	else
	  if MirTables.has_side_effects instr then
	    (* Ignore the delete request *)
	    filter_n (instrs, dels', n'+1, instr :: done)
	  else
	    (* Throw away the current instruction (redundant move) *)
	    filter_n (instrs, dels', n'+1, done)
	  
    fun analyse_BLOCK(MirTypes.BLOCK(tag, block)) =
      let
	val delete = analyse_block(MirTypes.GC.Map.empty, [], 0, block)
	val sorted_delete = Lists.qsort (fn (a, b) => a < b) delete
(*
	val _ =
	  if Lists.length sorted_delete > 0 then
	    Lists.iterate
	    (fn x => output(std_out, "Removing instruction at position " ^
			    Int.toString x ^ "\n"))
	    sorted_delete
	  else
	    ()
*)
      in
	MirTypes.BLOCK(tag, filter_n(block, sorted_delete, 0, []))
      end
    
    fun analyse_proc3 block_list = map analyse_BLOCK block_list
      
(*
    val analyse_proc1 =
      fn b =>
      let
	val b = analyse_proc1 b
	val _ = output(std_out, "After step 1\n")
	val _ = Lists.iterate
	  (fn b => (output(std_out, MirPrint.block b);
		    output(std_out, "\n")))
	  b
      in
	b
      end

    val analyse_proc2 =
      fn b =>
      let
	val b = analyse_proc2 b
	val _ = output(std_out, "After step 2\n")
	val _ = Lists.iterate
	  (fn b => (output(std_out, MirPrint.block b);
		    output(std_out, "\n")))
	  b
      in
	b
      end

    val analyse_proc3 =
      fn b =>
      let
	val b = analyse_proc3 b
	val _ = output(std_out, "After step 3\n")
	val _ = Lists.iterate
	  (fn b => (output(std_out, MirPrint.block b);
		    output(std_out, "\n")))
	  b
      in
	b
      end
*)

    val transform =
      fn block_list =>
      let
(*
	val _ = output(std_out,
		       "MirExpr:before transform:\n" ^
		       implode (map MirPrint.block block_list) ^ "\n")
*)
	val result =
	  (analyse_proc3 o analyse_proc2 o analyse_proc1) block_list
(*
	val _ = output(std_out,
		       "MirExpr:after transform:\n" ^
		       implode (map MirPrint.block result) ^ "\n")
*)
      in
	result
      end

    val preassigned = MirTypes.GC.unpack_set (#gc MirRegisters.preassigned)
    fun is_preassigned (MirTypes.GC_REG r) = MirTypes.GC.Set.member (preassigned,r)
      | is_preassigned _ = false

    fun copy_propagate_instr(regs, MirTypes.TBINARY(opcode, tag, rn, gp1, gp2)) =
      let
	val instr = MirTypes.TBINARY(opcode, tag, rn, replace_gp(gp1, regs), replace_gp(gp2, regs))
      in
	(remove_def_and_use(rn, regs), instr)
      end
      | copy_propagate_instr(regs, MirTypes.BINARY(opcode, rn, gp1, gp2)) =
	let
	  val instr = MirTypes.BINARY(opcode, rn, replace_gp(gp1, regs), replace_gp(gp2, regs))
	in
	  (remove_def_and_use(rn, regs), instr)
	end
      | copy_propagate_instr(regs, MirTypes.UNARY(opcode, rn, gp)) =
        (* Don't propagate copies to preassigned regs as these can't generally be removed *)
        if is_preassigned rn
          then 
            let
              val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
            in
              (remove_def_and_use(rn, regs), instr)
            end
        else
          (case (opcode, gp) of
             (MirTypes.MOVE, MirTypes.GP_GC_REG r) =>
               (* Special case, defines a in terms of b *)
               (update_regs_table(regs, rn, MirTypes.GC_REG r),
                MirTypes.UNARY(opcode, rn, replace_gp(gp, regs)))
           | (MirTypes.MOVE, MirTypes.GP_IMM_INT 0) => 
               (case MirRegisters.zero of
                  (SOME r) => 
                    (update_regs_table(regs, rn, MirTypes.GC_REG r),
                     MirTypes.UNARY (MirTypes.MOVE, rn, MirTypes.GP_GC_REG r))
                | _ => 
                    let
                      val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
                    in
                      (remove_def_and_use(rn, regs), instr)
                    end)
           | (MirTypes.MOVE, MirTypes.GP_IMM_ANY 0) => 
               (case MirRegisters.zero of
                  (SOME r) => 
                    (update_regs_table(regs, rn, MirTypes.GC_REG r),
                     MirTypes.UNARY (MirTypes.MOVE, rn, MirTypes.GP_GC_REG r))
                | _ => 
                    let
                      val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
                    in
                      (remove_def_and_use(rn, regs), instr)
                    end)
           | _ =>
               let
                 val instr = MirTypes.UNARY(opcode, rn, replace_gp(gp, regs))
               in
                 (remove_def_and_use(rn, regs), instr)
               end)
      | copy_propagate_instr(regs, instr as MirTypes.NULLARY(_, rn)) =
	(remove_def_and_use(rn, regs), instr)
      | copy_propagate_instr(regs, instr as MirTypes.TBINARYFP _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.TUNARYFP _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.BINARYFP _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.UNARYFP _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.STACKOP(stack_op, rn, _)) =
	(case stack_op of
	   MirTypes.POP => (remove_def_and_use(rn, regs), instr)
	 | _ => (regs, instr))
      | copy_propagate_instr(regs, MirTypes.STOREOP(store_op, rn, rm, gp)) =
	let
	  val is_load = case store_op of
	    MirTypes.STREF => false
	  | MirTypes.ST => false
	  | MirTypes.STB => false
	  | _ => true
	  val regs = if is_load then remove_def_and_use(rn, regs) else regs
	  val rm = replace_reg(rm, regs)
	  val gp = replace_gp(gp, regs)
	  val rn = if is_load then rn else replace_reg(rn, regs)
	in
	  (regs, MirTypes.STOREOP(store_op, rn, rm, gp))
	end
      | copy_propagate_instr(regs, MirTypes.IMMSTOREOP(store_op, gp1, rm, gp2)) =
	let
	  val rm = replace_reg(rm, regs)
	  val gp1 = replace_gp(gp1, regs)
	  val gp2 = replace_gp(gp2, regs)
	in
	  (regs, MirTypes.IMMSTOREOP(store_op, gp1, rm, gp2))
	end
      | copy_propagate_instr(regs, MirTypes.STOREFPOP(opcode, fp, rn, gp)) =
	(regs, MirTypes.STOREFPOP(opcode, fp, replace_reg(rn, regs), replace_gp(gp, regs)))
      | copy_propagate_instr(regs, MirTypes.REAL(opcode, fp, gp)) =
	(regs, MirTypes.REAL(opcode, fp, replace_gp(gp, regs)))
      | copy_propagate_instr(regs, instr as MirTypes.FLOOR(_, _, rn, _)) =
	(remove_def_and_use(rn, regs), instr)
      | copy_propagate_instr(regs, instr as MirTypes.BRANCH _) = (regs, instr)
      | copy_propagate_instr(regs, MirTypes.TEST(opcode, tag, gp1, gp2)) =
	(regs, MirTypes.TEST(opcode, tag, replace_gp(gp1, regs), replace_gp(gp2, regs)))
      | copy_propagate_instr(regs, instr as MirTypes.FTEST _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.BRANCH_AND_LINK _) =
	([], instr) (* All bets off now *)
      | copy_propagate_instr(regs, instr as MirTypes.TAIL_CALL _) =
	([], instr) (* All bets off now *)
      | copy_propagate_instr(regs, instr as MirTypes.CALL_C) =
	([], instr) (* All bets off now *)
      | copy_propagate_instr(regs, MirTypes.SWITCH(opcode, rn, tags)) =
	(regs, MirTypes.SWITCH(opcode, replace_reg(rn, regs), tags))
      | copy_propagate_instr(regs, MirTypes.ALLOCATE(opcode, rn, gp)) =
	let
	  val instr = MirTypes.ALLOCATE(opcode, rn, replace_gp(gp, regs))
	in
	  (remove_def_and_use(rn, regs), instr)
	end
      | copy_propagate_instr(regs, instr as MirTypes.ALLOCATE_STACK(_, rn, _, _)) =
	(remove_def_and_use(rn, regs), instr)
      | copy_propagate_instr(regs, instr as MirTypes.DEALLOCATE_STACK _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.ADR(_, rn, _)) =
	(remove_def_and_use(rn, regs), instr)
      | copy_propagate_instr(regs, instr as MirTypes.INTERCEPT) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.INTERRUPT) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.ENTER _) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.RTS) = (regs, instr)
      | copy_propagate_instr(regs, instr as MirTypes.NEW_HANDLER(frame, tag)) =
	(regs, MirTypes.NEW_HANDLER(replace_reg(frame, regs), tag))
      | copy_propagate_instr(regs, instr as MirTypes.OLD_HANDLER) = (regs, instr)
      | copy_propagate_instr(regs, MirTypes.RAISE rn) =
	([], MirTypes.RAISE(replace_reg(rn, regs))) (* All bets off now *)
      | copy_propagate_instr(regs, instr as MirTypes.COMMENT _) = (regs, instr)
	
    fun copy_propagate_block([], done, regs) = rev done
      | copy_propagate_block(instr :: instrs, done, regs) =
	let
	  val (regs, instr) = copy_propagate_instr(regs, instr)
	in
	  copy_propagate_block(instrs, instr :: done, regs)
	end
      
    fun copy_propagate block_list =
      map
      (fn (MirTypes.BLOCK(tag, instrs)) => MirTypes.BLOCK(tag, copy_propagate_block(instrs, [], [])))
      block_list
      
    fun convert_to_immediate_stores block_list =
      if MachSpec.has_immediate_stores then
	let
	  fun gp_not_zero(MirTypes.GP_IMM_INT 0) = false
	    | gp_not_zero(MirTypes.GP_IMM_ANY 0) = false
	    | gp_not_zero _ = true

	  fun is_reg(MirTypes.GP_GC_REG _) = true
	    | is_reg(MirTypes.GP_NON_GC_REG _) = true
	    | is_reg _ = false

	  fun count_instr((gc_table, non_gc_table), opcode) =
	    let
	      val defines = MirTables.defined_by opcode
	      val uses = MirTables.referenced_by opcode
	      fun gc_add(table, element) =
		let
		  val so_far = MirTypes.GC.Map.apply_default'(table, 0, element)
		in
		  MirTypes.GC.Map.define(table, element, so_far+1)
		end
	      fun non_gc_add(table, element) =
		let
		  val so_far = MirTypes.NonGC.Map.apply_default'(table, 0, element)
		in
		  MirTypes.NonGC.Map.define(table, element, so_far+1)
		end
	      val reduce_gc = MirTypes.GC.Set.reduce gc_add
	      val reduce_non_gc = MirTypes.NonGC.Set.reduce non_gc_add
	    in
	      (reduce_gc (reduce_gc (gc_table, #gc defines), #gc uses),
	       reduce_non_gc (reduce_non_gc (non_gc_table, #non_gc defines), #non_gc uses))
	    end

	  fun convert_blocks block_list =
	    let
	      val gc_reg_map = MirTypes.GC.Map.empty
	      val non_gc_reg_map = MirTypes.NonGC.Map.empty
	      val (gc_table, non_gc_table) =
		Lists.reducel
		(fn (tables, block as MirTypes.BLOCK(tag, opcode_list)) =>
		 Lists.reducel
		 count_instr
		 (tables, opcode_list))
		((gc_reg_map, non_gc_reg_map), block_list)
	      (* This tells us how often each virtual register occurs *)
	      (* In cases where the registers occurs only twice, *)
	      (* and it is of the form MOV rn, #x; ST rn, rm, #gp *)
	      (* We can convert the store into a store immediate and remove the move *)
	      (* Otherwise, we may not be able to remove the move *)
	      fun check_occurrences(MirTypes.GC_REG reg) =
		(case MirTypes.GC.Map.tryApply'(gc_table, reg) of
		   SOME a => a
		 | _ => Crash.impossible"convert_proc looks up reg not in gc table")
		| check_occurrences(MirTypes.NON_GC_REG reg) =
		(case MirTypes.NonGC.Map.tryApply'(non_gc_table, reg) of
		   SOME a => a
		 | _ => Crash.impossible"convert_blocks looks up reg not in non_gc table")
	      fun do_block(done, []) = rev done
		| do_block(done, (move as MirTypes.UNARY(MirTypes.MOVE, reg, gp)) ::
			   (store as MirTypes.STOREOP(store_op, rn, rm, gp')) ::
			   rest) =
		  let
		    val is_load =
		      case store_op of
			MirTypes.LD => true
		      | MirTypes.LDB => true
		      | MirTypes.LDREF => true
		      | _ => false
		  in
		    if reg = rn then
		      if is_load then
			Crash.impossible"Load overwrites preceding move"
		      else
			if check_occurrences reg = 2 then
			  if is_reg gp then
			    do_block(store :: move :: done, rest)
			  else
			    if gp_not_zero gp then
			      let
				val new_store =
				  MirTypes.IMMSTOREOP(store_op, gp, rm, gp')
			      in
				((*output(std_out, "Replacing move,store pair with store imm\n");*)
				 do_block(new_store :: done, rest))
			      end
			    else
			      ((*output(std_out, "Not replacing move, store pair because immediate is zero\n");*)
			       do_block(store :: move :: done, rest))
			else
			  ((*output(std_out,
				  "Not replacing move,store pair with move,store imm\n" ^
				  "because " ^
				  Int.toString (check_occurrences reg) ^
				  " occurrences of register found\n");*)
			  do_block(store :: move :: done, rest))
		    else
		      do_block(store :: move :: done, rest)
		  end
		| do_block(done, (move as MirTypes.UNARY(MirTypes.MOVE, reg, gp)) :: rest) =
		  let
(*
		    val _ =
		      if check_occurrences reg = 2 then
			output(std_out, "Found move immediate register with two non-adjacent occurences of register\n")
		      else
			()
*)
		  in
		    do_block(move :: done, rest)
		  end
		| do_block(done, opcode :: rest) = do_block(opcode :: done, rest)
	    in
	      map
	      (fn (MirTypes.BLOCK(tag, opcodes)) =>
	       MirTypes.BLOCK(tag, do_block([], opcodes)))
	      block_list
	    end
	in
	  convert_blocks block_list
	end
      else
	block_list

    val simple_transform =
      fn block_list =>
      let
(*
	val _ = output(std_out,
		       "MirExpr:before simple_transform:\n" ^
		       implode (map MirPrint.block block_list) ^ "\n")
*)
	val result =  copy_propagate block_list
(*
	val _ = output(std_out,
		       "MirExpr:after simple_transform:\n" ^
		       implode (map MirPrint.block result) ^ "\n")
*)
      in
	convert_to_immediate_stores result
      end

(*
    fun transform(MirTypes.PROC(string, tag, parms, block_list, env)) =
      MirTypes.PROC(string, tag, parms,
		    analyse_proc3(analyse_proc2(analyse_proc1 block_list)),
		    env)

    val analyse_proc_list = map analyse_proc

    fun transform(MirTypes.CODE(refs, values, proc_list_list)) =
      MirTypes.CODE(refs, values, map analyse_proc_list proc_list_list)
*)
      
  end
