(*
The sharing constraint can't match the equality attribute
of the two types.

Result: FAIL

$Log: respect_eq1.sml,v $
Revision 1.2  1993/01/20 16:43:39  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

functor F (datatype t = T of int -> int
           eqtype u
           sharing type t = u) = 
  struct
  end
