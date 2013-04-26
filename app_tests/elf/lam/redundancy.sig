(*
 *
 * $Log: redundancy.sig,v $
 * Revision 1.2  1998/06/03 12:10:51  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Redundancy analysis of arguments *)

signature REDUNDANCY =
sig

  structure Term : TERM

  (* term should be Pi x1:A1 ... Pi xn:An. C *)
  (* second arg shows how many are implicit *)
  (* result are three lists *)
  (* indicating for each xi if it is inherited or synthesized, resp'ly *)
  (* and those arguments which are implicit and *)
  (* neither synthesized nor inherited *)
  val analyze : Term.term -> Term.term
                   -> (bool list * bool list) * string list

end  (* signature REDUNDANCY *)
