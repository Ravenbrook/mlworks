(*
Checks that local datatypes haven't screwed up workings of
normal datatype.

Result: OK

$Log: local_datatypes6.sml,v $
Revision 1.1  1996/10/04 18:36:32  andreww
new unit
new test


Copyright (c) 1996 Harlequin Ltd.
*)


datatype t = a | b;

fun x var = a;
