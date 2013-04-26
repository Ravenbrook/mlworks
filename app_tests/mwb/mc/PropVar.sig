(*
 *
 * $Log: PropVar.sig,v $
 * Revision 1.2  1998/06/11 13:14:52  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature PROPVAR =
sig

  structure A: McAGENT

  type propvar

  val mkstr : propvar -> string

  val eq: propvar -> propvar -> bool
  val mk_propvar: int -> propvar
  val next: propvar list -> propvar

end
