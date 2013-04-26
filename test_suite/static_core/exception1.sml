(*

Result: FAIL
 
$Log: exception1.sml,v $
Revision 1.2  1993/01/20 11:42:33  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

exception E of string

val _ = raise E 1
