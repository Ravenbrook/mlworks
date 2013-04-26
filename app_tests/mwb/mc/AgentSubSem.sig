(*
 *
 * $Log: AgentSubSem.sig,v $
 * Revision 1.2  1998/06/11 13:25:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature AGENTSUBSEM =
sig

  structure A : McAGENT

  structure NS : NAMESUBSTITUTION

  exception name_substitution_too_small

  exception open_agent_encountered

  val normal_form: A.agent -> NS.name_subst -> A.env -> A.agent

  val commitments: NS.name_subst -> A.agent -> A.env -> (A.ACT.action * A.agent) list

end
