(*
Result: OK
 
$Log: close.sml,v $
Revision 1.6  1998/03/26 15:23:07  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.5  1996/05/01  17:22:50  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.4  1994/04/27  13:37:20  jont
 * Revise for new meaning of closing stdio
 *
Revision 1.3  1993/01/22  16:42:19  daveb
Added semicolons.

Revision 1.2  1993/01/21  11:57:09  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val s = TextIO.openIn("pervasive/close.sml")
val _ = TextIO.closeIn s
val t = TextIO.openOut("pervasive/foo")
val _ = TextIO.closeOut t
