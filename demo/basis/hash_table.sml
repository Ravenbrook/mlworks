(*  ==== BASIS EXAMPLES : HASH_TABLE signature ====
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
