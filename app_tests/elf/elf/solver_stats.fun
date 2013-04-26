(*
 *
 * $Log: solver_stats.fun,v $
 * Revision 1.2  1998/06/03 12:24:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

functor SolverStats () : SOLVER_STATS =
struct
  val skipped_by_indexing = ref 0
  val attempted_resolutions = ref 0
  val successful_resolutions = ref 0
  val dynamic_skipped_by_indexing = ref 0
  val dynamic_attempted_resolutions = ref 0
  val dynamic_successful_resolutions = ref 0
  val assumption_count = ref 0
end
