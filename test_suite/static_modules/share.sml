(*
Sharing error.

Result: FAIL

$Log: share.sml,v $
Revision 1.2  1993/01/20 16:44:05  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature S = 
  sig
    datatype t = T | TT
  end;

signature SS = 
  sig
    datatype t = T
    structure S:S
    sharing type t = S.t
  end
