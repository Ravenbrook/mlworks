(* _sparc_schedule.sml the functor *)
(*
$Log: _sparc_schedule.sml,v $
Revision 1.42  1997/05/01 13:18:35  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.41  1997/04/21  15:49:28  jont
 * [Bug #20001]
 * Remove debugging comments when filling load delays
 *
 * Revision 1.40  1997/02/04  17:29:53  matthew
 * Adding treatment of load delays
 *
 * Revision 1.39  1995/12/22  16:31:24  jont
 * Remove references to utils/option
 *
Revision 1.38  1995/12/22  13:04:35  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.37  1995/07/28  09:22:27  matthew
Putting sources registers for various instructions in correct order

Revision 1.36  1994/10/13  11:22:48  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.35  1994/07/22  16:13:48  nickh
Prevent rescheduling of allocation sequence.
(Also add comments and abstract common code to a function).

Revision 1.34  1994/03/09  15:54:40  jont
Adding load offset instructions

Revision 1.33  1993/07/29  15:30:08  nosa
structure Option.

Revision 1.32  1993/05/18  18:58:49  jont
Removed integer parameter

Revision 1.31  1993/02/25  15:03:02  jont
Modified to use new variable size hashsets

Revision 1.30  1993/01/27  14:34:43  jont
Improved scheduling of short blocks. Improved procedure level scheduling
by removing chained branchs first as well as after

Revision 1.29  1993/01/20  17:53:35  jont
Made selection of 3 instruction blocks more selective, to allow
scheduling of short blocks which tail or call but not those which branch

Revision 1.28  1992/12/08  11:18:37  clive
Changed the type of nop used for tracing to store it being moved by the scheduler

Revision 1.27  1992/12/03  11:28:37  clive
Changed reschedule block to ignore the small blocks (really to
get the new stack overflow check optimised)

Revision 1.26  1992/12/01  20:51:33  jont
Modified to use new improved hashset signature

Revision 1.25  1992/10/30  12:34:53  jont
Modified to use MirTypes.Map for the tag lookups

Revision 1.24  1992/10/05  10:09:28  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.23  1992/09/16  10:17:56  clive
Removed some handles of hashtable lookup exceptions

Revision 1.22  1992/08/26  16:14:27  jont
Removed some redundant structures and sharing

Revision 1.21  1992/08/10  10:35:15  davidt
Now uses NewMap instead of BalancedTree structure.
Array is now pervasive.

Revision 1.20  1992/07/30  19:05:09  jont
Fixed problem with delay opcodes disappearing from between fcmp
and fb

Revision 1.19  1992/05/06  18:23:00  jont
Modified the inter block rescheduler to use hash sets and
balanced trees instead of sets and association lists

Revision 1.18  1992/03/05  11:47:43  jont
Reded intrablock shceduling to be much more efficient

Revision 1.17  1992/02/18  19:26:00  jont
Improved speed of rescheduling by about a factor of ten by
careful use of set primitives

Revision 1.16  1992/02/17  17:32:51  richard
Some efficiency changes by jont re-checked because of accidental
deletion.

Revision 1.16  1992/02/17  16:39:29  richard
Some attempts at improving efficiency by jont.  This revision
was accidentally deleted so I rechecked it.

Revision 1.18  1992/02/14  19:31:47  jont
Some attempts at improving rescheduling efficiency

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

require "../utils/_hashset";
require "../utils/crash";
require "../utils/lists";
require "sparc_assembly";
require "sparc_schedule";

functor Sparc_Schedule(
  structure Crash : CRASH
  structure Lists : LISTS
  structure Sparc_Assembly : SPARC_ASSEMBLY
  ) : SPARC_SCHEDULE =
struct
  structure Sparc_Assembly = Sparc_Assembly
  structure MirTypes = Sparc_Assembly.MirTypes
  structure Set = MirTypes.Set
  structure MachTypes = Sparc_Assembly.Sparc_Opcodes.MachTypes
  structure NewMap = MirTypes.Map
  structure HashSet = HashSet(
    structure Crash = Crash
    structure Lists = Lists
    type element = MirTypes.tag
    val eq = MirTypes.equal_tag
    val hash = MirTypes.int_of_tag
      )


  (* limit on the number of instructions to look at for a slot filler *)
  val schedule_limit = 20

  val hashset_size = 32

  fun refs_for_opcode_list(done, []) = done
  | refs_for_opcode_list(done, (_, SOME tag, _) :: rest) =
    refs_for_opcode_list(HashSet.add_member(done, tag), rest)
  | refs_for_opcode_list(done, _ :: rest) =  refs_for_opcode_list(done, rest)

  fun refs_for_block (done, (tag, opcode_list)) =
    refs_for_opcode_list(done, opcode_list)

  fun refs_all (tag, block_list) =
    Lists.reducel
    refs_for_block
    (HashSet.add_member(HashSet.empty_set hashset_size, tag), block_list)

  val nop_code = Sparc_Assembly.nop_code
  val nop = (nop_code, NONE, "")

  fun passes_from_sets((first_i_defines, first_i_uses, first_r_defines, first_r_uses),
		       (second_i_defines, second_i_uses, second_r_defines, second_r_uses)) =
    (* Return true if the first instruction can safely pass the second *)
    not (Set.intersect (first_i_defines, second_i_defines)) andalso
    not (Set.intersect (first_i_defines, second_i_uses)) andalso
    not (Set.intersect (first_i_uses, second_i_defines)) andalso
    not (Set.intersect (first_r_defines, second_r_defines)) andalso
    not (Set.intersect (first_r_defines, second_r_uses)) andalso
    not (Set.intersect (first_r_uses, second_r_defines))

  fun convert_branch_annul(Sparc_Assembly.BRANCH_ANNUL
			   (branch, disp), tag_opt, comment) =
    (Sparc_Assembly.BRANCH(branch, disp), tag_opt, comment)
    | convert_branch_annul(Sparc_Assembly.FBRANCH_ANNUL
			   (branch, disp), tag_opt, comment) =
      (Sparc_Assembly.FBRANCH(branch, disp), tag_opt, comment)
    | convert_branch_annul opcode = opcode

  fun has_delay(Sparc_Assembly.BRANCH _) = true
    | has_delay(Sparc_Assembly.BRANCH_ANNUL _) = true
    | has_delay(Sparc_Assembly.FBRANCH _) = true
    | has_delay(Sparc_Assembly.FBRANCH_ANNUL _) = true
    | has_delay(Sparc_Assembly.Call _) = true
    | has_delay(Sparc_Assembly.JUMP_AND_LINK _) = true
    | has_delay _ = false


(* remove_doubled_instrs turns this sequence:
		bcc,a	dest
		instr		\these two instrs
		instr		/are identical
   into this:
		bcc	dest
		instr
*)
  
  fun remove_doubled_instrs(tag, opcode_list) =
    let
      fun remove(done, []) = rev done
      | remove(done, [x]) = rev(x :: done)
      | remove(done, [x, y]) = rev(y :: x :: done)
      | remove(done,
	       (opc as (Sparc_Assembly.BRANCH_ANNUL(opcode, i),
			SOME tag, comment)) ::
	       (other as
		(op1 as (opc1, opt1, _)) ::
		(op2 as (opc2, opt2, _)) :: rest)) =
	(case opcode of
	   Sparc_Assembly.BA =>
             (* Got rid of the error message as it was given for computed gotos -
                we really ought to check that it is a computed goto at this point *)
	      remove(opc :: done, other)
	 | _ =>
	     if opc1 = opc2 andalso opt1 = opt2 then
	       remove(op1 :: (Sparc_Assembly.BRANCH(opcode, i),
			      SOME tag, comment) :: done, rest)
	     else
	       remove(op1 :: opc :: done, op2 :: rest))
	| remove(done, x :: rest) = remove(x :: done, rest)
	  
    in
      (tag, remove([], opcode_list))
    end

  fun get_tag_and_instr(tag, opcode :: _) = (tag, opcode)
    | get_tag_and_instr(_, _) = Crash.impossible"Empty block"


(* find_baa_block returns true on a block which is just a ba,a *)
(* instruction (and an optional nop *)

  fun find_baa_block(_, []) = Crash.impossible"Empty block"
    | find_baa_block(_, (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),
			 _, _) :: rest) =
      (case rest of
	 [] => true
       | [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL(Sparc_Assembly.AND,
						 MachTypes.G0,
						 MachTypes.G0,
						 Sparc_Assembly.IMM 0),
	   _, _)] => true
       | _ => Crash.impossible"Unreachable instructions after BAA")
    | find_baa_block _ = false

  (* 'get_transitive_dest table ([],tag)' uses the table to look for the
   ultimate destination of the branch at tag. *)

  fun get_transitive_dest baa_tags_and_dests =
    let
      fun g_t_d(visited, tag) =
	(case NewMap.tryApply'(baa_tags_and_dests, tag) of
	   SOME dest_tag =>
	     (case NewMap.tryApply'(baa_tags_and_dests, dest_tag) of
		SOME _ =>
		  if not(Lists.member(tag, visited)) then
		    g_t_d(tag :: visited, dest_tag)
		  else dest_tag
	      | NONE => dest_tag)
	 | NONE => Crash.impossible"get_transitive_dest failure")
    in
      g_t_d
    end

  (* replace_chained_branch table replaces branches to ba,a branches
     with branches to the destination *)

  fun replace_chained_branch baa_tags_and_dests =
    fn (opcode as (Sparc_Assembly.BRANCH(branch, _),
		   SOME tag, comment)) =>
    (case NewMap.tryApply'(baa_tags_and_dests, tag) of
       SOME dest_tag => 
	 (Sparc_Assembly.BRANCH(branch, 0), SOME dest_tag, comment)
     | NONE => opcode)
    | (opcode as (Sparc_Assembly.BRANCH_ANNUL(branch,_),
		  SOME tag, comment)) =>
      (case NewMap.tryApply'(baa_tags_and_dests, tag) of
	 SOME dest_tag =>
	   (Sparc_Assembly.BRANCH_ANNUL(branch, 0), SOME dest_tag, comment)
       | NONE => opcode)
    |  opcode => opcode


  fun replace_chained_branches block_list =
    let
      (* baa_blocks is the set of blocks which are simply ba,a branches *)

      val baa_blocks = Lists.filterp find_baa_block block_list

      (* baa_tags_and_dests is a map from tags of baa_blocks to the
         destinations of their branches *)

      val baa_tags_and_dests =
	Lists.reducel
	(fn (tree,
	     (tag,
	      (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),
	       SOME dest_tag, _) :: _)) =>
	 NewMap.define(tree, tag, dest_tag)
	     | _ => Crash.impossible"Bad baa block")
	(NewMap.empty, baa_blocks)

      (* "get_transitive_dest' ([],tag)" finds the tag of the ultimate
       destination of a chain of baa blocks starting at "tag" *)

      val get_transitive_dest' = get_transitive_dest baa_tags_and_dests

      (* baa_tags_and_dests is a map from tags of baa blocks to their
         ultimate destinations *)

      val baa_tags_and_dests =
	Lists.reducel
	(fn (tree, (tag, _)) =>
	 NewMap.define(tree, tag, get_transitive_dest'([], tag)))
	(NewMap.empty, baa_blocks)

      (* replace_chained_branch' op replaces any branch to a baa block
         with a branch to the ultimate destination. *)

      val replace_chained_branch' = replace_chained_branch baa_tags_and_dests
    in
      (* return the block list with branches fixed as above *)
      map
      (fn (tag, opcode_list) =>
       (tag, map replace_chained_branch' opcode_list))
      block_list
    end

(* has_delay' x returns true if the instruction cannot be moved
(i.e. if it has a delay slot or is one of a couple of special
instructions) *)

  fun has_delay'(Sparc_Assembly.LOAD_OFFSET _) = true
    | has_delay'(Sparc_Assembly.TAGGED_ARITHMETIC (_, MachTypes.G1,_,_)) = true
    | has_delay' x = has_delay x

  fun is_fcmp op1 =
    case op1 of
      Sparc_Assembly.FUNARY (funary,_,_) =>
        (case funary of
           Sparc_Assembly.FCMPS => true
         | Sparc_Assembly.FCMPD => true
         | Sparc_Assembly.FCMPX => true
         | _ => false)
    | _ => false

  fun is_fbranch op1 =
    case op1 of
      Sparc_Assembly.FBRANCH _ => true
    | Sparc_Assembly.FBRANCH_ANNUL _ => true
    | _ => true

  (* This function indicates if we should attempt to separate two instructions *)
  (* The SPARC architecture manual suggests separating loads and instructions *)
  (* use the the result of the load, and any two store instructions *)
  (* Return true if we should attempt to separate the two instructions *)
  fun try_separate (op1,op2) =
    (* op2 follows op1 *)
    not (has_delay op1) andalso 
    let
      fun is_store_op (Sparc_Assembly.LOAD_AND_STORE(ls,_,_,_)) =
        (case ls of
           Sparc_Assembly.STB => true
         | Sparc_Assembly.STH => true
         | Sparc_Assembly.ST => true
         | Sparc_Assembly.STD => true
         | _ => false)
        | is_store_op (Sparc_Assembly.LOAD_AND_STORE_FLOAT (ls,_,_,_)) =
           (case ls of
              Sparc_Assembly.STF => true
            | Sparc_Assembly.STDF => true
            | _ => false)
        | is_store_op _ = false
      datatype reg = GC of MachTypes.Sparc_Reg | FLOAT of MachTypes.Sparc_Reg | NOREG
      val (load_reg,is_store) =
        case op1 of
          Sparc_Assembly.LOAD_AND_STORE (ls,reg,_,_) =>
            if is_store_op op1 then (NOREG,true)
            else (GC reg,false)
        | Sparc_Assembly.LOAD_AND_STORE_FLOAT (ls,reg,_,_) =>
            if is_store_op op1 then (NOREG,true)
            else (FLOAT reg,false)
        | _ => (NOREG,false)
    in
      case load_reg of
        NOREG =>
          (is_store andalso is_store_op op2) orelse
          (is_fcmp op1 andalso is_fbranch op2)
      | GC r => 
          let
            val (i_def, i_use, r_def, r_use) =
              Sparc_Assembly.defines_and_uses op2
          in
            Set.is_member (r,i_use)
          end
      | FLOAT r => 
          let
            val (i_def, i_use, r_def, r_use) =
              Sparc_Assembly.defines_and_uses op2
          in
            Set.is_member (r,r_use)
          end
    end

  fun reschedule_proc(tag, block_list) =
    let
      (* Attempt to move instructions from the starts of blocks into the delay slots *)
      (* of instructions referencing them from other blocks *)
      (* Mustn't move LOAD_OFFSET instructions *)
      (* which may expand into more than one opcode *)

      val block_list = replace_chained_branches block_list

      (* all_tags_and_instrs is a list of the tags and leading
         instructions of basic blocks *)

      val all_tags_and_instrs =	map get_tag_and_instr block_list

      (* ok_tags_and_instrs is a list of tags and leading instructions
       of basic blocks for which those leading instructions can be
       moved into delay slots *)

      val ok_tags_and_instrs =
	Lists.filterp
	(fn (_, (x, _, _)) => not(has_delay' x))
	all_tags_and_instrs

      (* "get_ref_tags_for_block (hs,instr_list)" looks through
       instr_list for annulled branches with nop in the delay slot,
       and adds their destinations to the hashset hs *)
         	
      fun get_ref_tags_for_block(done, []) = done
	| get_ref_tags_for_block(done,
				 (Sparc_Assembly.BRANCH_ANNUL(branch, _),
				  SOME tag, _) :: rest) =
	  (case (branch, rest) of
	     (Sparc_Assembly.BA, _) =>
	       get_ref_tags_for_block(done, rest)
	     | (_, (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
		    (Sparc_Assembly.AND, MachTypes.G0, MachTypes.G0, Sparc_Assembly.IMM 0), _, _) :: _) =>
	       get_ref_tags_for_block(HashSet.add_member(done, tag), rest)
		   | _ => get_ref_tags_for_block(done, rest))
	| get_ref_tags_for_block(done,
				 (Sparc_Assembly.FBRANCH_ANNUL(branch, _),
				  SOME tag, _) :: rest) =
	  (case (branch, rest) of
	     (Sparc_Assembly.FBA, _) =>
	       get_ref_tags_for_block(done, rest)
	     | (_, (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
		    (Sparc_Assembly.AND, MachTypes.G0, MachTypes.G0, Sparc_Assembly.IMM 0), _, _) :: _) =>
	       get_ref_tags_for_block(HashSet.add_member(done, tag), rest)
		   | _ => get_ref_tags_for_block(done, rest))
	| get_ref_tags_for_block(done, _ :: rest) =
	  get_ref_tags_for_block(done, rest)

      (* ref_tags is a hashset of all destinations of annulled
         branches with nop in the delay slot *)

      val ref_tags =
	Lists.reducel
	(fn (tags, (tag, x)) => get_ref_tags_for_block(tags, x))
	(HashSet.empty_set hashset_size, block_list)


      (* ref_tags_etc is a map, mapping tag to (instruction,newtag),
         where tag was the tag of a basic block, of which instruction
         was the first instruction, and it was relocatable, and it was
         the destination of an annulled branch with nop in the delay
         slot. The idea is that we'll stick that leading instruction
         in the delay slot *)
	
      fun filter_fun(tag, _) = HashSet.is_member(ref_tags, tag)

      val ref_tags_etc =
	Lists.reducel
	(fn (tree, (tag, instr)) =>
	 NewMap.define(tree, tag, (instr, MirTypes.new_tag())))
	(NewMap.empty,
	 Lists.filterp filter_fun ok_tags_and_instrs)

      (* new_block_list is a block list which has split each of the
       blocks we've identified as able to lose their leading
       instruction (see ref_tags_etc, above) into two blocks: one with
       the leading instruction and original tag, the other with the
       rest and the new tag. *)

      fun split_blocks(acc, []) = rev acc
      | split_blocks(_, (_, []) :: _) = Crash.impossible"Empty block"
      | split_blocks(acc, (block as (tag, opcode :: rest)) :: others) =
        (case NewMap.tryApply'(ref_tags_etc, tag) of
           SOME (instr, dest_tag) =>
	     split_blocks
             ((tag,
	       [opcode,
		(Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, 0),
		 SOME dest_tag,
		 "Split off leading instruction")]) ::
	      (dest_tag, rest) ::
	      acc,
	      others)
	 | NONE =>
             split_blocks(block :: acc,  others))

      val new_block_list = split_blocks([], block_list)

      (* do_replace ([],instr_list) fills any nop delay slots of
       annulled branches in instr_list that it can, using the
       information gathered above. *)

      fun do_replace(done, []) = rev done
	| do_replace(done, [opcode]) = rev(opcode :: done)
	| do_replace(done, op1 :: op2 :: rest) =
	  (case (op1, op2) of
	     ((Sparc_Assembly.BRANCH_ANNUL(branch, _), SOME tag,
	       bcomment),
	      (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
	       (Sparc_Assembly.AND, MachTypes.G0, MachTypes.G0, Sparc_Assembly.IMM 0), _, _)) =>
	     (case NewMap.tryApply'(ref_tags_etc, tag) of
		SOME ((opcode, tag_opt, comment), new_tag) => 
		  if branch = Sparc_Assembly.BA then
		    do_replace(op2 :: op1 :: done, rest)
		  else
		    do_replace((opcode, tag_opt, comment ^
				" moved to annulled delay slot") ::
			       (Sparc_Assembly.BRANCH_ANNUL(branch, 0),
				SOME new_tag, bcomment) :: done,
			       rest)
	      | NONE =>
		  do_replace(op2 :: op1 :: done, rest))
	   | ((Sparc_Assembly.FBRANCH_ANNUL(branch, _), SOME tag,
	       bcomment),
	      (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
	       (Sparc_Assembly.AND, MachTypes.G0, MachTypes.G0, Sparc_Assembly.IMM 0), _, _)) =>
	     (case NewMap.tryApply'(ref_tags_etc, tag) of
		SOME ((opcode, tag_opt, comment), new_tag) =>
		  if branch = Sparc_Assembly.FBA then
		    do_replace(op2 :: op1 :: done, rest)
		  else
		    do_replace((opcode, tag_opt, comment ^
				" moved to annulled delay slot") ::
			       (Sparc_Assembly.FBRANCH_ANNUL(branch, 0),
				SOME new_tag, bcomment) :: done,
			       rest)
	      | NONE =>
		  do_replace(op2 :: op1 :: done, rest))
	   | _ => do_replace(op1 :: done, op2 :: rest))

      (* new_new_block_list is the block list after filling delay slots *)

      fun replace_delay_slots(tag, opcode_list) =
	(tag, do_replace([], opcode_list))

      val new_new_block_list = map replace_delay_slots new_block_list
      val next_block_list = replace_chained_branches new_new_block_list
      (* remove any blocks which are not referred to by other blocks *)
      val new_ref_tags = refs_all(tag, next_block_list)
      fun use_block(tag, _) = HashSet.is_member(new_ref_tags, tag)
      val final_block_list = Lists.filterp use_block next_block_list
      (* Finally, remove doubled instructions *)
      val result as (_, blocks) = (tag, map remove_doubled_instrs final_block_list)
    in
	result
    end

(*
  val reschedule_proc = fn x => reschedule_proc(reschedule_proc x)
*)

  fun combine((i_d1, i_u1, r_d1, r_u1), (i_d2, i_u2, r_d2, r_u2)) =
    (Set.union(i_d1, i_d2), Set.union(i_u1, i_u2), Set.union(r_d1, r_d2),
     Set.union(r_u1, r_u2))

  (* This looks for "special" instructions that will terminate the search for a slot filler *)
  fun immoveable opcode =
    opcode = Sparc_Assembly.other_nop_code orelse
    (case opcode of
       Sparc_Assembly.LOAD_OFFSET _ => true
     (* don't relocate over a load_offset *)
     | Sparc_Assembly.TAGGED_ARITHMETIC (_, MachTypes.G1,_,_) => true
     | Sparc_Assembly.ARITHMETIC_AND_LOGICAL (_, MachTypes.G2,_,_) => true
     (* don't relocate over an allocation *)
     | Sparc_Assembly.FUNARY _ => true
     (* don't relocate over an FMCP -- in particular, don't move the nop *)
     | _ => false)

  (* pos is the number of instructions passed over *)
  fun search_for_moveable_instr(pos, _, next, []) = (pos, false, nop)
    | search_for_moveable_instr(pos, current_defs, next,
				(opc as (opcode, _, _)) :: rest) =
      if pos > schedule_limit orelse immoveable opcode
	then (pos,false,nop)
      else
	let
          (* check opc2 doesn't stall with the next instruction *)
          fun check_next opc2 =
            (case next of
               NONE => true
             | SOME opc1 => not (try_separate (opc1,opc2)))
	  val is_delay = case rest of
	    [] => false
	  | (opc', _, _) :: _ => has_delay opc'
	in
	  if is_delay
            then (pos, false, nop)
	  else
	    let
	      val (i_def, i_use, r_def, r_use) =
		Sparc_Assembly.defines_and_uses opcode
	      val new_defs =
		(Set.setdiff(i_def, Set.singleton MachTypes.G0), 
		 Set.setdiff(i_use, Set.singleton MachTypes.G0),
		 r_def, r_use)
	    in
              if passes_from_sets(new_defs, current_defs) 
                andalso check_next opcode then
                (pos, true, opc)
              else
                search_for_moveable_instr(pos+1, combine(new_defs, current_defs),
                                          next, rest)
	    end
	end

  fun copy_over (0, done, rest) = (done,rest)
    | copy_over (n, done, []) = Crash.impossible "copy_over: out of code"
    | copy_over (n, done, x::rest) = copy_over(n-1, x :: done, rest)

  fun drop [] = Crash.impossible "drop: out of code"
    | drop (a::b) = b

  fun traverse(done, static, []) = done
    | traverse(done, static, [x]) = x :: done
    | traverse(done, 
               static,
               (x as (opc1, _, _)) ::
	       (rest as ((y as (opc2, tag2, com2)) :: rest_of_block))) =
      if opc1 = nop_code andalso has_delay opc2 then
	(* The difficult case, we've found a delay slot we would like to fill *)
	let
	  val (pos, found, z) =
	    search_for_moveable_instr(0, Sparc_Assembly.defines_and_uses opc2,
                                      NONE,rest_of_block)
	in
	  if found then
	    (* Got a moveable instr, so move it in *)
	    let
	      val (done, rest) =
		copy_over (pos, convert_branch_annul y :: z :: done,
                                    rest_of_block)
	    in
              traverse(done, static, drop rest)
	    end
	  else 
            traverse(y :: x :: done, static, rest_of_block)
	end
      else if not static andalso try_separate (opc2,opc1)
        then
          let
            val (pos,found,z) =
              search_for_moveable_instr (0,Sparc_Assembly.defines_and_uses opc2,
                                         SOME opc2, rest_of_block)
          in
            if found then
              let
                val (done,rest) =
                  copy_over (pos, (opc2,tag2,com2) :: z :: x :: done,rest_of_block)
              in
                traverse (done,static,drop rest)
              end
            else 
              (traverse (x :: done, static, (opc2,tag2,com2) :: rest_of_block))
          end
      else
	traverse(x :: done, static, rest)

  (* This goes through the code forwards *)
  fun trav2(acc,true, l) = rev l
    | trav2(acc,static,[]) = acc
    | trav2(acc,static,[a]) = a::acc
    | trav2(acc,static,(opc1,tag1,com1)::(opc2,tag2,com2)::rest) =
    let
      fun find_filler (n,[],_) = NONE
        | find_filler (n,(opc3,tag3,com3)::rest,current_defs) =
        if n > schedule_limit orelse has_delay opc3 orelse immoveable opc3 then NONE
        else
          let
            val (i_def, i_use, r_def, r_use) =
              Sparc_Assembly.defines_and_uses opc3
            val new_defs =
              (Set.setdiff(i_def, Set.singleton MachTypes.G0), 
               Set.setdiff(i_use, Set.singleton MachTypes.G0),
               r_def, r_use)
          in
            if passes_from_sets(current_defs,new_defs) andalso
              not (try_separate (opc1,opc3)) (* Would just get another delay *)
              then SOME ((opc3,tag3,com3),n)
            else
              find_filler (n+1,rest,
                           combine(new_defs, current_defs))
          end
    in
      (* if opc2 is a branch of some sort then it's pointless looking after it *)
      (* since all there will be is the delay slot *)
      if not (has_delay opc2) andalso try_separate (opc1,opc2)
        then
          case find_filler (0,rest,Sparc_Assembly.defines_and_uses opc2) of
            NONE => trav2 ((opc1,tag1,com1)::acc,static,(opc2,tag2,com2)::rest)
          | SOME (c,n) => 
              let
                val (done,rest) = copy_over (n,(opc2,tag2,com2) :: c :: (opc1,tag1,com1) :: acc, rest)
              in
                trav2 (done,static,drop rest)
              end
      else trav2 ((opc1,tag1,com1)::acc,static,(opc2,tag2,com2)::rest)
    end

  (* Insert nops as required between fcmps and fbranches *)
  fun check_fcmp opcodelist =
    let
      fun check (op1 :: op2 :: rest,acc) =
        if is_fcmp (#1 op1) andalso is_fbranch (#1 op2)
          then check (rest,op2 :: nop :: op1 :: acc)
        else check (op2::rest,op1::acc)
        | check ([a],acc) = rev (a::acc)
        | check ([],acc) = rev acc
    in
      case opcodelist of
        (op1 as (Sparc_Assembly.FBRANCH _,_,_)) :: rest => check (rest,[op1,nop])
      | (op1 as (Sparc_Assembly.FBRANCH_ANNUL _,_,_)) :: rest => check (rest,[op1,nop])
      | _ => check (opcodelist,[])
    end

  (* The static flag indicates that we are dealing with a setup procedure or *)
  (* a functor, so needn't worry about some of the transformations *)
  fun reschedule_block
    (static, ops as [_, (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),_,_), _]) = ops
    | reschedule_block (static,opcode_list) =
    let
      val l1 = if false then trav2 ([],static,opcode_list) else rev opcode_list
      val l2 = if true then traverse ([],static,l1) else rev l1
      val l3 = if true then rev (trav2 ([],static,l2)) else l2
    in
      (* Note that we _must_ do check_fcmp or we may get scheduling errors *)
      check_fcmp l3
    end

end
