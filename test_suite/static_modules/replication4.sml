(*
Checks that replicated constructors have constructor status

Result: OK
 
$Log: replication4.sml,v $
Revision 1.1  1996/10/25 11:51:45  andreww
new unit
new test.
[1682]


Copyright (c) 1996 Harlequin Ltd.
*)

structure JungleBook =
  struct
    datatype animals = ShereKhan of int | Baloo
  end;

datatype animals = datatype JungleBook.animals;

fun baddie (ShereKhan _) = true
  | baddie (Baloo) = false;
