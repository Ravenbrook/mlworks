(*

Result: OK
 
$Log: bytearray_to_list.sml,v $
Revision 1.4  1997/05/28 11:52:28  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:17  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:09:49  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  11:55:32  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.from_list[1,2,3,4,5,1,2,3,4,5]

val _ = case MLWorks.Internal.ByteArray.to_list a of
  [1,2,3,4,5,1,2,3,4,5] => print"Pass\n"
| _ => print"Fail\n"
