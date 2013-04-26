(*

Result: OK
 
$Log: bytearray_subarray.sml,v $
Revision 1.5  1997/06/05 16:43:57  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.4  1996/09/11  14:32:17  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.3  1996/05/21  14:06:14  matthew
 * Exception changes
 *
 * Revision 1.2  1996/05/01  17:07:53  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  17:02:43  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ByteArray.subarray(a, 3, 5)

val _ = case MLWorks.Internal.ByteArray.to_list b of
  [3,4] => print"Pass1\n"
| _ => print"Fail1\n"

val c = MLWorks.Internal.ByteArray.subarray(a, 3, 2) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[3,2]

val _ = case MLWorks.Internal.ByteArray.to_list c of
  [3,2] => print"Pass2\n"
| _ => print"Fail2\n"

val d = MLWorks.Internal.ByteArray.subarray(a, 3, 11) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[3,11]

val _ = case MLWorks.Internal.ByteArray.to_list d of
  [3,11] => print"Pass3\n"
| _ => print"Fail3\n"

val e = MLWorks.Internal.ByteArray.subarray(a, ~3, 2) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[253,2]

val _ = case MLWorks.Internal.ByteArray.to_list e of
  [253,2] => print"Pass4\n"
| _ => print"Fail4\n"
