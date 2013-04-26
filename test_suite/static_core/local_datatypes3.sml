(*
Tests that local type names don't escape via pattern matching.
(Taken from revised definition)

Result: FAIL

$Log: local_datatypes3.sml,v $
Revision 1.1  1996/10/04 17:11:46  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

val x = fn x => let datatype t = C
                    val _ = if true then x else C
                 in 5
                end
                   
