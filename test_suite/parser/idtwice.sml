(*
Repeated identifiers are not permitted in value bindings.

Result: FAIL
 
$Log: idtwice.sml,v $
Revision 1.2  1993/01/19 16:10:58  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val x = 1 and y = 2 and z = 3 and y = 4
