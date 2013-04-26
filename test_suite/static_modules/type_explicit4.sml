(*
Argument signature in functor declaration not type-explicit

Result: FAIL
 
$Log: type_explicit4.sml,v $
Revision 1.1  1993/12/02 11:08:51  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F(type t
	  val y:t
	  type t) =
  struct
  end;
