(*
 *
 * $Log: criticalpair.sig,v $
 * Revision 1.2  1998/06/08 17:56:34  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

equalityset.sig

functions for manipulating equality sets.

*)

signature CRITICALPAIR =
   sig
	
	type Signature
	type Equality
	type EqualitySet

	val proper_cps : Signature -> Equality -> Equality -> Equality list
	val top_cps : Signature -> Equality -> Equality -> Equality list

	val cpg : Signature -> (Equality -> Equality -> Order) ->  EqualitySet -> 
		string -> Equality -> EqualitySet -> int * Equality -> EqualitySet

	val cpall : Signature -> (Equality -> Equality -> Order) -> EqualitySet -> Equality -> 
		EqualitySet -> EqualitySet -> EqualitySet

	val coherencepairs : Signature -> Equality -> Equality -> Equality list
	val all_coherencepairs : Signature -> EqualitySet -> Equality -> Equality list
	
	val extended_rules : Signature -> EqualitySet -> Equality -> Equality list


    end (* of signature EQUALITYSET *)
    ; 


