(*
 *
 * $Log: i_precedence.sig,v $
 * Revision 1.2  1998/06/08 18:02:02  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_precedence.sig

This module provides the top level interface for the formal entering and 
display of the precedence on function symbols.

*)

signature I_PRECEDENCE = 
   sig
	type Precedence
	type Signature
	
	val display_precedence : Signature -> Precedence -> unit 
	val enter_precedence   : Signature  -> Precedence -> Precedence
	val remove_precedence  : Signature  -> Precedence -> Precedence
	val save_precedence    : (string -> unit) -> Signature 
				          -> Precedence  -> unit 
	val load_precedence    : (unit -> string) -> Signature 
				          -> Precedence  -> Precedence

	val precedence_options : Signature -> Precedence -> Precedence

   end (* of signature I_PRECEDENCE *)
   ;
