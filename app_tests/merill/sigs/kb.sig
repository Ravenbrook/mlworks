(*
 *
 * $Log: kb.sig,v $
 * Revision 1.2  1998/06/08 18:14:17  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     04/12/90
Glasgow University and Rutherford Appleton Laboratory.

kb.sml 

Knuth-Bendix Completion algorithm

*)

signature KB = 
  sig
	type EqualitySet
	type State
	
	val CompName : string 
	val complete : State  -> 
	         bool -> 
	         EqualitySet * EqualitySet -> 
	         EqualitySet -> 
	         (EqualitySet * EqualitySet * EqualitySet) * State

  end (* of signature KB *)
  ;
