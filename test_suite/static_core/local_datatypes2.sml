(*
Tests that hidden tynames don't escape let expressions.  (Taken from
the revised definition)

Result: FAIL

$Log: local_datatypes2.sml,v $
Revision 1.1  1996/10/04 17:10:26  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

val x = let datatype hidden = boo in boo end;
