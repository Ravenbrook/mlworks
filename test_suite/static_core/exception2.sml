(*
Result: OK
 
$Log: exception2.sml,v $
Revision 1.3  1993/07/12 15:16:13  daveb
Added handler at top level.

Revision 1.2  1993/01/20  11:42:50  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

exception E of string

val x = (raise E "mmm")
	handle E s => s
