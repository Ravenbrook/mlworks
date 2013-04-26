(*
 *
 * $Log: save.sig,v $
 * Revision 1.2  1998/06/08 18:21:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/07/90
Glasgow University and Rutherford Appleton Laboratory.

save.sig

Functions to save the state of eril, or parts thereof, in files for
later reuse.

*)

signature SAVE =
   sig

   	type Signature
   	type EqualitySet
   	type State

   	val save_signature : Signature -> unit

  	val save_equalities : Signature * EqualitySet list -> unit
  	
  	val save_state : State -> unit
  	
  	val save_options : State -> State

   end (* of signature ORDERING *)
   ;
