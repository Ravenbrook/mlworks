(*
Repeated identifiers are not permitted in exception bindings.

Result: FAIL
 
$Log: idtwice1.sml,v $
Revision 1.2  1993/01/19 16:13:02  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

exception E of string and E
