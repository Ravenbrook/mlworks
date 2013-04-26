(*
 Tests that Polymorphic exceptions are done correctly.  In SML '96, we
 can use polymorphic exceptions as long as they don't occur at toplevel.

Result: OK

$Log: exception15.sml,v $
Revision 1.1  1996/08/01 10:56:39  andreww
new unit
Tests that we can declare polymorphic exceptions via eta-expansion
(not allowed at top-level).


Copyright (c) 1996 Harlequin Ltd.
*)

val t = fn x => let exception test of 'a in test end x


