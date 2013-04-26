(*
Constructors can't be bound by value declarations.

Result: FAIL
 
$Log: exception.sml,v $
Revision 1.2  1993/01/20 11:40:48  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

exception E

val E = 2

val _ = raise E
