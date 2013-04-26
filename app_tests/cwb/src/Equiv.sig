(*
 *
 * $Log: Equiv.sig,v $
 * Revision 1.2  1998/06/02 15:21:32  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Equiv.sig,v 1.2 1998/06/02 15:21:32 jont Exp $";
(*********************************** Equiv ***********************************)
(*                                                                           *)
(* This contains some operations on polymorphic graphs. The graphs are       *)
(* exactly as in "PolyGraph", and the info field is not used (much). The     *)
(* following functions are provided:                                         *)
(*                                                                           *)
(* equiv: Takes two graphs and returns "true" if there exists a bisimulation *)
(*    containing the initial states.                                         *)
(* min: Takes a graph and returns a "minimal" graph, i.e. a bisimilar graph  *)
(*    where all bisimilar states are collapsed to single states. The result  *)
(*     is not necessarily minimal w.r.t. transitions, but tau loops are out. *)
(* bisim: Takes a graph and returns the largest bisimulation on it.          *)
(*                                                                           *)
(* For the three last functions above, an additional parameter of type       *)
(* 'a*'a -> bool is required (where 'a is the type of the info field)        *)
(* This function will be used to determine whether two states can be         *)
(* admitted in the same block in a bisimulation.      Joachim Parrow June-88 *)
(*                                                                           *)
(*****************************************************************************)

signature EQUIV =
sig
   structure PG : POLYGRAPH

   val equiv : ('_a * '_a -> bool)
               -> ('_a PG.state ref * '_a PG.state ref list) *
                  ('_a PG.state ref * '_a PG.state ref list) -> bool

   val bisim : ('_a * '_a -> bool)
               -> '_a PG.state ref * '_a PG.state ref list
               -> '_a PG.state ref list ref list

   val min   : ('_a * '_a  -> bool)
               -> '_a PG.state ref * '_a PG.state ref list
               -> '_a PG.state ref * '_a PG.state ref list
end

