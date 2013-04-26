(*

All clauses in a funbind must have the same name.

Result: FAIL
 
$Log: funname.sml,v $
Revision 1.2  1993/01/28 10:24:55  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.

*)

fun f 0 = 0 
  | g x = x - 1
