(*
 *
 * $Log: Agent.sig,v $
 * Revision 1.2  1998/06/02 15:45:46  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Agent.sig,v 1.2 1998/06/02 15:45:46 jont Exp $";
(*********************************** Agent ***********************************)
(*                                                                           *)
(*  This is the definitions of "Agents".                                     *)
(*                                                                           *)
(*****************************************************************************)

signature AGENT =
sig
   structure A  : ACT
   structure V  : VAR

   datatype relabelling = Relabellist of (A.act * A.P.part) list
                        | Relabelvar  of V.var

   datatype permission = Permlist of A.P.part list
                       | Actlistvar of V.var

   datatype param = Actparam   of A.act
   | Actlistparam of permission		(* experimental *)
   | Timeparam  of int
   | Agentparam of agent

        and agent = Nil
                  | Bottom
                  | Var      of V.var * param list
                  | Prefix   of A.act * agent
                  | Delta    of agent
                  | Time     of int * agent
                  | Sum      of agent list
                  | Parallel of agent list
                  | Permit   of agent * permission
                  | Relabel  of agent * relabelling

   val hashval  : agent -> int
     
   val parameq : param * param -> bool
   val paramle : param * param -> bool

   val eq : agent * agent -> bool
   val le : agent * agent -> bool

   val permlisteq : permission * permission -> bool
   val permlistle : permission * permission -> bool


end

