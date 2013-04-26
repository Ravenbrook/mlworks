(*

Result: OK
 
$Log: vector_sub.sml,v $
Revision 1.5  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.4  1997/05/28  12:16:14  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/08  12:19:51  jont
 * Vectors have moved
 *
 * Revision 1.2  1996/05/01  17:21:24  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/30  11:40:40  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.Vector.vector[0,1,2,3,4,5,6,7,8,9]

val _ =
  if MLWorks.Internal.Vector.sub(a, 0) = 0 andalso
    MLWorks.Internal.Vector.sub(a, 1) = 1 andalso
    MLWorks.Internal.Vector.sub(a, 2) = 2 andalso
    MLWorks.Internal.Vector.sub(a, 3) = 3 andalso
    MLWorks.Internal.Vector.sub(a, 4) = 4 andalso
    MLWorks.Internal.Vector.sub(a, 5) = 5 andalso
    MLWorks.Internal.Vector.sub(a, 6) = 6 andalso
    MLWorks.Internal.Vector.sub(a, 7) = 7 andalso
    MLWorks.Internal.Vector.sub(a, 8) = 8 andalso
    MLWorks.Internal.Vector.sub(a, 9) = 9 then
    print"Pass1\n"
  else
    print"Fail1\n"

val _ =
  (ignore(MLWorks.Internal.Vector.sub(a, ~1));
   print"Fail2.1\n") handle MLWorks.Internal.Vector.Subscript =>
  ((ignore(MLWorks.Internal.Vector.sub(a, 10));
    print"Fail2.2\n") handle MLWorks.Internal.Vector.Subscript =>
   print"Pass2\n")
