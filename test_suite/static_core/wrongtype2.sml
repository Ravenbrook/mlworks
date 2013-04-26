(*
Type clash.

Result: FAIL
 
$Log: wrongtype2.sml,v $
Revision 1.2  1993/01/20 13:11:40  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val rec f:int -> int = fn x => (x andalso true)
