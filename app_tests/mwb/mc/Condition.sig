(*
 *
 * $Log: Condition.sig,v $
 * Revision 1.2  1998/06/11 13:18:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature CONDITION =
sig

  structure NS : NAMESUBSTITUTION

  structure F : FORMULA

  type general_cond

  (* Name substitutions special case of name conditions *)
  datatype cond = NameSubst of NS.name_subst |
                  GeneralCond of general_cond

  (* Constructors *)

  val mk_cond: NS.name_subst -> cond

  (* testers *)

  val eq: cond -> cond -> bool

  val entails: cond -> cond -> bool

  (* selectors *)

  val mk_form: cond -> F.formula

  val domain: cond -> NS.N.name list

  (* Given a domain nl and a name condition c, partition nl c builds     *)
  (* a maximal list of name substitutions with domain nl union domain c  *)
  (* such that each name substitution in the list is a distinct model    *)
  (* of c                                                                *)
  val partition: NS.N.name list -> cond -> NS.name_subst list

  (* Special functions *)

  (* diff: For now only applicable to name substitutions. Given a name x *)
  (* in domain(c), diff x c computes a formula f such that if            *)
  (* NS.eq ns1 (NS.restrict ns2 [x]) and x is in the domain of ns2       *)
  (* then mk_form(NameSubst ns2) and mk_and(mk_form(NameSubst ns1),      *)
  (* diff x (NameSubst ns2)) are equivalent.                             *) 
  val diff: NS.N.name -> cond -> F.formula

end
