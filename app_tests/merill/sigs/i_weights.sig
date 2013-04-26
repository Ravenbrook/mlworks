(*
 *
 * $Log: i_weights.sig,v $
 * Revision 1.2  1998/06/08 18:03:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     03/12/91
Glasgow University and Rutherford Appleton Laboratory.

i_weights.sig

This module provides the top level interface for the formal entering and 
display of the weights on function symbols.

*)

signature I_WEIGHTS = 
   sig
	type Weights
	type Signature
	
	val display_weights : Signature -> Weights-> unit 
	val enter_weight   : Signature  -> Weights-> Weights
	val delete_weight  : Signature  -> Weights-> Weights
	val save_weights    : (string -> unit) -> Signature 
				          -> Weights -> unit 
	val load_weight    : (unit -> string) -> Signature 
				          -> Weights -> Weights

	val weight_options : Signature -> Weights -> Weights

   end (* of signature I_WEIGHTS *)
   ;
