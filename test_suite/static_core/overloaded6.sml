(*
Overloaded operators are resolved when decs become strdecs.

Result: FAIL INTERPRETATION
 
$Log: overloaded6.sml,v $
Revision 1.1  1996/09/23 14:18:32  andreww
new unit
test files to show that overloaded identifiers don't have defaults
in SML'90 mode.


Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition, true);

structure S = struct fun foo x y = x + y fun bar x y = foo x y = 3 end;
