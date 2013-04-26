(*
Realisation error: equality types.

Result: FAIL

$Log: realise_err.sml,v $
Revision 1.2  1993/01/20 16:37:51  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig eqtype t end = 
  struct
    type t = int -> real
  end
