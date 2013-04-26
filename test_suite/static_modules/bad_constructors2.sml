(*
Sharing datatypes with inconsistent constructors
 first type in rigid structure,
 second in signature

Result: FAIL
 
$Log: bad_constructors2.sml,v $
Revision 1.1  1993/12/02 11:30:12  nickh
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
    sharing type S.t = t
  end;
