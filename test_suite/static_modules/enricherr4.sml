(*
Enrichment error.

Result: FAIL

$Log: enricherr4.sml,v $
Revision 1.2  1993/01/20 16:34:07  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig structure B : sig end end =
  struct 
    datatype t = T
  end
    
