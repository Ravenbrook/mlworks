(*

Result: OK
 
$Log: array_array.sml,v $
Revision 1.4  1997/06/05 16:42:08  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.3  1996/05/08  11:05:33  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:43:38  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:54:53  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.array(10, 0)
val b = MLWorks.Internal.ExtendedArray.array(10, 0)

val _ = print(if a = b then "Fail\n" else "Pass\n")
