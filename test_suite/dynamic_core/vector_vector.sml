(*

Result: OK
 
$Log: vector_vector.sml,v $
Revision 1.5  1997/05/28 12:16:57  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.4  1996/09/03  09:32:23  jont
 * Add test for top level vector function
 *
 * Revision 1.3  1996/05/08  11:35:40  jont
 * Vectors have moved
 *
 * Revision 1.2  1996/05/01  17:21:51  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/30  11:32:18  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.Vector.vector[0,1,2,3,4,5,6,7,8,9]
val b = MLWorks.Internal.Vector.vector[0,1,2,3,4,5,6,7,8,9]

val _ = print(if a <> b then "Fail\n" else "Pass\n")
val a = vector[0,1,2,3,4,5,6,7,8,9,10]
val b = vector[0,1,2,3,4,5,6,7,8,9,10]

val _ = print(if a <> b then "Fail\n" else "Pass\n")
