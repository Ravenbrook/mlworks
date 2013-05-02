(*  ==== BASIS EXAMPLES : HashTable functor ====
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





