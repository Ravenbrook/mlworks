(*
Enrichment error: type clash.

Result: FAIL

$Log: enricherr2.sml,v $
Revision 1.2  1993/01/20 16:33:20  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig val x : {1 : int, 2: real} end = 
  struct
    val x = (1,1.1,2)
  end
