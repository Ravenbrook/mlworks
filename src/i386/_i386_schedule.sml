(* _i386_schedule.sml the functor *)
(*
$Log: _i386_schedule.sml,v $
Revision 1.14  1999/02/02 15:59:52  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.13  1998/08/20  17:04:14  jont
 * [Bug #20116]
 * Fix poor code sequences bserved in 20116 and 20118
 *
 * Revision 1.12  1997/05/06  10:07:04  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.11  1996/11/06  11:12:34  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.10  1996/08/09  17:11:55  daveb
 * [Bug #1534]
 * before is now an infix identifier.
 *
 * Revision 1.9  1996/04/30  13:21:06  matthew
 * Removing use of MLWorks.Integer
 *
 * Revision 1.8  1996/04/04  13:41:43  jont
 * Allow offsets in mem_operands to be bigger than an int, to cope with words
 *
 * Revision 1.7  1995/12/20  14:30:38  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.6  1995/02/10  15:35:45  jont
Remove the debug output

Revision 1.5  1995/01/16  18:01:25  jont
Add some more peepholing (zero propagation, large moves)

Revision 1.4  1994/11/15  15:59:08  jont
Add some peephole optimisations
In particular, to remove superfluous pop/push pairs
and to remove reloads after stores and restores after loads

Revision 1.3  1994/10/26  18:45:17  jont
Change of option type in newmap

Revision 1.2  1994/09/21  10:38:33  jont
Add code to remove unwanted blocks

Revision 1.1  1994/09/15  12:32:49  jont
new file

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

require "../utils/crash";
require "../utils/lists";
require "../mir/mirtypes";
require "i386_assembly";
require "i386_schedule";

functor I386_Schedule(
  structure Crash : CRASH
  structure Lists : LISTS
  structure I386_Assembly : I386_ASSEMBLY
  structure MirTypes: MIRTYPES
  sharing type MirTypes.tag = I386_Assembly.tag
  sharing type MirTypes.Set.Set = I386_Assembly.Set
  ) : I386_SCHEDULE =
struct
  structure I386_Assembly = I386_Assembly
  structure NewMap = MirTypes.Map
  structure Set = MirTypes.Set
  structure I386Types = I386_Assembly.I386_Opcodes.I386Types

  (* No scheduling done at present *)
  (* Block level peepholing *)
  (* We look for pop/push pairs of the same register *)
  (* Store/load pairs of the same register, store location pair *)
  (* Sequences of the form mov ecx, n[esp] ; mov ecx, a ; mov b, ecx ; mov ecx, n[esp] *)
  (* where b is not n[esp]. These shrink to mov ecx, a ; mov b, ecx ; mov ecx, n[esp] *)
  (* Ie we omit the first mov ecx, n[esp]. These can occur in large numbers *)
  (* in setup functions *)
  (* Clearing of registers which are already zero *)
  (* Use of lea as a move where there is no gain (a one byte loss in fact ) *)
  (* Long copying sequences of contiguous data (tricky stuff this) *)

  fun is_mem(I386_Assembly.r_m32(I386_Assembly.INR _)) = true
    | is_mem _ = false

  fun is_reg(I386_Assembly.r32 _) = true
    | is_reg(I386_Assembly.r_m32(I386_Assembly.INL _)) = true
    | is_reg _ = false

  fun involves(reg, I386_Assembly.r_m32(I386_Assembly.INR
					(I386_Assembly.MEM{base, index, ...}))) =
    (isSome base andalso valOf base = reg) orelse
    (isSome index andalso #1(valOf index) = reg)
    | involves _ = false

  fun convert_reg(I386_Assembly.r32 reg) = I386_Assembly.r_m32(I386_Assembly.INL reg)
    | convert_reg(I386_Assembly.r_m32(I386_Assembly.INL reg)) = I386_Assembly.r32 reg
    | convert_reg _ = Crash.impossible"convert_reg: not a register"

  fun check_for_more_copying([],_ , _, _, _, _, _, _) =
    Crash.impossible"check_for_more_copying reaches block end"
    | check_for_more_copying([_], count_of_copies, _, _, _, _, _, _) =
      count_of_copies
    | check_for_more_copying((opcode1 as
			      (I386_Assembly.OPCODE
			       (I386_Assembly.mov,
				[I386_Assembly.r32 reg1,
				 I386_Assembly.r_m32
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME base_reg1,
				    index=NONE,
				    offset=SOME(I386_Assembly.SMALL offset1)}))]),
			       NONE, _)) ::
                             (opcode2 as
			      (I386_Assembly.OPCODE
			       (I386_Assembly.mov,
				[I386_Assembly.r_m32
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME base_reg2,
				    index=NONE,
				    offset=SOME(I386_Assembly.SMALL offset2)})),
				 I386_Assembly.r32 reg2]),
			       NONE, _)) ::
			     rest,
			     count_of_copies, inc, internal_register,
			     source_reg, dest_reg,
			     source_count, dest_count) =
      if reg1 = internal_register andalso reg2 = internal_register andalso
	source_reg = base_reg1 andalso dest_reg = base_reg2 andalso
	offset1 = source_count + inc andalso dest_count + inc = offset2 then
	check_for_more_copying(rest, count_of_copies + 1, inc, internal_register,
			       source_reg, dest_reg,
			       source_count + inc, dest_count + inc)
      else
	count_of_copies
    | check_for_more_copying(_, count_of_copies, _, _, _, _, _, _) =
      count_of_copies

  fun find_copy_sequence_in_block(_, []) = NONE
    | find_copy_sequence_in_block(_, [_]) = NONE
    | find_copy_sequence_in_block(position, [_, _]) = NONE
    | find_copy_sequence_in_block(position, instr1 :: (rest' as (instr2 :: rest))) =
      (case instr1 of
	 (I386_Assembly.OPCODE
	  (I386_Assembly.mov,
	   [I386_Assembly.r32 reg1,
	    I386_Assembly.r_m32
	    (I386_Assembly.INR
	     (I386_Assembly.MEM
	      {base=SOME base_reg1,
	       index=NONE,
	       offset=SOME(I386_Assembly.SMALL offset1)}))]),
	  NONE, _) =>
	 (case instr2 of
	    (I386_Assembly.OPCODE
	     (I386_Assembly.mov,
	      [I386_Assembly.r_m32
	       (I386_Assembly.INR
		(I386_Assembly.MEM
		 {base=SOME base_reg2,
		  index=NONE,
		  offset=SOME(I386_Assembly.SMALL offset2)})),
	       I386_Assembly.r32 reg2]),
	     NONE, _) =>
	    if reg1 = reg2 (* Check it is a store copy *) then
	      let
		(* A possible store copying sequence *)
		val copy_count_up =
		  check_for_more_copying(rest, 1, 4, reg1, base_reg1, base_reg2,
					 offset1, offset2)
		val copy_count_down =
		  check_for_more_copying(rest, 1, ~4, reg1, base_reg1, base_reg2,
					 offset1, offset2)
	      in
		if copy_count_up > 3 then
		  ((*output(std_out, "Found store copy up sequence of length " ^
			  Int.toString copy_count_up ^ "\n");*)
		   SOME(position, 4, copy_count_up, reg1,
				  base_reg1, base_reg2, offset1, offset2))
		else
		  if copy_count_down > 3 then
		    ((*output(std_out, "Found store copy down sequence of length " ^
			    Int.toString copy_count_down ^ "\n");*)
		     SOME(position, ~4, copy_count_down, reg1,
				    base_reg1, base_reg2, offset1, offset2))
		  else
		    find_copy_sequence_in_block(position + 2, rest)
	      end
	    else
	      find_copy_sequence_in_block(position + 2, rest)
	  | _ => find_copy_sequence_in_block(position + 1, rest'))
	| _ => find_copy_sequence_in_block(position + 1, rest'))

  fun is_clear(I386_Assembly.r32 reg, I386_Assembly.r_m32(I386_Assembly.INL reg')) =
    (reg = reg', reg)
    | is_clear(I386_Assembly.r_m32(I386_Assembly.INL reg'), I386_Assembly.r32 reg) =
      (reg = reg', reg)
    | is_clear _ = (false, I386Types.cond)

  fun needs_rewrite [] = false
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.pop, [I386_Assembly.r32 r1]),
		     NONE, _) ::
		    (I386_Assembly.OPCODE(I386_Assembly.push, [I386_Assembly.r32 r2]),
		     NONE, _) ::
		    rest) =
      r1 = r2 orelse needs_rewrite rest
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.mov,
					  [op1 as I386_Assembly.r_m32
					   (I386_Assembly.INR a),
					   I386_Assembly.imm8 _]),
		     NONE, comment) ::
		    (rest as ((I386_Assembly.OPCODE(I386_Assembly.mov,
						    [I386_Assembly.r32 reg, op2]),
			       NONE, _) ::
			      _))) =
      op1 = op2 orelse needs_rewrite rest
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.mov,
					  [op1 as I386_Assembly.r_m32
					   (I386_Assembly.INR a),
					   I386_Assembly.imm16 _]),
		     NONE, comment) ::
		    (rest as ((I386_Assembly.OPCODE(I386_Assembly.mov,
						    [I386_Assembly.r32 reg, op2]),
			       NONE, _) ::
			      _))) =
      op1 = op2 orelse needs_rewrite rest
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.mov,
					  [op1 as I386_Assembly.r_m32
					   (I386_Assembly.INR a),
					   I386_Assembly.imm32 _]),
		     NONE, comment) ::
		    (rest as ((I386_Assembly.OPCODE(I386_Assembly.mov,
						    [I386_Assembly.r32 reg, op2]),
			       NONE, _) ::
			      _))) =
      op1 = op2 orelse needs_rewrite rest
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.mov, [op1, op2]),
		     NONE, comment) ::
		    (rest as ((I386_Assembly.OPCODE(I386_Assembly.mov, [op3, op4]),
			       NONE, _) ::
			      rest'))) =
      if (op1 = op4 andalso op2 = op3) then
	true
      else
	(* Check for other potential rewrites involving moves *)
	(case rest' of
	   [] => false
	 | (I386_Assembly.OPCODE(I386_Assembly.mov, [op5, op6]),
	     NONE, comment) :: rest'' =>
	     (op2 = op3 andalso op5 = op6 andalso op1 = op5) orelse needs_rewrite rest
	 | _ => needs_rewrite rest)
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.xor, [a, b]), _, _) :: rest) =
      let
	val (ok, _) = is_clear(a, b)
      in
	ok orelse needs_rewrite rest
      end
    | needs_rewrite((I386_Assembly.OPCODE(I386_Assembly.lea,
					  [I386_Assembly.r32 reg,
					   I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME reg',
					      index=SOME(reg'', NONE),
					      offset=offset}))]), _, _) :: rest) =
      let
	val offset_ok = case offset of
	  SOME(I386_Assembly.SMALL i) => i = 0
	| SOME(I386_Assembly.LARGE(i, j)) => i = 0 andalso j = 0
	| _ => true
      in
	offset_ok andalso (reg = reg' orelse reg = reg'')
      end
    | needs_rewrite(_ :: rest) = needs_rewrite rest

  fun rewrite_block(done, _, []) = rev done
    | rewrite_block(done, set,
		    not_done as ((instr as (opcode, tag_opt, comment)) :: instrs)) =
      let
	val (defs, _, _, _) = I386_Assembly.defines_and_uses opcode
      in
	case opcode of
	  I386_Assembly.OPCODE(I386_Assembly.xor, [a, b]) =>
	    let
	      val (ok, reg) = is_clear(a, b)
	    in
	      if ok then
		if Set.is_member(reg, set) then
		  rewrite_block(done, set, instrs) (* Omit reset to zero of reg *)
		else
		  rewrite_block(instr :: done, Set.add_member(reg, set), instrs)
	      else
		rewrite_block(instr :: done, set, instrs)
	    end
	| (opc as I386_Assembly.OPCODE(I386_Assembly.lea,
				[I386_Assembly.r32 reg,
				 I386_Assembly.r_m32
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME reg',
				    index=NONE,
				    offset=SOME offs}))])) =>
	  (case offs of
	     I386_Assembly.SMALL i =>
	       if i = 0 then
		 (if Set.is_member(reg', set) then
		    if Set.is_member(reg, set) then
		      (* Here we are resetting to zero a register which is already zero *)
		      rewrite_block(done, set, instrs)
		    else
		      (* Here we are resetting to zero a register not known to be zero *)
		      rewrite_block((I386_Assembly.OPCODE(I386_Assembly.xor,
							  [I386_Assembly.r32 reg,
							   I386_Assembly.r_m32
							   (I386_Assembly.INL reg)]),
				     tag_opt, comment) :: done,
				    Set.add_member(reg, set), instrs)
		  else
		    (* Here we have an lea which is really a move *)
		    rewrite_block((I386_Assembly.OPCODE(I386_Assembly.mov,
							  [I386_Assembly.r32 reg,
							   I386_Assembly.r_m32
							   (I386_Assembly.INL reg')]),
				     tag_opt, comment) :: done,
				    Set.setdiff(set, defs), instrs))
	       else
		 if (i < ~128 orelse i > 127) andalso Set.is_member(reg', set) then
		   (rewrite_block((I386_Assembly.OPCODE(I386_Assembly.mov,
							[I386_Assembly.r32 reg,
							 I386_Assembly.imm32(i div 4, i mod 4)]),
				   tag_opt, comment) :: done, Set.setdiff(set, defs), instrs))
		 else
		   rewrite_block(instr :: done, Set.setdiff(set, defs), instrs)
	   | I386_Assembly.LARGE(i, j) =>
	       if (i < ~32 orelse i > 31) andalso Set.is_member(reg', set) then
		 rewrite_block((I386_Assembly.OPCODE(I386_Assembly.mov,
						     [I386_Assembly.r32 reg,
						      I386_Assembly.imm32(i, j)]),
				tag_opt, comment) :: done, Set.setdiff(set, defs), instrs)
	       else
		 rewrite_block(instr :: done, Set.setdiff(set, defs), instrs))
	| (I386_Assembly.OPCODE(I386_Assembly.lea,
				[I386_Assembly.r32 reg,
				 I386_Assembly.r_m32
				 (I386_Assembly.INR
				  (I386_Assembly.MEM
				   {base=SOME reg',
				    index=SOME(reg'', NONE),
				    offset=offset}))])) =>
	  let
	    (* Thanks to Tony for this one *)
	    val offset_ok = case offset of
	      SOME(I386_Assembly.SMALL i) => i = 0
	    | SOME(I386_Assembly.LARGE(i, j)) => i = 0 andalso j = 0
	    | _ => true
	    val set = Set.setdiff(set, defs)
	  in
	    if offset_ok then
	      if reg = reg' then
		rewrite_block((I386_Assembly.OPCODE(I386_Assembly.add,
						    [I386_Assembly.r32 reg,
						     I386_Assembly.r_m32
						     (I386_Assembly.INL reg'')]),
			       tag_opt, comment) :: done, set, instrs)
	      else
		if reg = reg'' then
		  rewrite_block((I386_Assembly.OPCODE(I386_Assembly.add,
						      [I386_Assembly.r32 reg,
						       I386_Assembly.r_m32
						       (I386_Assembly.INL reg')]),
				 tag_opt, comment) :: done, set, instrs)
		else
		  rewrite_block(instr :: done, set, instrs)
	    else
	      rewrite_block(instr :: done, set, instrs)
	  end
	| _ =>
	    let
	      val set = Set.setdiff(set, defs)
	    in
	      case not_done of
		((pop as
		  (I386_Assembly.OPCODE(I386_Assembly.pop, [I386_Assembly.r32 r1]),
		   NONE, _)) ::
		 (push as
		  (I386_Assembly.OPCODE(I386_Assembly.push, [I386_Assembly.r32 r2]),
		   NONE, _)) :: rest) =>
		if r1 = r2 then
		  rewrite_block(done, set, rest) (* Omit pop/push of same register *)
		else
		  rewrite_block(push :: pop :: done, set, rest)
	      | ((mov1 as (I386_Assembly.OPCODE(I386_Assembly.mov, [op1, op2]),
			   NONE, comment1)) ::
		 (mov2 as (I386_Assembly.OPCODE(I386_Assembly.mov, [op3, op4]),
			   NONE, comment2)) ::
		 rest) =>
		if op1 = op4 andalso op2 = op3 then
		  (* Here we check for a further inefficiency *)
		  (* We may be able to remove mov1 as well *)
		  (* This all steams from sequences of MIR like *)
		  (* ld gcn, r[clos] ; st gcn, s[reg]; ld gcn, s[clos] *)
		  (* The first ld translates into a move from store into ecx *)
		  (* and then onto the stack. The st translates *)
		  (* to a move from the stack back to ecx *)
		  (* and then from ecx into store *)
		  (* The second ld translates into a move from store into ecx *)
		  (* and then back into the same stack slot used by the first ld *)
		  (* Hence rendering the first move onto the stack irrelevant *)
		  case (mov1, rest) of
		    ((I386_Assembly.OPCODE(I386_Assembly.mov,
					  [I386_Assembly.r_m32
					   (I386_Assembly.INR
					    (I386_Assembly.MEM
					     {base=SOME I386Types.ESP,
					      index=NONE,
					      offset=offset1})),
					   I386_Assembly.r32 reg1]),
		     NONE, _),
		     (op1 as (I386_Assembly.OPCODE(I386_Assembly.mov,
						   [I386_Assembly.r_m32
						    (I386_Assembly.INR
						     (I386_Assembly.MEM
						      {base=SOME reg',
						      index=NONE,
						       offset=offset2})),
						    I386_Assembly.r32 reg2]),
			      NONE, _)) ::
		     (op2 as (I386_Assembly.OPCODE(I386_Assembly.mov,
						   [I386_Assembly.r32 reg3,
						    I386_Assembly.r_m32
						    (I386_Assembly.INR
						     (I386_Assembly.MEM
						      {base=SOME reg'',
						       index=NONE,
						       offset=offset3}))]),
			      NONE, _)) ::
		     (op3 as (I386_Assembly.OPCODE(I386_Assembly.mov,
						   [I386_Assembly.r_m32
						    (I386_Assembly.INR
						     (I386_Assembly.MEM
						      {base=SOME I386Types.ESP,
						       index=NONE,
						       offset=offset4})),
						    I386_Assembly.r32 reg4]),
			      NONE, _)) :: rest') =>
		    let
		      val do_rewrite =
			reg1 = reg4 andalso offset1 = offset4 andalso
			reg2 = reg1 andalso reg3 = reg1 andalso
			(reg'' <> I386Types.ESP orelse offset3 <> offset1)
			val op1' = #1 op1
			val op2' = #1 op2
			val op3' = #1 op3
		    in
		      if do_rewrite then
			let
			  val (defs1, _, _, _) = I386_Assembly.defines_and_uses op1'
			  val (defs2, _, _, _) = I386_Assembly.defines_and_uses op2'
			  val (defs3, _, _, _) = I386_Assembly.defines_and_uses op3'
			  val set = Set.setdiff
			    (Set.setdiff(Set.setdiff(set, defs1), defs2), defs3)
			in
			  rewrite_block(op2 :: op1 :: done, set, op3 :: rest')
			  (* Note that op3 may be a further candidate for this reduction *)
			end
		      else
			(rewrite_block(mov1 :: done, set, rest))
		    end
		     | _ => rewrite_block(mov1 :: done, set, rest)
		else
		  (* Here we look for mov a, $n; mov reg, a *)
		  (* which we rewrite as xor reg, reg; mov a, reg *)
		  (* or mov reg, $n; mov a, reg depending on whther n = 0 or not *)
		  (* We must take care here that reg is defined but not used *)
		  (* by mov a, reg else we shall corrupt reg before the store into a *)
		  (* We also look for mov reg, a; mov b, reg; mov reg, a *)
		  (* which we rewrite by leaving out the second mov *)
		  if op1 = op4 then
		    if is_mem op1 then
		      (case op3 of
			 I386_Assembly.r32 reg =>
			   let
			     val (is_imm, is_zero) =
			     case op2 of
			       I386_Assembly.imm8 i => (true, i = 0)
			     | I386_Assembly.imm16 i => (true, i = 0)
			     | I386_Assembly.imm32(i, j) => (true, i = 0 andalso j = 0)
			     | _ => (false, false)
			   in
			     if is_imm then
			       if not(involves(reg, op4)) then
				 let
				   val mov2' =
				     (I386_Assembly.OPCODE(I386_Assembly.mov, [op1, op3]),
				      NONE, comment2)
				   val mov1' =
				     if is_zero then
				       (I386_Assembly.OPCODE(I386_Assembly.xor,
							     [op3,
							      I386_Assembly.r_m32
							      (I386_Assembly.INL reg)]),
					NONE, comment1)
				     else
				       (I386_Assembly.OPCODE(I386_Assembly.mov, [op3, op2]),
					NONE, comment1)
				   val (defs', _, _, _) =
				     I386_Assembly.defines_and_uses(#1 mov1')
				   val set' = Set.setdiff(set, defs')
				   val set' =
				     if is_zero then Set.add_member(reg, set') else set'
				   val omit_mov1 =
				     is_zero andalso Set.is_member(reg, set)
				   val done =
				     if omit_mov1 then done else mov1' :: done
				 in
				   rewrite_block(mov2' :: done, set', rest)
				 end
			       else
				 (* mov2 corrupts its argument so we can't rewrite *)
				 rewrite_block(mov1 :: done, set, mov2 :: rest)
			     else
			       (* Non immediate version *)
			       (* Optimise the case of mov a, reg ; mov reg', a *)
			       (* into mov a, reg; mov reg', reg *)
			       if is_reg op2 then
				 let
				   val (defs', _, _, _) =
				     I386_Assembly.defines_and_uses(#1 mov2)
				   val set = Set.setdiff(set, defs')
				   val mov2' =
				     (I386_Assembly.OPCODE(I386_Assembly.mov,
							   [op3, convert_reg op2]),
				      NONE, comment2)
				 in
				   rewrite_block(mov2' :: mov1 :: done, set, rest)
				 end
			       else
				 (* This almost never happens, so isn't worth optimising *)
				 (rewrite_block(mov1 :: done, set, mov2 :: rest))
			   end
		       | _ => rewrite_block(mov1 :: done, set, mov2 :: rest))
		    else
		      (* op1 not a memory operand *)
		      (* Should therefore be a register operand *)
		      (* But it might be something not 32 bit *)
		      (* in which case we would leave well alone *)
		      if is_reg op1 then
			case rest of
			  mov3 :: rest' =>
			    if #1 mov1 = #1 mov3 andalso is_mem op3 then
			      (* We can delete mov3 *)
			      (* As it simply repeats mov1 and mov2 can't change *)
			      (* the store moved into a reg by mov1 *)
			      (rewrite_block(mov1 :: done, set, mov2 :: rest'))
			    else
			      rewrite_block(mov1 :: done, set, mov2 :: rest)
			| _ =>
			      (* This case should never happen *)
			      (rewrite_block(mov1 :: done, set, mov2 :: rest))
		      else
			(rewrite_block(mov1 :: done, set, mov2 :: rest))
		  else
		    (* op1 <> op4 *)
		    (* No known rewrites at present *)
		    rewrite_block(mov1 :: done, set, mov2 :: rest)
	      | (opc :: rest) => rewrite_block(opc :: done, set, rest)
	      | [] => rev done (* Should never occur, but makes match exhaustive *)
	    end
      end

  fun reschedule_block x =
    if needs_rewrite x then
      rewrite_block([], Set.empty_set, x)
    else
      x

  fun deal_with_tags(_, new_block_map, []) = new_block_map
    | deal_with_tags(old_block_map, new_block_map, tag :: tags) =
      case NewMap.tryApply'(new_block_map, tag) of
	NONE =>
	  (case NewMap.tryApply'(old_block_map, tag) of
	     NONE => deal_with_tags(old_block_map, new_block_map, tags)
	       (* Tag refers outside procedure anyway *)
	   | SOME opcode_list =>
	       let
		 val tags = Lists.reducel
		   (fn (tags, (_, SOME tag, _)) => tag :: tags
		     | (tags, _) => tags)
		   (tags, opcode_list)
	       in
		 deal_with_tags(old_block_map,
				NewMap.define(new_block_map, tag, opcode_list),
				tags)
	       end)
      | _ => deal_with_tags(old_block_map, new_block_map, tags)

  fun rev_app([], y) = y
    | rev_app(x :: xs, y) = rev_app(xs, x:: y)

  fun split_block(previous, after, insert, n) =
    if n < 0 then
      Crash.impossible"split_block:negative argument"
    else
      if n = 0 then
	(rev_app(previous, insert), after)
      else
	case after of
	  instr :: instrs =>
	    split_block(instr :: previous, instrs, insert, n-1)
	| _ => Crash.impossible"split_block:end of list"

  fun drop(n, x) =
    if n < 0 then
      Crash.impossible"drop:negative argument"
    else
      if n = 0 then
	x
      else
	case x of
	  _ :: xs => drop(n-1, xs)
	| _ => Crash.impossible"drop:end of list"

  fun convert_copy_blocks(done, []) = done
    | convert_copy_blocks(done, (block as (tag, x)) :: blocks) =
      (case find_copy_sequence_in_block(0, x) of
	 SOME(position, inc, copy_count, reg1,
			base_reg1, base_reg2, offset1, offset2) =>
	 let
	   val new_tag = MirTypes.new_tag()
	   val direction_op =
	     if inc = 4 then I386_Assembly.cld else I386_Assembly.std
	   val insert =
	     [(I386_Assembly.OPCODE
	       (I386_Assembly.push,
		[I386_Assembly.r32 I386Types.ESI]),
	       NONE, "save string source"),
	      (I386_Assembly.OPCODE
	       (I386_Assembly.push,
		[I386_Assembly.r32 I386Types.EDI]),
	       NONE, "save string destination"),
	      (I386_Assembly.OPCODE
	       (I386_Assembly.push,
		[I386_Assembly.r32 I386Types.ESI]),
	       NONE, "save global"),
	      (I386_Assembly.OPCODE
	       (I386_Assembly.lea,
		[I386_Assembly.r32 I386Types.ESI,
		 I386_Assembly.r_m32
		 (I386_Assembly.INR
		  (I386_Assembly.MEM
		   {base=SOME base_reg1,
		    index=NONE,
		    offset=SOME(I386_Assembly.SMALL offset1)}))]),
	       NONE, "Set string source to base of stuff to copy"),
	      (I386_Assembly.OPCODE
	       (I386_Assembly.lea,
		[I386_Assembly.r32 I386Types.EDI,
		 I386_Assembly.r_m32
		 (I386_Assembly.INR
		  (I386_Assembly.MEM
		   {base=SOME base_reg2,
		    index=NONE,
		    offset=SOME(I386_Assembly.SMALL offset2)}))]),
	       NONE, "Set string destination to base of area to copy to"),
	      (I386_Assembly.OPCODE(direction_op, []),
	       NONE, "set direction flag appropriately"),
	      (I386_Assembly.OPCODE
	       (I386_Assembly.mov,
		[I386_Assembly.r32 I386Types.global,
		 I386_Assembly.imm32(copy_count div 4, copy_count mod 4)]),
	       NONE, "initialise counter for loop"),
	      (I386_Assembly.OPCODE(I386_Assembly.jmp, [I386_Assembly.rel32 0]),
	       SOME new_tag, "jump to start of loop (should be elided)")]
	   val (pre_block, post_block) =
	     split_block([], x, insert, position)
	   val post_block =
	     (I386_Assembly.OPCODE
	      (I386_Assembly.movsd, []), NONE, "One word move") ::
	     (I386_Assembly.OPCODE
	      (I386_Assembly.loop, []), SOME new_tag, "loop until ecx = 0") ::
	     (I386_Assembly.OPCODE
	      (I386_Assembly.mov,
	       [I386_Assembly.r32 reg1,
		I386_Assembly.r_m32
		(I386_Assembly.INR
		 (I386_Assembly.MEM
		  {base=SOME base_reg1,
		   index=NONE,
		   offset=SOME(I386_Assembly.SMALL(offset1 + inc*(copy_count-1)))}))]),
	      NONE, "load intermediate register final value") ::
	     (I386_Assembly.OPCODE
	      (I386_Assembly.pop, [I386_Assembly.r32 I386Types.global]),
	      NONE, "restore global (probably unnecessary)") ::
	     (I386_Assembly.OPCODE
	      (I386_Assembly.pop, [I386_Assembly.r32 I386Types.EDI]),
	      NONE, "restore string destination") ::
	     (I386_Assembly.OPCODE
	      (I386_Assembly.pop, [I386_Assembly.r32 I386Types.ESI]),
	      NONE, "restore string source") ::
	     drop(copy_count*2, post_block) (* Remove the old code *)
	 in
	   convert_copy_blocks((tag, pre_block) :: done, (new_tag, post_block) :: blocks)
	 end
       | _ =>
	   convert_copy_blocks(block :: done, blocks))

  (* This just removes unreachable blocks *)
  fun reschedule_proc(proc_tag, blocks) =
    let
(*
      val blocks = convert_copy_blocks([], blocks)
*)
      val block_map = NewMap.from_list blocks
      val new_block_map = NewMap.empty
    in
      (proc_tag, NewMap.to_list(deal_with_tags(block_map, new_block_map, [proc_tag])))
    end

end
