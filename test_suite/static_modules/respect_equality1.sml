(*
Constraining signature in structure declaration doesn't respect equality

Result: FAIL
 
$Log: respect_equality1.sml,v $
Revision 1.1  1993/12/02 11:12:09  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

structure S : sig
		datatype t = T of int -> int
		eqtype u
		sharing type t=u
	      end = struct end;
