(* constructor rebinding.  Tests that constructors that occur as arguments
   can appear more than once.

Result: OK

* Revision Log: $Log: conrebind11.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:26:47  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
* 
* Copyright (C) 1997 Harlequin Ltd.
*)


datatype x = N;
fun f (N,N) = 2;
