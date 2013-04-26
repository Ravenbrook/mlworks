(*

Result: OK
 
$Log: bytearray_find_default.sml,v $
Revision 1.4  1997/05/28 11:46:29  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:14  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:02:32  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  15:54:35  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)



val a = MLWorks.Internal.ByteArray.arrayoflist[1,2,3,4,5,6,7,8,9,0]

val b = MLWorks.Internal.ByteArray.find_default (fn x => x = 4, 10) a

val c = MLWorks.Internal.ByteArray.find_default (fn x => x = ~1, 10) a

val _ =
  if b = 3 then print"Pass 1\n" else print"Fail 1\n"

val _ =
  if c = 10 then print"Pass 2\n" else print"Fail 2\n"
