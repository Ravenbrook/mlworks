(*
Realisation error: arity.

Result: FAIL

$Log: realise_err1.sml,v $
Revision 1.2  1993/01/20 16:38:20  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig type 'a t end = 
  struct 
    datatype ('a,'b) t = T of 'a * 'b | R
  end
