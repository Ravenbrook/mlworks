(*
 *
 * $Log: sort.sig,v $
 * Revision 1.2  1998/06/08 17:38:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

sort.sig				BMM  27-02-90

Gives the signature for sort, sort-orderings, and stores of sorts 

*)

signature SORT = 
   sig
	
	type Sort

	(* functions on Sorts *)

	val Top : Sort
	val Bottom : Sort
	val name_sort : string -> Sort
	val sort_name : Sort -> string
	val SortEq : Sort -> Sort -> bool
	val ord_s  : Sort -> Sort -> bool

	type Sort_Order
	val Empty_Sort_Order : Sort_Order
	val Null_Sort_Order : Sort_Order
	val subsorts : Sort_Order -> Sort -> Sort list
	val supersorts : Sort_Order -> Sort -> Sort list
	val sort_ordered : Sort_Order -> (Sort * Sort) -> bool
	val sort_ordered_reflexive : Sort_Order -> (Sort * Sort) -> bool
	val minimal_sorts : Sort_Order -> Sort list -> Sort list
	val maximal_sorts : Sort_Order -> Sort list -> Sort list
	val extend_sort_order : Sort_Order -> (Sort * Sort) -> Sort_Order
	val meet_of_sorts : Sort_Order -> (Sort * Sort) -> Sort list (* * Sort_Order *)
	val restrict_sort_order : Sort_Order -> (Sort * Sort) -> Sort_Order
	val remove_from_order : Sort_Order -> Sort -> Sort_Order
	val name_sort_order : Sort_Order -> (string * string) list
	val sort_ordered_list : Sort_Order -> Sort list -> Sort list -> bool
	
	type Sort_Store
	val Empty_Sort_Store : Sort_Store
	val insert_sort : Sort_Store -> Sort -> Sort_Store
	val insert_sort_order : Sort_Store -> Sort_Order -> Sort_Store
	val is_declared_sort : Sort_Store -> Sort -> bool
	val get_sort_order : Sort_Store -> Sort_Order
	val delete_sort : Sort_Store -> Sort -> Sort_Store
	val name_all_sorts : Sort_Store -> string list

	val fold_over_sorts : ('a -> Sort -> 'a) -> 'a -> Sort_Store -> 'a

   end ; (* of signature SORT *)
