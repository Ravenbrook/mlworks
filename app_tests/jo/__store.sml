(*
 *
 * $Log: __store.sml,v $
 * Revision 1.2  1998/06/08 13:01:10  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	    Jo: A Concurrent Constraint Programming Language
		      (Programming for the 1990s)

			    Andrew Wilson

		  An implementation of a code memory
			  (using a 2-3 tree)

		       2nd Nov and 17th Nov 1990

		Modified 17th December to store lists of items


			    the structure

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.

****************************************************************************)

require "store";


structure Store: STORE =
struct


  exception NotFound of string


  datatype 'a store
      = empty
      | leaf of (string * 'a list)
      | leaf2 of (string * 'a list) * (string * 'a list)
      | node2 of 'a store * (string * 'a list) * 'a store
      | node3 of 'a store * (string * 'a list) 
	       * 'a store * (string * 'a list) * 'a store
      | split of 'a store * (string * 'a list) * 'a store






  fun newStore() = empty






  fun retrieve(key,str) = 
      case str of
	empty              => raise NotFound key
      | leaf(k,d) 	   => if k=key then d else raise NotFound key
      | leaf2((k1,d1),(k2,d2)) => 
		if k1=key then d1 else
		if k2=key then d2 else raise NotFound key
 
      | node2(left,(k,d),right) =>
		if key<k then retrieve(key,left) else
		if key>k then retrieve(key,right) else d

      | node3(left,(k1,d1),mid,(k2,d2),right) =>
		if key<k1 then retrieve(key,left)  else
		if key=k1 then d1		   else
		if key=k2 then d2		   else
	 	if key>k2 then retrieve(key,right) else retrieve(key,mid)

      | split(_,_,_) => raise NotFound key






local


  fun insert(key,datum,str) =
      case str of
	empty => leaf(key,[datum])
      | leaf(k,d) => 
	   if k<key then leaf2((k,d),(key,[datum])) else
	   if k>key then leaf2((key,[datum]),(k,d)) else 
			 leaf(k,d@[datum])


      | leaf2((k1,d1),(k2,d2)) =>
	   if key<k1 then split(leaf(key,[datum]),(k1,d1),leaf(k2,d2)) else
	   if key>k2 then split(leaf(k1,d1),(k2,d2),leaf(key,[datum])) else
	   if key=k1 then leaf2((k1,d1@[datum]),(k2,d2)) else
           if key=k2 then leaf2((k1,d1),(k2,d2@[datum])) else
		split(leaf(k1,d1),(key,[datum]),leaf(k2,d2))




      | node2(left,(k,d),right) =>   
	   if key=k then node2(left,(k,d@[datum]),right)
  	   else if key<k then 
	     (
	      case insert(key,datum,left) of
	        split(l,(k2,d2),r) => node3(l,(k2,d2),r,(k,d),right)
	      | x                  => node2(x,(k,d),right)
	     )
	   else 
	     (
	      case insert(key,datum,right) of
                split(l,(k2,d2),r) => node3(left,(k,d),l,(k2,d2),r)
	      | x                  => node2(left,(k,d),x)
	     )





      | node3(left,(k1,d1),mid,(k2,d2),right) =>   
	   if key=k1 then node3(left,(k1,d1@[datum]),mid,(k2,d2),right) else
           if key=k2 then node3(left,(k1,d1),mid,(k2,d2@[datum]),right)
  	   else if key<k1 then 
	     (
	      case insert(key,datum,left) of
	        split(l,(k3,d3),r) => split(node2(l,(k3,d3),r),(k1,d1),
					    node2(mid,(k2,d2),right))
	      | x                  => node3(x,(k1,d1),mid,(k2,d2),right)
	     )
	   else if key>k2 then
	     (
	      case insert(key,datum,right) of
                split(l,(k3,d3),r) => split(node2(left,(k1,d1),mid),(k2,d2),
					    node2(l,(k3,d3),r))
	      | x                  => node3(left,(k1,d1),mid,(k2,d2),x)
	     )
	   else
	     (
	      case insert(key,datum,mid) of
                split(l,(k3,d3),r) => split(node2(left,(k1,d1),l),(k3,d3),
					    node2(r,(k2,d2),right))
	      | x                  => node3(left,(k1,d1),x,(k2,d2),right)
	     )



      | split(_,_,_) => raise NotFound key	   (* not possible *)




  in



     fun store(key,datum,str) =
         case insert(key,datum,str) of
             split(a,b,c) => node2(a,b,c)
           | result => result

  end


	(* RETRIEVE_ALL: simple "inorder" tree search: returns all *)
	(* elements of store.					   *)


  fun retrieveAll(empty) = []
    | retrieveAll(leaf(_,code)) = [code]
    | retrieveAll(leaf2((_,c1),(_,c2))) = [c1,c2]
    | retrieveAll(node2(left,(_,code),right)) = retrieveAll(left) @	
						 [code] @
					   	 retrieveAll(right)

    | retrieveAll(node3(left,(_,c1),mid,(_,c2),right)) = 
	retrieveAll(left) @[c1] @retrieveAll(mid) @[c2] @retrieveAll(right)

    | retrieveAll(split _) = []






	(* WIPE: removes a clause from the store: note that no time *)
	(* is wasted reshuffling trees: it's just an overwriting    *)
	(* with [].  The chances are that it will be overwritten by *)
	(* the next program to be loaded, anyway.		    *)


  fun wipe(key,str) = 
      case str of
	empty              => raise NotFound key
      | leaf(k,d) 	   => if k=key then leaf(k,[]) else raise NotFound key
      | leaf2((k1,d1),(k2,d2)) => 
		if k1=key then leaf2((k1,[]),(k2,d2)) else
		if k2=key then leaf2((k1,d1),(k2,[])) else raise NotFound key
 
      | node2(left,(k,d),right) =>
		if key<k then wipe(key,left)  else
		if key>k then wipe(key,right) 
	        	 else node2(left,(k,[]),right)

      | node3(left,(k1,d1),mid,(k2,d2),right) =>
		if key<k1 then wipe(key,left)                      else
		if key=k1 then node3(left,(k1,[]),mid,(k2,d2),right)   else
		if key=k2 then node3(left,(k1,d1),mid,(k2,[]),right)   else
	 	if key>k2 then wipe(key,right) else wipe(key,mid)

      | split(_,_,_) => raise NotFound key

end
