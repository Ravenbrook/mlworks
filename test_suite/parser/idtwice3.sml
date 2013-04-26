(*
Repeated identifiers are not allowed in constructor bindings.

Result: FAIL
 
$Log: idtwice3.sml,v $
Revision 1.2  1993/01/19 16:14:29  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype t = T | T of t
