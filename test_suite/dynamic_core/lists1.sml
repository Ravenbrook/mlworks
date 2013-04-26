(*
Check matching of lists in value declarations.

Result: WARNING

$Log: lists1.sml,v $
Revision 1.3  1997/06/11 14:21:34  matthew
Changing a revision log

 * Revision 1.2  1993/04/15  10:31:29  daveb
 * Changed status to WARNING.
 *
Revision 1.1  1993/01/21  12:10:31  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

local
  fun f 0 = []
  |   f n = n :: f (n-1)
in
  val [a,b] = f 2
end
