(*
 *
 * $Log: AgentTable.sig,v $
 * Revision 1.2  1998/06/11 13:29:13  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature AGENTTABLE =
sig

  structure A: McAGENT

  structure P: PROPVAR

  type agent_table

  exception not_in_table

  exception already_in_table

  val init: agent_table

  val next_var: agent_table -> P.propvar

  val is_visited: agent_table -> A.agent -> bool

  val lookup: agent_table -> A.agent -> P.propvar

  val associate: agent_table -> A.agent -> P.propvar -> agent_table

end
