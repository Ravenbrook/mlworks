(*
Note that even though e is a hidden type name, it is allowed to escape
a local declaration, and subsequently to appear in the type of f.  Crazy,
but true.

Also note that in this test, both declarations are top-level, and hence
structure declarations.  This is another reason why things can escape.

Result: OK

$Log: local_datatypes8.sml,v $
Revision 1.1  1996/10/04 18:36:57  andreww
new unit
new test


Copyright (c) 1996 Harlequin Ltd.
*)

local
 datatype e = x;
in
 datatype t = b of e
end;

fun f var = b var;
