(* _newhashtable.sml the functor *)
(*
$Log: _hashtable.sml,v $
Revision 1.14  1997/05/19 13:10:22  jont
[Bug #30090]
Translate output std_out to print

 *  Revision 1.13  1997/05/01  13:20:35  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 *  Revision 1.12  1996/11/06  10:53:27  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.11  1996/05/16  16:35:46  matthew
 *  Bits becomes MLWorks.Internal.Bits
 *
 *  Revision 1.10  1996/05/07  10:40:02  jont
 *  Array moving to MLWorks.Array
 *
 *  Revision 1.9  1996/04/30  17:45:27  jont
 *  String functions explode, implode, chr and ord now only available from String
 *  io functions and types
 *  instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 *  now only available from MLWorks.IO
 *
 *  Revision 1.8  1996/04/29  15:07:22  matthew
 *  Integer changes
 *
 *  Revision 1.7  1996/02/26  12:05:54  jont
 *  new unit
 *  Renamed from newhashtable
 *
Revision 1.15  1994/09/07  11:51:50  matthew
Use MLWorks.Integer.makestring

Revision 1.14  1993/11/01  14:39:54  nickh
Fixed bugs in map() and copy(), which previously returned empty hash tables.

Revision 1.13  1993/02/25  13:43:19  jont
Fixed a bug in the resizing code which allowed more to be placed in the
new table than it should

Revision 1.12  1992/09/22  09:08:30  clive
Changed hashtables to a single structure implementation

Revision 1.11  1992/09/16  14:08:37  clive
Added tryLookup

Revision 1.10  1992/09/14  14:20:21  jont
Added a lookup_default function to assign a default value when the
key is not found

Revision 1.9  1992/08/26  14:56:11  richard
Changed MLWorks.Bits to Bits to improve performance under
New Jersey.

Revision 1.8  1992/08/21  09:00:59  clive
Don't recalculate hash function on resize

Revision 1.7  1992/08/13  16:47:41  davidt
Added fold and iterate functions.

Revision 1.6  1992/08/10  16:51:20  davidt
Changed MLworks to MLWorks.

Revision 1.5  1992/08/07  16:05:13  davidt
Now uses MLworks structure instead of NewJersey structure.

Revision 1.4  1992/07/28  09:53:20  clive
Added some functionality including the printing of statistics, and resizing

Revision 1.3  1992/07/16  17:28:16  jont
Removed count from tables. Allows better imperative use

Revision 1.2  1992/07/16  16:23:25  jont
Removed array parameter, now uses pervasive one

Revision 1.1  1992/07/16  11:21:17  jont
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

require "../basis/__int";

require "hashtable";
require "crash";
require "lists";

(* A hash table with more than one table *)

functor HashTable(
  structure Crash : CRASH
  structure Lists : LISTS
 ) : HASHTABLE =
  struct

    structure Bits = MLWorks.Internal.Bits

    type HashValue = int
    type ('Key,'Value) HashTable = (('Key * HashValue * 'Value ref) list MLWorks.Internal.Array.array 
                                    * int ref
                                    * ('Key * 'Key -> bool) 
                                    * ('Key -> int)) ref

    val print_debug = false

    (* This expansion ratio of 2 is used to maintain the fact that the tables
     are a power of two in size. This means we may use bitwise operations to go from
     hash value to table index, and can do the resize operation much more
     quickly - if this is changed, some of the other functions need to be re-written *)

    val expansion_ratio = 2 (* factor to increase by on re-size - if this is changed from 2, adjust
                             partitioning part of the re-sizing code in update *)
    val max_size_ratio = 4  (* resize when number of elements is this multiplied by the size *)

    exception Lookup 

    local
      fun nearest_power_of_two (size,x) =
        if x >= size
          then x
        else nearest_power_of_two (size,2*x)
    in
      fun new (size,eq,hash) =
        let
          val initial_size = nearest_power_of_two(size,1)
        in
          ref(MLWorks.Internal.Array.array(initial_size, []),
              ref(max_size_ratio * initial_size),
              eq,
              hash)
        end
    end

    fun assoc(eq,key, []) = raise Lookup
      | assoc(eq,key, (k, _, v) :: xs) =
	if eq(key, k) then v else assoc(eq,key, xs)

    fun lookup(ref (elt_array,_,eq,hash), key) =
      let
	val hash = hash key
	val len = MLWorks.Internal.Array.length elt_array
	val list_map = MLWorks.Internal.Array.sub(elt_array, Bits.andb(hash,len-1))
      in
	!(assoc(eq,key, list_map))
      end

    fun assoc_default(eq,_, []) = NONE
      | assoc_default(eq, key, (k, _, ref v) :: xs) =
	if eq(key, k) 
          then SOME v
        else assoc_default(eq,key, xs)

    fun tryLookup(ref (elt_array,_,eq,hash),key) =
      let
	val hash = hash key
	val len = MLWorks.Internal.Array.length elt_array
	val list_map = MLWorks.Internal.Array.sub(elt_array, Bits.andb(hash,len-1))
      in
        assoc_default(eq,key,list_map)
      end

    fun lookup_default (table,value,key) =
      case tryLookup (table,key) of
        SOME res => res
      | _ => value

    fun iterate_hash f (arr,_,_,_) =
      let
        fun down x =
          if x < 0 then ()
          else (Lists.iterate (fn (k, v', ref v) => f(k,v',v)) (MLWorks.Internal.Array.sub(arr,x)); down (x-1))
      in
        down (MLWorks.Internal.Array.length arr - 1)
      end

    fun iterate f (ref h) = iterate_hash (fn (x,_,y) => f(x,y)) h

    fun fold f (res, ref (arr,_,_,_)) =
      let
        fun down (res, x) =
          if x < 0 then
	    res
          else
	    down(Lists.reducel (fn (res, (k, _, ref v)) => f(res, k, v)) (res, MLWorks.Internal.Array.sub(arr,x)), x-1)
      in
        down (res, MLWorks.Internal.Array.length arr - 1)
      end

    val makestring = Int.toString

    fun assoc_default'(eq,_, []) = NONE
      | assoc_default'(eq,key, (k, _, v) :: xs) =
	if eq(key, k) 
          then SOME v
        else assoc_default'(eq,key, xs)

    fun update(initial as ref (elt_array,count_down as ref c,eq,hash_fn), key, value) =
      let
	val hash = hash_fn key
	val old_size = MLWorks.Internal.Array.length elt_array
	val pos = Bits.andb(hash,old_size - 1)
	val list_map = MLWorks.Internal.Array.sub(elt_array, pos)
        val assoced = assoc_default'(eq,key, list_map)
      in
        (case assoced of
           SOME r => r := value 
         | NONE => 
             (if c <= 0
                then 
                  let
                    val _ = if print_debug then
		      print("Resizing " ^ makestring(old_size) ^ "...\n")
                            else ()
                    val new_size = old_size * expansion_ratio
                    val new_arr = MLWorks.Internal.Array.array(new_size, [])
                    val _ = initial := (new_arr,ref(max_size_ratio * (new_size - old_size) + c - 1),eq,hash_fn)
		    (* Since the expansion size is two, we can calculate the new position  *)
		    (* of the elements from the old positions very easily *)
		    fun partition([],size,f,s) = (f,s)
		      | partition((elem as (_,hashvalue,_))::rest,size,f,s) =
			if Bits.andb(hashvalue,size) = 0
			  then partition(rest,size,elem::f,s)
			else partition(rest,size,f,elem::s)

                    fun deal_with_elements index = 
                      if index < 0
                        then ()
                      else
                        let
                          val elems = MLWorks.Internal.Array.sub(elt_array,index)
                       in
                         case elems of
                           [] => deal_with_elements (index-1)
                         | _ =>
                             let
                               val (f,s) =
                                 partition(elems,old_size,[],[])
                             in
                               MLWorks.Internal.Array.update(new_arr,index,f);
                               MLWorks.Internal.Array.update(new_arr,index + old_size,s);
                               deal_with_elements (index-1)
                             end
                       end
                 in
                   deal_with_elements (old_size-1);
                   let
                     val new_pos = Bits.andb(hash,new_size - 1)                     
                     val old_value = MLWorks.Internal.Array.sub(new_arr, new_pos)
                   in 
                     MLWorks.Internal.Array.update(new_arr, new_pos, (key, hash,ref value)::old_value)
                   end
                 end
             else (count_down := c - 1;
                   MLWorks.Internal.Array.update(elt_array, pos, (key, hash,ref value) :: list_map))))
      end

    fun delete_from_list(eq,key, [], acc) = (acc, false)
      | delete_from_list(eq,key, (elt as (k, _, _)) :: rest, acc) =
	if eq(key, k) then
	  (acc @ rest, true)
	else
	  delete_from_list(eq,key, rest, elt :: acc)

    fun delete(ref (elt_array,count_down,eq,hash), key) =
      let
	val hash = hash key
	val len = MLWorks.Internal.Array.length elt_array
	val pos = Bits.andb(hash,len-1)
	val list_map = MLWorks.Internal.Array.sub(elt_array, pos)
	val (list_map, found) = delete_from_list(eq,key, list_map, [])
        val _ = count_down := !count_down + 1
      in
	MLWorks.Internal.Array.update(elt_array, pos, list_map)
      end

    fun check_nil(array, curr, max) =
      if curr >= max then true
      else
	case MLWorks.Internal.Array.sub(array, curr) of
	  [] => check_nil(array, curr + 1, max)
	| _ => false

    fun empty_setp(ref (elt_array,_)) =
      check_nil(elt_array, 0, MLWorks.Internal.Array.length elt_array)

    fun add_members(pos:int, max, mems, elts) =
      if pos >= max then
	mems
      else
	let
	  val set = map (fn (x,_,ref y) => (x,y)) (MLWorks.Internal.Array.sub(elts, pos))
	in
	  add_members(pos+1, max, set @ mems, elts)
	end

    fun to_list(ref (elt_array,_,_,_)) =
      add_members(0, MLWorks.Internal.Array.length elt_array, [], elt_array)

    (* have to copy each entry because it's all ref cells *)

    fun copy_list (acc,[]) = acc (* reversal doesn't matter *)
      | copy_list (acc,(k,h,ref v)::xs) =
      copy_list ((k,h,ref v)::acc,xs)

    fun copy_array(old_array, new_array, max, curr) =
      if curr >= max then new_array
      else
	let
	  val this = MLWorks.Internal.Array.sub(old_array, curr)
	  val _ = MLWorks.Internal.Array.update(new_array, curr, copy_list ([],this))
	in
	  copy_array(old_array, new_array, max, curr+1)
	end

    fun copy(ref (elt_array,count_down,eq,hash)) =
      let
	val len = MLWorks.Internal.Array.length elt_array
	val new_array = MLWorks.Internal.Array.array(len, [])
	val _ = copy_array(elt_array, new_array, len, 0)
      in
	ref (new_array,ref(!count_down),eq,hash)
      end

    fun map f (ref(table as (elt_array,count_down,eq,hash))) =
      let
        val new_table = new(MLWorks.Internal.Array.length elt_array,eq,hash)
      in
        iterate_hash (fn (x,_,y) => update(new_table,x,f (x,y))) table;
        new_table
      end

    fun stats(ref (arr,_,_,_)) = 
      let
        val len = MLWorks.Internal.Array.length(arr)
        val largest = ref(0)
        val smallest = ref(if len >0
                             then Lists.length(MLWorks.Internal.Array.sub(arr,0))
                           else 0)
        val count = ref(0)

        fun walk_buckets x =
          if x<0
            then ()
          else
            let
              val length = Lists.length(MLWorks.Internal.Array.sub(arr,x))
              val _ = if length > !largest 
                        then largest := length
                      else ()
              val _ = if length < !smallest
                        then smallest := length
                      else ()
            in
              (count := !count + length;
               walk_buckets(x-1))
            end

        val _ = walk_buckets (len - 1)
      in
        {size = len,
         smallest = !smallest,
         largest = ! largest,
         count = ! count}
      end

    fun string_hash_table_stats(table) =
      let
        val {size : int ,count : int ,smallest : int ,largest : int} = stats table
      in
        if count>0 then
          (" statistics: "^
           "size = "^(makestring size)^
           " count = "^(makestring count)^
           "\n                              smallest = "^
           (makestring smallest)^
           " largest = "^(makestring largest))
        else " EMPTY"
      end
        

  end
