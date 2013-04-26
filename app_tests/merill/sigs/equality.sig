(*
 *
 * $Log: equality.sig,v $
 * Revision 1.2  1998/06/08 17:50:11  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

equality.sig 

*)

signature EQUALITY =
   sig
	structure Pretty : PRETTY

	type Signature
	type Term
	type Substitution
	type ORIENTATION

	type Equality

	val mk_equality : Term -> Term -> Equality
	val mk_rule : Term -> Term -> ORIENTATION -> Equality
	val mk_conjecture : Term -> Term -> Equality
	val mk_conditional : Equality -> Equality list -> Equality
	
	(* for conditionals *)
	val is_conditional : Equality -> bool
	val conditions : Equality -> Equality list
	val conclusion : Equality -> Equality
	
	val is_rule : Equality -> bool
	
	val lhs : Equality -> Term
	val rhs : Equality -> Term
	
	val terms : Equality -> Term * Term
	
	val protect : Equality -> Equality
	val unprotect : Equality -> Equality
	val protected : Equality -> bool

	val num_ops_in_eq : Equality -> int * int
	val num_of_vars_in_eq : Equality -> int * int
	
	val left_linear : Equality -> bool
	val right_linear : Equality -> bool
	val linear_equation : Equality -> bool

	val relate : (Term -> Term -> bool) -> Equality -> bool

	val identity   : Equality -> bool
	val EqualityEq : Equality -> Equality -> bool
	
	val rename_equality : Equality -> Equality
	val reorder :  Equality -> Equality
	val order :  Equality -> Equality
	val unorder : Equality -> Equality

	val applysubtoequality : Substitution -> Equality -> Equality
	
	val orientation : (Term -> Term -> bool) -> Equality -> ORIENTATION
	
	val parse_equality :  Signature -> Term TranSys.TranSys 
				-> string list -> Equality Maybe
				
	val unparse_equality : Signature -> Equality -> string 
	val pretty_equality : Signature -> Equality -> Pretty.T
	val show_equality : Signature -> Equality -> string * string

   end ; (* of signature EQUALITY *)

