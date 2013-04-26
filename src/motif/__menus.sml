(* Motif menu bar utilites *)
(*

$Log: __menus.sml,v $
Revision 1.7  1999/03/23 14:51:11  johnh
[Bug #190536]
Add Version structure.

 * Revision 1.6  1997/11/03  14:30:38  johnh
 * [Bug #30125]
 * Add getenv structure to get help doc path.
 *
 * Revision 1.5  1996/10/30  18:27:58  daveb
 * Changed name of Xm_ structure to Xm, because we're giving it to users.
 *
 * Revision 1.4  1996/04/30  09:24:12  matthew
 * Use basis/integer
 *
 * Revision 1.3  1995/07/26  14:11:15  matthew
 * Restructuring directories
 *
Revision 1.2  1993/03/30  16:14:24  matthew
 Added Integer structure
/

Revision 1.1  1993/03/17  16:29:13  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.

*)

require "../utils/__lists";
require "../motif/__xm";
require "../system/__getenv";
require "../main/__version";

require "_menus";

structure Menus_ = Menus(structure Lists = Lists_
			 structure Getenv = Getenv_
                         structure Xm = Xm
			 structure Version = Version_);
