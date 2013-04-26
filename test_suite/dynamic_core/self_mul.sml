(*

Result: OK
 
$Log: self_mul.sml,v $
Revision 1.1  1996/08/27 12:00:04  jont
new unit
Test multiplication by self (relevant to i386 to test a cg bug fix)


Copyright (c) 1996 Harlequin Ltd.
*)

fun sqr(x:int) = x*x;

val x = sqr 1
and y = sqr 4
