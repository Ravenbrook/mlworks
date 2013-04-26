(*

Result: OK
 
$Log: array_reducel_index.sml,v $
Revision 1.4  1997/06/05 16:42:33  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.3  1996/05/08  11:23:02  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:53:31  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:59:05  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[1,2,3,4,5,6,7,8,9]

fun f(i, acc, x:int) = (acc+x)*i

val b = MLWorks.Internal.ExtendedArray.reducel_index f (0, a)

val _ = print(if b = 328792 then "Pass\n" else "Fail\n")
