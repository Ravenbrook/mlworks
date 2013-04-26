(*
Result: OK

$Log: local_datatypes7.sml,v $
Revision 1.1  1996/10/04 18:36:46  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

datatype e = x;

datatype t = b of e;

fun f var = b var;
