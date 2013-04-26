(*
Repeated identifiers are not permitted in type bindings.

Result: FAIL
 
$Log: idtwice2.sml,v $
Revision 1.2  1993/01/19 16:13:58  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

type t = int and r = real and r = string
