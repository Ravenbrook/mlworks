(*
see comment on local_datatypes8.sml.

Result: OK

$Log: local_datatypes9.sml,v $
Revision 1.1  1996/10/04 18:37:12  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)


local
 structure X = struct datatype e = x end;
in
 datatype t = b of X.e
end;

fun f var = b var;
