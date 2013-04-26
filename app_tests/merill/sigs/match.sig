(*
 *
 * $Log: match.sig,v $
 * Revision 1.2  1998/06/08 17:46:59  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     16/01/90
Glasgow University and Rutherford Appleton Laboratory.

match.sig

The functions for generating Matches 
*)

signature MATCH = 
sig
	type Signature
	type Term
	type Substitution
	
	val match : Signature -> Term -> Term -> Substitution
	val all_matches : Signature -> Term -> Term -> Substitution list
	
end (* of signature MATCH *)
;
