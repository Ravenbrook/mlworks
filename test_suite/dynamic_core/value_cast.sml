(*

Result: OK
 
$Log: value_cast.sml,v $
Revision 1.1  1994/08/16 11:26:17  jont
new file

Copyright (c) 1993 Harlequin Ltd.
*)
datatype bar = B of int | A
val a = MLWorks.Internal.Value.cast[1,2,3] : bar
val b = MLWorks.Internal.Value.cast[] : bar
val c = MLWorks.Internal.Value.cast "foobar": bar
val d = MLWorks.Internal.Value.cast["a","b"] : bar
datatype foo = A of int | B
val w = MLWorks.Internal.Value.cast[1,2,3] : foo
val x = MLWorks.Internal.Value.cast[] : foo
val y = MLWorks.Internal.Value.cast "foobar": foo
val z = MLWorks.Internal.Value.cast["a","b"] : foo
