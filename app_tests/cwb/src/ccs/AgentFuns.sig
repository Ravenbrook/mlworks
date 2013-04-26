(*
 *
 * $Log: AgentFuns.sig,v $
 * Revision 1.2  1998/06/02 15:38:52  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: AgentFuns.sig,v 1.2 1998/06/02 15:38:52 jont Exp $";
(* Caution, many v7 changes, giving horrendous function types!  Most	  *)
(* functions take 3 environments, viz the parameterised agent env, the	  *)
(* action list env and the relabellings (pair of actions) env (?!)  *)
signature AGENTFUNS =
  sig
    structure Ag : AGENT
    structure E : ENV
    sharing E.V = Ag.V 

    exception Unguarded of E.V.var
    exception Unguarded_rec of E.V.var
    exception Mismatch of Ag.agent

    val forgetall : unit -> unit	(* discard saved info about    *)
(* successors of agents, typically because it may have been	       *)
(* invalidated  by the rebinding of some identifier. *)

    val lookupapply : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> (Ag.V.var * Ag.param list) -> Ag.agent

    val subenv : 
        (Ag.param list * Ag.agent) E.env -> Ag.agent 
        -> Ag.agent * (Ag.param list * Ag.agent) E.env

    val diverges : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> bool

    val sort : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.A.act list

    val transitions : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> (Ag.A.act * Ag.agent) list

(* taking relevant environments, allow agent to be put into prefix	  *)
(* form, i.e. like a.A + ... + z.Z 					  *)
    val prefixform : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.agent

    val initial : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.A.act list

    val actders : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.A.act -> Ag.agent -> Ag.agent list

    val tauders : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.agent list

    val stable : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> bool

    val tauclosure : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.agent list

    val actclosure : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.A.act -> Ag.agent -> Ag.agent list

    val stepclosure : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.agent list

    val initobs : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.A.act list

    val statespace : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> Ag.agent list

    val statespaceexp :
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> (Ag.A.act list * Ag.agent) list

    val statespaceobs : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.agent -> (Ag.A.act list * Ag.agent) list

    val findinit : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.A.act list -> Ag.agent -> (Ag.A.act list * Ag.agent) list

    val findinitobs : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.A.act list -> Ag.agent -> (Ag.A.act list * Ag.agent) list

    val observations : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> int -> Ag.agent -> (Ag.A.act list * Ag.agent) list

    val visibleseq : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> int -> Ag.agent -> Ag.A.act list list

    val obsderivatives : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> Ag.A.act list -> Ag.agent -> Ag.agent list

    val randseq : 
        (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
         * (Ag.A.act * Ag.A.act) list E.env
        -> int -> Ag.agent -> Ag.A.act list

    val freevars : 
        (Ag.param list * Ag.agent) E.env -> Ag.agent -> E.V.var list

(*
    val subst : ??

    val normform : (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
                   * (Ag.A.act * Ag.A.act) list E.env
                   -> Ag.agent -> Ag.agent
    val statespace2 : (Ag.param list * Ag.agent) E.env * Ag.A.act list E.env
                      * (Ag.A.act * Ag.A.act) list E.env
                      -> Ag.agent -> Ag.agent list list
*)
    val efficiencyInfo: unit -> string
  end
