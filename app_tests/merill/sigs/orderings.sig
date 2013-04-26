(*
 *
 * $Log: orderings.sig,v $
 * Revision 1.2  1998/06/08 18:19:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/02/90
Glasgow University and Rutherford Appleton Laboratory.

ordering.sig

signature of an term ordering function

*)

signature ORDERINGS =
   sig

   	type Signature
   	type Equality
   	type Environment
   	type ORIENTATION

   	val userRPOLeft : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment
  	val userRPORight : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment

  	val userRPOMultiSet : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment

  	val userKBO : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment

	val KBO : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment

	val RPO : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment

	val load_globalord : string -> string * (Signature -> Environment -> Equality -> ORIENTATION * Environment)

	val globalord_options : 'a -> 
		string * (Signature -> Environment -> Equality -> ORIENTATION * Environment)

   end (* of signature ORDERING *)
   ;
