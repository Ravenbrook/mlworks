(*

Result: OK
 
$Log: bytearray_to_string.sml,v $
Revision 1.4  1996/09/11 14:32:17  io
[Bug #1603]
convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions

 * Revision 1.3  1996/08/21  09:34:39  daveb
 * ByteArray.to_string no longer adds a trailing null byte.
 *
 * Revision 1.2  1996/05/01  17:10:07  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:14:14  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.from_list[9,8,7,6,5,4,3,2,1,0]
val b = MLWorks.Internal.ByteArray.to_string a

val _ = case b of
  "\009\008\007\006\005\004\003\002\001" => print "Pass\n"
| _ => print "Fail\n"

