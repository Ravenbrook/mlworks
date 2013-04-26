(*
 *
 * $Log: load.sig,v $
 * Revision 1.2  1998/06/08 18:22:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/07/90
Glasgow University and Rutherford Appleton Laboratory.

load.sig

Functions to load the state of eril, or parts thereof, in files
saved previously.

*)

signature LOAD =
   sig

(*   	type Signature
   	type Term
   	type EqualitySet
   	type Environment *)
   	type State

   	val load_signature : State -> State (*Signature * Term TranSys.TranSys -> Signature * Term TranSys.TranSys*)

  	val load_equations : State -> State

  	val load_state  : State -> State

  	val load_options : State -> State

   end (* of signature LOAD *)
   ;
