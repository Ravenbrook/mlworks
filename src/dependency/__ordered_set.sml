(*
 * util/set.sml: sets of things with an order relation
 *
 *   Copyright (c) 1995 by AT&T Bell Laboratories
 *
 * author: Matthias Blume (blume@cs.princeton.edu)
 *)

require "ordered_set";
require "../basis/__list";

structure OrderedSet:> ORDERED_SET = struct

    datatype 'a set = S of { all: 'a list, last: 'a option }

    fun fold f d (S { all, ... }) = List.foldl f d all
    val empty = S { all = [], last = NONE }
    fun isEmpty (S { last = NONE, ... }) = true | isEmpty _ = false
    fun makelist (S { all, ... }) = all
    fun singleton e = S { all = [e], last = SOME e }

    fun filter p = let
	fun f [] = { all = [], last = NONE }
	  | f (h :: t) =
	    if p h then
		case f t of
		    { all, last = NONE } => { all = h :: all, last = SOME h }
		  | { all, last } => { all = h :: all, last = last }
	    else
		f t

	fun get (S { all, ... }) = all
    in
	S o f o get
    end

    fun gen { eq, lt } = let

	fun memberOf (S { last = NONE, ... }) _ = false
	  | memberOf (S { all, last = SOME last }) x = let
		infix has
		fun [] has _ = false
		  | (h :: t) has x =
		    eq (x, h) orelse
		    not (lt (x, h)) andalso t has x
	    in
		not (lt (last, x)) andalso all has x
	    end

	fun union (S { last = NONE, ... }, s2) = s2
	  | union (s1, S { last = NONE, ... }) = s1
	  | union (S { all = a1, last = SOME l1 },
		   S { all = a2, last = SOME l2 }) =
	    let
		fun u ([], a2) = (a2, l2)
		  | u (a1, []) = (a1, l1)
		  | u (a1 as (h1 :: t1), a2 as (h2 :: t2)) =
		    if lt (l1, h2) then (a1 @ a2, l2)
		    else if lt (l2, h1) then (a2 @ a1, l1)
		    else if lt (h1, h2) then let
			val (a, l) = u (t1, a2)
		    in
			(h1 :: a, l)
		    end
		    else if eq (h1, h2) then let
			val (a, l) = u (t1, t2)
		    in
			(h1 :: a, l)
		    end
		    else let
			val (a, l) = u (a1, t2)
		    in
			(h2 :: a, l)
		    end
		val (a, l) = u (a1, a2)
	    in
		S { all = a, last = SOME l }
	    end

	fun mklast (x, NONE) = SOME x
	  | mklast (x, l as SOME y) = if lt (x, y) then l else SOME x

	fun intersection (S { last = NONE, ...}, _) = empty
	  | intersection (_, S { last = NONE, ... }) = empty
	  | intersection (S { all = a1, last = SOME l1 },
			  S { all = a2, last = SOME l2 }) =
	    let
		fun i ([], _) = ([], NONE)
		  | i (_, []) = ([], NONE)
		  | i (a1 as (h1 :: t1), a2 as (h2 :: t2)) =
		    if lt (l1, h2) orelse lt (l2, h1) then ([], NONE)
		    else if eq (h1, h2) then let
			val (a, l) = i (t1, t2)
		    in
			(h1 :: a, mklast (h1, l))
		    end
		    else if lt (h1, h2) then i (t1, a2)
		    else i (a1, t2)

		val (a, l) = i (a1, a2)
	    in
		S { all = a, last = l }
	    end

	fun difference (s1, S { last = NONE, ... }) = s1
	  | difference (S { last = NONE, ... }, _) = empty
	  | difference (S { all = a1, last = SOME l1 },
			S { all = a2, last = SOME l2 }) =
	    let
		fun d ([], _) = ([], NONE)
		  | d (a1, []) = (a1, SOME l1)
		  | d (a1 as (h1 :: t1), a2 as (h2 :: t2)) =
		    if lt (l2, h1) orelse lt (l1, h2) then (a1, SOME l1)
		    else if eq (h1, h2) then d (t1, t2)
		    else if lt (h1, h2) then let
			val (a, l) = d (t1, a2)
		    in
			(h1 :: a, mklast (h1, l))
		    end
		    else d (a1, t2)

		val (a, l) = d (a1, a2)
	    in
		S { all = a, last = l }
	    end

	fun isSubset (S { last = NONE, ...}, _) = true
	  | isSubset (_, S { last = NONE, ... }) = false
	  | isSubset (S { all = a1, last = SOME l1 },
		      S { all = a2, last = SOME l2 }) =
	    let
		fun iss ([], _) = true
		  | iss (_, []) = false
		  | iss (a1 as (h1 :: t1), h2 :: t2) =
		    if lt (l2, h1) orelse lt (l1, h2) then false
		    else if eq (h1, h2) then iss (t1, t2)
		    else lt (h2, h1) andalso iss (a1, t2)
	    in
		iss (a1, a2)
	    end

	fun add (e, S { last = NONE, ... }) = singleton e
	  | add (e, S { all, last = last as SOME l }) =
	    if lt (l, e) then
		S { all = all @ [e], last = SOME e }
	    else let
		fun ad [] = [e]
		  | ad (a as (h :: t)) =
		    if eq (e, h) then a
		    else if lt (e, h) then e :: a
		    else h :: ad t
	    in
		S { all = ad all, last = last }
	    end

	fun addl (l, s) = List.foldl add s l

	fun makeset l = addl (l, empty)

	fun set_eq (S { all = a1, ...}, S { all = a2, ... }) = let
	    fun loop ([], []) = true
	      | loop (h1 :: t1, h2 :: t2) = eq (h1, h2) andalso loop (t1, t2)
	      | loop _ = false
	in
	    loop (a1, a2)
	end

    in
	{ memberOf = memberOf, union = union,
	  intersection = intersection, difference = difference,
	  add = add, addl = addl, makeset = makeset, isSubset = isSubset,
	  eq = set_eq }
    end

end
