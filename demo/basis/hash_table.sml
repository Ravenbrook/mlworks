(*  ==== BASIS EXAMPLES : HASH_TABLE signature ====
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
 *  $Log: hash_table.sml,v $
 *  Revision 1.1  1996/08/12 10:43:56  davids
 *  new unit
 *
 *
 *)


signature HASH_TABLE =
  sig

    exception Full

    type 'a hash_table

    eqtype key


    (* create (size, element) 
     Create a hash table with 'size' entries.  Any 'element' can be given -
     this argument is only used to resolve the polymorphism so that this
     function can be used at the top level. *)

    val create : int * 'a -> 'a hash_table


    (* insert (table, newItem, newKey)  
     Insert item 'newItem' into the hash table 'table' according to its 
     key 'newKey'.  If there is no space left in the hash table, then the
     exception Full is raised. *)
    
    val insert : 'a hash_table * key * 'a -> unit


    (* remove (table, searchKey)
     Remove the item in the hash table 'table' with key 'searchKey'.  If
     found then return the item, otherwise return NONE. *)

    val remove : 'a hash_table * key -> 'a option


    (* lookUp (table, searchKey) 
     Look up the item in the hash table 'table' with key 'searchKey'.  If
     found then return the item, otherwise return NONE. *)    

    val lookUp : 'a hash_table * key -> 'a option

  end
