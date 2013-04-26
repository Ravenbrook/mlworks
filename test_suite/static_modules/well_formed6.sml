(*
Badly formed result signature in functor declaration

Result: FAIL
 
$Log: well_formed6.sml,v $
Revision 1.1  1993/12/02 11:06:18  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

structure S = struct
	      end;

functor F (): sig
		type t
		structure B : sig
				val x:t
			      end
		sharing B = S
	      end =
	      struct
	      end;

