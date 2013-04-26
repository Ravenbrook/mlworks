(*
 *
 * $Log: i_equality.sig,v $
 * Revision 1.2  1998/06/08 18:09:48  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_equality.sig

This module provides the top level interface for the formal entering and display 
of equality sets.

*)

signature I_EQUALITY = 
   sig
	type Signature
	type Term
	type Equality
	type EqualitySet
	type ORIENTATION

	val printequality : Signature -> string -> Equality -> unit
	val eq_set_size : EqualitySet -> string

	val enter_equality_set : Signature -> 
				 Term TranSys.TranSys ->
				(Equality -> Equality -> Order) -> 
				EqualitySet -> EqualitySet 

	val display_equality_set :  Signature -> EqualitySet -> unit 
	val delete_from_equality_set : EqualitySet -> EqualitySet

	val save_equality_set : (string -> unit) -> Signature -> 
				EqualitySet -> unit
	val load_equality_set : (unit -> string) -> Signature ->
				Term TranSys.TranSys ->
				(Equality -> Equality -> Order) -> 
				EqualitySet -> EqualitySet

	val orient_select :  Signature ->
		(Equality -> Equality -> Order) -> 
		'a -> ('a -> Equality -> ORIENTATION * 'a) -> 
		EqualitySet -> EqualitySet * 'a
 

   end (* of signature I_EQUALITY *)
   ;
