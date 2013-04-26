(*
Sharing with non-existent structure.

Result: FAIL

$Log: share6.sml,v $
Revision 1.2  1993/01/20 16:46:32  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    structure A : sig end
    sharing A = B
  end
