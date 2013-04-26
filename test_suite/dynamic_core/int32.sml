(*

Result: OK
 
$Log: int32.sml,v $
Revision 1.1  1996/01/31 13:39:04  jont
new unit


Copyright (c) 1996 Harlequin Ltd.
*)

val a : MLWorks.Internal.Types.int32 = 12
val b = a mod 5
val c = a div 5
val d = a mod ~5
val e = a div ~5
val f = 0 - a
val g = f mod 5
val h = f div 5
val i = f mod ~5
val j = f div ~5
