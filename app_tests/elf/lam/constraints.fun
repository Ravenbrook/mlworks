(*
 *
 * $Log: constraints.fun,v $
 * Revision 1.2  1998/06/03 12:18:16  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991,1994 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Constraint management *)
(* Printing should be fixed to use formatter !!! *)
(* Added unify_failure  -er *)
(* Added verbose constraint printing *)

functor Constraints (structure Term : TERM
		     structure ConstraintsDataTypes : CONSTRAINTS_DATATYPES
			sharing ConstraintsDataTypes.Term = Term
		     structure Print : PRINT
		        sharing Print.Term = Term
		     structure PrintVarVerbose : PRINT_VAR
			sharing PrintVarVerbose.Term = Term
		     structure Sb : SB
		        sharing Sb.Term = Term
		     structure Reduce : REDUCE
		        sharing Reduce.Term = Term) : CONSTRAINTS =
struct

open ConstraintsDataTypes

structure Term = Term
structure F = Print.F
structure S = Print.S

local open Term
in
  datatype unify_failure
   = FailArgs
   | FailOccursCheck of term
   | FailFuntype of occurs * term
   | FailClash of term * term
   | FailDependency of term * term * term list * term list

  exception Nonunifiable of unify_failure

  fun bare_term (Gvar(M,_)) = M
    | bare_term (Flex(M,_)) = M
    | bare_term (Abstraction(M)) = M
    | bare_term (Rigid(M,_)) = M
    | bare_term (Quant(M)) = M
    | bare_term (Any(M)) = M

  fun makestring_eqterm (Gvar(M,_)) = "[G]" ^ Print.makestring_term M
    | makestring_eqterm (Flex(M,_)) = "[F]" ^ Print.makestring_term M
    | makestring_eqterm (Abstraction(M)) = "[L]" ^ Print.makestring_term M
    | makestring_eqterm (Rigid(M,_)) = "[R]" ^ Print.makestring_term M
    | makestring_eqterm (Quant(M)) = "[Q]" ^ Print.makestring_term M
    | makestring_eqterm (Any(M)) = "[A]" ^ Print.makestring_term M

  val mkDpair = Dpair

  fun makestring_dpair (Dpair(eqM,eqN)) =
      "(" ^ makestring_eqterm eqM ^ ", "
      ^ makestring_eqterm eqN ^ ")"

  fun makestring_dset ds =
      " [[ "
      ^ (let fun ms nil = ""
		  | ms (dpair :: rest) =
		       makestring_dpair dpair
		       ^ (case rest of nil => "" | _ => ",\n    ") ^ ms rest
	      in ms ds end)
      ^ " ]] \n"

  (* This might still miss opportunities (head-normalization, eta conv.) *)

  fun eq_uvar_or_non_uvar stamp1 (Uvar(_,stamp2)) = (stamp1 = stamp2)
    | eq_uvar_or_non_uvar stamp1 (Evar(_,_,_,ref(SOME(M0)))) =
	 eq_uvar_or_non_uvar stamp1 M0
    | eq_uvar_or_non_uvar stamp1 _ = true

  fun dominates_all depends_on nil = true
    | dominates_all depends_on (Uvar(_,stamp)::rest) =
	 if exists (eq_uvar_or_non_uvar stamp) rest
	      orelse exists (Sb.eq_uvar stamp) depends_on
	    then false
	    else dominates_all depends_on rest
    | dominates_all depends_on _ = false  (* first arg is not a Uvar *)


  fun anno_norm (M as (Abst _)) = Abstraction(M)
    | anno_norm (Evar(_,_,_,ref(SOME(M0)))) = anno_norm M0
    | anno_norm (M as Type) = Rigid(M,(M,nil))
    | anno_norm (M as Pi _ ) = Quant(M)
    | anno_norm M = 
	let fun anorm (head as Const _) args = Rigid(M,(head,args))
	      | anorm (head as Uvar _) args = Rigid(M,(head,args))
	      | anorm (Evar(_,_,_,ref(SOME(M0)))) args = anorm M0 args
	      | anorm (head as Evar(_,_,uvars,_)) args =
		   if dominates_all uvars args
		      then Gvar(M,(head,args))
		      else Flex(M,head)
	      | anorm (Appl(M1,N1)) args = anorm M1 (N1::args)
	      | anorm (Abst _) args = anno_norm (Reduce.head_norm M)
	      | anorm (head as Fvar _) args = Rigid(M,(head,args))
	      | anorm M _ = raise Print.subtype("anorm",M,"illegal argument.")
	 in anorm M nil end

  (* fun anno M = anno_norm (Reduce.head_norm M) *)
  val anno = anno_norm

  fun reclassify M = anno_norm (Reduce.head_args_norm M)

  val empty_constraint = Con(nil)
  fun is_empty_constraint (Con(nil)) = true
    | is_empty_constraint _ = false

  fun collect_sorted_vars vars nil = vars
    | collect_sorted_vars vars (Dpair(eqM,eqN) :: rest) =
      collect_sorted_vars (csv (csv vars (bare_term eqM)) (bare_term eqN)) rest
  and csv vars (Bvar _) = vars
    | csv vars (Evar(_,_,_,ref(SOME M0))) = csv vars M0
    | csv vars (M as Evar(Varbind(x,A),_,uvars,ref(NONE))) =
      if (exists (fn v => eq_var(M,v)) vars)
	  then vars
      else M :: (csv' (csv vars A) uvars)
    | csv vars (M as Fvar(Varbind(x,A))) =
      if (exists (fn v => eq_var(M,v)) vars)
	  then vars
      else M :: (csv vars A)
    | csv vars (M as Uvar(Varbind(x,A),_)) =
      if (exists (fn v => eq_var(M,v)) vars)
	  then vars
      else M :: (csv vars A)
    | csv vars (Const _) = vars
    | csv vars (Appl(M1,M2)) =
      csv (csv vars M1) M2
    | csv vars (Abst(Varbind(x,A),M1)) =
      csv (csv vars A) M1
    | csv vars (Pi((Varbind(x,A),B),_)) =
      csv (csv vars A) B
    | csv vars (Type) = vars
    | csv vars (HasType(M,A)) =
      csv (csv vars A) M
    | csv vars (M as Wild) = raise Print.subtype("csv",M,"illegal wildcard")
    | csv vars (M as Mark _) = raise Print.subtype("csv",M,"illegal marked term")
  and csv' vars nil = vars
    | csv' vars ((M as Uvar(Varbind(x,A),_))::varlist) =
      csv' (if (exists (fn v => eq_var(M,v)) vars)
		then vars
	    else M::csv vars A)
           varlist
    | csv' vars (M::varlist) = raise Print.subtype("csv'",M,"is not a Uvar")

  fun makeformat_dpair (Dpair(eqM,eqN)) =
      F.HOVbox [Print.makeformat_term (bare_term eqM), F.Break,
		F.String S.equal, F.Space,
		Print.makeformat_term (bare_term eqN)]

  fun makeformat_dset nil = nil
    | makeformat_dset (dpair :: rest) =
	 (makeformat_dpair dpair
	  :: (case rest of nil => [] | _ => [F.String S.comma, F.Break]))
	 @ makeformat_dset rest

  fun makeformat_varlist nil fmts = fmts
    | makeformat_varlist (v :: varlist) fmts =
         makeformat_varlist varlist (F.String (PrintVarVerbose.makestring_var (fn _ => false) v)
				     :: F.String S.comma :: F.Break :: fmts)

  fun makeformat_constraint (Con(dset)) =
      let val sorted_vars = collect_sorted_vars nil dset
      in 
	  F.Hbox [F.String S.lparen, F.String S.lparen, F.Space,
		  F.Vbox0 0 1 (makeformat_varlist sorted_vars nil @ makeformat_dset dset),
		  F.Space, F.String S.rparen, F.String S.rparen,
		  F.Newline ()]
      end
  val makestring_constraint = F.makestring_fmt o makeformat_constraint

  local
      val S = F.String o S.string
  in
      fun makeformat_unify_failure (FailArgs) =
	  S ("Unification failure due to differing numbers of arguments")
	| makeformat_unify_failure (FailOccursCheck(ev)) =
	  F.HVbox [S "Unification failure due to occurs-check on variable", F.Break,
		   Print.makeformat_term ev, F.Newline ()]
	| makeformat_unify_failure (FailFuntype(occ,M)) =
	  F.HVbox [S "Unification failure due to clash:", F.Break,
		   S (if (occ = Maybe) then "{...}" else "->"), F.Break,
		   S "<>", F.Break,
		   Print.makeformat_term M, F.Newline ()]
	| makeformat_unify_failure (FailClash(M,N)) =
	  F.HVbox [S "Unification failure due to clash:", F.Break,
		   Print.makeformat_term M, F.Break,
		   S "<>", F.Break,
		   Print.makeformat_term N, F.Newline ()]
	| makeformat_unify_failure (FailDependency(ev,M,args,uvars)) = 
	  F.HVbox [S "Unification failure due to dependency of", F.Break,
		   Print.makeformat_term ev, F.Break, S "on", F.Break,
		   Print.makeformat_term M, F.Break,
		   S "which may depend only on [",
		   F.HVbox (fold (fn (M,r) => (Print.makeformat_term M::F.Break::r)) args nil),
		   S "]", F.Break, S "and", F.Break, S "[",
		   F.HVbox (fold (fn (M,r) => (Print.makeformat_term M::F.Break::r)) uvars nil),
		   S "]", F.Newline ()]
  end

  val makestring_unify_failure = F.makestring_fmt o makeformat_unify_failure

end  (* local ... *)
end  (* functor Constraints *)
