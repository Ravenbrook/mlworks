(*
Enrichment error: type clash.

Result: FAIL

$Log: enricherr5.sml,v $
Revision 1.2  1993/01/20 16:34:25  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    datatype t = T of int | R of real
  end;

structure A:SIG = 
  struct
    datatype t = T of int | R
  end
