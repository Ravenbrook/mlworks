(*
Enrichment error: type clash.

Result: FAIL
 
$Log: enricherr.sml,v $
Revision 1.2  1993/01/20 16:31:42  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    datatype t = T | R of int
  end;

structure A : SIG = 
  struct
    datatype t = T | R of real
  end


