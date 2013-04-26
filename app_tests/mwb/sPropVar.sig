(*
 *
 * $Log: sPropVar.sig,v $
 * Revision 1.2  1998/06/11 13:04:29  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature SPROPVAR =
sig

  structure A: SAGENT

  type propvar

  val eq: propvar -> propvar -> bool
  val mk_propvar: string -> propvar
  val mkstr : propvar -> string
(*   val next: propvar list -> propvar *)

end
