(*
 *
 * $Log: TGraph.sig,v $
 * Revision 1.2  1998/06/02 15:33:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: TGraph.sig,v 1.2 1998/06/02 15:33:33 jont Exp $";
(********************************** TGraph ***********************************)
(*                                                                           *)
(* This file contains a signature for building Dgraphs Tgraphs and STgraphs, *)
(* which are deterministic transition systems.  They are constructed on the  *)
(* basis of *polygraphs*, which are polymorphic graphs that correspond to    *)
(* transition systems.  The definitions of Dgraphs Tgraphs and STgraphs      *)
(* associated with an agent are the following.                               *)
(* Dgraph - a deterministic graph (i.e. no tau-moves, and only one state     *)
(*     transition per action from a given state) that is observable trace    *)
(*     equivalent (i.e. same tau-free traces) to the polygraph of the agent  *)
(* Tgraph - a deterministic graph (in the same sense that a Dgraph is        *)
(*     deterministic, satisfying the following constraints:                  *)
(*     1. Each state in the Tgraph is labeled with (a minimal representation *)
(*        of) the acceptance set associated with the trace (between the root *)
(*        and the state in the Tgraph) in the original polygraph.            *)
(*     2. Each state in the Tgraph is either *open* or *closed*.  A state is *)
(*       *open* if at least one polygraph state in the set of polygraph      *)
(*       states corresponding to the Tgraph is divergent or if some ancestor *)
(*       state in the Tgraph is open; otherwise, the Tgraph state is closed. *)
(* STgraph - an STgraph is a "strong" Tgraph, meaning that open states have  *)
(*      no successors built for them.  These are used for testing the "must" *)
(*      equivalence and preorder.                    Rance Cleaveland Aug-88 *)
(*                                                                           *)
(* P        - the structure of polymorphic graph operations (from Joachim).  *)
(* AS       - the structure for acceptance sets.                             *)
(* mkDgraph - given a polygraph and an initilization function, builds the    *)
(*            (polymorphic) Dgraph associated with the polygraph.            *)
(* mkTgraph - given a polygraph and an initialization function (that, note,  *)
(*            takes a list of state *and* an acceptance set as an argument), *)
(*            build the appropriate Tgraph.                                  *)
(* mkSTgraph- builds the appropriate STgraph, given the same arguments as    *)
(*            "mkTgraph".                                                    *)
(*****************************************************************************)

signature TGRAPH =
sig
   structure PG   : POLYGRAPH
   structure AS   : ACCSET
     sharing type PG.act = AS.act

   val mkDgraph  : '_a PG.state ref * '_a PG.state ref list
                    -> ('_a PG.state ref list -> '_b)
                    -> '_b PG.state ref * '_b PG.state ref list

   val mkTgraph  : '_a PG.state ref * '_a PG.state ref list
                    -> ('_a PG.state ref list -> AS.accset -> '_b)
                    -> '_b PG.state ref * '_b PG.state ref list

   val mkSTgraph : '_a PG.state ref * '_a PG.state ref list
                    -> ('_a PG.state ref list -> AS.accset -> '_b)
                    -> '_b PG.state ref * '_b PG.state ref list
end

