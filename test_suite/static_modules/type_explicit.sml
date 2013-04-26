(*
This signature is not type-explicit.

Result: FAIL

$Log: type_explicit.sml,v $
Revision 1.2  1993/01/20 16:58:19  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    type t
    val x : t
    type t
  end
