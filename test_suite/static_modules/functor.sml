(*
Eqtype error.

Result: FAIL

$Log: functor.sml,v $
Revision 1.2  1993/01/20 16:36:01  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

functor F () : sig eqtype t end = 
  struct
    datatype t = T of int -> int | R
  end
