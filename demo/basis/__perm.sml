(*  ==== BASIS EXAMPLES : Perm structure ====
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
 *  This module demonstrates the use of the List structure in the basis
 *  library.  It provides functions to find all possible permutations and
 *  partitions of a given list or string.
 *
 *  Revision Log
 *  ------------
 *  $Log: __perm.sml,v $
 *  Revision 1.3  1996/10/21 15:03:17  jont
 *  Avoid compiler warnings
 *
 *  Revision 1.2  1996/09/04  11:54:20  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/07/26  15:10:32  davids
 *  new unit
 *
 *
 *)


require "perm";
require "$.basis.__list";

structure Perm : PERM =
  struct

    (* Returns all of the list except the nth element *)

    exception Rest of int

    fun rest (h::t, 1) = t 
      | rest (h::t, n) = h :: rest (t, n - 1)
      | rest (_, n) = raise Rest n

    (* A second order function performing the :: operation *)
	 
    fun addHead item l = item :: l


    (* Finds all the permutations of a list.  This is done by selecting each
     element of the list in turn, and finding all permutations with this
     element at the head. *)

    fun perm [item] = [[item]]
      | perm l = select (l, List.length l)

    (* Finds all permutations of a list which have the nth element at the head.
     This is done by finding all permutations of the rest of the list, and
     adding the nth element to the head of each using List.map *) 

    and select (l, 0) = []
      | select (l, n) = select (l, n - 1) 
	@ (List.map (addHead (List.nth (l, n - 1))) (perm (rest (l, n))))
     

    (* Finds all permutations of a string.  This is done by converting the
     string to a list using explode, and then converting each of the
     resulting lists back to strings using implode. *)
	
    fun permString s = List.map implode (perm (explode s))


    (* Finds all possible partitions of a list.  This is done by dividing the
     list up at every possible point, and then finding all partitions which
     start with the front of each division. *)

    fun partition [] = [[]]
      | partition l = divide (l, List.length l)
	
    (* Divides a list up at a given position into front and back.  The front is
     then added to each possible partition of the back by using addFront. *)

    and divide (l, 0) = []
      | divide (l, pos) =
	let
	  val front = List.take (l, pos)
	  fun addFront back = front :: back
	in
	  (List.map addFront (partition (List.drop (l, pos))))
	  @ divide (l, pos - 1)
	end


    (* Finds all partitions of a string.  This is done by converting the
     string to a list using explode, and then converting each of the
     resulting lists back to strings using implode.  List.map is used
     to apply this to each of the innermost lists. *)

    fun partitionString s =
      List.map (List.map implode) (partition (explode s))

  end
