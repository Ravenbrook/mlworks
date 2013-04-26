(*

Result: OK
 
$Log: bytearray_copy.sml,v $
Revision 1.5  1997/05/28 11:43:07  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.4  1996/09/11  14:32:14  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.3  1996/05/21  12:54:08  matthew
 * Exceptions have changed
 *
 * Revision 1.2  1996/05/01  16:59:24  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  17:51:31  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ByteArray.array(10, 0)

val _ = MLWorks.Internal.ByteArray.copy(a, 0, 4, b, 1)

val _ = case MLWorks.Internal.ByteArray.to_list b of
  [0,0,1,2,3,0,0,0,0,0] => print"Pass\n"
| _ => print"Fail\n"


val c = (MLWorks.Internal.ByteArray.copy(a, 3, 2, b, 1);
	 MLWorks.Internal.ByteArray.from_list []) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[3,2,1]

val _ = case MLWorks.Internal.ByteArray.to_list c of
  [3,2,1] => print"Pass2\n"
| _ => print"Fail2\n"

val d = (MLWorks.Internal.ByteArray.copy(a, 3, 11, b ,1);
	 MLWorks.Internal.ByteArray.from_list [])
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[3,11,1]

val _ = case MLWorks.Internal.ByteArray.to_list d of
  [3,11, 1] => print"Pass3\n"
| _ => print"Fail3\n"

val e = (MLWorks.Internal.ByteArray.copy(a, ~3, 2, b, 1);
	 MLWorks.Internal.ByteArray.from_list [])
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[253,2,1]

val _ = case MLWorks.Internal.ByteArray.to_list e of
  [253,2, 1] => print"Pass4\n"
| _ => print"Fail4\n"

val f = (MLWorks.Internal.ByteArray.copy(a, 0, 9, b, 4);
	 MLWorks.Internal.ByteArray.from_list []) 
  handle MLWorks.Internal.ByteArray.Subscript =>
  MLWorks.Internal.ByteArray.from_list[0,9,4]
  
val _ = case MLWorks.Internal.ByteArray.to_list f of
  [0, 9, 4] => print"Pass5\n"
| _ => print"Fail5\n"
