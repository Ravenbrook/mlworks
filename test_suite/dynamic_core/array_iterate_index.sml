(*

Result: OK
 
$Log: array_iterate_index.sml,v $
Revision 1.4  1997/05/28 11:35:32  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:18:18  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:51:12  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:57:23  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = ref [] : (int * int) list ref

fun f(index, value) = b := (index, 9-value) :: (!b)

val _ = MLWorks.Internal.ExtendedArray.iterate_index f a

val _ = case b of
  ref[(9,0),(8,1),(7,2),(6,3),(5,4),(4,5),(3,6),(2,7),(1,8),(0,9)] => print"Pass\n"
| _ => print"Fail\n"
