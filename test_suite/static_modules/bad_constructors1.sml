(*
Sharing datatypes with inconsistent constructors
 first type in signature,
 second in rigid structure

Result: FAIL
 
$Log: bad_constructors1.sml,v $
Revision 1.1  1993/12/02 11:29:27  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

structure S =
  struct
    datatype t = T
  end;

signature SIG =
  sig
    datatype t = S
    sharing type t = S.t
  end;
