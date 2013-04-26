(*
 *
 * $Log: state.sml,v $
 * Revision 1.2  1998/06/08 18:05:47  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     08/05/92
Glasgow University and Rutherford Appleton Laboratory.

state.sml

The overall global state of the system.

*)

functor StateFUN (structure T  : TERM
		  structure Eq : EQUALITYSET
		  structure En : ENVIRONMENT
		 )   : STATE =
struct
		  
type Signature = T.Sig.Signature
type Term = T.Term
type EqualitySet = Eq.EqualitySet
type Environment = En.Environment

type State = 
	Signature * 			(*    Object Language    *)
	Term TranSys.TranSys * 		(* Term Parser Datatype  *)
	EqualitySet list * 		(* Current Equation Sets *)
	EqualitySet * 			(* Equational Theory Set *)
	Environment			(*  Current Environment  *)

val Initial_State = (T.Sig.Empty_Signature, 
		     TranSys.bracket_transys(): Term TranSys.TranSys,
	             [Eq.new_equality_set "A" "Axioms",
		      Eq.new_equality_set "R" "Rewrite Rules"],
		     Eq.EmptyEqSet,
		     En.Initial_Env)

val get_Signature   = #1 : State -> Signature
val get_Parser      = #2 : State -> Term TranSys.TranSys
val get_Equalities  = #3 : State -> EqualitySet list
val get_EqTheory    = #4 : State -> EqualitySet
val get_Environment = #5 : State -> Environment

fun change_Signature   (s,t,e,a,n) s' = (s',t,e,a,n)
fun change_Parser      (s,t,e,a,n) t' = (s,t',e,a,n)
fun change_Equalities f (st as (s,t,e,a,n))  = (s,t,f st,a,n)
fun change_EqTheory    (s,t,e,a,n) a' =  (s,t,e,a',n)
fun change_Environment f (st as (s,t,e,a,n))  =  (s,t,e,a,f st)

end ; (* of functor StateFUN *)
