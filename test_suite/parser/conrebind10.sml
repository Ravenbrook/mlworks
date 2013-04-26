(* constructor rebinding: checks that a rebound constructor has lost
   constructor status.

Result: FAIL

* Revision Log: $Log: conrebind10.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:26:39  andreww
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
fun (m T n) = 5;
fun x (m T n) = 4;
