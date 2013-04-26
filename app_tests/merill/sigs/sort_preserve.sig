(*
 *
 * $Log: sort_preserve.sig,v $
 * Revision 1.2  1998/06/08 17:53:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				      9/11/90.
Glasgow University and Rutherford Appleton Laboratory.

sort_preserve.sig

*)

signature SORT_PRESERVE = 
sig

	type Signature
	type Term 
	val sort_preserving : Signature -> Term * Term -> bool
	val sort_decreasing : Signature -> Term * Term -> bool

end (* of signature SORT_PRESERVE *)
;
