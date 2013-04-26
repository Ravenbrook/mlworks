(*
Enrichment error: type clash.

Result: FAIL

$Log: enricherr3.sml,v $
Revision 1.2  1993/01/20 16:33:46  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig val x : ''a end = 
  struct
    fun x y = y
  end
