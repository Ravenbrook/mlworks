(*
 *
 * $Log: eq_options.sig,v $
 * Revision 1.2  1998/06/08 18:20:29  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     14/11/90
Glasgow University and Rutherford Appleton Laboratory.

eq_options.sig

options to act on equalitysets.

*)

signature EQ_OPTIONS =
   sig
   	type State
	val equation_options : State -> State

   end (* of signature EQ_OPTIONS *)
   ;
