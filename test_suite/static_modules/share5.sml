(*
Sharing error.

Result: FAIL

$Log: share5.sml,v $
Revision 1.2  1993/01/20 16:54:15  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure S = 
  struct
    type t = int
    datatype u = U
  end;

signature SIG = 
  sig
    sharing type S.t = S.u
  end
