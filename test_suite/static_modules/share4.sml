(*
Sharing error: equality types.

Result: FAIL

$Log: share4.sml,v $
Revision 1.2  1993/01/20 16:54:01  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure S = 
  struct
    datatype t = T of real -> real
  end;

signature SIG = 
  sig
    eqtype t
    sharing type t = S.t
  end
