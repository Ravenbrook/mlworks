(*
Explicit type variable must be generalised at their scoping declarations.

Result: FAIL
 
$Log: tyvarscope2.sml,v $
Revision 1.2  1993/01/20 12:12:26  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val f = (fn x => let val g : 'a = x in g g end) 5
