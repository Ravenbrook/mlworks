(*
 *
 * $Log: substitution.sml,v $
 * Revision 1.2  1998/06/08 17:45:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/02/90
Glasgow University and Rutherford Appleton Laboratory.

substitution.sml 

This file contains an implementation of substitutions of terms for variables. 
This is the substitution with the propogated substitution list

Depends on:
	signature.sml
	transys.sml
	opsymb.sml
	variable.sml
	sort.sml

*)


functor SubstitutionFUN (structure T : TERM
			 sharing type T.Sig.V.Variable = T.Variable
			 and     type T.Sort = T.Sig.V.Sort
			) : SUBSTITUTION =
struct

type Variable = T.Sig.V.Variable
type Variable_Print_Env = T.Sig.V.Variable_Print_Env
type Signature = T.Sig.Signature
type Term = T.Term
val VarEq = T.Sig.V.VarEq
val TermEq = T.TermEq

abstype Substitution = Sub of (Variable * Term) list | Fail
   with
        local 
        fun add p (Sub bl) = Sub (p::bl)
	  | add _  Fail = Fail

        fun lookup x bl =
          let fun scan ((h,hb)::tl) = if VarEq x h then OK hb else scan tl
	        | scan [] = errM
          in scan bl
          end

	in
	val FailSub = Fail
	val EMPTY = Sub []
	fun isfail (Sub s) = false | isfail Fail = true


	fun updatesubs (Sub sl) (x,i) = (case lookup x sl of 
				   OK t   => if TermEq i t then Sub sl else FailSub (* check for clashes *)
				| Error _ => add (x,i) (Sub sl))
	  | updatesubs Fail _ = FailSub

	local 
	fun applysub (Sub sl) x = if T.variable x then 
				  (case lookup (T.get_Variable x) sl of
				   Error _ => x | OK t => t)
				  else x
	  | applysub Fail x = x 
	in 
	fun applysubtoterm sl = T.termmap (applysub sl) 
	end


        fun compose_subst Fail _ = FailSub
          | compose_subst _ Fail = FailSub
          | compose_subst (Sub []) S = S
          | compose_subst S (Sub []) = S
          | compose_subst (Sub ((v,t)::rs)) S =
            updatesubs (compose_subst (Sub rs) S) (v,applysubtoterm S t) 

	fun addsub sl (x,i) = add (x,i) sl  (* a naive add, with no check for clashes *)

(* 
As we want to model order-sorted reasoning, we have to check that substitutions respect the sort
order.  That is, all variables are assigned to terms of equal or lesser sort.
*)

	fun well_formed_subst (sign : Signature) (Fail : Substitution) = false
	  | well_formed_subst (sign : Signature) (Sub sl : Substitution) = 
	    let fun check_pair (x,t) = T.of_sort sign (T.Sig.V.variable_sort x) t
	    in forall check_pair sl
	    end
	
	fun domain_of_sub Fail = [] 
	  | domain_of_sub (Sub sl) = map fst sl 

	local
	fun show_vt_list Sigma vpe [] = []
	  | show_vt_list Sigma vpe ((v,t)::rsubs) = 
	    let val (varstring,newvpe)   = T.unparse_term Sigma vpe (T.mk_VarTerm v)
	        val (termstring,newvpe') = T.unparse_term Sigma newvpe t
	    in  (varstring ^ " --> " ^ termstring ) :: show_vt_list Sigma newvpe' rsubs
	    end
	in
	fun show_substitution Sigma Fail = "Failure"
	  | show_substitution Sigma (Sub sl) = stringwith ("{ ","\n  "," }") 
	    (show_vt_list Sigma T.Sig.V.Empty_Var_Print_Env sl)

	fun show_subs_context Sigma _ Fail = "Failure"
	  | show_subs_context Sigma vpe (Sub sl) = stringwith ("{ ","\n  "," }") 
	    (show_vt_list Sigma vpe sl)
	end (* of show_substitution local *)

	end (* of local *)

   end  (* of abstype Substitution *) 
   
end (* of functor SubstitutionFUN *) 
; 
