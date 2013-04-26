(*
Argument signature in functor declaration with result signature
 not type-explicit

Result: FAIL
 
$Log: type_explicit5.sml,v $
Revision 1.1  1993/12/02 11:09:35  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F(type t
	  val y:t
	  type t) : sig end =
  struct
  end;
