(*
 *
 * $Log: print_ellide.fun,v $
 * Revision 1.2  1998/06/03 12:14:54  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Printing with respect to a signature. *)
(* Synthesized arguments will be ellided. *)

functor PrintEllide (structure Basic : BASIC
		     structure Term : TERM
		     structure Reduce : REDUCE
		        sharing Reduce.Term = Term
		     structure PrintTerm : PRINT_TERM
		        sharing PrintTerm.Term = Term
		     structure Symtab : SYMTAB
		        sharing type Symtab.entry = Term.sign_entry)
		    : PRINT_TERM =
struct

structure Term = Term
structure F = PrintTerm.F
structure S = PrintTerm.S

local open Term
in

  val printDepth = PrintTerm.printDepth
  val printLength = PrintTerm.printLength

  fun beta_norm_syn M = bangify (beta_syntactify (Reduce.renaming_head_norm M))
  and beta_syntactify (M as (Bvar _)) = (M,Wild)
    | beta_syntactify (M as (Evar(_,_,_,ref NONE))) = (M,Wild)
    | beta_syntactify (M as (Evar(_,_,_,ref (SOME M0)))) =
	 beta_syntactify M0
    | beta_syntactify (M as (Uvar _)) = (M,Wild)
    | beta_syntactify (M as (Fvar _)) = (M,Wild)
    | beta_syntactify (M as (Const(E (ref {Full = s, ...})))) = (M, s)
    | beta_syntactify (M as Const _) = (M,Wild)
    | beta_syntactify (Appl(M1,M2)) =
	let val (normal_M1,template) = beta_syntactify M1
	 in case template
	      of (Appl(N,Wild)) => (normal_M1,N)
	       | _ => (Appl(normal_M1,beta_norm_syn M2),Wild)
	end
    | beta_syntactify (Abst(Varbind(x,A),M)) =
	 (Abst(Varbind(x,beta_norm_syn A),beta_norm_syn M),Wild)
    | beta_syntactify (Type) = (Type,Wild)
    | beta_syntactify (Pi((Varbind(x,A),B),occ)) =
	 (Pi((Varbind(x,beta_norm_syn A),beta_norm_syn B),occ),Wild)
    | beta_syntactify (HasType(M,A)) = beta_syntactify M
    | beta_syntactify (Mark(_,M)) = beta_syntactify M
    | beta_syntactify (Wild) = (Wild,Wild)
  and bangify (M as Const(cname),Appl(N,Wild)) =
         raise Basic.Illegal("bangify: "
	    ^ F.makestring_fmt (PrintTerm.makeformat_term M)
	    ^ " not eta-expandable in current context")
    | bangify (M,Appl(N,Wild)) =
         raise Basic.Illegal("bangify: "
	    ^ F.makestring_fmt (PrintTerm.makeformat_term M)
	    ^ " not printable in current context")
    | bangify (M,_) = M

  fun makeformat_term M = PrintTerm.makeformat_term (beta_norm_syn M)
  val makeformat_const = PrintTerm.makeformat_const

end  (* local ... *)
end  (* functor PrintEllide *)
