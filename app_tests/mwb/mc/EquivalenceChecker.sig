(*
 *
 * $Log: EquivalenceChecker.sig,v $
 * Revision 1.2  1998/06/11 13:28:26  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature EQUIVALENCECHECKER =
sig

  structure MC : MODELCHECKER

  val characteristic_formula:
        MC.S.C.cond -> MC.S.A.agent -> MC.S.A.env -> MC.S.F.formula

  val equivalence_checker:
        MC.S.C.cond -> MC.S.A.agent -> MC.S.A.agent -> MC.S.A.env -> bool

end
