(* constructor rebinding. tests that constructors may not be rebound
   (in sml'96) in an ordinary VAL dec.

Result: FAIL

* Revision Log: $Log: conrebind7.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:26:11  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
*
* Copyright (C) 1997 Harlequin Ltd.
*)

datatype fruit = APPLE | BANANA;

val APPLE = 6
