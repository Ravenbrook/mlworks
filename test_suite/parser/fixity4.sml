(*

Result: FAIL
 
$Log: fixity4.sml,v $
Revision 1.2  1993/01/19 16:08:30  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun f (x,y) = x orelse y

val a = true f false
