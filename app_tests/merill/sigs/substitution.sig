(*
 *
 * $Log: substitution.sig,v $
 * Revision 1.2  1998/06/08 17:44:56  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

substitution.sig

*)

signature SUBSTITUTION = 
   sig 

	type Variable
	type Variable_Print_Env
	type Term 
	type Signature

	type Substitution

	val EMPTY : Substitution
	val FailSub : Substitution
	
	val domain_of_sub : Substitution -> Variable list

	val addsub : Substitution -> Variable * Term -> Substitution
   	val isfail : Substitution -> bool
  	val updatesubs : Substitution -> Variable * Term -> Substitution
   	val compose_subst : Substitution -> Substitution -> Substitution
   	val applysubtoterm : Substitution -> Term -> Term
   	
   	val well_formed_subst : Signature -> Substitution -> bool
   	
   	val show_substitution : Signature -> Substitution -> string
    	val show_subs_context : Signature -> Variable_Print_Env -> Substitution -> string
 
   end ;
