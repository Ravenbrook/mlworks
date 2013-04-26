(*

Result: OK
 
$Log: bytearray_substring.sml,v $
Revision 1.7  1998/02/18 11:55:59  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.6  1997/05/28  11:51:39  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.5  1996/11/03  15:59:48  io
 * [Bug #1614]
 * remove toplevel String
 *
 * Revision 1.4  1996/09/11  14:32:17  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.3  1996/05/01  17:35:10  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1995/07/27  14:59:16  matthew
 * New test for bounds checks
 *
Revision 1.1  1993/03/25  17:18:47  jont
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ByteArray.substring(a, 3, 5)

val _ = (ignore(MLWorks.Internal.ByteArray.substring (a,0,10)); print"Pass0\n")
        handle MLWorks.Internal.ByteArray.Substring => print"Fail0\n"

val _ = case b of
  "\003\004\005\006\007" => print"Pass1\n"
| _ => print"Fail1\n"

val d = MLWorks.Internal.ByteArray.substring(a, 3, 11) handle MLWorks.Internal.ByteArray.Substring =>
  (str o chr) 3 ^ (str o chr) 11

val _ = case d of
  "\003\011" => print"Pass2\n"
| _ => print"Fail2\n"

val e = MLWorks.Internal.ByteArray.substring(a, ~3, 2) handle MLWorks.Internal.ByteArray.Substring =>
  (str o chr) 253 ^ (str o chr) 2

val _ = case e of
  "\253\002" => print"Pass3\n"
| _ => print"Fail3\n"
