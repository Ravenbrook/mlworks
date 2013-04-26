(*
 *
 * $Log: Etools.sig,v $
 * Revision 1.2  1998/06/08 17:52:00  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

Etools.sig

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     22/01/92
Glasgow University and Rutherford Appleton Laboratory.

A linking signature providing the three basic operations for an equational theory:

equality : Signature -> Term -> Term -> bool
match    : Signature -> Term -> Term -> Substitution 
unify    : Signature -> Term -> Term -> Substitution list

*)

signature ETOOLS = 
   sig

	type Signature
	type Term
	type Substitution
	type Equality
	
	val equality : Signature -> Term -> Term -> bool
	val equivalent : Signature -> Equality -> Equality -> bool
	val match : Signature -> Term -> Term -> Substitution
	val all_matches : Signature -> Term -> Term -> Substitution list
	val unify : Signature -> Term -> Term -> Substitution list

end (* of signature ETOOLS *)
;
