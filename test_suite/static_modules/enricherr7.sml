(*
Enrichment error.

Result: FAIL

$Log: enricherr7.sml,v $
Revision 1.2  1993/01/20 16:34:52  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig exception E of int end = 
  struct
    fun x y = y
  end;
