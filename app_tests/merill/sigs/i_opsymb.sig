(*
 *
 * $Log: i_opsymb.sig,v $
 * Revision 1.2  1998/06/08 18:07:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_opsymb.sml

This module provides the top level interface for the formal entering and 
display of operator symbol descriptions.  

This also as it reads the operator symbol declaration, builds the term
parser to read terms built from those operators.

Depends on:
	sort.sml
	opsymb.sml
	transys.sml
	term.sml

*)

signature I_OPSYMB = 
   sig 
	type Sort
	type Term
	type Sort_Store
	type OpId
	type Op_Store
	type OpSig

	val enter_operators : Sort_Store -> 
			    Term TranSys.TranSys ->  
			    Op_Store -> 
			    Op_Store * Term TranSys.TranSys
	val display_operator_sig : Op_Store -> OpId -> 
			    OpSig -> string
	val display_operator  : Op_Store -> OpId -> unit 
	val display_operators : Op_Store -> unit 
	val delete_operators : Term TranSys.TranSys -> Op_Store -> 
			    Op_Store * Term TranSys.TranSys
	val load_operators :  (unit -> string) -> Sort_Store ->
			    Term TranSys.TranSys -> Op_Store -> 
			    Op_Store * Term TranSys.TranSys
	val save_operators :  (string -> unit) -> Op_Store -> unit
	
	val operator_options : Sort_Store * (Op_Store * Term TranSys.TranSys) -> Op_Store * Term TranSys.TranSys

   end (* of signature I_OPSYMB *)
   ;
