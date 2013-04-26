(*
 *
 * $Log: userRPO.sml,v $
 * Revision 1.2  1998/06/08 18:16:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/07/90
Glasgow University and Rutherford Appleton Laboratory.

userRPO.sml

Provides an implementation of RPO with a fixed ordering
on operators.
*)

(*
A definition of RPO with lexicographic status is:-
	s = f (s1, ... , sm) >=rpo g(t1, ... ,tn) = t
	if
	i)	si >= rpo t   	for some i = 1,...,m
	or
	ii)	f > g and s >rpo tj 	for all j = 1,...,n
	or
	iii)	f = g and [s1, ... , sm] >>=rpo [t1, ... ,tn] 
where >>=rpo is the lexicographic extension of RPO.
*)

signature USERRPO =
   sig
    	type Signature
   	type Equality
   	type Environment
   	type ORIENTATION

     	val userRPOLeft : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment
  	val userRPORight : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment

  	val userRPOMultiSet : Signature -> Environment -> Equality 
   				-> ORIENTATION * Environment
	
  end (* of signature USERRPO *)
;

functor UserRPOFUN (structure T : TERM
		    structure Eq : EQUALITY
		    structure O : ORDER
		    structure En : ENVIRONMENT
		    structure P : PRECEDENCE
		    sharing type T.Sig.Signature = Eq.Signature = 
		                 En.Signature = P.Signature
		    and     type T.Term = Eq.Term = P.Term
		    and     type T.Sig.O.OpId = P.OpId = T.OpId
		    and     type Eq.Equality = En.Equality
		    and     type O.ORIENTATION = En.ORIENTATION = Eq.ORIENTATION
		    and     type P.Precedence = En.Precedence
		    and     type T.Variable = T.Sig.V.Variable
		   ) : USERRPO = 
struct

type Signature = T.Sig.Signature
type Equality = Eq.Equality
type Environment = En.Environment
type ORIENTATION = O.ORIENTATION

structure Ops = T.Sig.O
structure Vars = T.Sig.V

open Eq T En O P

local 

(*
fun printbool s (b:bool) = (write_terminal (s^" "^makestring b^"\n") ; b)
*)

(* function for testing whether s > t in RPO *)

	 fun userRPO A Ext (P:Precedence) = 
	     let fun RPOext l1 l2 = Ext RecPathOrd l1 l2 
          	 and
	    	 BiggerThanAny (s:Term) t1 = forall (RecPathOrd s) t1 
          	 and 
	    	 RecPathOrd s t  = 
                 ((* write_terminal ("comparing "^show_term A s^" & "^show_term A t^"\n");*)
	    	 case (compound s,compound t) of
	    	   (true,true)  => let val (f,g) = (root_operator s, root_operator t)
	    	   		       val (s1,t1) = (subterms s, subterms t)
	    	   		   in


(* case 1	The outermost function symbols are different.
		check precedence, and check LHS is RPO-orientable with all subterms of RHS. *)

	  	         	   ((apply_prec P f g) andalso 
				((*write_terminal (show_term A s^" bigger root than "^" & "^show_term A t^"\n");*)
					     BiggerThanAny s t1) )

	  			   orelse 

(* case 2	The outermost function symbols are the same (or equivalent)
		Apply the status extention to the ordering. *)

(* 
(* This has changed to allow congruent ops in the precedence *)
	  			   (Ops.OpIdeq f g andalso (RPOext s1 t1)) 
*)
	  			   ((Ops.OpIdeq f g orelse equal_prec P f g) 
                                    andalso ((*write_terminal ("equal root "^show_term A s^" & "^show_term A t^"\n");*)
					     RPOext s1 t1))

				   orelse 

(* case 3	An argument of the LHS is permutatively congruent or RPO-orientable
		with the RHS.  Note the C combinator to swap arguments around. *)

	    	   		   (exists (permutatively_congruent t) s1)
	  	       		   orelse (exists (C RecPathOrd t) s1)
	  	         	   end
		| (true,false)  => 
(* in the case where the potentially smaller term is a variable, we can simplify the process - we only need check that the variable is in the lhs term.  This is probably more efficient   *)
				   let (*val _ = write_terminal ("test term to var "^show_term A s^" & "^show_term A t^"\n") *)
				       val s1 = subterms s
	    	   		   in (exists (C RecPathOrd t) s1)
	  	        	      orelse (exists (TermEq t) s1)
	  	         	   end
				   (* (*than this*) element Vars.VarEq (vars_of_term s) (get_Variable t)*)
(*	LHS is a variable  -  fail. *)
	  	|      _	=> false )
      	    in RecPathOrd 
            end 

in 

fun userRPOLeft A env e = (orientation (userRPO A (LexicoExtLeft TermEq) (get_precord env)) e , env)
fun userRPORight A env e = (orientation (userRPO A (LexicoExtRight TermEq) (get_precord env)) e , env)
fun userRPOMultiSet A env e = (orientation (userRPO A MultiSetExt (get_precord env)) e , env)

end 

end (* of functor UserRPOFUN *)
;

