(*
 *
 * $Log: environment.sig,v $
 * Revision 1.2  1998/06/08 18:04:24  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/07/90
Glasgow University and Rutherford Appleton Laboratory.

environment.sml

The MERILL environment contains all those adjustable bits whivch do not fit well
else where !  This basically gives all the options that the user can set.

*)

signature ENVIRONMENT = 
   sig
   	
   	type Signature
   	type Equality
   	type Precedence
   	type Weights
   	type ORIENTATION
 
   	type Environment 
  	
   	val set_globord :  
   		((string * (Signature -> Environment -> Equality -> 
   			ORIENTATION * Environment)) ->
   		(string * (Signature -> Environment -> Equality -> 
   			ORIENTATION * Environment))) ->
	 	Environment -> Environment
   	val get_globord :  Environment -> string * 
   		(Signature -> Environment -> Equality -> 
   			ORIENTATION * Environment) 

	val set_precord : (Precedence -> Precedence) -> Environment -> Environment
	val get_precord : Environment -> Precedence 

	val set_locord : 
		(string * (Signature -> Equality -> ORIENTATION)) -> 
		Environment -> Environment
	val get_locord : Environment -> 
		string * (Signature -> Equality -> ORIENTATION) 

	val set_weights : (Weights -> Weights) -> Environment -> Environment
	val get_weights : Environment -> Weights

	val set_locstrat : 
		(string * (Signature -> Equality -> Equality -> Order)) -> 
		Environment -> Environment 	  
	val get_locstrat : Environment -> 
		string * (Signature -> Equality -> Equality -> Order)   


	val default_global_order : Signature -> Environment -> 
			Equality -> ORIENTATION * Environment

	val Initial_Env : Environment

   end (* of signature ENVIRONMENT *)
   ;
