(*
Tests that signatures can't share rigid types (one uses where instead).

Result: FAIL
 
$Log: share21.sml,v $
Revision 1.1  1996/10/07 11:28:02  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

structure S =
  struct
    datatype t = T
  end;

signature SIG =
  sig
    type t
    sharing type t = S.t
  end;



