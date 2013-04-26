(*
 *
 * $Log: skeleton.sig,v $
 * Revision 1.2  1998/06/03 11:56:03  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1992 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* The type of skeletons to eliminate occurs-check from unification *)

signature SKELETON =
sig

  structure Term : TERM

  datatype skeleton
    = Rigid of Term.term * skeleton list  (* rigid compound term *)
    | FirstVarOcc                     (* first occurrence of a variable *)
    | Other                           (* all other terms: no information *)

  val debone : Term.term -> skeleton

end  (* signature SKELETON *)
