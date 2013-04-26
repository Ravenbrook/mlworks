(*
Overloaded operators can't be resolved in SML'90.

Result: FAIL
 
$Log: overloaded5.sml,v $
Revision 1.1  1996/09/23 14:19:10  andreww
new unit
test files to show that overloaded identifiers don't have defaults
in SML'90 mode.


Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun f x y = x + y
