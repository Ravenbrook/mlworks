(*

Result: OK
 
$Log: bytearray_reducer.sml,v $
Revision 1.4  1997/05/28 11:49:37  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:16  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:05:42  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  17:30:16  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[1,2,3,4,5,6,7,8,9]

fun f(x:int, acc) = (acc+x)*x

val b = MLWorks.Internal.ByteArray.reducer f (a, 0)

val _ = print(if b = 3628799 then "Pass\n" else "Fail\n")
