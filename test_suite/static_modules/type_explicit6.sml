(*
Result signature in functor declaration not type-explicit

Result: FAIL
 
$Log: type_explicit6.sml,v $
Revision 1.1  1993/12/02 11:10:16  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F(): sig
	       type t
	       val y:t
	       type t
	     end = struct end;
