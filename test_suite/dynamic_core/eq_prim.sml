(*

Result: OK
 
$Log: eq_prim.sml,v $
Revision 1.1  1995/08/23 11:05:37  jont
new unit


Copyright (c) 1995 Harlequin Ltd.
*)

datatype char = CH of string;
val x = CH"AB";
val y = CH"AB";
val z = x=y;
fun foo (x, y) = x = y;
val a = foo(x, y);
