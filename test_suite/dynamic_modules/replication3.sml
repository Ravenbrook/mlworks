(* Tests that specified replicated datatypes can be
   matched against actually replicated datatypes.
   (This is the converse of the test dynamic_modules/replication2.sml)

Result: OK
 
$Log: replication3.sml,v $
Revision 1.1  1996/09/18 16:20:35  andreww
new unit
Test for datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

datatype fruit = apple | banana;

signature S =
  sig
    datatype fruit = datatype fruit
  end;

structure X:S =
  struct
    datatype fruit = datatype fruit
  end;
