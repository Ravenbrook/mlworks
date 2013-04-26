(*
Handlers match on values of type exn.

Result: FAIL
 
$Log: handler1.sml,v $
Revision 1.2  1993/01/20 12:29:00  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


val y = 1 handle 1 => 1
