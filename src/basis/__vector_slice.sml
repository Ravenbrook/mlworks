(* __vector_slice.sml --- Standard ML Basis Library VectorSlice structure
 *
 * This code has been placed in the public domain.
 *)

require "vector_slice";
require "__vector";
require "__array";

structure VectorSlice :> VECTOR_SLICE = struct

    datatype 'a slice = Slice of {vector : 'a Vector.vector,
				  start : int,
				  stop : int}

    fun length (Slice {start, stop, ...}) = stop - start

    (* FIXME: maybe use some unsafe accessor instead of Vector.sub *)
    fun sub (Slice {vector, start, stop}, i) =
	let
	    val j = start + i
	in
	    if start <= j andalso j < stop then Vector.sub (vector, j)
	    else raise Subscript
	end

    fun full vec = Slice {vector = vec, start = 0, stop = Vector.length vec}

    fun slice (vec, start, size) =
	let
	    val len = Vector.length vec
	    val stop = case size of
			   NONE => len
			 | SOME l => start + l
	in
	    if 0 <= start andalso start <= stop andalso stop <= len
	    then Slice {vector = vec, start = start, stop = stop}
	    else raise Subscript
	end

    fun subslice (Slice {vector, start, stop}, i, size) =
	let
	    val start' = start + i
	    val stop' = case size of
			    NONE => stop
			  | SOME l => start' + l
	in
	    if start <= start' andalso start' <= stop' andalso stop' <= stop
	    then Slice {vector = vector, start = start', stop = stop'}
	    else raise Subscript
	end

    fun base (Slice {vector, start, stop}) = (vector, start, stop - start)

    (* FIXME: seems inefficient *)
    fun vector (Slice {vector, start, stop}) =
	Vector.tabulate (stop - start, fn i => Vector.sub (vector, start + i))

    fun appi (f:(int * 'a) -> unit) (Slice {vector, start, stop}) =
	let fun loop i =
		if i = stop then ()
		else (f (i - start, (Vector.sub (vector, i)));
		      loop (i + 1))
	in loop start end

    fun app (f:'a -> unit) (Slice {vector, start, stop}) =
	let fun loop i =
		if i = stop then ()
		else (f (Vector.sub (vector, i));
		      loop (i + 1))
	in loop start end

    fun concat [] = Vector.concat []
      | concat [s] = vector s
      | concat l =
	let
	    fun len (slice, (len, elt)) =
		let val l = length slice
		in (len + l, case elt of
				 NONE => if l = 0 then NONE
					 else SOME (sub (slice, 0))
			       | x => x)
		end
	    fun copy (slice, (array, start)) =
		(appi (fn (i, x) => Array.update (array, start + i, x))
		      slice;
		 (array, start + length slice))
	in
	    case foldl len (0, NONE) l of
	       (_, NONE) => Vector.concat []
	     | (len, SOME elt) =>
	       let val (array, _) = foldl copy (Array.array (len, elt), 0) l
	       in Array.vector array end
	end

    fun isEmpty (Slice {start, stop, ...}) = start = stop

    fun getItem (Slice {vector, start, stop}) =
	if start = stop then NONE
	else SOME (Vector.sub (vector, start),
		   Slice {vector = vector, start = start + 1, stop = stop})

    fun mapi f (Slice {vector, start, stop}) =
	Vector.tabulate (stop - start,
			 fn i => f (i, Vector.sub (vector, start + i)))

    fun map f (Slice {vector, start, stop}) =
	Vector.tabulate (stop - start,
			 fn i => f (Vector.sub (vector, start + i)))

    fun foldli f init (Slice {vector, start, stop}) =
	let fun loop i state =
		if i = stop then state
		else loop (i + 1)
			  (f (i - start, Vector.sub (vector, i), state))
	in loop start init end

    fun foldl f init (Slice {vector, start, stop}) =
	let fun loop i state =
		if i = stop then state
		else loop (i + 1) (f (Vector.sub (vector, i), state))
	in loop start init end

    fun foldri f init (Slice {vector, start, stop}) =
	let fun loop i state =
		if i < start then state
		else loop (i - 1)
			  (f (i - start, Vector.sub (vector, i), state))
	in loop (stop - 1) init end

    fun foldr f init (Slice {vector, start, stop}) =
	let fun loop i state =
		if i < start then state
		else loop (i - 1) (f (Vector.sub (vector, i), state))
	in loop (stop - 1) init end

    fun findi f (Slice {vector, start, stop}) =
	let fun loop i =
		if i = stop then NONE
		else let val x = Vector.sub (vector, i)
		     in
			 if f (i, x) then SOME (i, x)
			 else loop (i + 1)
		     end
	in loop 0 end

    fun find f (Slice {vector, start, stop}) =
	let fun loop i =
		if i = stop then NONE
		else let val x = Vector.sub (vector, i)
		     in
			 if f x then SOME x
			 else loop (i + 1)
		     end
	in loop 0 end

    fun exists f (Slice {vector, start, stop}) =
	let fun loop i =
		i < stop andalso f (Vector.sub (vector, i)) orelse loop (i + 1)
	in loop 0 end

    fun all f (Slice {vector, start, stop}) =
	let fun loop i =
		i = stop orelse f (Vector.sub (vector, i)) andalso loop (i + 1)
	in loop 0 end

    fun collate f (Slice {vector = v1, start = s1, stop = e1},
		   Slice {vector = v2, start = s2, stop = e2}) =
	let fun loop i1 i2 =
		if i1 = e1 then (if i2 = e2 then EQUAL else LESS)
		else if i2 = e2 then GREATER
		else case f (Vector.sub (v1, i1),
			     Vector.sub (v2, i2)) of
			 EQUAL => loop (i1 + 1) (i2 + 1)
		       | x => x
	in loop s1 s2 end

end
