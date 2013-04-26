(* _hashset.sml the functor *)
(*
$Log: _hashset.sml,v $
Revision 1.19  1998/02/19 16:46:57  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.18  1996/11/06  10:53:55  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.17  1996/10/28  14:25:57  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.16  1996/05/17  09:18:31  matthew
 * Moving Bits to MLWorks.Internal
 *
 * Revision 1.15  1996/05/07  10:44:29  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.14  1996/04/30  17:45:12  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.13  1996/04/29  13:50:56  matthew
 * Integer changes
 *
 * Revision 1.12  1993/05/20  12:48:37  jont
 * Added a rehash function to deal with sets where the hash value changes
 * due to update (eg Namesets)
 *
Revision 1.11  1993/05/18  18:35:45  jont
Removed integer parameter

Revision 1.10  1993/03/01  11:48:58  jont
Modified to allow expansion and contraction of the hashset according to amount
of data.

Revision 1.9  1992/12/22  10:54:13  clive
Corrected references to ExtendedArray

Revision 1.8  1992/12/21  13:28:29  daveb
Chnaged references to Array to ExtendedArray, where appropriate.

Revision 1.7  1992/12/01  18:37:30  jont
Improved to avoid parameter recopying in numerous places

Revision 1.6  1992/08/27  16:23:06  jont
Recoded using new array utilities

Revision 1.5  1992/08/13  16:15:29  davidt
Added iterate function.

Revision 1.4  1992/08/04  19:07:11  davidt
Added fold function.

Revision 1.3  1992/08/04  11:02:53  jont
Removed unnecessary require

Revision 1.2  1992/07/16  16:23:04  jont
Removed array parameter, now uses pervasive one

Revision 1.1  1992/04/21  16:57:29  jont
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

require "^.basis.__int";
require "hashset";
require "crash";
require "lists";

(* A few basic well-known set functions, using a hashtable internally *)

functor HashSet(
  structure Crash : CRASH
  structure Lists : LISTS
  type element
  val eq : element * element -> bool
  val hash : element -> int
) : HASHSET =
  struct

    structure Bits = MLWorks.Internal.Bits

    type element = element

    type HashSet = ((int * element) list MLWorks.Internal.ExtendedArray.array * int ref) ref
    (* (hash value, element) list array * available until we resize count *)

    val max_size = 16384
    (* A safe amount by which to reduce during hash calculation *)

    fun member(elt, []) = false
      | member(elt, (_, x) :: xs) = eq(elt, x) orelse member(elt, xs)

    (*
     This expansion ratio of 2 is used to maintain the fact that the tables
     are a power of two in size. This means we may use bitwise operations to go from
     hash value to table index, and can do the resize operation much more
     quickly - if this is changed, some of the other functions need to be re-written
     *)

    val expansion_ratio = 2
    (* factor to increase by on re-size - if this is changed from 2, adjust
     partitioning part of the re-sizing code in update *)
    val max_size_ratio = 4
    (* resize when number of elements is this multiplied by the size *)

    fun set_size(ref(the_lists, ref count)) =
      let
	val c1 =
	  MLWorks.Internal.ExtendedArray.reducel
	  (fn (sum, list) => sum + length list)
	  (0, the_lists)
	val c2 = MLWorks.Internal.ExtendedArray.length the_lists * max_size_ratio - count
      in
	if c1 = c2 then c1
	else
	  Crash.impossible
	  (concat["Strange hashset size not as expected\n",
		   "Length = ",
		   Int.toString(MLWorks.Internal.ExtendedArray.length the_lists),
		   ", count = ",
		   Int.toString count,
		   ", c1 = ",
		   Int.toString c1,
		   "\n"])
      end

    local
      fun nearest_power_of_two (size,x) =
        if x >= size
          then x
        else nearest_power_of_two (size,2*x)
    in
      fun empty_set size =
	let
	  val initial_size = nearest_power_of_two(size, 1)
	in
	  ref(MLWorks.Internal.ExtendedArray.array(initial_size, [] : (int * element) list),
	      ref(max_size_ratio * initial_size))
	end
    end

    fun force_shrink(elts as ref(the_list, count as ref c)) =
      let
	val old_size = MLWorks.Internal.ExtendedArray.length the_list
	val new_size = old_size div expansion_ratio
	val _ =
	  if new_size <= 0 then
	    Crash.impossible"Hashset resized down to zero length??"
	  else
	    ()
	val new_arr = MLWorks.Internal.ExtendedArray.array(new_size, [] : (int * element) list)
	(* Since the expansion size is two, *)
	(* we can calculate the new position  *)
	(* of the elements from the old positions very easily *)
	(* The resulting f and s are the first and second *)
	(* halves of the table *)

	fun deal_with_elements index =
	  if index < 0 then ()
	  else
	    (let
	       val f = MLWorks.Internal.ExtendedArray.sub(the_list, index)
	       val s = MLWorks.Internal.ExtendedArray.sub(the_list, index + new_size)
	     in
	       MLWorks.Internal.ExtendedArray.update(new_arr, index, f @ s)
	     end;
	     deal_with_elements(index - 1))

	val new_count = max_size_ratio * (new_size - old_size) + c
      in
	deal_with_elements(new_size - 1);
	elts := (new_arr, ref new_count);
	elts
      end

    fun force_resize(elts as ref(the_list, count as ref c)) =
      let
	val old_size = MLWorks.Internal.ExtendedArray.length the_list
	val new_size = old_size * expansion_ratio
	val new_arr = MLWorks.Internal.ExtendedArray.array(new_size, [] : (int * element) list)
	(* Since the expansion size is two, *)
	(* we can calculate the new position  *)
	(* of the elements from the old positions very easily *)
	(* The resulting f and s are the first and second *)
	(* halves of the table *)

	fun partition([], size, f, s) = (f, s)
	  | partition((elem as (hashvalue,_)) :: rest, size, f, s) =
	    if Bits.andb(hashvalue, size) = 0
	      then partition(rest, size, elem :: f, s)
	    else partition(rest, size, f, elem :: s)

	fun deal_with_elements(_, []) = ()
	  | deal_with_elements(index, elems) =
	    let
	      val (f,s) = partition(elems, old_size, [], [])
	    in
	      MLWorks.Internal.ExtendedArray.update(new_arr, index, f);
	      MLWorks.Internal.ExtendedArray.update(new_arr, index + old_size, s)
	    end
	val new_count = max_size_ratio * (new_size - old_size) + c
      in
	MLWorks.Internal.ExtendedArray.iterate_index deal_with_elements the_list;
	elts := (new_arr, ref new_count);
	elts
      end

    fun resize(elts as ref(_, ref c)) =
      if c >= 0 then elts
      else
	resize(force_resize elts)

    fun add_member'(elts as ref(the_list, count as ref c), elt) =
      let
	val hash = hash elt
	val old_size = MLWorks.Internal.ExtendedArray.length the_list
	val pos = Bits.andb(hash, old_size-1)
	val set = MLWorks.Internal.ExtendedArray.sub(the_list, pos)
      in
	if member(elt, set) then
	  elts
	else
	  (MLWorks.Internal.ExtendedArray.update(the_list, pos, (hash, elt) :: set);
	   count := c - 1;
	   resize elts)
      end

    fun add_member(arg as (elts, _)) = (ignore(add_member' arg); elts)

    fun remove_member(elts as ref(the_list, count as ref c), elt) =
      let
	val hash = hash elt
	val size = MLWorks.Internal.ExtendedArray.length the_list
	val pos = Bits.andb(hash, size-1)
	val set = MLWorks.Internal.ExtendedArray.sub(the_list, pos)
      in
	if member(elt, set) then
	  (MLWorks.Internal.ExtendedArray.update(the_list, pos,
					Lists.filterp (fn (_, x) => not(eq(x, elt))) set);
	   count := c + 1; (* One more space available *)
	   elts)
	else
	  elts
      end

    fun empty_setp(ref(the_list, _)) =
      MLWorks.Internal.ExtendedArray.reducel
      (fn (false, _) => false
       | (_, []) => true
       | _ => false)
      (true, the_list)

    fun is_member(ref(the_list, _), elt) =
      let
	val hash = hash elt
	val size = MLWorks.Internal.ExtendedArray.length the_list
	val pos = Bits.andb(hash, size-1)
	val set = MLWorks.Internal.ExtendedArray.sub(the_list, pos)
      in
	member(elt, set)
      end

    fun fold f (base, ref(the_list, _)) =
      MLWorks.Internal.ExtendedArray.reducel
      (Lists.reducel (fn (acc, (_, x)) => f(acc, x)))
      (base, the_list)

    fun iterate f (ref(the_list, _)) =
      MLWorks.Internal.ExtendedArray.iterate
      (Lists.iterate (fn (_, x) => f x))
      the_list

    fun set_to_list s = fold (fn (L, e) => e :: L) ([], s)

    val add_list_to_set = Lists.reducel add_member

    val add_list = add_list_to_set

    fun list_to_set set = add_list_to_set(empty_set(length set div 2), set)

    fun union_lists([], _, acc) = acc
      | union_lists((z as (_, x)) :: xs, y, acc) =
	union_lists(xs, y, if member(x, y) then acc else z :: acc)

    fun unite_sets(ref(list, ref count), ref(list', _)) =
      let
	val count = ref count
      in
	resize
	(ref
	 (MLWorks.Internal.ExtendedArray.map_index
	  (fn (index, elem) =>
	   let
	     val old_list = MLWorks.Internal.ExtendedArray.sub(list, index)
	     val new_list = union_lists(old_list, elem, elem)
	   in
	     count := !count - length new_list + length old_list;
	     new_list
	   end)
	  list', count))
      end

    (* Think about resizing here *)

    fun union(arg as (a1 as ref(set1, _), a2 as ref(set2, _))) =
      let
	val l1 = MLWorks.Internal.ExtendedArray.length set1
	val l2 = MLWorks.Internal.ExtendedArray.length set2
      in
	if l1 = l2 then
	  unite_sets arg
	else
	  if l1 < l2 then
	    union(force_resize a1, a2)
	  else
	    union(a1, force_resize a2)
      end
	  
    fun intersect_lists([], list, acc) = acc
      | intersect_lists(list, [], acc) = acc
      | intersect_lists((z as (_, x)) :: xs, y, acc) =
	intersect_lists(xs, y, if member(x, y) then z :: acc else acc)

    fun intersect_sets(set1 as ref(list, ref count), ref(list', _)) =
      let
	val count = ref count
      in
	ref
	(MLWorks.Internal.ExtendedArray.map_index
	 (fn (index, elem) =>
	  let
	    val old_list = MLWorks.Internal.ExtendedArray.sub(list, index)
	    val new_list = intersect_lists(old_list, elem, [])
	  in
	    count := !count - length new_list + length old_list;
	    new_list
	  end)
	 list', count)
      end

    fun intersection(arg as (a1 as ref(set1, _), a2 as ref(set2, _))) =
      let
	val l1 = MLWorks.Internal.ExtendedArray.length set1
	val l2 = MLWorks.Internal.ExtendedArray.length set2
      in
	if l1 = l2 then
	  intersect_sets arg
	else
	  if l2 < l1 then
	    intersection(force_shrink a1, a2)
	  else
	    intersection(a1, force_shrink a2)
      end

    fun subset(ref(list, _), arg2 as ref(list', _)) =
      MLWorks.Internal.ExtendedArray.reducel
      (fn (false, _) => false
       | (_, list) => Lists.forall (fn (_, elt) => is_member(arg2, elt)) list)
      (true, list)

    fun list_diff([], _, acc) = acc
      | list_diff((z as (_, x)) :: xs, y, acc) =
	list_diff(xs, y, if member(x, y) then acc else z :: acc)

    fun diff_sets(ref(list, ref count), ref(list', _)) =
      let
	val count = ref count
      in
	ref
	(MLWorks.Internal.ExtendedArray.map_index
	 (fn (index, elem) =>
	  let
	    val old_list = MLWorks.Internal.ExtendedArray.sub(list, index)
	    val new_list = list_diff(old_list, elem, [])
	  in
	    count := !count - length new_list + length old_list;
	    new_list
	  end)
	 list', count)
      end

    fun setdiff(arg as (a1 as ref(set1, _), a2 as ref(set2, _))) =
      let
	val l1 = MLWorks.Internal.ExtendedArray.length set1
	val l2 = MLWorks.Internal.ExtendedArray.length set2
      in
	if l1 = l2 then
	  diff_sets arg
	else
	  if l1 < l2 then
	    setdiff(force_resize a1, a2)
	  else
	    setdiff(a1, force_resize a2)
      end

    fun seteq(arg as (set1, set2)) =
      subset(set1, set2) andalso
      set_size set1 = set_size set2

    fun set_print(hashset, printfun) =
      let
	val list = set_to_list hashset
	fun print_sub([], acc) = concat(rev acc)
	  | print_sub([x], acc) = concat(rev(printfun x :: acc))
	  | print_sub(x :: xs, acc) = print_sub(xs, "," :: printfun x :: acc)
      in
	print_sub(list, [])
      end

    fun rehash(set as ref(array, _)) =
      let
	val length = MLWorks.Internal.ExtendedArray.length array
	val new_array = MLWorks.Internal.ExtendedArray.array(length, [] : (int * element)list)
	val array_and_count =
	  (new_array, ref(max_size_ratio * length))
	val new_set = ref array_and_count
      in
	MLWorks.Internal.ExtendedArray.iterate
	(fn list =>
	 Lists.iterate (fn (_, element) => add_member'(new_set, element))
	 (list))
	array;
	set := array_and_count
      end
  end
