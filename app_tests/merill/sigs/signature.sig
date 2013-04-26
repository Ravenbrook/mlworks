(*
 *
 * $Log: signature.sig,v $
 * Revision 1.2  1998/06/08 17:39:29  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

signature.sig				

Gives the signature for sort, sort-orderings, and stores of sorts 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     22/11/91
Glasgow University and Rutherford Appleton Laboratory.

*)

signature SIGNATURE =
   sig
	structure S : SORT
	structure O : OPSYMB
	structure V : VARIABLE

	type Signature

	val Empty_Signature : Signature
	val mk_signature : S.Sort_Store -> O.Op_Store -> V.Variable_Store
				-> Signature

	val change_sorts : Signature -> S.Sort_Store -> Signature
	val change_operators : Signature -> O.Op_Store -> Signature
	val change_variables : Signature -> V.Variable_Store -> Signature

	val get_sorts : Signature -> S.Sort_Store
	val get_sort_ordering : Signature -> S.Sort_Order
	val get_operators : Signature -> O.Op_Store
	val get_variables : Signature -> V.Variable_Store

	val regular : Signature -> (O.OpId * (O.OpSig * O.OpSig) list) list

	val monotonic : Signature -> (O.OpId * (O.OpSig * O.OpSig) list) list

	val inhabited : Signature -> S.Sort list * S.Sort list

   end ;

