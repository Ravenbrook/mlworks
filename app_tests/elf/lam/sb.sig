(*
 *
 * $Log: sb.sig,v $
 * Revision 1.2  1998/06/03 11:53:25  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Substitution primitives and utilities *)

signature SB =
sig

  structure Term : TERM

  type sb
  exception LooseBvar of Term.term

  val shadow : Term.varbind -> Term.varbind -> bool
  val free_in : Term.varbind -> Term.term -> bool
  val occurs_in : Term.term -> Term.term -> bool

  val id_sb : sb
  val term_sb : Term.varbind -> Term.term -> sb
  val add_sb : Term.varbind -> Term.term -> sb -> sb

  val shadow_sb : Term.varbind -> sb -> sb
  val rename_sb : (Term.varbind * Term.term) -> sb -> (Term.varbind * sb)

  val apply_sb : sb -> Term.term -> Term.term  (* term must be closed wrt sb *)
  val varbind_sb : sb -> Term.varbind -> Term.varbind

  val renaming_apply_sb : sb -> Term.term -> Term.term


  val generic_type : Term.varbind

  val new_evar : Term.varbind -> Term.term list -> Term.term
  val new_uvar : Term.varbind -> Term.term
  val new_evar_sb : Term.varbind list -> Term.term list -> sb
  val new_named_evar_sb : Term.varbind list -> Term.term list -> sb
  val new_fvar_sb : string list -> sb
  val app_to_evars : Term.term -> sb -> Term.term

  val eq_uvar : int -> Term.term -> bool       (* term must be Uvar *)

  val rename_vbds : Term.varbind list -> Term.varbind list

end  (* signature SB *)
