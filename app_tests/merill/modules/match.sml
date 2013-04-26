(*
 *
 * $Log: match.sml,v $
 * Revision 1.2  1998/06/08 17:47:54  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     16/01/90
Glasgow University and Rutherford Appleton Laboratory.

match.sml

An implementation of the naive, non-deterministic algorithm of Martelli and Montenari for matching.

It is made deterministic by considering the first element which has not yet been converted 
into a (variable,term) pair.

It uses ../experiment/{term.ml,substitution.ml}
*)


functor MatchFUN (structure S:SUBSTITUTION
		  structure T:TERM
		  sharing type S.Term = T.Term 
		  and     type S.Variable = T.Sig.V.Variable = T.Variable
		  and     type T.Sig.V.Sort = T.Sort = T.Sig.S.Sort
		  and     type T.Sig.Signature = S.Signature 
		 ) : MATCH =
struct

type Signature = T.Sig.Signature
type Term = T.Term
type Substitution = S.Substitution

open T S

local  (* we only want to export the match function *)


fun term_reduction t1 t2 = zip (subterms t1,subterms t2) 

val leq = T.Sig.S.sort_ordered_reflexive o T.Sig.get_sort_ordering

(* NB No variable-elimination necessary for matching, but updatesubs is used as this checks for clashes *)

fun matchlist A ((s,t)::re) S = 
	(case (compound s,compound t) of
	   (true,true)   => if same_root s t 
	   		    then matchlist A (term_reduction s t @ re) S
	  		    else FailSub 
	 | (true,false)  => FailSub 
	 | (false,_)  => if TermEq s t then matchlist A re S
	 		 else let val v = get_Variable s 
			      in if (not(T.of_sort A (T.Sig.V.variable_sort v) t))
			             orelse (compound t andalso occurs v t)
			         then FailSub 
	 		         else let val S' = updatesubs S (v,t)
	 		              in if isfail S' then FailSub else matchlist A re S'
	 		              end  
	 		      end )
  | matchlist _ [] S = S 

in

fun match S t1 t2 = matchlist S [(t1,t2)] EMPTY

end (* of local *) ;

fun all_matches sign t1 t2 = 
    filter (not o isfail) [match sign t1 t2]

end (* of functor MatchFUN *)
;
