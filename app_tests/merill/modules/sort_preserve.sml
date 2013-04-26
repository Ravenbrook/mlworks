(*
 *
 * $Log: sort_preserve.sml,v $
 * Revision 1.2  1998/06/08 17:53:48  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				      9/11/90.
Glasgow University and Rutherford Appleton Laboratory.

sort_preserve.sml

This file contains the development code for checking whether a rewrite
rule is sort preserving.

This is used in the order-sorted equational completion routine to 
ensure correct completion - only sort-decreasing rules are allowed.

It follows SNGM pg 29-30 as per usual. 


depends on:
substitution.sml
term.sml
signature.sml
sort.sml
variable.sml

*)

functor Sort_PreserveFUN (structure T : TERM
			  structure S : SUBSTITUTION
			  sharing type S.Term = T.Term
			  and     type S.Variable = T.Sig.V.Variable = T.Variable
			  and     type T.Sig.S.Sort = T.Sig.V.Sort = T.Sort
			  and 	  type S.Signature = T.Sig.Signature
			 ) : SORT_PRESERVE =
struct

type Term = T.Term
type Substitution = S.Substitution

structure Sort = T.Sig.S
structure Vars = T.Sig.V

open S T

(* 

We start by producing a tau-weakening for the variables of a term.`

*)

(* 
Makes all pairs of a variable and variables of a lower sort.
*)

fun weaken_variable so (V : Vars.Variable) =
    let val var_sort = Vars.variable_sort V
        val ss = var_sort :: (Sort.subsorts so var_sort)  (* remember subsorts is strict *)
    in map ((pair V) o mk_VarTerm o Vars.generate_variable) ss
    end 


fun tau_weakenings (Sigma : Sig.Signature) (Vars : Vars.Variable list) = 
    let val new_var_pairs = map (weaken_variable (Sig.get_sort_ordering Sigma)) Vars
        val proto_subs = all_seqs new_var_pairs
    (* so at this point, we have all the sets of pairs - they need to be made into substitutions *)
    in  map (foldl addsub EMPTY) proto_subs
    end 

fun test_all_weakenings p (Sigma : Sig.Signature) (t1,t2) = 
    let val vars = vars_of_term t1
        val taus = tau_weakenings Sigma vars
        fun sort_test (s,t) Sub =
            p (least_sort Sigma (applysubtoterm Sub s)) (applysubtoterm Sub t)
        val failTaus = filter (not o sort_test (t1,t2)) taus
    in null failTaus
       orelse 
       (if Display_Level.current_display_level () = Display_Level.full
        then let val b = !Display_Level.Show_Sorts (* store previous setting *) 
             in (Display_Level.Show_Sorts := true ;
                 write_terminal (stringlist (show_substitution Sigma) 
       				("\nNon-Sort Decreasing Weakenings:\n",",\n","\n") failTaus) ;
                 Display_Level.Show_Sorts := b (* restore to previous setting *))
	     end 
        else ();
        false)
    end 

fun sort_decreasing (Sigma : Sig.Signature) (t,t') = 
	(test_all_weakenings (of_sort Sigma) Sigma  (t,t')
	 	handle (Least_Sort _) => (error_message "Signature is not Regular" ; false))

fun sort_preserving (Sigma : Sig.Signature) (t,t') = 
	 (test_all_weakenings (C (Sort.SortEq o least_sort Sigma)) Sigma (t,t')
	 	handle (Least_Sort _) => (error_message "Signature is not Regular" ; false))

end (* of functor Sort_PreserveFUN *) 
;
