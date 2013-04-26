(*
Sharing types with incompatible equality attributes,
 first type in rigid structure,
 second in signature

Result: FAIL
 
$Log: eq_attr3.sml,v $
Revision 1.1  1993/12/02 11:25:13  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

structure S =
  struct
    datatype t = T of real -> real
  end;

signature SIG =
  sig 
    eqtype t
    sharing type S.t = t
  end;
