(*
 *
 * $Log: AgentTable.sml,v $
 * Revision 1.2  1998/06/11 13:30:14  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor AgentTable(structure Agent: McAGENT
                   structure PropVar: PROPVAR): AGENTTABLE =
struct

  structure A = Agent

  structure P = PropVar

  type agent_table = (A.agent * P.propvar) list

  exception not_in_table

  exception already_in_table

  val init = nil

  fun next_var at = P.next (map (fn (x,y) => y) at)
   
  fun is_visited at A =
        McList.member A.eq A (map (fn (x,y) => x) at)

  fun lookup nil A = raise not_in_table |
      lookup ((A1,pv)::at) A = if A.eq A A1 then pv else lookup at A

  fun associate at A pv =
        if is_visited at A
        then raise already_in_table
        else (A,pv)::at

end
