(*  tests that reals cannot be pattern matched against in SML 96.

Result: FAIL

$Log: reals1.sml,v $
Revision 1.1  1996/11/01 11:12:49  andreww
new unit
[Bug #1711]
test


Copyright (c) 1996 Harlequin Ltd.
*)

fun f 1.0 = true | f _ = false;
