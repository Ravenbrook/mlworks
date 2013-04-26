(*
Type identifier in withtype repeats main binding.

Result: FAIL
 
$Log: idtwice5.sml,v $
Revision 1.2  1993/01/20 13:10:06  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype t = T of t | R of r withtype r = int and t = real
