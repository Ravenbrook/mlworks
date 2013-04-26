(*

Result: OK
 
$Log: vector_length.sml,v $
Revision 1.4  1997/05/28 12:15:16  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:33:03  jont
 * Vectors have moved
 *
 * Revision 1.2  1996/05/01  17:20:45  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/30  11:33:06  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.Vector.vector[0,1,2,3,4,5,6,7,8,9]

val _ = print(if MLWorks.Internal.Vector.length a <> 10 then "Fail\n" else "Pass\n")
