(*
Checks that replication specification works

Result: OK

$Log: replication3.sml,v $
Revision 1.1  1996/09/18 14:52:32  andreww
new unit
Tests for parsing datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

datatype fruit = apple | banana;
signature S = sig datatype fruit = datatype fruit end;

  


