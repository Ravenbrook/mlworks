(* rebinding constructors: tests that sml'90 cannot rebind constructors
   in function patterns.

Result: FAIL

* Revision Log: $Log: conrebind4.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:25:43  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
* Copyright (C) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

datatype fruit = APPLE | BANANA;

fun APPLE x = true
