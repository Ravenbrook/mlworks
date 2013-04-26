(*
Sharing types with incompatible equality attributes,
 first type in functor argument signature,
 second in result signature

Result: FAIL
 
$Log: eq_attr1.sml,v $
Revision 1.1  1993/12/02 11:22:10  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F (datatype t = T of int -> int) :
  sig
    eqtype t'
    sharing type t=t'
  end =
  struct
  end;
