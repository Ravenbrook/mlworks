(*
 *
 * $Log: precedence.sig,v $
 * Revision 1.2  1998/06/08 17:57:27  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

order.sig

some routines for buiding term orderings 

bmm   10 - 03 - 90
*)

signature PRECEDENCE =
   sig

	type OpId
	type Signature
	type Term
	
	type Precedence 
	
	val Null_Precedence : Precedence

	val Prec_Order : OpId list -> Precedence
	
	val apply_prec : Precedence -> OpId -> OpId -> bool
	val equal_prec : Precedence -> OpId -> OpId -> bool

	val add_to_prec_order : Precedence -> 
				OpId * OpId -> Precedence
	val remove_from_prec_order : Precedence -> 
				OpId * OpId -> Precedence

	val add_eq_to_prec_order : Precedence -> 
				OpId * OpId -> Precedence
	val remove_eq_from_prec_order : Precedence -> 
				OpId * OpId -> Precedence

	val unparse_prec : Signature -> Precedence -> string list
	
	val sub_prec : Precedence -> OpId -> OpId list
	val sup_prec : Precedence -> OpId -> OpId list
	val same_prec : Precedence -> OpId -> OpId list

	val permutatively_congruent : Term -> Term -> bool

  end (* of signature PRECEDENCE *)
  ;
