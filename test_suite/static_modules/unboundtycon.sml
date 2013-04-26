(*
Attempt to share an unbound type identifier.

Result: FAIL

$Log: unboundtycon.sml,v $
Revision 1.2  1993/01/20 17:00:28  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    type t
    sharing type t = u
  end
