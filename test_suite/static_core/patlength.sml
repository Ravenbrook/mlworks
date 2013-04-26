(*
Type clash.

Result: FAIL
 
$Log: patlength.sml,v $
Revision 1.2  1993/01/20 12:56:53  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype t = A | B 

fun f (A,A) = 2
  | f (B,B,B) = 3
