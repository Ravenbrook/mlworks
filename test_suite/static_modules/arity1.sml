(*
Sharing types with different arities
 first type in signature,
 second in rigid structure

Result: FAIL
 
$Log: arity1.sml,v $
Revision 1.1  1993/12/02 11:26:57  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

structure S =
  struct
    datatype 'a t = T
  end;

signature SIG =
  sig
    type t
    sharing type t = S.t
  end;
