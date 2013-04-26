(* constructor rebinding: tests that constructors are still allowed as
   arguments

Result: OK

* Revision Log: $Log: conrebind1.sml,v $
* Revision Log: Revision 1.1  1997/01/06 11:25:12  andreww
* Revision Log: new unit
* Revision Log: [Bug #1578]
* Revision Log: tests and answers
* Revision Log:
* -------------
*
* Copyright (C) 1996 Harlequin Ltd.
*)




fun not true = false
  | not false = true
