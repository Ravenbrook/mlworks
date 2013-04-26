(*
 *
 * $Log: Constant.sig,v $
 * Revision 1.2  1998/06/11 13:15:35  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature CONSTANT =
sig

  type constant

  val mkstr : constant -> string

  val eq: constant -> constant -> bool
  val init: constant
  val next: constant -> constant

end
