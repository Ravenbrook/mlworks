(* _match_utils.sml the functor *)
(*
$Log: _match_utils.sml,v $
Revision 1.3  1991/11/27 13:23:06  jont
Removed all code bar union_lists. All other was either unused or in Lists

Revision 1.2  91/11/21  16:33:57  jont
Added copyright message

Revision 1.1  91/06/07  11:06:22  colin
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
require "match_utils";

(**
    Utility functions that might get needed from time to time, used in
    the Match compiler only at the moment.
    
    Last updated : Tue Jan 22 17:43:57 1991
**)

functor Match_utils () : MATCH_UTILS =
    struct

(** remove all elements for which a predicate is true **)
(*
      fun remove_if predicate =
	  let
	    fun remove rest [] = rev rest
	      | remove rest (head::tail) =
		if predicate head then
		  remove rest tail
		else
		  remove (head::rest) tail
	  in
	    remove []
	  end

(** return true if all elements of a list pass a predicate **)
      fun every predicate =
	  let
	    fun every' [] = true
	      | every' (head::tail) =
		  predicate head  andalso  every' tail
	  in
	    every'
	  end

(** return true if any of the elements of a list pass a predicate **)
      fun any predicate =
	  let
	    fun any' [] = false
	      | any' (head::tail) =
		  predicate head  orelse   any' tail
	  in
	    any'
	  end
	   

(** remove all occurances of an element from a list **)
      fun remove element =
	    remove_if (fn x => x = element)

(** is a value a member of a list **)
      fun memberp value =
	    any (fn x => x = value)
*)

(** Union two lists together **)
       fun member (_,[]) = false
	 | member (a,h::t) = (a=h) orelse member(a,t)
	  
      fun union_lists [] rest = rest
	| union_lists rest [] = rest
	| union_lists (head::tail) rest =
	  if member(head, rest) then
	    union_lists tail rest
	  else
	    union_lists tail (head::rest)
	  
(*
(** remove duplicates from a list, returns elements in same order **)
      fun remove_duplicates [] = []
	| remove_duplicates (head::tail) =
	    rev (union_lists tail [head])

(** QuickSort routine.  Tail recursive and no appends !
    Type of Qsort is (('a * 'a) -> bool) -> 'a list -> 'a list  **)
      fun Qsort (op >) the_list =
	  let
	    fun qs [] rest = rest
	      | qs (head::tail) rest =  (* first element can be pivot *)
		let                     (* now split about chosen pivot *)
		  fun split [] high low = qs high (head::(qs low rest))
		    | split (first::more) high low =
		      if first > head then
			split more (first::high) low
		      else
			split more high (first::low)
		in
		  split tail [] []
		end
	  in
	    qs the_list []
	  end

(** Generate the powerset of a list of elements.  Order isn't very
    good, (done for speed.) **)
      fun power thelist =
	  let
	    fun power' [] rest = rest
	      | power' (front::back) rest =
		let
		  fun add_element [] rest = rest
		    | add_element (head::tail) rest =
			add_element tail (head::((front::head)::rest))
		in
		  power' back (add_element rest [])
		end  
	  in
	    power' thelist [[]]
	  end

(** Generate the powerset of a list, and return all elements which are
    at least as long as the size given. **)
      fun power_size number thelist =
	  let
	    fun power2 [] rest _ = rest
	      | power2 (front::back) rest n =
		let
		  (* Add an element to all lists large enough *)
		  fun add_element [] rest = rest
		    | add_element (head::tail) rest =
		      let
			val len = length head
		      in
			if (n > len) then
			  add_element tail rest
			else
			  if (n = len) then
			    add_element tail ((front::head)::rest)
			  else
			    add_element tail (head::((front::head)::rest))
		      end
		in
		  power2 back (add_element rest []) (n + 1)
		end
      
	    val thelength = length thelist
	  in
	    if (number > thelength) then
	      []               (* none possible *)
	    else
	      if (number = thelength) then
		[ thelist ]  (* one possible *)
	      else           (* many possible *)
		power2 thelist [[]] (number - thelength)
	  end

*)
    end
