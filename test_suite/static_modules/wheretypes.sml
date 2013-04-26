(*
Where types can no longer bind flexible types to types within the
signature.

Result: FAIL
 
$Log: wheretypes.sml,v $
Revision 1.1  1996/09/23 11:32:36  andreww
new unit
Tests that "where" can't bind flexible types to other types in the
signature.


Copyright (c) 1996 Harlequin Ltd.
*)

signature S =
  sig
    datatype fruit = apple | banana
    type flexible
  end
where type flexible = fruit
