(*

Result: OK
 
$Log: rec_eq.sml,v $
Revision 1.1  1994/06/10 17:18:19  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)
val x = (0,1) = (0,1)
val y = (0,1) = (1,0)
val z = [1] = [1]
val a = [0] = [1]
val b = (0,1) <> (0,1)
val c = (0,1) <> (1,0)
val d = [1] <> [1]
val e = [0] <> [1]
