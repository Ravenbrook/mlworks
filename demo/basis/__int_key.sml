(*  ==== BASIS EXAMPLES : IntKey structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines hashing functions for integer keys.
 *
 *  Revision Log
 *  ------------
 *  $Log: __int_key.sml,v $
 *  Revision 1.1  1996/08/09 18:21:16  davids
 *  new unit
 *
 *
 *)


require "key";

structure IntKey : KEY =
  struct

    type key = int


    (* A simple hash function. *)

    fun hash (hashKey : key, tableSize) = hashKey mod tableSize


    (* A simple rehashing function to be used when collisions occur. *)

    fun rehash (hashKey : key, index, tableSize) = 
      (index + 8 - (hashKey mod 8)) mod tableSize

  end

