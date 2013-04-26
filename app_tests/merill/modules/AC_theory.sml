(*
 *
 * $Log: AC_theory.sml,v $
 * Revision 1.2  1998/06/08 17:52:54  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     11/04/92
Glasgow University and Rutherford Appleton Laboratory.

AC_theory.sml

functions for rewriting by equality sets.

*)


functor AC_TheoryFUN ( structure A : AC_TOOLS
	               structure M : MATCH 
	               structure U : UNIFY
	               structure E : EQUALITY
	               sharing type A.Term = M.Term = U.Term = E.Term
	               and     type A.Signature = M.Signature = U.Signature = E.Signature
	               and     type M.Substitution = U.Substitution = E.Substitution
	             ) : ETOOLS =
struct 

type Signature = A.Signature
type Term = A.Term
type Substitution = M.Substitution
type Equality = E.Equality

val equality = A.AC_equivalent
val match = M.match
val all_matches = M.all_matches
val unify = U.unify

fun equivalent A e1 e2 = A.equivalentPairs A (E.terms e1) (E.terms e2)

end (* of functor AC_TheoryFUN *)
;
