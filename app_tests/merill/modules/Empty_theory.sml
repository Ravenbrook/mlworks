(*
 *
 * $Log: Empty_theory.sml,v $
 * Revision 1.2  1998/06/08 17:52:28  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     11/04/92
Glasgow University and Rutherford Appleton Laboratory.

Empty_theory.sml

The basic tools for the empty theory.

*)


functor Empty_TheoryFUN ( structure T : TERM
		          structure M : MATCH 
	                  structure U : UNIFY
	                  structure E : EQUALITY
	                  sharing type T.Term = M.Term = U.Term = E.Term
	                  and     type T.Sig.Signature = M.Signature = U.Signature = E.Signature
	                  and     type M.Substitution = U.Substitution = E.Substitution
	                ) : ETOOLS =
struct 

type Signature = T.Sig.Signature
type Term = T.Term
type Substitution = M.Substitution
type Equality = E.Equality

val equality = fn x => K T.TermEq x
val match = M.match
val all_matches = M.all_matches
val unify = U.unify
val equivalent = fn x => K E.EqualityEq x

end (* of functor AC_TheoryFUN *)
;
