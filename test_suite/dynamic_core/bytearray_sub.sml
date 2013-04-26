(*

Result: OK
 
$Log: bytearray_sub.sml,v $
Revision 1.5  1997/05/28 11:50:34  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.4  1996/09/11  14:32:16  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.3  1996/05/01  17:06:28  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1993/10/05  13:43:48  daveb
 * Merged in bug fix.
 *
Revision 1.1.1.2  1993/09/30  13:29:36  jont
Changed to use non zero value in array creation

Revision 1.1.1.1  1993/03/25  11:48:25  jont
Fork for bug fixing

Revision 1.1  1993/03/25  11:48:25  jont
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.array(10, 5)

val b = MLWorks.Internal.ByteArray.sub(a, 3)

val _ = print(if b = 5 then "Pass\n" else "Fail\n")
