(*

Result: OK
 
$Log: array_sub.sml,v $
Revision 1.4  1997/05/28 11:38:22  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:25:40  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:54:48  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:55:43  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.array(10, 0)

val b = MLWorks.Internal.ExtendedArray.sub(a, 3)

val _ = print(if b = 0 then "Pass\n" else "Fail\n")
