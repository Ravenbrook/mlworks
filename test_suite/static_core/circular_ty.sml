(*
ML only allows multiple instatiations of a polymorphic type using let.

Result: FAIL
 
$Log: circular_ty.sml,v $
Revision 1.2  1993/01/20 11:36:03  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun f x = f f
