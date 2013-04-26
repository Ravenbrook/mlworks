(*
The sharing constraint can't match the equality attribute of
the two types.

Result: FAIL

$Log: respect_eq.sml,v $
Revision 1.2  1993/01/20 16:42:20  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature S = 
  sig
    datatype t = T of int -> int
    eqtype u
    sharing type t = u
  end
