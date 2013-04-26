(*
 *
 * $Log: superpose.sig,v $
 * Revision 1.2  1998/06/08 17:54:19  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

superpose.sig

Some horrible functions developed for the purpose of doing various devious 
variations on the basic superposition algorithm. 

*)

signature SUPERPOSE =
   sig 
   	
   	type Signature
   	type Term 
   	type Substitution
   
   	type Path

   	val superpose :  Signature -> Term -> Term -> (Substitution * Path) list

   	val superposerep : Signature -> Term -> Term -> Term -> (Substitution * Term) list

   	val supreponsubterms : Signature -> Term -> Term -> Term -> (Substitution * Term) list

   end ; (* of signature SUPERPOSE *)
