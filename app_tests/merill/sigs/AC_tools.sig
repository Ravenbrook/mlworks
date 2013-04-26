(*
 *
 * $Log: AC_tools.sig,v $
 * Revision 1.2  1998/06/08 17:45:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

AC_tools.sml

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     22/01/92
Glasgow University and Rutherford Appleton Laboratory.

Provides some basic tools for equational reasoning modulo the 
Commutative and Associative-Commutative theories.

*)

signature AC_TOOLS =
  sig 
  	type Signature
  	type Term
  	type OpId
  	type Variable
  	val AC_flatten : Signature -> Term -> Term
  	val AC_subterms : Term -> Term list
  	val AC_unflatten : OpId -> Term list -> Term
  	val AC_equivalent : Signature -> Term -> Term -> bool
	val AC_alpha_equivalent : Signature -> Term -> Term -> 
			(Variable,Variable) Assoc.Assoc -> 
			bool * (Variable,Variable) Assoc.Assoc
        val Cmutate : Signature -> Term -> Term -> (Term * Term) list list
        val equivalentPairs : Signature -> (Term * Term) -> (Term * Term) -> bool

  end (* of signature AC_TOOLS *)
  ;
