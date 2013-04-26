(* checks that real vars do have an equality attribute in SML'90.

Result: OK

$Log: reals4.sml,v $
Revision 1.1  1996/11/01 11:16:28  andreww
new unit
[Bug #1711]
test


Copyright (C) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);
val x = 1.0;
x=x;

