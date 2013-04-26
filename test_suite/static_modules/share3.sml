(*
Sharing error: arity.

Result: FAIL

$Log: share3.sml,v $
Revision 1.2  1993/01/20 16:53:37  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG =
  sig
    type 'a t
    type ('a,'b) u
    sharing type t = u
  end
