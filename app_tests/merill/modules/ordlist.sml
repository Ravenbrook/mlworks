(*
 *
 * $Log: ordlist.sml,v $
 * Revision 1.2  1998/06/08 17:30:51  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* a structure for ordered list. 	B.M.Matthews  - 11 - 1 - 90

The nice (or nasty depending on your point of view) thing about this type is
that the type system is not strong enough to distinguish between this list type
and built in lists, so all the list functions and pattern matching can be used
on them.  Of course, this breaks the security of the ordering, so care must be taken.
*)

signature ORDLIST = 
   sig
	type 'a OrdList
	val EMPTY : 'a OrdList
	val isnull : 'a OrdList -> bool
	val mem : ('a -> 'a -> Order) -> 'a OrdList -> 'a -> bool
	val head : 'a OrdList -> 'a
	val insert : ('a -> 'a -> Order) -> 'a OrdList -> 'a -> 'a OrdList
	val remove : ('a -> 'a -> Order) -> 'a OrdList -> 'a -> 'a OrdList
	val merge : ('a -> 'a -> Order) -> 'a OrdList -> 'a OrdList -> 'a OrdList
	val both : ('a -> 'a -> Order) -> 'a OrdList -> 'a OrdList -> 'a OrdList
	val diff : ('a -> 'a -> Order) -> 'a OrdList -> 'a OrdList -> 'a OrdList
	val reorder : ('a -> 'a -> Order) -> 'a OrdList -> 'a OrdList
	
	val map : ('b -> 'b -> Order) -> ('a -> 'b) -> 'a OrdList -> 'b OrdList
	val fold : ('a -> 'b -> 'a) -> 'a -> 'b OrdList -> 'a

	val lookup : ('a -> 'a -> Order) -> 'a OrdList -> 'a -> 'a Search
	val search : ('a -> 'b -> bool) -> 'b OrdList -> 'a -> 'b Search

  end ; (* of signature ORDLIST *)

functor OrdListFUN () :ORDLIST = 
   struct
   
	type 'a OrdList = 'a list
	val EMPTY = []
   
	fun isnull [] = true
	  | isnull _  = false

	fun insert order [] e = [e]
	  | insert order (a::l) e = 
	    (case order e a of 
  		LT => e::a::l |
  		EQ => a::l |
  		GT => a::insert order l e) 

	fun remove order [] e = []
	  | remove order (a::l) e = 
	  	(case order e a of 
	  		LT => a::l |
	  		EQ => l |
	  		GT => a::remove order l e) 

	fun merge order [] l2 = l2
	  | merge order l1 [] = l1 
	  | merge order (a::l1) (b::l2) = 
	    	(case order a b of 
	  		LT => a::merge order l1 (b::l2) |
	  		EQ => a::merge order l1 l2 |
	  		GT => b::merge order (a::l1) l2) 

	fun both order [] l2 = []
	  | both order l1 [] = []
	  | both order (a::l1) (b::l2) = 
	  	(case order a b of
	  		LT => both order l1 (b::l2) |
	  		EQ => a::both order l1 l2 |
	  		GT => both order (a::l1) l2) 

	fun diff order l1 [] = l1
	  | diff order [] l2 = l2
	  | diff order (a::l1) (b::l2) = 
	  	(case order a b of
	  		LT => a::diff order l1 (b::l2) |
	  		EQ => diff order l1 l2 |
	  		GT => a::diff order l1 l2) 

	fun mem order [] e = false
	  | mem order (a::l) e = 
 	 	(case order e a of
	  		LT => false |
	  		EQ => true |
	  		GT => mem order l e) 

	val head = hd
	
	fun reorder order = foldl (insert order) []
	
	fun map order f (a::l) = insert order (map order f l) (f a)
          | map order f [] = []

        val fold = foldl
        
        fun lookup order (b::l) a = 
        	(case order a b of 
        	 LT => NoMatch | EQ => Match b | GT => lookup order l a)
          | lookup order [] a = NoMatch

        fun search p (b::l) a = if p a b then Match b else search p l a
          | search p [] a = NoMatch
		
  end;

(* a structure for ordered list. 	B.M.Matthews  - 11 - 1 - 90

This structure for ordered list has the ordering function built in.

*)

signature ORDLIST2 = 
   sig
	type T
	type OrdList
	val EMPTY : OrdList
	val isnull : OrdList -> bool
	val mem : OrdList -> T -> bool
	val head : OrdList -> T
	val insert : OrdList -> T -> OrdList
	val remove : OrdList -> T -> OrdList
	val merge : OrdList -> OrdList -> OrdList
	val both : OrdList -> OrdList -> OrdList
	val diff : OrdList -> OrdList -> OrdList
	val reorder : OrdList -> OrdList
	
	val map : (T -> T) -> OrdList -> OrdList
	val fold : ('a -> T -> 'a) -> 'a -> OrdList -> 'a

	val lookup : OrdList -> T -> T Search
	val search : ('a -> T -> bool) -> OrdList -> 'a -> T Search

  end ; (* of signature ORDLIST *)

signature ORDSIG = 
  sig
     type T
     val order : T -> T -> Order
  end ;

functor OrdList2FUN (Ord : ORDSIG) : ORDLIST2 = 
   struct
	
	structure OL = OrdListFUN ()
        type T = Ord.T

	type OrdList = T OL.OrdList

	val EMPTY = OL.EMPTY

	val isnull = OL.isnull
	val insert = OL.insert Ord.order
 	val remove = OL.remove Ord.order
 	val merge = OL.merge Ord.order
 	val both = OL.both Ord.order
 	val diff = OL.both Ord.order
 	val mem = OL.mem Ord.order
 	val head = OL.head
 	val reorder = OL.reorder Ord.order
 	val map = fn x => OL.map Ord.order x
	val fold = OL.fold

	val lookup = OL.lookup Ord.order
	val search =  OL.search
		
  end;
