(* checks that real vars do not have an equality attribute in SML'96.

Result: FAIL

$Log: reals3.sml,v $
Revision 1.1  1996/11/01 11:15:57  andreww
new unit
[Bug #1711]
test


Copyright (C) 1996 Harlequin Ltd.
*)

val x = 1.0;
x=x;

