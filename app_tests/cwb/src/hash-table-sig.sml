(*
 *
 * $Log: hash-table-sig.sml,v $
 * Revision 1.2  1998/06/02 15:43:24  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* hash-table-sig.sml
 *
 * COPYRIGHT (c) 1992 by AT&T Bell Laboratories.
 *
 * The result signature of the hash table functor (see hash-table.sml).
 *
 * AUTHOR:  John Reppy
 *          AT&T Bell Laboratories
 *          Murray Hill, NJ 07974
 *          jhr@research.att.com
 *)

signature HASH_TABLE =
  sig

    structure Key : HASH_KEY

    type 'a hash_table

    val mkTable : (int * exn) -> '1a hash_table
        (* Create a new table; the int is a size hint and the exception
         * is to be raised by find.
         *)

    val insert : '2a hash_table -> (Key.hash_key * '2a) -> unit
        (* Insert an item.  If the key already has an item associated with it,
         * then the old item is discarded.
         *)

    val find : 'a hash_table -> Key.hash_key -> 'a
        (* Find an item, the table's exception is raised if the item doesn't exist *)

    val peek : 'a hash_table -> Key.hash_key -> 'a option
        (* Look for an item, return NONE if the item doesn't exist *)

    val remove : 'a hash_table -> Key.hash_key -> 'a
        (* Remove an item, returning the item.  The table's exception is raised if
         * the item doesn't exist.
         *)

    val numItems : 'a hash_table ->  int
        (* Return the number of items in the table *)

    val listItems : '_a hash_table -> (Key.hash_key * '_a) list
        (* Return a list of the items (and their keys) in the table *)

    val apply : ((Key.hash_key * 'a) -> 'b) -> 'a hash_table -> unit
        (* Apply a function to the entries of the table *)

    val map : ((Key.hash_key * 'a) -> '2b) -> 'a hash_table -> '2b hash_table
        (* Map a table to a new table that has the same keys *)

    val filter : ((Key.hash_key * 'a) -> bool) -> 'a hash_table -> unit
        (* remove any hash table items that do not satisfy the given
         * predicate.
         *)

    val transform : ('a -> '2b) -> 'a hash_table -> '2b hash_table
        (* Map a table to a new table that has the same keys *)

    val copy : '1a hash_table -> '1a hash_table
        (* Create a copy of a hash table *)

    (* Parameter is imperative -- MLA *)
    val bucketSizes : '_a hash_table -> int list
        (* returns a list of the sizes of the various buckets.  This is to
         * allow users to gauge the quality of their hashing function.
         *)

  end (* HASH_TABLE *)
