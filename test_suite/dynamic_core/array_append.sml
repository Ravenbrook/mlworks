(*

Result: OK
 
$Log: array_append.sml,v $
Revision 1.4  1997/05/28 11:27:51  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:04:46  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  17:32:29  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:58:14  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,5]

val c = MLWorks.Internal.ExtendedArray.append(a, b)

val _ = case MLWorks.Internal.ExtendedArray.to_list c of
  [0,1,2,3,4,5,6,7,8,9,0,1,2,3,5] => print"Pass\n"
| _ => print"Fail\n"
