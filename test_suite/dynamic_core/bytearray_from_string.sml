(*

Result: OK
 
$Log: bytearray_from_string.sml,v $
Revision 1.4  1996/09/11 14:32:15  io
[Bug #1603]
convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions

 * Revision 1.3  1996/08/21  09:35:29  daveb
 * ByteArray.from_string no longer discards the trailing null.
 *
 * Revision 1.2  1996/05/01  17:03:16  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:06:37  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.from_string"\009\008\007\006\005\004\003\002\001\000"

val _ = case MLWorks.Internal.ByteArray.to_list a of
  [9,8,7,6,5,4,3,2,1,0,0] => print "Pass\n"
| _ => print "Fail\n"
