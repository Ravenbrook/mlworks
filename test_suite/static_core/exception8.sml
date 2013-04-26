(*
What looks like an exception is actually a variable.
This is semantically correct, but I believe that a
decent compiler should generate a warning.

Result: OK, WARNING, INTERPRETATION
 
$Log: exception8.sml,v $
Revision 1.3  1993/01/22 15:44:13  daveb
Added OK result.

Revision 1.2  1993/01/20  11:50:13  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val x = 3 handle E => 5;
