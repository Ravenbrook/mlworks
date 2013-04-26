(*
 *
 * $Log: completiontools.sig,v $
 * Revision 1.2  1998/06/08 18:13:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/92
Glasgow University and Rutherford Appleton Laboratory.

completiontools.sig

Functions for splitting and for handling conjectures in completion.

*)

signature COMPLETIONTOOLS = 
  sig
  	type Signature 
  	type Equality
  	type Term
  	type EqualitySet

	val split : Signature -> Term TranSys.TranSys -> 
			Equality -> EqualitySet * Signature * Term TranSys.TranSys
	val consider_conjectures : Signature  -> EqualitySet ->
                       EqualitySet list -> EqualitySet -> (bool * EqualitySet)

	val stop : bool -> Signature -> EqualitySet list -> EqualitySet -> bool
	
	val selectNext : string -> EqualitySet -> (Equality * EqualitySet)

  end (* of signature COMPLETIONTOOLS *)
  ;
