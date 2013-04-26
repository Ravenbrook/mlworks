(*
 *
 * $Log: absyn.sig,v $
 * Revision 1.2  1998/06/03 12:19:12  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Abstract syntax *)

signature ABSYN =
sig

  structure Term : TERM
  structure Symtab : SYMTAB		(* not necessary, but useful *)
    sharing type Symtab.entry = Term.sign_entry

  val mark_syntax : bool ref

  type aterm
  type avarbind
  type afixity
  type atermseq
  type aatom

  exception UndeclConst of (int * int) * string
  exception FixityError of (int * int) * string
  exception AbsynError of (int * int) * string

  val to_varbind : avarbind -> string list * Term.varbind
  val to_term : aterm -> string list * Term.term

  val mk_abst : avarbind * aterm -> (int * int) -> aterm
  val mk_pi :  avarbind * aterm -> (int * int) -> aterm
  val mk_arrow : aterm * aterm -> (int * int) -> aterm
  val mk_appl : aterm * aterm -> (int * int) -> aterm
  val mk_hastype : aterm * aterm -> (int * int) -> aterm
  val mk_mark : aterm -> (int * int) -> aterm

  val mk_varbind : string * aterm -> avarbind

  val mk_oneseq : aatom -> (int * int) -> atermseq
  val mk_termseq : atermseq * aatom -> (int * int) -> atermseq
  val seq_to_term : atermseq -> (int * int) -> aterm
  val atom_to_term : aatom -> aterm
  val term_to_term : aterm -> (Term.term -> Term.term) -> aterm

  val mk_const       : string -> (int * int) -> aatom
  val mk_bv_const    : string -> (int * int) -> aatom
  val mk_bv_fv	     : string -> (int * int) -> aatom
  val mk_bv_const_fv : string -> (int * int) -> aatom
  val mk_bv_uv_const : string -> (int * int) -> aatom
  val mk_bv_uv_const_fv : string -> (int * int) -> aatom

  val mk_uscore : (int * int) -> aterm
  val mk_ttype : (int * int) -> aterm

  val term_to_atom : aterm -> aatom

  val mk_uscore_string : string

  val mk_binop : (string * aterm * aterm) -> (int * int) -> (int * int) -> aterm
  val mk_quant : (string * aterm) -> (int * int) -> (int * int) -> aterm

  val mk_fix : Term.fixity * afixity -> (int * int)
	          -> (Term.fixity * int) * Term.sign_entry list
  val mk_fixity : int * string list -> (int * int) -> afixity
  val mk_name_pref : string * string list -> (int * int)
		  -> Term.sign_entry * string list

  val mk_int : int -> (int * int) -> aterm
  val mk_string : string -> (int * int) -> aterm
  val mk_int_type : (int * int) -> aterm
  val mk_string_type : (int * int) -> aterm

end  (* signature ABSYN *)
