(*

Result: OK

$Log: local_datatypes11.sml,v $
Revision 1.1  1996/10/04 18:37:31  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)


datatype t = b;

val x = let datatype c = a of t in b end;




