(*
Check compilation of overloaded operators which are rebound
Result: OK
 
$Log: overload.sml,v $
Revision 1.1  1995/04/07 13:02:50  jont
new unit
No reason given


Copyright (c) 1995 Harlequin Ltd.
*)

val op < = op < : int * int -> bool
fun min(a, b) = if a < b then a else b
