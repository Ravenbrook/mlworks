(* rebinding constructors: tests that sml'96 can indeed rebind constructors
   in function patterns.

Result: OK

* Revision Log: $Log: conrebind3.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:25:32  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
* Copyright (C) 1996 Harlequin Ltd.
*)

datatype fruit = APPLE | BANANA;

fun APPLE x = true
