(*
Imperative type variables may not be closed over if the expression
is non-expansive.

Result: FAIL
 
$Log: imptyvar2.sml,v $
Revision 1.1  1993/01/20 16:19:29  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

val x = ref []: '_a list ref
