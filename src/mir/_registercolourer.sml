(*  ==== REGISTER GRAPH COLOURER ====
 *             FUNCTOR
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
 *  See below for details of the graph data structure.
 *  The colouring algorithm is greedy, but colours the vertex with the most
 *  edges first.
 *
 *  Revision Log
 *  ------------
 *  $Log: _registercolourer.sml,v $
 *  Revision 1.33  1999/02/02 16:01:18  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.32  1998/08/27  12:32:54  jont
 * [Bug #70040]
 * Modify register colourer to use stack colourer only if requested from machspec
 *
 * Revision 1.31  1997/05/02  16:24:33  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.30  1997/04/24  15:43:22  jont
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.29  1997/02/07  12:23:21  jont
 * [Bug #0]
 * Pass name of function to colourer so we don't try too hard on setups and functors
 * Only try to recolour where there are some bug not many spills
 * Only accept the result when all spills are removed
 * This produces an improvement of around 400 bytes in a batch.img
 *
 * Revision 1.28  1997/01/24  12:08:01  jont
 * Redoing so as to use unspill registers when sufficiently few spills
 *
 * Revision 1.27  1996/11/06  11:08:58  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.26  1996/05/07  11:04:50  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.25  1996/04/29  14:48:35  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.24  1996/03/28  11:05:01  matthew
 * Adding where type clause
 *
 * Revision 1.23  1995/12/22  16:31:02  jont
 * Remove references to utils/option
 *
 *  Revision 1.22  1995/05/31  11:25:11  matthew
 *  Simplification
 *
 *  Revision 1.21  1994/10/17  11:37:17  matthew
 *  Use pervasive Option.option for return values in NewMap
 *
 *  Revision 1.20  1994/08/25  13:04:30  matthew
 *  Added move preferencing mechanism (see comments).
 *
 *  Revision 1.19  1994/07/13  10:51:08  jont
 *  Change use of temporaries to be from a list
 *
 *  Revision 1.18  1994/06/10  17:22:37  jont
 *  Use improved register preference sorting
 *
 *  Revision 1.17  1993/10/19  09:09:48  matthew
 *  Added MLWorks to ExtendedArray in a couple of places
 *
 *  Revision 1.16  1993/10/11  13:10:01  jont
 *  Changed the sorting mechanism when the number of vertices is very large,
 *  all that is need is the most popular registers
 *
 *  Revision 1.15  1993/08/03  15:56:48  richard
 *  Added graph printing diagnostics.
 *
 *  Revision 1.14  1993/05/18  14:44:02  jont
 *  Removed Integer parameter
 *
 *  Revision 1.13  1992/12/21  16:34:37  daveb
 *  Chnaged references to Array to ExtendedArray, where appropriate.
 *
 *  Revision 1.12  1992/11/03  14:00:15  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.11  1992/10/02  16:57:46  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the
 *  single-function
 *
 *  Revision 1.10  1992/09/22  10:00:16  clive
 *  Got rid of some handles using tryApply and co
 *
 *  Revision 1.9  1992/08/26  15:21:03  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.8  1992/08/21  07:21:20  richard
 *  Changed use of Array structure due to changes in ther
 *  pervasive environment.
 *
 *  Revision 1.7  1992/06/23  14:10:06  richard
 *  Disabled unspilling -- it doesn't work properly.
 *
 *  Revision 1.6  1992/06/19  11:26:34  richard
 *  If the number of spill is not greater than the number of temporaries
 *  then the temporaries are assigned the spills.
 *
 *  Revision 1.5  1992/06/19  09:50:27  jont
 *  Added missing require integer
 *
 *  Revision 1.4  1992/06/17  10:20:41  richard
 *  Hints are no longer needed by the graphs.
 *  RegisterPack now packs registers incidentally.
 *
 *  Revision 1.3  1992/06/11  11:56:07  richard
 *  Altered the colouring priorities to generate better spill behaviour
 *  when pulling structures apart.
 *
 *  Revision 1.2  1992/06/09  15:58:24  richard
 *  Integer sets are used for adjacency rather than lists, which were
 *  getting rather long!
 *  Colours are now allocated using an ordering which is a parameter to
 *  the functor, and scattered pseudo-randomly across registers which
 *  compare equal.
 *  The colour function no longer returns a set of registers used, as this
 *  always included the preassigned registers and was therefore of little
 *  use.
 *
 *  Revision 1.1  1992/06/04  15:01:35  richard
 *  Initial revision
 *
 *)

require "../basis/__int";
require "../utils/lists";
require "../utils/crash";
require "../utils/diagnostic";
require "../utils/mutableintset";
require "../main/machspec";
require "virtualregister";
require "registercolourer";

functor RegisterColourer (structure Register   : VIRTUALREGISTER where type T = int
			  structure MachSpec   : MACHSPEC
                          structure Lists      : LISTS
                          structure Crash      : CRASH
                          structure Diagnostic : DIAGNOSTIC
                          structure IntSet     : MUTABLEINTSET
                          val instance_name    : Diagnostic.Text.T
                          val preassigned      : Register.Pack.T
                          val available        : Register.Pack.T
                          val debugging_available        : Register.Pack.T
                          val temporaries      : Register.T list
			  val corrupted_by_callee : Register.Pack.T
			  val reserved_but_preferencable : Register.Pack.T
			  val debugger_reserved_but_preferencable : Register.Pack.T
                          val allocation_equal : Register.T * Register.T -> bool
                          val allocation_order : Register.T * Register.T -> bool

                          sharing Diagnostic.Text = Register.Set.Text = IntSet.Text) : REGISTERCOLOURER =
  struct

    structure Register = Register
    structure Diagnostic = Diagnostic

    datatype ('a, 'b) union = INL of 'a | INR of 'b

    val callee_save_temporaries =
      Lists.filterp
      (fn reg => not(Register.Pack.member(corrupted_by_callee, reg)))
      temporaries

    val nr_temporaries = Lists.length temporaries
    val nr_callee_save_temporaries = Lists.length callee_save_temporaries
    val callee_save_temporary_array =
      MLWorks.Internal.Array.arrayoflist callee_save_temporaries

    val have_spills = nr_temporaries <> 0

    val have_callee_save_spills = nr_callee_save_temporaries <> 0

    val do_preferencing = true

    val do_diagnostics = false

    val N = Int.toString
    val $ = Diagnostic.Text.from_string
    val ^^ = Diagnostic.Text.concatenate
    infix ^^

    fun diagnostic (level, output_function) =
      if do_diagnostics
        then
          Diagnostic.output_text level
          (fn verbosity => $"RegisterColourer (" ^^ instance_name ^^ $"): " ^^ output_function verbosity)
      else
        ()

    fun crash message = Crash.impossible ("RegisterColourer: " ^ message)


    (*  == Sort graph vertices ==
     *
     *  This function maps a graph (array of adjacency sets) onto a list of
     *  vertices (array indices).  It is used to determine the order in
     *  which to colour the vertices.
     *
     *  At present the vertex with the largest number of uses is coloured
     *  first.  It is possible that a hybrid between this and the number of
     *  clashes should be used.
     *)

    (* Be nice to have this defined in IntSet -- it would be more efficient *)
    fun intsetforall f a =
      IntSet.reduce
      (fn (r,n) => r andalso f n)
      (true,a)

    val small_size = 32 (* This should depend on machspec later *)

    fun order_vertices (graph, uses) =
      let
	val length = MLWorks.Internal.Array.length graph
      in
	if length <= small_size*2 then
	  let
	    fun order ({vertex=_, uses=uses : int}, {vertex=_, uses=uses'}) = uses >= uses'
	    fun list (l, 0) = l
	      | list (l, n) =
		let
		  val n' = n-1
		in
		  list ({vertex=n', uses=MLWorks.Internal.Array.sub (uses, n')}::l, n')
		end
	  in
	    INL(Lists.qsort order (list ([], length)))
	  end
	else
	  (* The big list case *)
	  (* Algorithm *)
	  (* Set up an array of indirection pointers to the uses array *)
	  (* Sort this to get the largest at the start, but leave the rest *)
	  (* in a random order as we don't care about spill slot ordering *)
	  let
	    val indirections =
	      MLWorks.Internal.Array.tabulate (length, fn x => {vertex=x, uses=MLWorks.Internal.Array.sub(uses, x)})
	    fun find_smallest(result, 0) = result
	      | find_smallest(result as (best, {vertex=_, uses=value}), n) =
		let
		  val n' = n-1
		  val curr as {uses=current, ...} = MLWorks.Internal.Array.sub(indirections, n')
		in
		  find_smallest(if value > current then (n', curr) else result, n')
		end
	    val initial_smallest =
	      find_smallest((0, (MLWorks.Internal.Array.sub(indirections, 0))), small_size)

	    fun try_one_element(n, smallest as (index, value), current) =
	      if #uses current > #uses value then
		let
		  val _ = MLWorks.Internal.Array.update(indirections, index, current)
		  val _ = MLWorks.Internal.Array.update(indirections, n, value)
		(* Swap the larger value in and the smaller out *)
		in
		  find_smallest((0, MLWorks.Internal.Array.sub(indirections, 0)), small_size)
		end
	      else
		smallest

	    val _ = MLWorks.Internal.ExtendedArray.reducel_index
	      try_one_element
	      (initial_smallest, indirections)

	    (* Move all elements from from to to-1 up one place *)
	    fun shuffle(from, to) =
	      if from >= to then ()
	      else
		let
		  val to' = to-1
		in
		  (MLWorks.Internal.Array.update(indirections, to, MLWorks.Internal.Array.sub(indirections, to'));
		   shuffle(from, to'))
		end

	    (* Find index of first value at least as big as the given one *)
	    fun find(0, _:int) = 0
	      | find(m, value) =
		let
		  val m' = m-1
		  val {uses=curr, ...} = MLWorks.Internal.Array.sub(indirections, m')
		in
		  if curr >= value then m else find(m', value)
		end

	    (* a function to insert value in the correct place before n*)
	    (* Order is descending (biggest first) *)
	    fun insert(n, arg as {vertex=_, uses=value}) =
	      let
		val n' = n-1
		val {uses=prev, ...} = MLWorks.Internal.Array.sub(indirections, n')
	      in
		if prev >=  value then () (* Already in the right place *)
		else
		  let
		    val from = find(n', value) (* First place that shouldn't be moved *)
		    val _ = shuffle(from, n) (* Move those above up *)
		  in
		    MLWorks.Internal.Array.update(indirections, from, arg) (* And place in our current one*)
		  end
	      end

	    fun insert_all n =
	      if n >= small_size then () (* Only interested in first smallest_size *)
	      else
		(insert(n, MLWorks.Internal.Array.sub(indirections, n)); (* Put nth in right place *)
		 insert_all(n+1)) (* And recurse *)
	  in
	    INR(insert_all 1; (* Start at 1, because 0th is sorted (on its own) *)
			 indirections)
	  end
      end

    (*  === THE COLOURS ===
     *
     *  The colours are the real register aliases which are assigned to the
     *  virtual registers by the colouring of the graph.  The colour_order
     *  structure is an array of arrays.  Colours are taken from the first
     *  array in this array in preference to the second, and so on.  Colours
     *  are selected pseudo-randomly from each array.  (For any graph the
     *  colouring will be the same.)
     *
     *  Temporaries are registers reserved for the loading and storing of
     *  spills.  However, if the number of spills is not greater than the
     *  number of temporaries the spill slots can be assigned to the
     *  temporaries.  The colouring function does this.
     *)

   fun make_colour_info(available, reserved_but_preferencable) =
     let
       val nr_colours = Register.Pack.cardinality available
       val colours = MLWorks.Internal.Array.arrayoflist (Register.Pack.to_list available)
       val colour_order =
	 let

	   (*  == Insertion Sort Registers ==
	    *
	    *  This function sorts the available registers into a list of
	    *  lists.  The colours to use first are in the first list, and so
	    *  on.
	    *)

	   fun sort list =
	     let
	       fun insert (list, register) =
		 let
		   fun insert' [] = [[register]]
		     | insert' ((e as r::rs) :: es) =
		       (if allocation_equal (register, r)
			  then
			    (register::r::rs) :: es
			else
			  if allocation_order (register, r)
			    then
			      [register] :: e :: es
			  else
			    e :: insert' es)
		     | insert' _ = crash "insert"
		 in
		   insert' list
		 end
	     in
	       Lists.reducel insert ([], list)
	     end

	   (* Convert the list of lists into an array of arrays of colour *)
	   (* numbers. *)

	   fun convert list =
	     let
	       val length = Lists.length list
	       val new = MLWorks.Internal.Array.array (length, MLWorks.Internal.Array.array (0, 0))

	       fun colour register =
		 let
		   fun find 0 = crash "find"
		     | find n = if MLWorks.Internal.Array.sub (colours, n-1) = register then n-1 else find (n-1)
		 in
		   find nr_colours
		 end

	       fun fill (0, []) = new
		 | fill (n, e::es) =
		   (if do_diagnostics
		      then diagnostic (1, fn _ => $"Colour preference " ^^ $(N (n-1)) ^^
				       $" is " ^^ Register.Pack.to_text (Register.Pack.from_list e))
		    else ();
		      MLWorks.Internal.Array.update (new, n-1, MLWorks.Internal.Array.arrayoflist (map colour e));
		      fill (n-1, es))
		 | fill _ = crash "fill"
	     in
	       fill (length, list)
	     end
	 in
	   convert (sort (Register.Pack.to_list available))
	 end
     in
       (nr_colours, colours, colour_order, Register.Pack.cardinality available, reserved_but_preferencable)
     end

    val non_debug_colour_info = make_colour_info(available, reserved_but_preferencable)
    val debug_colour_info = make_colour_info(debugging_available, debugger_reserved_but_preferencable)

    (*  === GRAPH DATA STRUCTURE ===
     *
     *  A Graph consists of an array of adjacency sets and an array of
     *  colourings for the vertices.  The preassigned registers (such as the
     *  argument register) must be coloured so that the colouring function
     *  won't reassign them later.
     *)

    datatype Colour = COLOUR of int | SLOT of int | RESERVED of Register.T | MERGE of Register.T | UNCOLOURED

    type Graph = {nr_vertices : int,
                  graph	      : IntSet.T MLWorks.Internal.Array.array,
                  uses	      : int MLWorks.Internal.Array.array,
                  colouring   : Colour MLWorks.Internal.Array.array}

    local
      val (nr_colours,colours,colour_order, _, _) = debug_colour_info
      val map =
        let
          fun list (done, 0) = done
            | list (done, n) = list ((MLWorks.Internal.Array.sub (colours, n-1), n-1)::done, n-1)
        in
          Register.Map.tryApply (Register.Map.from_list (list ([], nr_colours)))
        end
    in
      fun debugging_preassigned_colour reg =
        case map reg of
          SOME x => COLOUR x
        |  _ => RESERVED reg
    end

    local
      val (nr_colours,colours,colour_order, _, _) = non_debug_colour_info
      val map =
        let
          fun list (done, 0) = done
            | list (done, n) = list ((MLWorks.Internal.Array.sub (colours, n-1), n-1)::done, n-1)
        in
          Register.Map.tryApply (Register.Map.from_list (list ([], nr_colours)))
        end
    in
      fun non_debugging_preassigned_colour reg =
        case map reg of
          SOME x => COLOUR x
        |  _ => RESERVED reg
    end

    fun empty(nr_registers, make_debugging_code) =
      let
        val preassigned_colour =
          if make_debugging_code then debugging_preassigned_colour
          else non_debugging_preassigned_colour
	val colouring =
	  let
	    val colouring = MLWorks.Internal.Array.array (nr_registers, UNCOLOURED)
	  in
	    Register.Pack.iterate
	    (fn reg => MLWorks.Internal.Array.update (colouring, reg, preassigned_colour reg))
	    preassigned;
	    colouring
	  end
      in
        {nr_vertices = nr_registers,
         graph = MLWorks.Internal.Array.array (nr_registers, IntSet.empty),
         uses = MLWorks.Internal.Array.array (nr_registers, 0),
	 colouring = colouring}
      end

    fun both_coloured(colouring, reg, reg') =
      case (MLWorks.Internal.Array.sub(colouring, reg),
	    MLWorks.Internal.Array.sub(colouring, reg')) of
	(COLOUR _, COLOUR _) => true
      | _ => false

    fun clash({graph, uses, colouring, ...} : Graph, defined, referenced, live) =
      (Register.Pack.iterate
       (fn reg => MLWorks.Internal.Array.update (uses, reg, MLWorks.Internal.Array.sub (uses, reg) + 1))
       referenced;

       let
	 val card = Register.Pack.cardinality defined
       in
	 if card > 0 then
	   Register.Pack.iterate
	   (fn reg =>
	    (MLWorks.Internal.Array.update (uses, reg, MLWorks.Internal.Array.sub (uses, reg) + 1);
	     Register.Pack.iterate
	     (fn reg' =>
	      (* avoid self clashes in the graph as this causes trouble later on *)
	      if reg = reg' orelse both_coloured(colouring, reg, reg')
		then ()
	      else
		(MLWorks.Internal.Array.update (graph,reg',IntSet.add' (MLWorks.Internal.Array.sub (graph, reg'),reg));
		 MLWorks.Internal.Array.update (graph,reg,IntSet.add' (MLWorks.Internal.Array.sub (graph, reg),reg'))))
	     live;
	     (* Now clash every defined register with every other one *)
	     (if card > 1 then
		Register.Pack.iterate
		(fn reg' =>
		 (* avoid self clashes in the graph as this causes trouble later on *)
		 if reg = reg' orelse both_coloured(colouring, reg, reg')
		   then ()
		 else
		   (MLWorks.Internal.Array.update (graph,reg',IntSet.add' (MLWorks.Internal.Array.sub (graph, reg'),reg));
		    MLWorks.Internal.Array.update (graph,reg,IntSet.add' (MLWorks.Internal.Array.sub (graph, reg),reg'))))
		defined
	      else
		()))
	    )
	   defined
	 else
	   ()
       end
     )

    datatype assignment = REGISTER of Register.T | SPILL of int

    (*  === COLOUR A GRAPH ===
     *
     *  The colourer works by considering the vertices in order of the
     *  number of edges they have.  The algorithm is basically:
     *
     *  For each vertex in order of nr of clashes:
     *    Clear the availability arrays.
     *    For each adjacent vertex:
     *      If the adjacent vertex is coloured or a spill slot then
     *        make the colour or slot unavailable
     *    Look for an available colour, using the colour_order.
     *    If that fails, look for an available spill slot.
     *)

    (* Preferencing:
     One of the inputs to colour is a list of pairs of registers.  Before
     the main part of the colouring algorithm, the preferencer attempts to
     ensure that each pair will be coloured the same.  If one of the pair is
     a precoloured register, then the other will be coloured the same, if
     possible.  If neither of the two registers have been coloured, they
     will be merged together, and eventually assigned the same colour
     *)

    fun copy_graph graph =
      let
	val graph' =
	  MLWorks.Internal.Array.tabulate
	  (MLWorks.Internal.Array.length graph,
	   fn i => IntSet.from_list(IntSet.to_list(MLWorks.Internal.Array.sub(graph, i))))
      in
	graph'
      end

    fun copy_colouring colouring = MLWorks.Internal.ExtendedArray.duplicate colouring

    fun colour({nr_vertices, graph, uses, colouring},preferences,make_debugging_code, name) =
      let
        val (nr_colours,colours,colour_order, _, reserved_but_preferencable) =
          if make_debugging_code then
	    debug_colour_info
	  else
	    non_debug_colour_info
        val available = MLWorks.Internal.Array.array (nr_colours, true)
        val available_spill = ref (MLWorks.Internal.Array.array (0, true))
        val nr_spills = ref 0
        val scatter = ref 0    (* Seed to scattering register assignments *)

        (* Find the real register corresponding to a merged register *)

        fun real_colour r =
          case MLWorks.Internal.Array.sub (colouring,r) of
            MERGE r' => real_colour r'
          | c => c

	fun resolve r =
	  case MLWorks.Internal.Array.sub (colouring,r) of
	    MERGE r' => resolve r'
	  | _ => r

        (* Try to colour r as c *)
        fun colour_preference (r,c) =
          let
	    (* Check that all registers clashing with r are either *)
	    (* uncoloured, or coloured to something different from c *)
	    (* If not, we can't do the merge *)
	    (* A MERGE should never happen here because merging *)
	    (* updates the clash graph *)
            val ok =
              intsetforall
              (fn r' =>
               case MLWorks.Internal.Array.sub (colouring,r') of
                 COLOUR c' => c <> c'
               | MERGE _ => crash "MERGE in colour_preference"
               | _ => true)
              (MLWorks.Internal.Array.sub (graph,r))
          in
            if ok then
	      ((* output (std_out,"Precolouring " ^ N r ^ " as " ^ N c ^ "\n"); *)
	       MLWorks.Internal.Array.update (colouring,r,COLOUR c))
            else ()
          end

	(* merge r1 and r2 together *)
	(* r2 disappears *)
	fun merge (r1,r2) =
	  if r1 = r2 orelse IntSet.member (MLWorks.Internal.Array.sub (graph,r1),r2)
	    then ()
	  (* Don't merge if they are the same *)
	  (* Or if they clash *)
	  else
	    (* merge the clash sets *)
	    (MLWorks.Internal.Array.update (graph,r1,IntSet.union' (MLWorks.Internal.Array.sub (graph,r1),MLWorks.Internal.Array.sub (graph,r2)));
	     IntSet.iterate
	     (fn r =>
	      let
		val set = MLWorks.Internal.Array.sub (graph,r)
	      in
		MLWorks.Internal.Array.update (graph,r,IntSet.add'(IntSet.remove' (set,r2),r1))
	      end)
	     (MLWorks.Internal.Array.sub (graph,r2));
	     MLWorks.Internal.Array.update (colouring,r2,MERGE r1))

        (* Attempts to do some colouring based on the moves in the program *)
        (* before the main colouring pass *)
	(* This is an aggressive coalesce *)
	(* It can produce graphs which are more difficult to colour *)
	(* One day we will try a conservative coalesce *)

        fun preference (r1,r2) =
          let
            val r1 = resolve r1
            val r2 = resolve r2
          in
	    case (MLWorks.Internal.Array.sub (colouring,r1),MLWorks.Internal.Array.sub (colouring,r2)) of
	      (COLOUR c,UNCOLOURED) => colour_preference (r2,c)
	    | (UNCOLOURED,COLOUR c) => colour_preference (r1,c)
	    | (UNCOLOURED,UNCOLOURED) => merge (r1,r2)
	    (* Allow merging with reserved registers -- *)
	    (* though they shouldn't be used for colouring *)
	    (* Have a special set which can be merged with *)
	    (* We may be able to extend this special set *)
	    | (RESERVED r1',UNCOLOURED) =>
		if Register.Pack.member(reserved_but_preferencable, r1') then
		  merge (r1',r2)
		else ()
	    | (UNCOLOURED,RESERVED r2') =>
		if Register.Pack.member(reserved_but_preferencable, r2') then
		  merge (r2',r1)
		else ()
	    | _ => ()
          end

        (* Scan the neighbours of a vertex, disallowing their colours *)
        (* and spill slots. *)

        fun neighbour vertex =
          case MLWorks.Internal.Array.sub (colouring, vertex)
            of COLOUR c => MLWorks.Internal.Array.update (available, c, false)
             | SLOT s   => MLWorks.Internal.Array.update (!available_spill, s, false)
             | MERGE r => crash (N vertex ^ " = " ^ "MERGE " ^ N r ^ " in neighbour")
             | _        => ()

        fun find_spill (spill,limit,available) =
          if spill = limit
            then (* We've run out of spills, so extend the spill array *)
              let
                val new_nr_spills = if limit = 0 then 4 else limit + limit
              in
                available_spill := MLWorks.Internal.Array.array (new_nr_spills,false);
                nr_spills := limit+1;
                SLOT limit
              end
          else
            if MLWorks.Internal.Array.sub (available, spill) then
              (if spill >= (!nr_spills) then nr_spills := spill+1 else ();
               SLOT spill)
            else
              find_spill (spill+1,limit,available)

        fun find_colour 0 =
          let
            val available = !available_spill
            val limit = MLWorks.Internal.Array.length available
          in
            find_spill (0,limit,available)
          end
          | find_colour n =
            let
              val set = MLWorks.Internal.Array.sub (colour_order, n-1)
              val length = MLWorks.Internal.Array.length set

              fun find 0 = find_colour (n-1)
                | find n =
                  let
                    val colour = MLWorks.Internal.Array.sub (set, (!scatter + n-1) mod length)
                  in
                    if MLWorks.Internal.Array.sub (available, colour) then
		      COLOUR colour
                    else
                      find (n-1)
                  end
            in
              scatter := !scatter+1;
              find length
            end

        (* Scan through the list of vertices, colouring each in turn. *)
        fun colour_one {vertex, uses} =
	  case MLWorks.Internal.Array.sub (colouring, vertex)
	     of UNCOLOURED =>
	       (MLWorks.Internal.ExtendedArray.fill (available, true);
		MLWorks.Internal.ExtendedArray.fill (!available_spill, true);
		IntSet.iterate neighbour (MLWorks.Internal.Array.sub (graph, vertex));
		MLWorks.Internal.Array.update (colouring, vertex, find_colour (MLWorks.Internal.Array.length colour_order)))
	   | _ => ()

	fun colour_all (INL x) = Lists.iterate colour_one x
	  | colour_all (INR x) = MLWorks.Internal.ExtendedArray.iterate colour_one x

(*
        val _ =
          if do_diagnostics
            then
              diagnostic (2, fn _ =>
                          let
                            fun p (text, 0) = text
                              | p (text, n) =
                                p (text ^^ $"\n" ^^ $(N (n-1)) ^^
                                   $": " ^^ $(N (MLWorks.Internal.Array.sub (uses, n-1))) ^^
                                   $"  " ^^ IntSet.to_text (MLWorks.Internal.Array.sub (graph, n-1)), n-1)
                          in
                            p ($"graph", MLWorks.Internal.Array.length graph)
                          end)
          else
            ()
*)

        val _ = if do_preferencing then Lists.iterate preference preferences else ()

	val use_order = order_vertices(graph, uses)
        val _ = colour_all use_order

        (* Use the results of colouring to assign each register to either a *)
        (* real register or a spill slot.  If the number of spill slots is *)
        (* less than the number of callee save temporary registers then the *)
	(* callee save temporaries are assigned to the slots, eliminating *)
	(* the spills. *)

	val do_unspill =
	  let
	    val nr_spills = !nr_spills
	  in
	    0 < nr_spills andalso
	    nr_spills <= nr_callee_save_temporaries
	  end

        val assign =
          let
            val assignments = MLWorks.Internal.Array.array (nr_vertices, SPILL 0)

            fun assign 0 = ()
              | assign n =
                (MLWorks.Internal.Array.update
                 (assignments, n-1,
                  case real_colour(n-1) of
		    UNCOLOURED    => crash "Colour: Unassigned registers after colouring"
		  | MERGE _ => crash "MERGE in assign"
		  | RESERVED reg  => REGISTER reg
		  | COLOUR colour => REGISTER (MLWorks.Internal.Array.sub (colours, colour))
		  | SLOT spill    => if do_unspill then REGISTER(MLWorks.Internal.Array.sub(callee_save_temporary_array, spill)) else SPILL spill);
                 assign (n-1))
          in
            assign nr_vertices;
            if do_diagnostics then
              diagnostic (2, fn _ =>
                          let
                            fun p (text, 0) = text
                              | p (text, n) =
                                p (text ^^ $"\n" ^^ $(N (n-1)) ^^ $" -> " ^^
                                   (case MLWorks.Internal.Array.sub (assignments, n-1)
                                      of REGISTER reg => Register.to_text reg
                                       | SPILL slot   => $(N slot)), n-1)
                          in
                            p ($"assignments", nr_vertices)
                          end)
            else ();
            fn reg => MLWorks.Internal.Array.sub (assignments, reg)
          end
      in
        {assign = assign,
         nr_spills = if do_unspill then 0 else !nr_spills}
      end

    fun resolve colouring =
      let
	fun res r =
	  case MLWorks.Internal.Array.sub (colouring,r) of
	    MERGE r' => res r'
	  | _ => r
      in
	res
      end

    fun find_low_degree_unassigned_node(graph, colouring, nodes_used, real_colours_available) =
      let
	val resolve = resolve colouring
	fun do_node (0, res) = res
	  | do_node (i, res) =
	  let
	    val i' = i-1
	  in
	    if resolve i' <> i' then
	      do_node(i', res) (* Merged node, ignore *)
	    else
	      case Register.Map.tryApply'(nodes_used, i') of
		SOME _ => do_node(i', res) (* Already done this node, ignore *)
	      | NONE =>
		  let
		    val set = MLWorks.Internal.ExtendedArray.sub(graph, i')
		    val degree' = IntSet.cardinality set
		  in
		    case res of
		      SOME(node, degree) =>
			if degree' < degree then
			  let
			    val res = SOME(i', degree')
			  in
			    if degree' < real_colours_available then
			      SOME(i', degree')
			    else
			      do_node(i', res) (* Try for a better one if we can *)
			  end
			else
			  do_node(i', res) (* Try for a better one if we can *)
		    | NONE =>
			let
			  val res = SOME(i', degree')
			in
			  if degree' <= real_colours_available then
			    res
			  else
			    do_node(i', res) (* Try for a better one if we can *)
			end
		  end
	  end
      in
	do_node(MLWorks.Internal.ExtendedArray.length graph, NONE)
      end

    fun assign_stack(nr_vertices, stack, info as (nr_colours, colours, colour_order, _, _),
		     colouring, graph) =
      (*
       * stack is the stack of unassigned resisters, in order
       * nr_colours is the number of real colours available
       * colours is the list of virtual names of the non-reserved machine registers
       * colouring is the assignment of the node names within the graph to
       * the names used within colours
       *)
      let
        val available = MLWorks.Internal.Array.array(nr_colours, true)
        val available_spill = ref (MLWorks.Internal.Array.array (0, true))
        val nr_spills = ref 0

        fun find_spill(spill, limit, available) =
          if spill = limit
            then (* We've run out of spills, so extend the spill array *)
              let
                val new_nr_spills =
                  if limit = 0
                    then 4
                  else limit + limit
              in
                available_spill := MLWorks.Internal.Array.array(new_nr_spills, false);
                nr_spills := limit+1;
                SLOT limit
              end
          else
            if MLWorks.Internal.Array.sub(available, spill) then
              (if spill >= (!nr_spills) then nr_spills := spill+1 else ();
               SLOT spill)
            else
              find_spill (spill+1,limit,available)

        val scatter = ref 0    (* Seed to scattering register assignments *)

        fun find_colour 0 =
	  (* No ordinary register available, so use a spill *)
          let
            val available = !available_spill
            val limit = MLWorks.Internal.Array.length available
          in
            find_spill(0, limit, available)
          end
          | find_colour n =
            let
              val set = MLWorks.Internal.Array.sub(colour_order, n-1)
              val length = MLWorks.Internal.Array.length set
              fun find 0 = find_colour(n-1)
                | find n =
                  let
                    val colour = MLWorks.Internal.Array.sub(set, (!scatter + n-1) mod length)
                  in
                    if MLWorks.Internal.Array.sub(available, colour) then
		      COLOUR colour
                    else
                      find(n-1)
                  end
            in
              scatter := !scatter+1;
              find length
            end

        fun neighbour vertex =
          case MLWorks.Internal.Array.sub(colouring, vertex) of
	    COLOUR c => MLWorks.Internal.Array.update(available, c, false)
	  | SLOT s   => MLWorks.Internal.Array.update(!available_spill, s, false)
	  | MERGE r => crash(N vertex ^ " = " ^ "MERGE " ^ N r ^ " in neighbour")
	  | _        => ()

        fun colour_one vertex =
	  case MLWorks.Internal.Array.sub(colouring, vertex) of
	    UNCOLOURED =>
	      (MLWorks.Internal.ExtendedArray.fill(available, true);
	       MLWorks.Internal.ExtendedArray.fill(!available_spill, true);
	       IntSet.iterate neighbour (MLWorks.Internal.Array.sub(graph, vertex));
	       MLWorks.Internal.Array.update(colouring, vertex, find_colour(MLWorks.Internal.Array.length colour_order)))
	  | _ => ()

	val _ = Lists.iterate colour_one stack

        fun real_colour r =
          case MLWorks.Internal.Array.sub (colouring,r) of
            MERGE r' => real_colour r'
          | c => c

        (* Use the results of colouring to assign each register to either a *)
        (* real register or a spill slot.  If the number of spill slots is *)
        (* less than the number of callee save temporary registers then the *)
	(* callee save temporaries are assigned to the slots, eliminating *)
	(* the spills. *)

	val do_unspill =
	  let
	    val nr_spills = !nr_spills
	  in
	    0 < nr_spills andalso
	    nr_spills <= nr_callee_save_temporaries
	  end

        val assign =
          let
            val assignments = MLWorks.Internal.Array.array (nr_vertices, SPILL 0)

            fun assign 0 = ()
              | assign n =
                (MLWorks.Internal.Array.update
                 (assignments, n-1,
                  case real_colour(n-1) of
		    UNCOLOURED    => crash "Stack Colour: Unassigned registers after colouring"
		  | MERGE _ => crash "MERGE in assign"
		  | RESERVED reg  => REGISTER reg
		  | COLOUR colour => REGISTER (MLWorks.Internal.Array.sub (colours, colour))
		  | SLOT spill    => if do_unspill then REGISTER(MLWorks.Internal.Array.sub(callee_save_temporary_array, spill)) else SPILL spill);
                 assign (n-1))
          in
            assign nr_vertices;
(*
            if do_diagnostics then
              diagnostic (2, fn _ =>
                          let
                            fun p (text, 0) = text
                              | p (text, n) =
                                p (text ^^ $"\n" ^^ $(N (n-1)) ^^ $" -> " ^^
                                   (case MLWorks.Internal.Array.sub (assignments, n-1)
                                      of REGISTER reg => Register.to_text reg
                                       | SPILL slot   => $(N slot)), n-1)
                          in
                            p ($"assignments", nr_vertices)
                          end)
            else ();
*)
            fn reg => MLWorks.Internal.Array.sub (assignments, reg)
          end
      in
	{assign = assign,
	 nr_spills = if do_unspill then 0 else !nr_spills}
      end

    (* Stack based colourer, version two, hopefully less time consuming *)
    (* Find the lowest degree uncoloured node from the graph *)
    (* Remember its degree then remove all its edges *)
    (* If its degree was less than colours_needed, simpy recurse *)
    (* Otherwise, recurse with colours_needed set to degree+1 *)
    (* When no further uncoloured nodes, return the stack we've made *)
    fun stack_colour'
      (nr_vertices, info, graph, uses, colouring, preferences, do_preference, real_colours_available, name, reserved_but_preferencable) =
      let
	fun resolve r =
	  case MLWorks.Internal.Array.sub(colouring,r) of
	    MERGE r' => resolve r'
	  | _ => r

	fun colour_preference(r, c) =
	  let
	    (* Check that all registers clashing with r are either *)
	    (* uncoloured, or coloured to something different from c *)
	    (* If not, we can't do the merge *)
	    (* A MERGE should never happen here because merging *)
	    (* updates the clash graph *)
	    val ok =
	      intsetforall
	      (fn r' =>
	       case MLWorks.Internal.Array.sub(colouring, r') of
		 COLOUR c' => c <> c'
	       | MERGE _ => crash "MERGE in colour_preference"
	       | _ => true)
	      (MLWorks.Internal.Array.sub(graph, r))
	  in
	    if ok then
	      (MLWorks.Internal.Array.update(colouring, r, COLOUR c))
	    else ()
	  end

	(* merge r1 and r2 together *)
	(* r2 disappears *)
	fun merge(r1, r2) =
	  if r1 = r2 orelse IntSet.member(MLWorks.Internal.Array.sub(graph, r1), r2)
	    then ()
	  else
	    (* merge the clash sets *)
	    ((*print("Merging " ^ N r2 ^ " as " ^ N r1 ^ "\n");*)
	     (* Merge on the stacking graph *)
	     MLWorks.Internal.Array.update(graph, r1, IntSet.union'(MLWorks.Internal.Array.sub(graph, r1), MLWorks.Internal.Array.sub(graph, r2)));
	     (* Now replace all clashes with r2 by clashes with r1 in the graphs *)
	     IntSet.iterate
	     (fn r =>
	      let
		val set = MLWorks.Internal.Array.sub(graph, r)
	      in
		MLWorks.Internal.Array.update(graph, r, IntSet.add'(IntSet.remove'(set, r2), r1))
	      end)
	     (MLWorks.Internal.Array.sub(graph, r2));
	     (* Finally update the colouring *)
	     MLWorks.Internal.Array.update(colouring, r2, MERGE r1))

	fun preference (r1, r2) =
	  let
	    val r1 = resolve r1
	    val r2 = resolve r2
	  in
	    case (MLWorks.Internal.Array.sub(colouring, r1), MLWorks.Internal.Array.sub(colouring, r2)) of
	      (COLOUR c, UNCOLOURED) => colour_preference(r2, c)
	    | (UNCOLOURED, COLOUR c) => colour_preference(r1, c)
	    | (UNCOLOURED, UNCOLOURED) => merge(r1, r2)
	    (* Allow merging with reserved registers -- *)
	    (* though they shouldn't be used for colouring *)
	    (* Have a special set which can be merged with *)
	    (* We may be able to extend this special set *)
	    | (RESERVED r1',UNCOLOURED) =>
		if Register.Pack.member(reserved_but_preferencable, r1') then
		  merge (r1',r2)
		else ()
	    | (UNCOLOURED,RESERVED r2') =>
		if Register.Pack.member(reserved_but_preferencable, r2') then
		  merge (r2',r1)
		else ()
	    | _ => ()
	  end

	val _ =
	  if do_preference then
	    Lists.iterate preference preferences
	  else
	    ()

	val unshrunk_graph = copy_graph graph

	fun stack_colour(stack, nodes_used) =
	  case find_low_degree_unassigned_node(graph, colouring, nodes_used, real_colours_available) of
	    NONE => stack
	  | SOME(node, degree) =>
	      (* Recurse with this node removed *)
	      (MLWorks.Internal.Array.update(graph, node, IntSet.empty);
	       MLWorks.Internal.ExtendedArray.iterate_index
	       (fn (i, set) =>
		MLWorks.Internal.Array.update(graph, i, IntSet.remove'(set, node)))
	       graph;
	       stack_colour(node :: stack, Register.Map.define(nodes_used, node, true)))

      in
	assign_stack(nr_vertices, stack_colour([], Register.Map.empty), info, colouring, unshrunk_graph)
      end

    val colour =
      fn (args as ({nr_vertices, graph, uses, colouring},
		   preferences,make_debugging_code, name)) =>
      if MachSpec.use_stack_colourer then
	let
	  val info as (_, _, _, real_colours_available, reserved_but_preferencable) =
	    if make_debugging_code then debug_colour_info else non_debug_colour_info
	  fun ignore_stack_colourer s =
	    let
	      fun is_prefix n =
		let
		  val l = size n
		in
		  size s > l andalso MLWorks.String.substring (s,0,l) = n
		end
	    in
	      is_prefix "<Setup>" orelse is_prefix "Functor "
	    end

	  val ignore = ignore_stack_colourer name
	  val (result as {nr_spills, ...}, result' as {nr_spills=nr_spills', ...}) =
	    if ignore then
	      let
		val result = colour args
	      in
		(result, result)
	      end
	    else
	      let
		val graph' = copy_graph graph
		val colouring' = copy_colouring colouring
		val result as {nr_spills, ...} = colour args

		(* Now retry using the stack colourer *)
		val result' =
		  if nr_spills = 0 orelse nr_spills > 3 then
		    (* No point if no spills, or too many, as we will ignore the result *)
		    result
		  else
		    stack_colour'
		    (nr_vertices, info, graph', uses, colouring', preferences, do_preferencing, real_colours_available, name, reserved_but_preferencable)
	      in
		(result, result')
	      end
	in
	  (* Accept stack colourer result if it gets rid of all spills *)
	  if nr_spills' = 0 then result' else result
	end
      else
	colour args
  end
