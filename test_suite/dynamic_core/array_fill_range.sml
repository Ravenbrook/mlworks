(*

Result: OK
 
$Log: array_fill_range.sml,v $
Revision 1.5  1997/05/28 11:31:54  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.4  1996/05/21  12:52:58  matthew
 * Exceptions have changed
 *
 * Revision 1.3  1996/05/08  11:14:37  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:47:12  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/30  10:43:38  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.array(10, 0)

val _ = MLWorks.Internal.ExtendedArray.fill_range(a, 0, 4, 1)

val _ = case MLWorks.Internal.ExtendedArray.to_list a of
  [1,1,1,1,0,0,0,0,0,0] => print"Pass\n"
| _ => print"Fail\n"

val c = (MLWorks.Internal.ExtendedArray.fill_range(a, 3, 2, 1);
	 MLWorks.Internal.ExtendedArray.from_list []) 
  handle MLWorks.Internal.ExtendedArray.Subscript =>
    MLWorks.Internal.ExtendedArray.from_list[3,2]

val _ = case MLWorks.Internal.ExtendedArray.to_list c of
  [3,2] => print"Pass2\n"
| _ => print"Fail2\n"

val d = (MLWorks.Internal.ExtendedArray.fill_range(a, 3, 11, 1);
	 MLWorks.Internal.ExtendedArray.from_list []) 
  handle MLWorks.Internal.ExtendedArray.Subscript =>
    MLWorks.Internal.ExtendedArray.from_list[3,11]

val _ = case MLWorks.Internal.ExtendedArray.to_list d of
  [3,11] => print"Pass3\n"
| _ => print"Fail3\n"

val e = (MLWorks.Internal.ExtendedArray.fill_range(a, ~3, 2, 1);
	 MLWorks.Internal.ExtendedArray.from_list [])
  handle MLWorks.Internal.ExtendedArray.Subscript =>
  MLWorks.Internal.ExtendedArray.from_list[~3,2]

val _ = case MLWorks.Internal.ExtendedArray.to_list e of
  [~3,2] => print"Pass4\n"
| _ => print"Fail4\n"
