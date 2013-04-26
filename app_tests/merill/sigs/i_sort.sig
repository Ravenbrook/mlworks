(*
 *
 * $Log: i_sort.sig,v $
 * Revision 1.2  1998/06/08 18:06:14  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_sort.sig

This module provides the top level interface for the formal entering and display of 
sorts and orderings on sorts.

*)

signature I_SORT = 
  sig 
	type Sort
	type Sort_Store

	val enter_sorts : Sort_Store -> Sort_Store
	val display_sorts : Sort_Store -> unit 
	val delete_sorts : Sort_Store -> Sort_Store

	val sort_parser : Sort_Store -> Sort Parse.parser

	val load_sorts : (unit -> string) -> Sort_Store -> Sort_Store
	val save_sorts : (string -> unit) -> Sort_Store -> unit

	val enter_sort_ordering : Sort_Store -> Sort_Store
	val display_sort_ordering : Sort_Store -> unit 
	val delete_sort_ordering : Sort_Store -> Sort_Store
	
	val load_sort_ordering : (unit -> string) -> Sort_Store -> Sort_Store
	val save_sort_ordering : (string -> unit) -> Sort_Store -> unit
	
	val sort_options : Sort_Store -> Sort_Store
	val sort_order_options : Sort_Store -> Sort_Store

  end (* of signature I_SORT *) 
  ; 
