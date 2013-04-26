(*  ==== BASIS EXAMPLES : IntHash structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This structure defines a hash table that takes integer keys.  The 
 *  HashTable functor demonstrates the use of the Array structure in the
 *  basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: __int_hash.sml,v $
 *  Revision 1.1  1996/08/09 17:31:33  davids
 *  new unit
 *
 *
 *)


require "_hash_table";
require "__int_key";

structure IntHash = HashTable (IntKey)
