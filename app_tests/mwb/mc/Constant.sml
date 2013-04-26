(*
 *
 * $Log: Constant.sml,v $
 * Revision 1.2  1998/06/11 13:32:21  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
structure Constant:CONSTANT =
struct
  type constant = int

  fun mkstr (n:constant) = "C"^(makestring n)

  fun eq n m = n=m

  val init = 0

  fun next n = n+1

end;
