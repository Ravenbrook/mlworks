(*
 *
 * $Log: strategies.sig,v $
 * Revision 1.2  1998/06/08 17:59:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/09/90
Glasgow University and Rutherford Appleton Laboratory.

strategies.sig

Built in strategies for selection equations from equality sets.
*)

signature STRATEGY = 
   sig
	type Signature 
   	type Equality
   	type EqualitySet
   	
   	val by_size_strat : Signature -> Equality -> Equality -> Order
   	val by_age_strat : Signature -> Equality -> Equality -> Order
   	val manual_strat : Signature -> Equality -> Equality -> Order
   	val insert_by_strat : Signature -> (Signature -> Equality -> Equality -> Order) ->
   			EqualitySet -> Equality -> EqualitySet
   	val merge_by_strat : Signature -> (Signature -> Equality -> Equality -> Order) ->
   			EqualitySet -> EqualitySet -> EqualitySet
	end ;
