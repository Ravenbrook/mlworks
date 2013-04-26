(*

Result: OK
 
$Log: array_map.sml,v $
Revision 1.4  1997/05/28 11:36:33  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:20:25  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:52:24  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:56:46  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ExtendedArray.map (fn x => 10-x) a

val _ = case MLWorks.Internal.ExtendedArray.to_list b of
  [10,9,8,7,6,5,4,3,2,1] => print"Pass\n"
| _ => print"Fail\n"
