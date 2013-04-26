(*

Result: OK
 
$Log: bytearray_fill_range.sml,v $
Revision 1.5  1997/05/28 11:44:59  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.4  1996/09/11  14:32:14  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.3  1996/05/21  12:55:13  matthew
 * Exceptions have changed
 *
 * Revision 1.2  1996/05/01  17:01:17  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  17:43:27  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.array(10, 0)

val _ = MLWorks.Internal.ByteArray.fill_range(a, 0, 4, 1)

val _ = case MLWorks.Internal.ByteArray.to_list a of
  [1,1,1,1,0,0,0,0,0,0] => print"Pass\n"
| _ => print"Fail\n"

val c = (MLWorks.Internal.ByteArray.fill_range(a, 3, 2, 1);
	 MLWorks.Internal.ByteArray.from_list []) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[3,2]

val _ = case MLWorks.Internal.ByteArray.to_list c of
  [3,2] => print"Pass2\n"
| _ => print"Fail2\n"

val d = (MLWorks.Internal.ByteArray.fill_range(a, 3, 11, 1);
	 MLWorks.Internal.ByteArray.from_list []) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[3,11]

val _ = case MLWorks.Internal.ByteArray.to_list d of
  [3,11] => print"Pass3\n"
| _ => print"Fail3\n"

val e = (MLWorks.Internal.ByteArray.fill_range(a, ~3, 2, 1);
	 MLWorks.Internal.ByteArray.from_list [])
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[253,2]

val _ = case MLWorks.Internal.ByteArray.to_list e of
  [253,2] => print"Pass4\n"
| _ => print"Fail4\n"
