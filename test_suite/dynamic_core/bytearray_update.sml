(*

Result: OK
 
$Log: bytearray_update.sml,v $
Revision 1.4  1997/05/28 11:53:05  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:17  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:10:31  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  11:50:04  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.array(10, 0)

val _ = MLWorks.Internal.ByteArray.update(a, 3, 2)

val b = MLWorks.Internal.ByteArray.sub(a, 3)

val _ = print(if b = 2 then "Pass1\n" else "Fail1\n")

val b = MLWorks.Internal.ByteArray.sub(a, 2)

val _ = print(if b = 0 then "Pass2\n" else "Fail2\n")

val b = MLWorks.Internal.ByteArray.sub(a, 4)

val _ = print(if b = 0 then "Pass3\n" else "Fail3\n")
