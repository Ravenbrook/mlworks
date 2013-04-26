(*
 *
 * $Log: i_term.sig,v $
 * Revision 1.2  1998/06/08 18:08:53  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_term.sml 

This module provides the top level interface for the formal entering and display 
of terms

*)

signature I_TERM = 
   sig
	type Variable
	type Term
	type Signature

	val enter_term : Signature -> Term TranSys.TranSys -> 
			(string,Variable) Assoc.Assoc -> (Term  * (string,Variable) Assoc.Assoc) Search
	val display_term : Signature -> Term -> unit

   end (* of signature I_TERM *)
   ;
