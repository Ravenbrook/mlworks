(*
 *
 * $Log: location.sml,v $
 * Revision 1.2  1998/06/03 11:48:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature LOCATION =
sig
  val lam_home : string
end

functor Location (structure Sys : SYS) : LOCATION =
struct
  val lam_home = Sys.cwd () ^ "/"
end
