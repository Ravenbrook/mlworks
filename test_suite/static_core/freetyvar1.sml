(*
Imperative type variables may not be free at top level.

Result: FAIL
 
$Log: freetyvar1.sml,v $
Revision 1.2  1993/01/20 11:52:06  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val x = let fun f x = !(ref x) in f end
