(*
Arity error.

Result: FAIL
 
$Log: handler2.sml,v $
Revision 1.2  1993/01/20 12:29:18  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


exception E

val y = 1 handle E 1 => 1
