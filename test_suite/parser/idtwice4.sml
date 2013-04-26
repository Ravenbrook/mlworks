(*
Repeated identifiers are not permitted in datatype bindings.

Result: FAIL
 
$Log: idtwice4.sml,v $
Revision 1.2  1993/01/19 16:14:55  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype t = T and r = R and t = S and s = S
