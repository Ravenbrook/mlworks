(*
 *
 * $Log: naming.sig,v $
 * Revision 1.2  1998/06/03 12:03:25  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Renaming primitives *)

signature NAMING =
sig

  structure Term : TERM

  val rename_varbind : (string -> bool) -> Term.varbind -> string 
  val new_vname : (string -> bool) -> Term.varbind -> string

  val reset_varnames : unit -> unit
  val store_varnames : unit -> unit
  val restore_varnames : unit -> unit
  val name_var : (string -> bool) -> Term.term -> string
  val name_uvar : (string -> bool) -> Term.term -> string
  val lookup_varname : string -> Term.term option

  val install_names : (Term.term * string option ref) list -> unit
end
