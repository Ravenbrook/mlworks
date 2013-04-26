(* constructor rebinding: tests that infix constructors can be rebound
   in val rec decs.

Result: OK

* Revision Log: $Log: conrebind9.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:26:31  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
*
* Copyright (C) 1997 Harlequin Ltd.
*)


datatype t = T of int * int;
infix T;
val rec op T = fn (x,y) => 3;
