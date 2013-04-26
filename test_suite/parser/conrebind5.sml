(* constructor rebinding: tests that in sml'96 mode that constructors
   may be rebound as patterns in val rec decs.

Result: OK

* Revision Log: $Log: conrebind5.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:25:52  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
* Copyright (C) 1996 Harlequin Ltd.
*)

datatype fruit = APPLE | BANANA;

val rec APPLE = fn x => x;
