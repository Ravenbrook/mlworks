(*
Arity error.

Result: FAIL
 
$Log: wrongarity1.sml,v $
Revision 1.2  1993/01/20 13:10:37  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype ('a,'b) t = T of ('a * 'b) t | R
