(*
 *
 * $Log: DefList.sml,v $
 * Revision 1.2  1998/06/11 13:31:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor DefList(structure Formula: FORMULA): DEF_LIST =
struct

  structure F = Formula

  type def_list = (F.CST.constant * F.fixed_point_formula) list

  exception not_in_domain of F.CST.constant
  exception constant_outside_domain
  exception constant_not_redefinable of F.CST.constant

  val init = nil

  fun new nil = F.CST.init |
      new ((U,F)::dl) = F.CST.next U

  fun domain nil = nil |
      domain ((U,F)::dl) = U :: (domain dl)

  fun assign dl U F =
        if not(McList.member F.CST.eq U (domain dl))
        then if McList.subset (F.CST.eq) (F.constants F) (domain dl)
             then (U,F)::dl
             else raise constant_outside_domain
        else raise constant_not_redefinable(U)

  fun entry nil U = raise not_in_domain(U) |
      entry ((V,F)::dl) U = if F.CST.eq U V then F else entry dl U

end
