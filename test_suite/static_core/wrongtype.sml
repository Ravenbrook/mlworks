(*
Type clash.

Result: FAIL
 
$Log: wrongtype.sml,v $
Revision 1.2  1993/01/20 13:11:20  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun f x = x + 1

val y = f true
