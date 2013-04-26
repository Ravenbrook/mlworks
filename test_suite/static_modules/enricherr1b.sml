(*
Enrichment error: type clash.

Result: FAIL

$Log: enricherr1b.sml,v $
Revision 1.2  1993/01/20 16:33:00  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig datatype ('a,'b) t = T of ('b,'a) t | R end = 
  struct
    datatype ('a,'b) t = T of ('a,'b) t | R
  end

 
