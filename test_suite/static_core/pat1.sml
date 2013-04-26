(*
Type clash.

Result: FAIL
 
$Log: pat1.sml,v $
Revision 1.2  1993/01/20 12:54:36  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype t = T | TT of int
 
fun f (TT true) = 1
