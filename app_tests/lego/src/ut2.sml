(*
 *
 * $Log: ut2.sml,v $
 * Revision 1.2  1998/08/05 17:26:35  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils";

fun fold x y z = foldr (fn a => fn b  => x (a,b)) z y;
fun revfold x y z = foldl (fn a => fn b  => x (b,a)) z y;
