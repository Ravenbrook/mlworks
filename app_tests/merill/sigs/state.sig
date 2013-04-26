(*
 *
 * $Log: state.sig,v $
 * Revision 1.2  1998/06/08 18:05:21  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     08/05/92
Glasgow University and Rutherford Appleton Laboratory.

state.sig

The overall global state of the system.

*)

signature STATE = 
   sig

	type Signature
	type Term
	type EqualitySet
	type Environment

	type State 

	val Initial_State : State

	val get_Signature : State -> Signature
	val get_Parser : State -> Term TranSys.TranSys
	val get_Equalities : State -> EqualitySet list
	val get_Environment : State -> Environment
	val get_EqTheory : State -> EqualitySet

	val change_Signature : State -> Signature -> State
	val change_Parser : State -> Term TranSys.TranSys -> State
	val change_Equalities : (State -> EqualitySet list) -> State -> State
	val change_Environment : (State -> Environment) -> State -> State
	val change_EqTheory : State -> EqualitySet -> State

   end ; (* of signature STATE *)

