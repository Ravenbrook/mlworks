(*
Result: OK
 
$Log: pat4.sml,v $
Revision 1.2  1993/01/20 12:55:40  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype a = A | B | C

fun f (A, _) = 0
  | f (_, A) = 1
  | f (B, B) = 2
  | f _ = 3
