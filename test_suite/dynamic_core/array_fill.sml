(*

Result: OK
 
$Log: array_fill.sml,v $
Revision 1.4  1997/05/28 11:30:52  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:13:03  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:46:14  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:51:17  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.array(10, 0)

val _ = MLWorks.Internal.ExtendedArray.fill(a, 1)

val _ = case MLWorks.Internal.ExtendedArray.to_list a of
  [1,1,1,1,1,1,1,1,1,1] => print"Pass\n"
| _ => print"Fail\n"
