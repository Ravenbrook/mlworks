(*
 *
 * $Log: solver_stats.sig,v $
 * Revision 1.2  1998/06/03 12:23:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

signature SOLVER_STATS =
sig
  val skipped_by_indexing : int ref
  val attempted_resolutions : int ref
  val successful_resolutions : int ref
  val dynamic_skipped_by_indexing : int ref
  val dynamic_attempted_resolutions : int ref
  val dynamic_successful_resolutions : int ref
  val assumption_count : int ref
end  (* signature SOLVER_STATS *)

