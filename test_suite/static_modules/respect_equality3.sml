(*
Result signature in functor declaration doesn't respect equality

Result: FAIL
 
$Log: respect_equality3.sml,v $
Revision 1.1  1993/12/02 11:15:02  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F ()
  : sig
      datatype t = T of int -> int
      eqtype u
      sharing type t=u
    end
  = struct end;
