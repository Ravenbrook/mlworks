(* checks that real literals do have an equality attribute in SML'90.

Result: OK

$Log: reals2.sml,v $
Revision 1.1  1996/11/01 11:15:06  andreww
new unit
[Bug #1711]
test


Copyright (C) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);
1.0=1.0;
