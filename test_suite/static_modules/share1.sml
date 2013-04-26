(*
Result: OK

$Log: share1.sml,v $
Revision 1.2  1993/01/20 16:57:56  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    datatype t = T 
    type u
    sharing type u = t
  end
