(*
Type clash.

Result: FAIL
 
$Log: pat3.sml,v $
Revision 1.2  1993/01/20 12:55:13  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype t = T | TT of int
 
fun f (T:int) = 1
