(*
 *
 * $Log: i_signature.sig,v $
 * Revision 1.2  1998/06/08 18:10:47  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_signature.sig

This module provides the interface for the formal entering and display 
of signatures.

*)

signature I_SIGNATURE = 
   sig 
   	type State
   	val signature_options : State -> State
 
   end (* of signature I_SIGNATURE *)
   ;
