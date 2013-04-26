(*
Arity error.

Result: FAIL
 
$Log: pat.sml,v $
Revision 1.2  1993/01/20 12:52:34  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype t = T | TT of int

fun f TT = 1
