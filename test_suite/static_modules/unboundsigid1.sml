(*
Attempt to include an unbound signature identifier.

Result: FAIL

$Log: unboundsigid1.sml,v $
Revision 1.3  1993/01/22 11:22:29  matthew
> Changed signature id.

Revision 1.2  1993/01/20  16:59:24  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature S = 
  sig 
    include SOME_UNLIKELY_SIGID
  end
