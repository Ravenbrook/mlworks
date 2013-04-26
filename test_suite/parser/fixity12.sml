(*
Test bracketing of infix fun decs.

Result: FAIL

$Log: fixity12.sml,v $
Revision 1.2  1993/01/19 15:56:45  daveb
Added header.

Revision 1.1  1992/11/05  13:29:49  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

infix %% @@

datatype T = @@ of a' * 'b 

fun a @@ b %% c @@ d = ()
