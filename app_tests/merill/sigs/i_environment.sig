(*
 *
 * $Log: i_environment.sig,v $
 * Revision 1.2  1998/06/08 18:11:57  jont
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

signature I_ENVIRONMENT = 
   sig
   	
   	type Signature
   	type Equality
   	type Environment
   	type ORIENTATION
   	type State
 
	val environment_options : (State -> string * 
		(Signature -> Environment -> Equality -> ORIENTATION * Environment)) 
			-> State -> State

	val save_environment : (string -> unit) -> Signature -> Environment -> unit
	
	val load_environment : (string -> string * 
		(Signature -> Environment -> Equality -> ORIENTATION * Environment)) 
			-> (unit -> string) -> State -> Environment

end (* of signatire I_ENVIRONMENT *)
;