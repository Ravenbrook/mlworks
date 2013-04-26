(*  ==== BASIS EXAMPLES : HashTable functor ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines functions for creating and using a hash table.  It
 *  illustrates the use of the Array structure in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: _hash_table.sml,v $
 *  Revision 1.2  1996/09/04 11:56:41  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/12  10:34:31  davids
 *  new unit
 *
 *
 *)


require "hash_table";
require "key";
require "__prime";
require "$.basis.__array";

functor HashTable (Key: KEY) : HASH_TABLE =
  struct

    (* Indicates that the hash table is full. *)

    exception Full

 
    (* This is the type of the key used in the hash table. *)

    type key = Key.key


    (* This type is used for entries in the hash table.  It represents either
     a (key, item) pair, an empty entry, or a deleted entry. *)

    datatype 'a item_pair = PAIR of key * 'a | EMPTY | DELETED
   

    (* This type represents a hash table of type 'a. *)

    type 'a hash_table = 'a item_pair Array.array


    (* Create a hash table with 'size' entries.  Any 'element' can be given -
     this argument is only used to resolve the polymorphism so that this
     function can be used at the top level.  Report a warning if 'size' is
     not prime. *)

    fun create (size, element) = 
      (if Prime.testPrime (size, 5) then
	 ()
       else
	 print "Warning: table size should be a prime number.\n";
       Array.array (size, EMPTY))


    (* Insert item 'newItem' into the hash table 'table' according to its 
     key 'newKey'.  If there is no space left in the hash table, then the
     exception Full is raised. *)

    fun insert (table, newKey, newItem) = 
      let
	val size = Array.length table
	fun insert' (i, probes) =
	  if probes >= size then
	    raise Full
	  else
	    case Array.sub (table, i) of
	      EMPTY => Array.update (table, i, PAIR (newKey, newItem))
	    | DELETED => Array.update (table, i, PAIR (newKey, newItem))
	    | PAIR (_, _) => insert' (Key.rehash (newKey, i, size), probes + 1)
      in
	insert' (Key.hash (newKey, size), 0)
      end


    (* Find the item in the hash table 'table' with key 'searchKey'.  Return
     both the item itself, and the position in the table it was found at. 
     If no match is found then return NONE. *)

    fun find (table, searchKey) = 
      let
	val size = Array.length table
	fun find' (i, probes) =
	  if probes >= size then
	    NONE
	  else
	    case Array.sub (table, i) of
	      EMPTY => NONE
	    | DELETED => find' (Key.rehash (searchKey, i, size), probes + 1)
	    | PAIR (itemKey, item) => 
	      if itemKey = searchKey then 
		SOME (item, i)
	      else 
		find' (Key.rehash (searchKey, i, size), probes + 1)
      in
	find' (Key.hash (searchKey, size), 0)
      end


    (* Find the item in the hash table 'table' with key 'searchKey'.  If found
     then return the item, otherwise return NONE. *)

    fun lookUp (table, searchKey) = 
      case find (table, searchKey) of
	NONE => NONE
      | SOME (item, i) => SOME item


    (* Remove the item in the hash table 'table' with key 'searchKey'.  If
     found then return the item, otherwise return NONE. *)

    fun remove (table, searchKey) =
      case find (table, searchKey) of
	NONE => NONE
      | SOME (item, index) => 
	  (Array.update (table, index, DELETED);
	   SOME item)

  end





