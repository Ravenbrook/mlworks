(*
Checks that "it" cannot be bound as a datatype or exception constructor.

Result: FAIL
 
$Log: bad_valids1.sml,v $
Revision 1.1  1996/09/20 16:07:50  andreww
new unit
[1588] Test to show new fixed constructor status of "it".


Copyright (c) 1996 Harlequin Ltd.
*)

datatype yogi_bear = it of int;

