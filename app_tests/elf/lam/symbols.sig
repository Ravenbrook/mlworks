(*
 *
 * $Log: symbols.sig,v $
 * Revision 1.2  1998/06/03 11:54:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Symbols for printing *)

signature SYMBOLS =
sig

  structure F : FORMATTER

  val lparen : string
  val rparen : string
  val lam_abs : F.format -> F.format list
  val pi_quant : F.format -> F.format list
  
  val langle : string
  val rangle : string

  val underscore : string

  val ldots : string
  val pctpct : string

  val colon : string
  val rightarrow : string
  val leftarrow : string

  val comma : string
  val dot : string
  val equal : string

  val var : string -> string
  val const : string -> string
  val string : string -> string

end  (* signature SYMBOLS *)
