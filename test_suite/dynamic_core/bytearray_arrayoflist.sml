(*

Result: OK
 
$Log: bytearray_arrayoflist.sml,v $
Revision 1.4  1997/05/28 11:42:00  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:14  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  16:58:18  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  11:52:38  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[1,2,3,4,5,1,2,3,4,5]

val b = MLWorks.Internal.ByteArray.length a

val c = MLWorks.Internal.ByteArray.sub(a, 7)

val _ = print(if b = 10 then "Pass1\n" else "Fail1\n")

val _ = print(if c = 3 then "Pass2\n" else "Fail2\n")
