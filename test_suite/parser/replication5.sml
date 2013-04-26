(*
Tests that datatype replication is not added to SML'90.

Result: FAIL

$Log: replication5.sml,v $
Revision 1.1  1996/09/20 15:36:10  andreww
new unit
Tests for datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.Mode.sml'90();
datatype fruit = apple | banana;
datatype yoghurt = datatype fruit;




