(*
Result: FAIL

$Log: record1.sml,v $
Revision 1.4  1993/09/28 12:41:51  daveb
Removed reference to old status from Log, as it confused the testing s/w.

Revision 1.3  1993/01/22  17:20:57  daveb
Changed result status to FAIL

Revision 1.2  1993/01/20  12:59:24  daveb
Added header.

Revision 1.1  1992/11/04  17:12:16  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

datatype Foo = FOO of {baz : int}
fun g (FOO _) = ()
fun test x = (#baz x;g x)
fun test2 x = (g x;#baz x)
