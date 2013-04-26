(*
 *
 * $Log: print_norm.fun,v $
 * Revision 1.2  1998/06/03 12:13:42  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Printing with respect to a signature. *)
(* Synthesized arguments will be ellided. *)

functor PrintNorm (structure Term : TERM
		   structure PrintTerm : PRINT_TERM
		      sharing PrintTerm.Term = Term
		   structure Reduce : REDUCE
		      sharing Reduce.Term = Term) : PRINT_TERM =
struct

structure Term = Term
structure F = PrintTerm.F
structure S = PrintTerm.S

local open Term
in

  val printDepth = PrintTerm.printDepth
  val printLength = PrintTerm.printLength

  val makeformat_term = PrintTerm.makeformat_term o Reduce.beta_norm
  val makeformat_const = PrintTerm.makeformat_const

end  (* local ... *)
end  (* functor PrintNorm *)
