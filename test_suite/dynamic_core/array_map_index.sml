(*

Result: OK
 
$Log: array_map_index.sml,v $
Revision 1.4  1997/05/28 11:36:59  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:21:25  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:52:45  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:57:05  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ExtendedArray.map_index (fn (index, value:int) => index*value) a

val _ = case MLWorks.Internal.ExtendedArray.to_list b of
  [0,1,4,9,16,25,36,49,64,81] => print"Pass\n"
| _ => print"Fail\n"
