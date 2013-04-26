(*
 *
 * $Log: sort.sml,v $
 * Revision 1.2  1998/06/08 17:39:57  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

sort.ml				BMM  27-02-90

Gives the code for sort, sort-orderings, and stores of sorts .

Functions on Sort:

Top : Sort				Top of the Sort Lattice
Bottom : Sort				Bottom of the Sort Lattice
name_sort : string -> Sort		new Sort named 
sort_name : Sort -> string		returns name of Sort
SortEq : Sort -> Sort -> bool	Equality on Sorts (as equality on names). 

*)

functor SortFUN () : SORT =

struct 

   abstype Sort = sort of string 
   	with
   	val Top = sort "Top" 
   	val Bottom = sort "Bottom" 

   	fun name_sort s = sort s 

   	fun sort_name (sort s) = s

   	fun SortEq (sort s) (sort s') = (s = s')
   	
   	(* ord_s gives a purely arbitrary syntactic ordering on terms *)
   	fun ord_s (sort s) (sort s') = (s <= s')
   	
   	fun sord (sort s) (sort s') = if s = s' then EQ
   	    else if s <= s' then LT else GT

   	end ;

structure SOL =  OrdList2FUN (struct type T = Sort val order = sord end) 

(*

sort-ordering

is a lattice implemented as a list of pairs. Transitive closure is calculated on fly 
so the induced pairs are not stored. 

Empty_Sort_Order : Sort_Order			(Empty Lattice)
Null_Sort_Order : Sort_Order			((Top > Bottom) Lattice)
subsorts : Sort_Order -> Sort -> Sort list	Not inclusive subsorts of a sort
supersorts : Sort_Order -> Sort -> Sort list	Not inclusive supersorts of a sort
sort_ordered : Sort_Order -> Sort * Sort -> bool	Test for sort-ordering on pairs of sorts (nonreflexive).
sort_ordered_reflexive : Sort_Order -> Sort * Sort -> bool	Test for sort-ordering on pairs of sorts (reflexive).
extend_sort_order : Sort_Order -> Sort * Sort -> Sort_Order	Add a pair to order
maximal_sorts : Sort_Order -> Sort list -> Sort list	Finds all maximal sorts in a list of sorts
minimal_sorts : Sort_Order -> Sort list -> Sort list	Finds all minimal sorts in a list of sorts
meet_of_sorts : Sort_Order -> Sort * Sort -> Sort list	Finds maximal sorts less than both given sorts
restrict_sort_order : Sort_Order -> Sort * Sort -> Sort_Order	Takes a pair out of the ordering
remove_from_order : Sort_Order -> Sort -> Sort_Order		Takes a Sort out of the ordering
name_sort_order : Sort_Order -> (string * string) list 		Produces printable representation.
sort_ordered_list : Sort_Order -> Sort list -> Sort list -> bool  Extension of the Sort-Order to lists of Sorts

*)

(* 
Type Sort_Order
 	(Sort * Sort) list - List of pairs cut down to prevent repetitions, and transitives.
	(Sort * Sort) list - List of subsort declarations as entered.
	(Sort,Sort list) Assoc.Assoc - the subsorts - calculated in advance.
*)

abstype Sort_Order = SO of (Sort * Sort) list * (Sort * Sort) list * (Sort,Sort list) Assoc.Assoc
with
local 
val in_sortlist = element SortEq
fun compare_sort_pair (s,t) (s',t') = SortEq s s' andalso SortEq t t'
in 
   	
val Empty_Sort_Order = SO ([],[],Assoc.Empty_Assoc)
val Null_Sort_Order  = SO ([(Bottom,Top)],[(Bottom,Top)],Assoc.Empty_Assoc)


(* finds all sorts strictly less than a given sort in the sort ordering - 
works through transitive closure.  Bottom is not in the returned list. *)

(*fun subsorts (So as SO (so,_,a)) s = 
    let fun check ((sl,su)::rs) = 
	    if SortEq s su then 
	    union SortEq (sl :: subsorts So sl) (check rs)
	    else (check rs)
	  | check [] = []
    in check so
    end
*)
fun subsorts (So as SO (_,_,a)) s = 
    (case Assoc.assoc_lookup SortEq s a of
     Match sl => sl | NoMatch => [])

(* finds all sorts strictly greater than a given sort in the sort ordering - 
works through transitive closure.  Top is not in the returned list.  *)

fun supersorts (So as SO (so,_,_)) s = 
    let fun check ((sl,su)::rs) = 
	    if SortEq s sl then 
	    union SortEq (su :: supersorts So su) (check rs)
	    else (check rs)
         | check [] = []
    in check so
    end

(* Test whether a given pair of sorts stands in the given sort-ordering. 
   Transitive, but ** Not Reflexive ** . In Many circumstances, this should be tested as well.

   this definition is more or less a specification of this function, and is not the
   most efficient definition.  By unwinding the definitions of member and subsort,
   we can arrive at a better definition. *)

fun sort_ordered so (s1,s2) = SortEq Top s2 orelse
			      SortEq Bottom s1 orelse
			      in_sortlist (subsorts so s2) s1

(*  As we want the Reflexive ordering so often, we give it below. *)

fun sort_ordered_reflexive so (s1,s2) = SortEq s1 s2 orelse sort_ordered so (s1,s2) 
	
(* 
finds all the sorts in a list which are greater than 
all other comparable sorts in the list - removes multiple copies too!!
*)
fun maximal_sorts so sl = 
    let fun f (s::l) = if exists (curry (sort_ordered so) s) sl 
	    	       then f l
	    	       else union SortEq [s] (f l)
	  | f [] = [] 
    in f sl
    end 

(* 
finds all the sorts in a list which are lesser than 
all other comparable sorts in the list - removes multiple copies too!!
*)

fun minimal_sorts so sl = 
    let fun f (s::l) = if exists (C (curry (sort_ordered so)) s) sl 
	    	       then f l
	    	       else union SortEq [s] (f l)
	  | f [] = [] 
    in f sl
    end 

(* 
extend_sort_order : Sort_Order -> (Sort * Sort) -> Sort_Order
adds a new subsort declaration to the sort ordering.  

It does detect whether the declaration generates a circularity, whether a
reflexive pair is added, and whether the pair has been added before, or whether 
the new declaration is implicit by transitivity or makes previous declarations 
redundant by transitivity. 
*)

fun update So subs a hi = Assoc.assoc_update SortEq hi (union SortEq (subsorts So hi) subs) a

fun extend_sort_order (So as SO (so,sl,a)) (lo,hi) = 
(* Reflexivity *)
    if SortEq lo hi 
    then (Error.error_message ((sort_name lo)^" < "^(sort_name hi)^
	    			 " reflexive declarations unnecessary.") ; So)
    else
    let val subs = (subsorts So lo)
    in
(* Circularity *)
    if in_sortlist subs hi
    then (Error.error_message ("adding "^(sort_name lo)^" < "^(sort_name hi)^
	    			 " generates a circularity.") ; So)
(* Transitivity and Duplication *)
    else if element compare_sort_pair sl (lo,hi) then So
    else if sort_ordered So (lo,hi)
    then SO (so, snoc sl (lo,hi),a)
    else let val sups = supersorts So hi
             fun P (s,t) = 
             	  (in_sortlist sups t orelse SortEq hi t)
             	    andalso 
             	  (in_sortlist subs s orelse SortEq lo s)
         in
         SO ((lo,hi)::(filter (not o P) so), 
             snoc sl (lo,hi),
             foldl (update So (lo::subs)) a (hi::sups)
            )
         end
    end

(* finds the lists of sorts which are maximal but less than the two given sorts *)
(* 
This function as it stands thus does not create the actual glb sort, but generates the
maximal declared sorts in contained in the glb sort.  Thus this follows the existing
practise of the ERIL system (at least the abandoned new implementation).

We could define this differently, so that it creates a new sort glb (s,s') which it
adds to the ordering (although we do not really need to explicitly adjust the ordering
as we always know where a glb sort occurs in the lattice).  
We would then want a mechanism by which the user could *declare*
a chosen sort to be the glb of two sorts.  Otherwise, we would get the following 

negint > zero < posint

the system would then create glb(negint,posint) and set glb(negint,posint) > zero.

We want to be able to say that zero is precisely the intersection set.

We could declare the datatype sort to be

datatype Sort = sort of string | glb of Sort * Sort | lub of Sort * Sort ;

or (better - generalised glbs and lubs - which are ACI operators remember) 

datatype Sort = sort of string | glb of Sort Set | lub of Sort Set | Top | Bottom ;

and an appropriate equality_function, which took into account the declaration
of meet_sorts (and presumably joins those these seem less useful). This would probably
require the use of references!  Rememeber, that for n sorts, we can potentially
create 2^n sorts on all which could easily be a v large number!

Also, it would be nice to have a mechanism where the user can declare a sort to be 
unihabited, but that should really go in the inhabited test section 

Also in the extend_sort_order if this would done would detect
whether the declaration is unnecessary due to one of the sorts is
a  glb, lub involving the other or top or bottom.  
In those cases, the position in the ordering can be deduced
and thus does not need to be stored.  

*)

fun meet_of_sorts so (s,s') = 
    if SortEq s s' then  [s]
    else let val ss = subsorts so s
         in if in_sortlist ss s'
            then [s']
            else let val ss' = subsorts so s'
	         in if in_sortlist ss' s
	            then [s]
	            else maximal_sorts so (intersection SortEq ss ss')
	         end
	 end

(*
restrict_sort_order : Sort_Order -> (Sort * Sort) -> Sort_Order
remove_from_order : Sort_Order -> Sort -> Sort_Order
restrict should take out one particular pair, from the sort-ordering, remove
should take out all references to a particular sort.  The sort ordering is then 
recalculated on the basis of the remaining subsort declarations.  
*)

fun restrict_sort_order (SO (_,sp,_)) (s,s') = 
   foldl extend_sort_order Empty_Sort_Order (remove compare_sort_pair sp (s,s'))
 
fun remove_from_order (SO (_,sp,_)) s = 
   foldl extend_sort_order Empty_Sort_Order 
   	(filter (non (fn (s1,s2) => SortEq s s1 orelse SortEq s s2)) sp)
	
(* 
Generates list of pairs of strings giving the sort-ordering for display purposes.
This uses the pairs of sorts as originally entered.
*)

fun name_sort_order (SO (_,so,_)) = map (apply_both sort_name) so

(* 
We need to be able to extend the notion of sort_ordering to sequences of sorts of equal length.
Note that for this extension, we use the Reflexive sort-ordering. 
*)

fun sort_ordered_list so [] [] = true
  | sort_ordered_list so [] _ = false
  | sort_ordered_list so _ [] = false
  | sort_ordered_list so (s::ss) (t::tt) = 
        sort_ordered_reflexive so (s,t)
    andalso 
	sort_ordered_list so ss tt

end (* of local *) 

end (* of abstype Sort_Order *)

(*
This provides the storage mechanism for sorts.  This is much less complicated
or contraversial than the sort-ordering mechanism.  

The store consists of  a model of a set of sorts and a lattice of sorts for the ordering.

The functions are largely self-explanatory.

Empty_Sort_Store : Sort_Store					Empty Sort Store
insert_sort : Sort_Store -> Sort -> Sort_Store			Adds a new sort.
insert_sort_order :  Sort_Store -> Sort_Order -> Sort_Store	Replaces Sort_Order
is_declared_sort : Sort_Store -> Sort -> bool			Is Sort in the Sort_Store?
get_sort_order : Sort_Store -> Sort_Order 			Pull out the Sort_Order
delete_sort : Sort_Store -> Sort -> Sort_Store			Deletes sort from Store
fold_over_sorts : ('a -> Sort -> 'a)  -> 'a -> Sort_Store -> 'a Fold function on Sorts
name_all_sorts : Sort_Store -> string list			List of all names of sorts in Store

*)
local 
open SOL
in  

abstype Sort_Store = Sort_Store of (OrdList * Sort_Order)
with
val Empty_Sort_Store = Sort_Store(EMPTY,Empty_Sort_Order)

fun insert_sort (Sort_Store(ss,so)) s = 
	Sort_Store(insert ss s, so)

fun insert_sort_order (Sort_Store(ss,so)) nso = Sort_Store(ss,nso)

fun is_declared_sort (Sort_Store(ss,so)) s = mem ss s
   	
fun get_sort_order (Sort_Store(ss,so)) = so

fun delete_sort (Sort_Store(ss,so)) s = 
	Sort_Store(remove ss s,
		   remove_from_order so s)

(* fold_over_sorts is an accumulating function over the set of sorts.
   It needs to be given a AC operator f to be well-defined.
*)

fun fold_over_sorts f b (Sort_Store(ss,so)) = 
		fold f b ss

fun name_all_sorts  SS = 
	fold_over_sorts (C (cons o sort_name)) [] SS 

end (* of abstype Sort_Store *)
end (* of local *)

end (* of functor SortFUN *) 
; 
