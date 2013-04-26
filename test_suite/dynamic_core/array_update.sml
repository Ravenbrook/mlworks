(*

Result: OK
 
$Log: array_update.sml,v $
Revision 1.4  1997/05/28 11:40:50  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:29:37  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:57:12  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:51:21  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.array(10, 0)

val _ = MLWorks.Internal.ExtendedArray.update(a, 3, 2)

val b = MLWorks.Internal.ExtendedArray.sub(a, 3)

val _ = print(if b = 2 then "Pass1\n" else "Fail1\n")

val b = MLWorks.Internal.ExtendedArray.sub(a, 2)

val _ = print(if b = 0 then "Pass2\n" else "Fail2\n")

val b = MLWorks.Internal.ExtendedArray.sub(a, 4)

val _ = print(if b = 0 then "Pass3\n" else "Fail3\n")
