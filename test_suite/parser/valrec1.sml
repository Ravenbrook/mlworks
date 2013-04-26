(*
_ is permitted as lhs of a val rec.

Result: OK

$Log: valrec1.sml,v $
Revision 1.2  1993/01/19 16:30:45  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val rec _ = fn x => x;

