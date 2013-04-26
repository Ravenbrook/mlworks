(*
Checks that there can't be type vars on a replicated datatype.

Result: FAIL

$Log: replication2.sml,v $
Revision 1.2  1996/10/29 14:37:16  andreww
[Bug #1708]
altered syntax of datatype replication.

 *  Revision 1.1  1996/09/18  14:51:06  andreww
 *  new unit
 *  Tests for parsing datatype replication.
 *

Copyright (c) 1996 Harlequin Ltd.
*)

datatype 'a yoghurt = datatype fruit;

