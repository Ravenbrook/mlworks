(*
 *
 * $Log: ModelChecker.sig,v $
 * Revision 1.2  1998/06/11 13:26:01  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature MODELCHECKER =
sig

  structure S : SEQUENT

  structure V : VISITEDTABLE

  structure AS : AGENTSUBSEM

  exception cannot_happen
  exception not_closed_formula

  val mc2 : V.visited_table -> S.C.NS.name_subst -> S.D.def_list -> S.A.agent -> S.F.formula -> S.A.env -> bool
  val model_checker: V.visited_table -> S.sequent -> AS.A.env -> bool
  val naked_model_checker : S.A.agent -> S.F.formula -> AS.A.env -> bool

end
