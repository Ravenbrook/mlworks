(*
 *
 * $Log: equalityset.sig,v $
 * Revision 1.2  1998/06/08 17:51:04  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
Status: R

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

equalityset.sig

functions for manipulating equality sets.

*)

signature EQUALITYSET =
   sig
	structure Pretty : PRETTY

	type Signature
	type Term
	type Equality

	type EqualitySet

	val EmptyEqSet : EqualitySet
	val empty_equality_set : EqualitySet -> bool

	val get_label : EqualitySet -> string
	val get_name : EqualitySet -> string
	val get_equalities : EqualitySet -> Equality list

	val eqinsert : (Equality -> Equality -> Order) -> 
			EqualitySet -> Equality -> EqualitySet 

(*	val insert_protected : (Equality -> Equality -> Order) -> 
			EqualitySet -> Equality -> EqualitySet 
*)
	val merge_eqsets : (Equality -> Equality -> Order) -> 
			EqualitySet -> EqualitySet -> EqualitySet

	val reorder_eqset : (Equality -> Equality -> Order) -> 
			EqualitySet -> EqualitySet

	val map_over_equations :  (Equality -> Equality -> Order) ->
			       (int * Equality -> int * Equality) -> 
			       EqualitySet -> EqualitySet

	val foldl_over_equations :  ('a -> int * Equality -> 'a) -> 'a ->
				    EqualitySet -> 'a
			       
	val select_eq : EqualitySet -> Equality 
	val rest_eq : EqualitySet -> EqualitySet
	
	val select_by_number : EqualitySet -> int -> Equality Maybe
	val delete_by_number : EqualitySet -> int -> EqualitySet 
	val total_entered_in_eqset : EqualitySet -> int

	val length_eq_set : EqualitySet -> int
	val rename_eq_set : EqualitySet -> EqualitySet
	
	val equality_map : (Equality -> Equality -> Order) -> (Equality -> Equality) -> 
			       EqualitySet -> EqualitySet
	val equality_foldl : ('a -> Equality -> 'a) -> 'a -> EqualitySet -> 'a
	val equality_filter : (Equality -> (bool * Equality)) -> EqualitySet
				-> ((int * Equality) list * EqualitySet)
	
	val unparse_equality_set : Signature -> EqualitySet -> (string * string) list
	val pretty_equality_set : Signature -> EqualitySet -> (string * Pretty.T) list

	val change_label : EqualitySet -> string -> EqualitySet
	val change_name : EqualitySet -> string -> EqualitySet
	
	val new_equality_set : string -> string -> EqualitySet
	val clear_equality_set : EqualitySet -> EqualitySet

	val insert_ES : EqualitySet list -> EqualitySet -> EqualitySet list
	val get_by_label : EqualitySet list -> string -> EqualitySet Maybe
	val get_by_name : EqualitySet list -> string -> EqualitySet Maybe
	val remove_by_label : EqualitySet list -> string -> EqualitySet list
	val remove_by_name : EqualitySet list -> string -> EqualitySet list
	val change_by_label : EqualitySet list -> string -> EqualitySet -> EqualitySet list
	val change_on_label : EqualitySet list -> EqualitySet -> EqualitySet list
	val new_labES : EqualitySet list -> EqualitySet -> EqualitySet list Maybe

    end (* of signature EQUALITYSET *)
    ; 



