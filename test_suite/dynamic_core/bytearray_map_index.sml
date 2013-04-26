(*

Result: OK
 
$Log: bytearray_map_index.sml,v $
Revision 1.4  1997/05/28 11:48:37  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:16  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:04:59  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:33:58  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ByteArray.map_index (fn (index, value:int) => index*value) a

val _ = case MLWorks.Internal.ByteArray.to_list b of
  [0,1,4,9,16,25,36,49,64,81] => print"Pass\n"
| _ => print"Fail\n"
