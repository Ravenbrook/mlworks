(*

Result: OK
 
$Log: bytearray_iterate.sml,v $
Revision 1.4  1997/05/28 11:47:16  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:15  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:03:38  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:39:37  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = ref [] : int list ref

fun f x = b := x :: (!b)

val _ = MLWorks.Internal.ByteArray.iterate f a

val _ = case b of
  ref[9,8,7,6,5,4,3,2,1,0] => print"Pass\n"
| _ => print"Fail\n"
