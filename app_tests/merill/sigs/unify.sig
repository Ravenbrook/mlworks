(*
 *
 * $Log: unify.sig,v $
 * Revision 1.2  1998/06/08 17:48:49  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     26/11/91
Glasgow University and Rutherford Appleton Laboratory.

unify.sig 

Presents the Unification routines.

*)

signature UNIFY = 
   sig

	type Signature
	type Term
	type Substitution
	
	val unify : Signature -> Term -> Term -> Substitution list

end (* of signature UNIFY *)
;
