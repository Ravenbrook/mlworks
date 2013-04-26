(*
Tyvars must match in both sides of replication specification.

Result: FAIL

$Log: replication4.sml,v $
Revision 1.1  1996/09/18 15:11:20  andreww
new unit
Tests for parsing datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

datatype 'a t = a | b;
signature S = sig datatype 'a t = datatype t end;






