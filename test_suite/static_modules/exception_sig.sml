(*
Exception specifications may not contain type variables.

Result: FAIL

$Log: exception_sig.sml,v $
Revision 1.2  1993/01/20 16:35:40  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    exception E of 'a
  end
