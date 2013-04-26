(*
Type variables may not be repeated in type declarations.

Result: FAIL

$Log: tyvarrepeat.sml,v $
Revision 1.2  1993/01/19 16:29:28  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)
type ('a,'b,'a) t = ('a * 'b * 'c)
