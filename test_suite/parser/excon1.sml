(*
Test check for excon in old exception binding

Result: FAIL

$Log: excon1.sml,v $
Revision 1.1  1994/03/21 11:23:41  matthew
new file


Copyright (c) 1992 Harlequin Ltd.
*)

fun foo s = Io s;

exception Foo = foo;
