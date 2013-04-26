(*
Argument signature in functor declaration with result signature doesn't
 respect equality

Result: FAIL
 
$Log: respect_equality2.sml,v $
Revision 1.1  1993/12/02 11:13:46  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F (datatype t = T of int -> int
	   eqtype u
	   sharing type t=u)
  : sig
    end 
  = struct
    end;
