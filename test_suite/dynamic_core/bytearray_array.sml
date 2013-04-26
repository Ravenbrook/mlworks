(*

Result: OK
 
$Log: bytearray_array.sml,v $
Revision 1.4  1997/05/28 11:41:35  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:13  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  16:57:54  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:09:33  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.array(10, 0)
val b = MLWorks.Internal.ByteArray.array(10, 0)

val _ = print(if a = b then "Fail\n" else "Pass\n")
