(* __LRbasics.sml the structure *)
(*
$Log: __LRbasics.sml,v $
Revision 1.5  1998/02/05 15:58:38  jont
[Bug #30090]
Add TextIO, Char and String parameters to functor arguments

 * Revision 1.4  1995/02/02  12:42:43  matthew
 * Fixing reading of parser tables
 *
Revision 1.3  1993/05/18  18:04:33  jont
Removed integer parameter

Revision 1.2  1992/09/08  10:51:47  matthew
More efficient representation of parsing tables.`

Revision 1.1  1992/08/25  16:30:31  matthew
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "_LRbasics";
require "../utils/__crash";
require "../utils/__lists";
require "../basis/__text_io";
require "../basis/__string";

structure LRbasics_ = LRbasics (val table_dir = "parser/ml-tables/"
                                structure Crash = Crash_
                                structure Lists = Lists_
				structure TextIO = TextIO
				structure String = String
                                  );
