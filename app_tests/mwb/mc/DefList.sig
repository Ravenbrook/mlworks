(*
 *
 * $Log: DefList.sig,v $
 * Revision 1.2  1998/06/11 13:16:54  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature DEF_LIST =
sig

    structure F : FORMULA

    type def_list

    exception not_in_domain of F.CST.constant
    exception constant_outside_domain
    exception constant_not_redefinable of F.CST.constant

    val init: def_list
    val new: def_list -> F.CST.constant
    val domain: def_list -> F.CST.constant list
    val assign: def_list -> F.CST.constant -> F.fixed_point_formula -> def_list
    val entry: def_list -> F.CST.constant -> F.fixed_point_formula

end
