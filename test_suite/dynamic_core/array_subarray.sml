(*

Result: OK
 
$Log: array_subarray.sml,v $
Revision 1.5  1997/05/28 11:39:24  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.4  1996/05/21  14:04:46  matthew
 * Exception changes
 *
 * Revision 1.3  1996/05/08  11:27:15  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:56:06  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/30  10:39:07  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ExtendedArray.subarray(a, 3, 5)

val _ = case MLWorks.Internal.ExtendedArray.to_list b of
  [3,4] => print"Pass1\n"
| _ => print"Fail1\n"

val c = MLWorks.Internal.ExtendedArray.subarray(a, 3, 2) 
  handle MLWorks.Internal.ExtendedArray.Subscript =>
  MLWorks.Internal.ExtendedArray.from_list[3,2]

val _ = case MLWorks.Internal.ExtendedArray.to_list c of
  [3,2] => print"Pass2\n"
| _ => print"Fail2\n"

val d = MLWorks.Internal.ExtendedArray.subarray(a, 3, 11) 
  handle MLWorks.Internal.ExtendedArray.Subscript =>
  MLWorks.Internal.ExtendedArray.from_list[3,11]

val _ = case MLWorks.Internal.ExtendedArray.to_list d of
  [3,11] => print"Pass3\n"
| _ => print"Fail3\n"

val e = MLWorks.Internal.ExtendedArray.subarray(a, ~3, 2) 
  handle MLWorks.Internal.ExtendedArray.Subscript =>
  MLWorks.Internal.ExtendedArray.from_list[~3,2]

val _ = case MLWorks.Internal.ExtendedArray.to_list e of
  [~3,2] => print"Pass4\n"
| _ => print"Fail4\n"

