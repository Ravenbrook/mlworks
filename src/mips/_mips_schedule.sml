(*
 Copyright (c) 1993 Harlequin Ltd.

 based on ???

 Revision Log
 ------------
 $Log: _mips_schedule.sml,v $
 Revision 1.19  1997/01/28 15:05:21  matthew
 Changing CGT code

 * Revision 1.18  1997/01/24  14:46:22  matthew
 * Adding option to control whether load delays are needed.
 *
 * Revision 1.17  1997/01/14  11:43:53  matthew
 * Check for multiplication hazards
 *
 * Revision 1.16  1996/12/05  12:02:43  jont
 * [Bug #1834]
 * Avoid problems scheduling past control transfers
 *
 * Revision 1.15  1996/10/10  02:39:55  io
 * [Bug #1557]
 * switch off instruction reordering and basify
 *
 * Revision 1.14  1995/12/22  13:22:05  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.13  1995/09/08  13:46:55  jont
Add a fixed branch type which can't be expanded beyond the 16 bit limit
This can be used to detect disastrous code generation in computed gotos
If this ever occurs, we can then fix the bug

Revision 1.12  1995/06/19  13:20:38  matthew
Fixing problem with handler register

Revision 1.11  1995/06/16  13:59:12  jont
Temporary fix for scheduling problems with handlers and trapping instructions

Revision 1.10  1995/06/01  10:15:41  matthew
Fix problem with moving instructions over intercept nops

Revision 1.9  1995/03/07  16:15:57  matthew
Debug annotations for CALLs

Revision 1.8  1994/11/24  17:16:46  matthew
Fix to not move other_nop

Revision 1.7  1994/11/24  14:31:03  matthew
Tidied up fill_candidate a little as I didn't understand it.

Revision 1.6  1994/11/23  15:53:51  io
Fixing problem with scheduling floats

Revision 1.5  1994/11/15  12:03:06  matthew
Lots more work

Revision 1.4  1994/11/02  15:26:05  matthew
Added "move from above to fill delay slots" stuff

Revision 1.3  1994/10/21  14:35:45  matthew
Added a function to remove unused blocks
Added a function to remove unnecessary load delay nops

Revision 1.2  1993/11/16  17:05:20  io
Deleted old SPARC comments and fixed type errors

 *)

require "../utils/crash";
require "../utils/lists";
require "mips_assembly";

require "mips_schedule";

functor Mips_Schedule(
  structure Crash : CRASH
  structure Lists : LISTS
  structure Mips_Assembly : MIPS_ASSEMBLY
  ) : MIPS_SCHEDULE =
struct
  structure Mips_Assembly = Mips_Assembly
  structure MirTypes = Mips_Assembly.MirTypes
  structure Set = MirTypes.Set
  structure MachTypes = Mips_Assembly.Mips_Opcodes.MachTypes
  structure NewMap = MirTypes.Map

  val do_scheduling = true

  val max_fill_iterations = 20
  val small_block_size = 2

  (* Various utility functions *)

  (* Most of these functions work on (opcode * tag option * comment) triples *)

  local
    open Mips_Assembly
  in
    fun is_nop (opcode,_,_) = opcode = Mips_Assembly.nop_code
    fun is_other_nop (opcode,_,_) = 
      opcode = Mips_Assembly.other_nop_code orelse
      opcode = Mips_Assembly.trace_nop_code

    val nop = (Mips_Assembly.nop_code, NONE, "")

    (* all kinds of transfers of control *)
    fun is_branch (BRANCH _,_,_) = true
      | is_branch (FIXED_BRANCH _,_,_) = true
      | is_branch (CALL _,_,_) = true
      | is_branch (JUMP _,_,_) = true
      | is_branch (FBRANCH _,_,_) = true
      | is_branch (_,_,_) = false

    fun is_fp_op (LOAD_AND_STORE_FLOAT _,_,_) = true
      | is_fp_op (FBRANCH _,_,_) = true
      | is_fp_op (FUNARY _,_,_) = true
      | is_fp_op (FBINARY _,_,_) = true
      | is_fp_op (FCMP _,_,_) = true
      | is_fp_op (CONV_OP _,_,_) = true
      | is_fp_op _ = false

    fun is_fp_delay_op (LOAD_AND_STORE_FLOAT _,_,_) = true
      | is_fp_delay_op (FCMP _,_,_) = true
      | is_fp_delay_op _ = false

    fun is_unconditional_branch (BRANCH (BA,_,_,_),_,_) = true
      | is_unconditional_branch (FIXED_BRANCH (BA,_,_,_),_,_) = true
      | is_unconditional_branch (CALL (BGEZAL,reg,_,_),_,_) = reg = MachTypes.zero_reg
      | is_unconditional_branch _ = false

    (* Simple test for possible instruction to fill a delay slot *)
    (* No fp operations for now *)
    (* No branches *)
    (* No funny operations like LOAD_OFFSET -- these can expand later *)

    fun fill_candidate op1 =
      if is_other_nop op1 then false
      else
        case op1 of
          (LOAD_AND_STORE _,_,_) => true
        | (ARITHMETIC_AND_LOGICAL _,_,_) => true
(*
          (LOAD_AND_STORE(opcode, dest, _, _), _, _) =>
	    (* Don't allow handler realods to be moved *)
	    (case opcode of
	       LW => dest <> Mips_Opcodes.MachTypes.handler
	     | _ => true)
        | (ARITHMETIC_AND_LOGICAL(opcode, dest, _, _),_,_) =>
	    (* Don't allow exception causing instructions to be moved *)
	    (case opcode of
	       ADD => false
	     | ADDI => false
	     | ADDIU => true
	     | ADDU => true
	     | SUB => false
	     | SUBU => true
	     | AND => true
	     | ANDI => true
	     | OR => dest <> Mips_Opcodes.MachTypes.handler
		 (* Don't allow handler setup instructions to be moved *)
	     | ORI => true
	     | XOR => true
	     | XORI => true
	     | NOR => true
	     | SLT => true
	     | SLTU => true
	     | SLTI => true
	     | SLTIU => true
	     | SLL => true
	     | SRL => true
	     | SRA => true
	     | SLLV => true
	     | SRLV => true
	     | SRAV => true)
*)
        | (SETHI _,_,_) => true
        | _ => false

    fun is_load mnemonic =
      case mnemonic of
        LB => true
      | LBU => true
      | LH => true
      | LHU => true
      | LW => true
      | LWL => true
      | LWR => true
      | _ => false

    (* Is is a load from memory? *)
    fun is_load_opcode (LOAD_AND_STORE (mnemonic,to,from,imm),_,_) = is_load mnemonic
      | is_load_opcode _ = false

    (* Get the register loaded *)

    fun loaded_reg (LOAD_AND_STORE (_,to,_,_),_,_) = to
      | loaded_reg _ = Crash.impossible "loaded_reg"

    (* (Partial) test for whether an instruction references a given register *)
    (* This should catch the common cases at least *)

    fun is_referenced (reg,(opn,_,_)) =
      case opn of
        LOAD_AND_STORE (mnemonic,to,from,_) => 
          if is_load mnemonic then reg = from
           (* Otherwise it's a store and we need to look at both registers *)
          else reg = from orelse reg = to
      | ARITHMETIC_AND_LOGICAL (_,_,reg1,REG reg2) => reg = reg1 orelse reg = reg2
      | ARITHMETIC_AND_LOGICAL (_,_,reg1,IMM _) => reg = reg1
      | SPECIAL_ARITHMETIC (_,reg1,REG reg2,reg3) => reg = reg1 orelse reg = reg2 orelse reg = reg3
      | SPECIAL_ARITHMETIC (_,reg1,IMM _,reg3) => reg = reg1 orelse reg = reg3
      | MULT_AND_DIV (_,reg1,reg2) => reg = reg1 orelse reg = reg2
      | MULT_AND_DIV_RESULT (_,reg1) => reg = reg1
      | SETHI _ => false
      | BRANCH (_,reg1,reg2,_) => reg = reg1 orelse reg = reg2
      | FIXED_BRANCH (_,reg1,reg2,_) => reg = reg1 orelse reg = reg2
      | CALL (_,reg1,_,_) => reg = reg1
      | JUMP (jump,reg_or_imm,reg2,_) =>
          (case reg_or_imm of
             REG reg1 =>
               (case jump of
                  JR => reg = reg1
                | JALR => reg = reg2
                | _ => Crash.impossible "is_referenced JUMP reg")
           | _ => false)
      (* Lets do the others sometime *)
      |  _ => true  (* Assume the worst *)
  end

  fun needs_delay (op1,next) =
    if is_branch op1 
      then true
    else if is_load_opcode op1
      then
        case next of
          SOME op2 => is_referenced (loaded_reg op1,op2)
        | _ => true
    (* For the moment, assume the worst for fp *)
     else if is_fp_delay_op op1 then true
     else false

  fun definitions (op1,_,_) =
    Mips_Assembly.defines_and_uses op1

  fun add_uses (op1,(int_defines,int_uses,fp_defines,fp_uses)) =
    let
      val (int_defines',int_uses',fp_defines',fp_uses') =
        definitions op1
    in
      (Set.union (int_defines,int_defines'),
       Set.union (int_uses,int_uses'),
       Set.union (fp_defines,fp_defines'),
       Set.union (fp_uses,fp_uses'))
    end

  fun disjoint (s1, s2) =
    let
      val l1 = Set.set_to_list s1
    in
      not(Lists.exists (fn x => Set.is_member(x, s2)) l1)
    end

  fun is_safe (op1,(int_defines,int_uses,fp_defines,fp_uses)) =
    let
      val (int_defines',int_uses',fp_defines',fp_uses') = definitions op1
    in
      disjoint (int_defines,int_defines') andalso
      disjoint (int_defines,int_uses') andalso
      disjoint (int_uses,int_defines') andalso
      disjoint (fp_defines,fp_defines') andalso
      disjoint (fp_defines,fp_uses') andalso
      disjoint (fp_uses,fp_defines')
    end

  (* target is the op whose delay slot needs filling *)
  (* rest is the preceding code *)
  (* next is (optionally) the next instruction *)

  fun find_filler (target,[],next) = NONE
    | find_filler (target,previous as (op1 :: _),next) =
    if is_branch op1 then
      (* Target is in the delay slot of a branch, so we can't move anything *)
      (* from before the branch into the delay slot of target *)
      NONE
    else
      let
	fun find (_,uses,0,acc) = NONE
	  | find (op1::op2::op3::rest,uses,count,acc) =
	  (* op2 is the candidate *)
	  (* if it's in a delay slot, give up *)
	  if is_branch op3 then
	    (* If its an intercept NOP, give up *)
	    NONE
	  else
	    if is_other_nop op3 then
	      NONE
	    else
	      if not (is_nop op2) andalso fill_candidate op2 andalso
		is_safe (op2,uses) andalso not (needs_delay (op2,next)) then
		SOME
		(if needs_delay (op3,SOME op1) then
		   (op2,rev acc @ (Mips_Assembly.nop::op3::rest))
		 else
		   (op2,rev acc @ (op3::rest)))
	      else
		find (op2::op3::rest,add_uses (op2,uses),count-1,op2::acc)
	  | find ([op1,op2],uses,count,acc) =
	    if is_branch op2 then
	      NONE
	    else
	      if fill_candidate op2 andalso
		is_safe (op2,uses) andalso
		not (needs_delay (op2,next)) then
		SOME (op2,rev acc)
	      else
		NONE
	  | find _ = NONE
      in
	find (target::previous,definitions target,max_fill_iterations,[])
      end

  (* and now some whizzier stuff *)
  fun do_block (need_load_delays, opcode_list,next) = 
    let

      fun delay_optional (op1,next) =
        if is_branch op1 
          then false
        else if need_load_delays then not (needs_delay (op1,next))
        else true

      fun fill_slots (op1::op2::rest,next,acc) =
        (if not (is_nop op1)
           then fill_slots (op2::rest,SOME op1,op1::acc)
         else
           (* We have found a nop *)
           if not (needs_delay (op2,next))
             (* Drop the nop if not required *)
             then fill_slots (op2::rest,next,acc)
           else
             (* The interesting case *)
             case find_filler (op2,rest,if is_branch op2 then NONE else next) of
               NONE => 
                 if delay_optional (op2,next)
                   then fill_slots (op2::rest,next,acc)
                 else fill_slots (op2::rest,SOME op1,op1::acc)
             | SOME (op1',rest') => 
                   fill_slots (op2::rest',SOME op1',op1'::acc))
        | fill_slots ([op1],next,acc) =
           if is_nop op1 then acc else op1 :: acc
        | fill_slots ([],next,acc) = acc
      
      val opcodes1 = rev opcode_list
      val result = fill_slots (opcodes1,next,[])
    in
      result
    end

  (* We want to change the linearized code so that blocks not jumped to *)
  (* are coalesced with the previous block that falls through to it *)

  fun collect_tags_from_block (tag_set, (tag,opcode_list)) =
    Lists.reducel
    (fn (tag_set,(opcode,SOME tag,_)) =>
     NewMap.define (tag_set,tag,())
  | (tag_set,_) => tag_set)
    (tag_set,opcode_list)

  fun collect_tags_from_proc (tag,blocklist) =
    let
      (* make sure the entry tag is marked as used *)
      val initial_tag_set = NewMap.define (NewMap.empty,tag,())
    in
      Lists.reducel collect_tags_from_block (initial_tag_set,blocklist)
    end
      
  fun coalesce_blocks (tag,blocklist) =
    let
      val used_map = collect_tags_from_proc (tag,blocklist)
      val used_fn = NewMap.tryApply used_map
      fun scan (block1::block2::rest,acc) =
        let
          val (tag1,opcodes1) = block1
        in
          case used_fn tag1 of
            SOME _ => scan (block2::rest,block1::acc)
          | _ => 
              (* If the block is unmentioned *)
              let
                val (tag2,opcodes2) = block2
                (* val _ = output (std_out,"Dropping " ^ MirTypes.print_tag tag1 ^ "\n") *)
              in
                scan ((tag2,opcodes2@opcodes1)::rest,acc)
              end
        end
        | scan (rest,acc) =(rev rest) @ acc
    in
      (scan (rev blocklist,[]))
    end

  (* Move first instruction from jumped to block for unconditional branches *)

  fun fill_unconditional_branches blocklist =
    let
      val block_map = NewMap.from_list blocklist
      val block_fn = NewMap.tryApply block_map
      val new_tag_map = ref NewMap.empty
      fun get_new_tag tag =
        case NewMap.tryApply'(!new_tag_map,tag) of
          SOME new_tag => new_tag
        | _ => 
            let
              val new_tag = MirTypes.new_tag ()
              val _ = new_tag_map := NewMap.define (!new_tag_map,tag,new_tag)
            in
              new_tag
            end
      fun first_instruction tag =
        case block_fn tag of
          SOME (first::_) =>
            if fill_candidate first then 
              SOME first
            else NONE
        | _ => NONE
      fun branch_target (_,SOME tag,_) = tag
        | branch_target (_,_,_) = Crash.impossible "branch target"
      fun set_target ((opc,_,comment),tag) = (opc,SOME tag,comment)
      fun scan (op1::op2::rest,acc) =
        if is_unconditional_branch op1 andalso is_nop op2
          then
            let
              val target = branch_target op1
            in
              case first_instruction target of
                SOME first =>
                  let
                    val new_tag = get_new_tag target
                  in
                    scan (rest,first :: set_target (op1,new_tag) :: acc)
                  end
              | _ => scan (rest,op2 :: op1 :: acc)
            end
        else scan (op2::rest,op1::acc)
        | scan (rest,acc) = rev rest @ acc
      fun add_new_blocks blocklist =
        let
          val tag_fn = NewMap.tryApply (!new_tag_map)
          fun scan ([],acc) = rev acc
            | scan ((tag,opcodes)::rest,acc) =
              case tag_fn tag of
                SOME new_tag =>
                  (case opcodes of
                     (first::rest_opcodes) => 
                       scan (rest,(new_tag,rest_opcodes) :: (tag,[first]) :: acc)
                   | _ => Crash.impossible "Funny body in add_new_blocks")
              | _ => scan (rest,(tag,opcodes)::acc)
        in
          scan (blocklist,[])
        end
      val new_blocklist = 
        map
        (fn (tag,opcodelist) => (tag, rev (scan (opcodelist,[]))))
        blocklist
    in
      add_new_blocks new_blocklist
    end

  fun falls_through (tag,opcodes) =
    let
      fun scan (op1 :: op2 :: op3 :: rest) =
        scan (op2 :: op3 :: rest)
        | scan [(Mips_Assembly.BRANCH (Mips_Assembly.BA,_,_,_),_,_), op2] = false
        | scan [(Mips_Assembly.FIXED_BRANCH (Mips_Assembly.BA,_,_,_),_,_), op2] = false
        | scan [(Mips_Assembly.JUMP (Mips_Assembly.J,_,_,_),_,_), op2] = false
        | scan [(Mips_Assembly.JUMP (Mips_Assembly.JR,_,_,_),_,_), op2] = false
        | scan _ = true
    in
      scan opcodes
    end

  (* Eliminate branch to branches *)
  fun inline_small_blocks (tag,blocklist) =
    let
      (* Find all the small blocks *)
      val small_map =
        Lists.reducel
        (fn (map,(tag,opcodes)) =>
         if length opcodes <= small_block_size andalso
           not (falls_through (tag,opcodes))
           then
             NewMap.define (map,tag,opcodes)
         else map)
        (NewMap.empty,blocklist)
      val small_fn = NewMap.tryApply small_map
      (* Replace branch destinations *)
      (* We could do this just for the branches that need it *)
      fun scan (rest,acc,0) = rev rest @ acc
        | scan (op1::op2::op3::rest,acc,depth) =
        scan (op2::op3::rest,op1::acc,depth)
        (* Branch at end of block *)
        | scan ([op1 as (Mips_Assembly.BRANCH(Mips_Assembly.BA,_,_,_),SOME tag,_),
                 op2],
                acc,depth) =
          (case small_fn tag of
             SOME opcodes =>
               if is_nop op2
                 then scan (opcodes,acc,depth-1)
               else scan (op2::opcodes,acc,depth-1)
           | _ => op2 :: op1 :: acc)
        | scan ([op1 as (Mips_Assembly.FIXED_BRANCH(Mips_Assembly.BA,_,_,_),SOME tag,_),
                 op2],
                acc,depth) =
          (case small_fn tag of
             SOME opcodes =>
               if is_nop op2
                 then scan (opcodes,acc,depth-1)
               else scan (op2::opcodes,acc,depth-1)
           | _ => op2 :: op1 :: acc)
        | scan (rest,acc,depth) = rev rest @ acc
    in
      map (fn (tag,opcodes) => (tag, rev (scan (opcodes,[],20)))) blocklist
    end
                
  (* Once again, remove unreachable blocks *)
  fun remove_redundant (tag,blocklist) =
    let
      val used_map = collect_tags_from_proc (tag,blocklist)
      val used_fn = NewMap.tryApply used_map
      fun scan (block1::block2::rest,acc) =
        let
          val (tag,_) = block2
        in
          case used_fn tag of
            SOME _ => scan (block2::rest,block1::acc)
          | NONE =>
              if falls_through block1
                then scan (block2::rest,block1::acc)
              else scan (block1::rest,acc)
        end
      | scan (rest,acc) = rev rest @ acc
    in
      rev (scan (blocklist,[]))
    end

  fun check_multiply (tag, opcodes) =
    let
      val nop = (Mips_Assembly.nop_code, NONE, "for multiply delay")
      fun scan (n,[],acc) = rev acc
        | scan (0, (opcode as (Mips_Assembly.MULT_AND_DIV _,_,_)) :: rest, acc) =
        scan (3, rest, opcode :: nop :: nop :: acc)
        | scan (1, (opcode as (Mips_Assembly.MULT_AND_DIV _,_,_)) :: rest, acc) =
        scan (3, rest, opcode :: nop :: acc)
        | scan (n, (opcode as (Mips_Assembly.MULT_AND_DIV_RESULT _,_,_)) :: rest, acc) =
        scan (0, rest, opcode :: acc)
        | scan (n, opcode :: rest, acc) =
        scan (n+1, rest, opcode :: acc)
    in
      (tag, scan (0,opcodes,[]))
    end
    
  fun reschedule_proc mips2 (tag, blocklist) =
    if not do_scheduling
      then (tag,map check_multiply blocklist)
    else
      let
        val blocklist = inline_small_blocks (tag,blocklist)
        val blocklist = coalesce_blocks (tag,blocklist)
        (* The blocks are in the correct order *)
        fun scan ((tag,opcode_list)::rest,acc) =
          let
            (* Find the first instruction of the next block *)
            val next = case rest of
              ((_,(next::_))::_) => SOME next
            | _ => NONE
          in
            scan (rest,(tag,do_block (not mips2,opcode_list,next))::acc)
          end
          | scan ([],acc) = rev acc
        val blocklist = scan (blocklist,[])
(*
        val blocklist =
          map
          (fn (tag,opcode_list) => (tag,do_block opcode_list))
          blocklist
*)
        val blocklist = fill_unconditional_branches blocklist
        val blocklist = remove_redundant (tag,blocklist)
      in
        (tag, map check_multiply blocklist)
      end

end
