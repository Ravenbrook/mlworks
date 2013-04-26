(*  tests that reals can be pattern matched against in SML 90.

Result: OK

$Log: reals2.sml,v $
Revision 1.1  1996/11/01 11:12:56  andreww
new unit
[Bug #1711]
test


Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun f 1.0 = true | f _ = false;
