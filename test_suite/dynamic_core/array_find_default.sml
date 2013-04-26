(*

Result: OK
 
$Log: array_find_default.sml,v $
Revision 1.4  1997/05/28 11:33:21  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:16:04  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:49:59  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  12:00:08  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)


val a = MLWorks.Internal.ExtendedArray.arrayoflist[1,2,3,4,5,6,7,8,9,0]

val b = MLWorks.Internal.ExtendedArray.find_default (fn x => x = 4, 10) a

val c = MLWorks.Internal.ExtendedArray.find_default (fn x => x = ~1, 10) a

val _ =
  if b = 3 then print"Pass 1\n" else print"Fail 1\n"

val _ =
  if c = 10 then print"Pass 2\n" else print"Fail 2\n"
