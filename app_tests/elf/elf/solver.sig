(*
 *
 * $Log: solver.sig,v $
 * Revision 1.2  1998/06/03 12:21:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)
(* Modified: Spiro Michaylov <spiro@cs.cmu.edu>     *)

(* The solver for Elf *)

signature SOLVER =
sig
  structure Term : TERM
  structure Constraints : CONSTRAINTS  sharing Constraints.Term = Term

  val solve : Term.term
                 -> bool
	         -> Constraints.constraint
		 -> (Constraints.constraint -> unit)
		 -> unit

  structure Switch : SWITCH

  val trace : int -> unit
  val untrace : unit -> unit

end  (* signature SOLVER *)
