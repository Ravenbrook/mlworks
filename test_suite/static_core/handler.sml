(*
The type of a handler must match the type of its expression.

Result: FAIL
 
$Log: handler.sml,v $
Revision 1.2  1993/01/20 12:28:28  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


exception E

val x = 1 handle E => true
