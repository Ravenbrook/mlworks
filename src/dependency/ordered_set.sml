(*
 * util/set.sig: sets of things with an order relation
 *
 *   Copyright (c) 1995 by AT&T Bell Laboratories
 *
 * author: Matthias Blume (blume@cs.princeton.edu)
 *)
signature ORDERED_SET = sig

    type 'a set

    val gen:
	{ eq: 'a * 'a -> bool, lt: 'a * 'a -> bool }
	->
	{
	  memberOf: 'a set -> 'a -> bool,
	  union: 'a set * 'a set -> 'a set,
	  intersection: 'a set * 'a set -> 'a set,
	  difference: 'a set * 'a set -> 'a set,
	  isSubset: 'a set * 'a set -> bool,
	  add: 'a * 'a set -> 'a set,
	  addl: 'a list * 'a set -> 'a set,
	  makeset: 'a list -> 'a set,
	  eq: 'a set * 'a set -> bool
	}
	
    val fold: ('a * 'b -> 'b) -> 'b -> 'a set -> 'b
    val empty: 'a set
    val isEmpty: 'a set -> bool
    val makelist: 'a set -> 'a list
    val singleton: 'a -> 'a set
    val filter: ('a -> bool) -> 'a set -> 'a set

end
