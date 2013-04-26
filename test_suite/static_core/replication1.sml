(*
Checks that replicated datatypes actually replicate existing
datatypes.

Result: FAIL
 
$Log: replication1.sml,v $
Revision 1.1  1996/09/20 11:46:10  andreww
new unit
Tests for datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

datatype 'a foo = datatype 'a foo;
