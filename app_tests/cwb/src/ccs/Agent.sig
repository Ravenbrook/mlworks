(*
 *
 * $Log: Agent.sig,v $
 * Revision 1.2  1998/06/02 15:37:56  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Agent.sig,v 1.2 1998/06/02 15:37:56 jont Exp $";
(*********************************** Agent ***********************************)
(*                                                                           *)
(*  This is the definitions of "Agents".                                     *)
(*                                                                           *)
(*****************************************************************************)

signature AGENT =
sig
   structure A  : ACT
   structure V  : VAR

   datatype actlist = Actlist    of A.act list
                    | Actlistvar of V.var

   datatype relabelling = Relabellist of (A.act * A.act) list
                        | Relabelvar  of V.var

   datatype param = Actparam   of A.act
   | Actlistparam of actlist		(* experimental *)
   | Timeparam  of int
   | Agentparam of agent

        and agent = Nil
                  | DNil
                  | Bottom
                  | Var      of V.var * param list
                  | Prefix   of A.act list * agent
                  | Delta    of A.act * agent
                  | Time     of int * agent
                  | WSum     of agent list
                  | SSum     of agent list
                  | Parallel of agent list
                  | SMerge   of (agent * actlist) list
                  | Restrict of agent * actlist
                  | Relabel  of agent * relabelling

   val hashval  : agent -> int
     
   val parameq : param * param -> bool
   val paramle : param * param -> bool

   val actlisteq : actlist * actlist -> bool
   val actlistle : actlist * actlist -> bool

   val relabeleq : relabelling * relabelling -> bool
   val relabelle : relabelling * relabelling -> bool

   val eq : agent * agent -> bool
   val le : agent * agent -> bool
end

