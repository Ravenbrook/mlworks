(*
Sharing types with different arities
 first type in rigid structure,
 second in signature

Result: FAIL
 
$Log: arity2.sml,v $
Revision 1.1  1993/12/02 11:28:00  nickh
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
    sharing type S.t = S
  end;
