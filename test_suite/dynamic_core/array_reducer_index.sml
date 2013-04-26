(*

Result: OK
 
$Log: array_reducer_index.sml,v $
Revision 1.4  1997/06/06 09:43:38  jont
[Bug #30090]
Replace use of MLWorks.IO with print

 * Revision 1.3  1996/05/08  11:24:21  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:54:12  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:59:20  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[1,2,3,4,5,6,7,8,9]

fun f(i, x:int, acc) = (acc+i)*x

val b = MLWorks.Internal.ExtendedArray.reducer_index f (a, 0)

val _ = print(if b = 3219686 then "Pass\n" else "Fail\n")
