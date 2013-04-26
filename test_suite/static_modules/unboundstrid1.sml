(*
Attempt to share an unbound structure identifier.

Result: FAIL

$Log: unboundstrid1.sml,v $
Revision 1.2  1993/01/20 17:00:06  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature S = 
  sig
    sharing A = B
  end
