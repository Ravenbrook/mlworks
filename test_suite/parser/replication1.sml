(*
checks the new datatype replication declaration
works and doesn't conflict with old datatype.

Result: OK

$Log: replication1.sml,v $
Revision 1.2  1996/10/29 14:36:31  andreww
[Bug #1708]
altered syntax of datatype replication.

 *  Revision 1.1  1996/09/18  14:49:32  andreww
 *  new unit
 *  Tests for parsing datatype replication.
 *

Copyright (c) 1996 Harlequin Ltd.
*)

datatype 'a fruit = apple of 'a | banana of 'a * 'a;

datatype yoghurt = datatype fruit;

