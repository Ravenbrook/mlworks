(*

Result: OK
 
$Log: bytearray_length.sml,v $
Revision 1.4  1997/05/28 11:47:56  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:15  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:04:21  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  11:46:52  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.array(10, 0)
val b = MLWorks.Internal.ByteArray.length a
val _ = print(if b = 10 then "Pass\n" else "Fail\n")
