(*
Realisation error: datatype declarations are generative.

Result: FAIL

$Log: realise_err5.sml,v $
Revision 1.2  1993/01/20 16:41:14  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A = 
  struct
    datatype t = T
  end;

signature SIG = 
  sig
    type t
    sharing type t = A.t
  end;

structure B : SIG = 
  struct
    datatype t = T
  end
