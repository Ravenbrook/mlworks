(*
Result: OK
 
$Log: nospace.sml,v $
Revision 1.3  1995/07/18 16:47:50  jont
Fix after introducing hex integers invalidated test

Revision 1.2  1993/01/20  14:41:57  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype dt = y30;
fun f a b = a;
f 0y30;
