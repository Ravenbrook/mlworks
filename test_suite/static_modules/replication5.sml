(*
Checks that we can replicate datatypes in functor parameters.

Result: OK
 
$Log: replication5.sml,v $
Revision 1.1  1997/05/06 10:40:21  andreww
new unit
[Bug #30110]
new test


Copyright (c) 1997 Harlequin Ltd.
*)

signature ANIMALS =
  sig
    datatype animals = Simba | Dumbo | Bambi | ADalmation
  end;

structure Animals:ANIMALS =
  struct
    datatype animals = Simba | Dumbo | Bambi | ADalmation
  end;

functor MyAnimals(A:ANIMALS) =
  struct
    datatype animals = datatype A.animals
  end;

structure MyAnimals = MyAnimals(Animals);

if (MyAnimals.Simba = Animals.Simba) then "test succeeded"
else "test failed";
