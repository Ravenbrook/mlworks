(*
 *
 * $Log: NameSubstitution.sig,v $
 * Revision 1.2  1998/06/11 13:17:46  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature NAMESUBSTITUTION =
sig

   structure N: NAME

   structure B: TEST

   type name_subst

   exception bound_name_expected of N.name * N.name
   exception unbound_name_expected of N.name
   exception cannot_happen

   val eq: name_subst -> name_subst -> bool
   val mkstr : name_subst -> string
   val domain: name_subst -> N.name list
   val init: name_subst
   val is_eq: N.name -> N.name -> name_subst -> bool
   val is_neq: N.name -> N.name -> name_subst -> bool
   val restrict: name_subst -> N.name list -> name_subst
   val add_distinct: N.name -> name_subst -> name_subst
   val add_new: N.name -> name_subst -> name_subst list
   val partition: (N.name list) -> name_subst -> name_subst list
   val unpack: name_subst -> (N.name list) list
   val pack: (N.name list) list -> name_subst
   val entails: name_subst -> B.test -> bool
   val private: N.name -> name_subst -> name_subst

end
