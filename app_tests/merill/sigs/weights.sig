(*
 *
 * $Log: weights.sig,v $
 * Revision 1.2  1998/06/08 17:58:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/09/90
Glasgow University and Rutherford Appleton Laboratory.

The Signature for functions for assigning weights to functions
as used in the Knuth-Bendix Ordering.

*)

signature WEIGHTS = 
   sig
   	type OpId
   	type Weights
   	
   	val No_Weights : Weights
	val add_weight : Weights -> OpId -> int -> Weights
	val find_weight : Weights -> OpId Search -> int 
	val remove_weight : Weights -> OpId -> Weights 
	val show_weights  : (OpId -> string) -> Weights -> (string * string) list

  end (* of signature WEIGHTS *) ;
