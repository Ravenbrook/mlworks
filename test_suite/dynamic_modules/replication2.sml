(* Tests that specified replicated datatypes can only be
   matched against actually replicated datatypes.

Result: FAIL
 
$Log: replication2.sml,v $
Revision 1.1  1996/09/18 16:19:16  andreww
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
    datatype fruit = apple | banana
  end;
