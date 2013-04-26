(*

Result: OK
 
$Log: bytearray_fill.sml,v $
Revision 1.4  1997/05/28 11:44:04  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:14  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:00:14  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:27:27  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.array(10, 0)

val _ = MLWorks.Internal.ByteArray.fill(a, 1)

val _ = case MLWorks.Internal.ByteArray.to_list a of
  [1,1,1,1,1,1,1,1,1,1] => print"Pass\n"
| _ => print"Fail\n"
