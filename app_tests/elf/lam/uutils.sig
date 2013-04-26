(*
 *
 * $Log: uutils.sig,v $
 * Revision 1.2  1998/06/03 11:52:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Unification utilities *)
(* Can abstraction functions be shared with type reconstruction ??? *)

signature UUTILS =
sig

  structure Term : TERM

  val is_rigid : Term.term -> bool		   (* term must be ah-normal *)
  val is_flex : Term.term -> bool		   (* term must be ah-normal *)
  val is_defn : Term.term -> Term.term option	   (* term must be ah-normal *)

  (* first arg must be ah-normal *)
  val replace_head : Term.term -> Term.term -> Term.term 

  (* first term must be Uvar *)
  val abst_over_uvar :
         Term.term * string -> Term.term -> Term.varbind * Term.term
  val abst_over_uvar_raise :
         Term.term * string -> Term.term -> Term.varbind * Term.term

  (* first term must be Uvar *)
  val pi_over_uv_raise : Term.term * Term.term -> Term.term
  val abst_over_uv_raise : Term.term * Term.term -> Term.term
  val pi_over_uv : Term.term * Term.term -> Term.term
  val abst_over_uv : Term.term * Term.term -> Term.term
  
  (* both must be list of Uvar's *)
  val init_seg : Term.term list -> Term.term list -> bool

  val dest_pi_error : Term.term -> Term.varbind * Term.term

end  (* signature UUTILS *)
