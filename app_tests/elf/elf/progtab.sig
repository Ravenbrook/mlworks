(*
 *
 * $Log: progtab.sig,v $
 * Revision 1.2  1998/06/03 12:20:40  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Spiro Michaylov <spiro@cs.cmu.edu>       *)

(* Program table *)

signature PROGTAB =
sig

  structure Term : TERM
  structure Sign : SIGN
     sharing Sign.Term = Term
  structure Skeleton : SKELETON
     sharing Skeleton.Term = Term

  datatype mobility = Dynamic of bool | Static | Unknown of bool

  datatype progentry =
      Progentry of 
	  {
	  Faml: Term.term,                (* family *) 
	  Name: Term.term,                (* name of rule *)
	  Vars: Term.varbind list,        (* variables *)
	  Head: Term.term,                (* head of rule *)
	  Subg: mobility list,            (* subgoals *)
	  Indx: Term.term option,    	  (* principal functor of 1st arg *)
	  Skln: Skeleton.skeleton         (* skeleton for unification *)
	  }

  val reset : unit -> unit

  val store_prog : progentry list list -> unit

  val mark_dynamic : Term.term -> unit
  val is_dynamic : Term.term -> bool
  val subgoals : Term.term -> mobility list

  val get_rules : Term.term -> progentry list

  val get_index : Term.term -> Term.term list -> Term.term option

  val indexes_match : Term.term option -> Term.term option -> bool

  val make_progentry : bool -> Term.term * Term.term -> progentry option
  val sign_to_prog : bool -> Sign.sign -> progentry list

end  (* signature PROGTAB *)
