(*
Constraining signature for structure declaration not type-explicit

Result: FAIL
 
$Log: type_explicit3.sml,v $
Revision 1.1  1993/12/02 11:07:52  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

structure S : sig
		type t
		val y:t
		type t
	      end = struct
		    end;
