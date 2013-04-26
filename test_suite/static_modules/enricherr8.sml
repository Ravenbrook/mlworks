(*
Enrichment error: type clash.

Result: FAIL

$Log: enricherr8.sml,v $
Revision 1.2  1993/01/20 16:35:09  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    exception E of int
  end;

structure A : SIG = 
  struct
    exception E of string
  end;
