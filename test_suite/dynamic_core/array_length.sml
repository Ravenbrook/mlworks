(*

Result: OK
 
$Log: array_length.sml,v $
Revision 1.4  1997/05/28 11:36:09  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:19:49  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:51:51  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:55:16  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.array(10, 0)
val b = MLWorks.Internal.ExtendedArray.length a
val _ = print(if b = 10 then "Pass\n" else "Fail\n")
