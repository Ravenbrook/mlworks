(*

Result: OK
 
$Log: array_reducel.sml,v $
Revision 1.4  1997/05/28 11:37:16  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:22:07  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:53:14  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:58:29  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[1,2,3,4,5,6,7,8,9]

fun f(acc, x:int) = (acc+x)*x

val b = MLWorks.Internal.ExtendedArray.reducel f (0, a)

val _ = print(if b = 1972809 then "Pass\n" else "Fail\n")
