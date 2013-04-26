(*

Result: OK
 
$Log: vector_tabulate.sml,v $
Revision 1.4  1997/05/28 12:16:29  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:34:55  jont
 * Vectors have moved
 *
 * Revision 1.2  1996/05/01  17:21:36  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/30  11:45:19  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

fun f x = 10 - x

val a = MLWorks.Internal.Vector.tabulate(10, f)
val b = MLWorks.Internal.Vector.vector[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
val _ = print(if a <> b then "Fail\n" else "Pass\n")
