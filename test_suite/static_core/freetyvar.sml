(*
Imperative type variables may not be free at top level.

Result: FAIL
 
$Log: freetyvar.sml,v $
Revision 1.2  1993/01/20 11:51:22  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val x = (let val Id1 : '_a -> '_a = fn z => z in Id1 Id1 end)
