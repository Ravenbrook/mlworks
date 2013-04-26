(*
Enrichment error.

Result: FAIL

$Log: enricherr6.sml,v $
Revision 1.2  1993/01/20 16:34:42  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig structure B : sig val x : int -> int end end = 
  struct
    fun x y = y
  end;
