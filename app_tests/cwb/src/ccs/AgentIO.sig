(*
 *
 * $Log: AgentIO.sig,v $
 * Revision 1.2  1998/06/02 15:39:39  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: AgentIO.sig,v 1.2 1998/06/02 15:39:39 jont Exp $";
(********************************** AgentIO **********************************)
(*                                                                           *)
(*  Input and Output of agents                                               *)
(*                                                                           *)
(*****************************************************************************)

signature AGENTIO =
sig
   structure Ag : AGENT

   exception Parse of string

   val mkagent : string -> Ag.agent
   val mkstr   : Ag.agent -> string
   val mkstr2  : Ag.agent -> string	(* Meije format *)

end

