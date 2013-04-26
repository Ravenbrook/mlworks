(*
Type variables may not be repeated in datatype declarations.

Result: FAIL

$Log: tyvarrepeat1.sml,v $
Revision 1.2  1993/01/19 16:29:59  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype ('a,'a, 'b) t = T of 'a -> 'a
