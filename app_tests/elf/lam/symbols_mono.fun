(*
 *
 * $Log: symbols_mono.fun,v $
 * Revision 1.2  1998/06/03 12:07:55  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Symbols for Ascii printing *)

functor Symbols_Mono (structure F : FORMATTER) : SYMBOLS =
struct

  structure F = F

  val lparen = "("
  val rparen = ")"
  fun lam_abs (xofA) = [F.String("["), xofA, F.String("]")]
  fun pi_quant (xofA) = [F.String("{"), xofA, F.String("}")]

  val langle = "<"
  val rangle = ">"

  val underscore = "_"

  val ldots = "..."
  val pctpct = "%%"

  val colon = ":"
  val rightarrow = "->"
  val leftarrow = "<-"

  val comma = ","
  val dot = "."
  val equal = "="

  fun var (x) = x
  fun const (c) = c
  fun string (s) = s

end  (* functor Symbols_Mono *)
