(*
Overloaded operators are resolved when decs become strdecs.

Result: OK
 
$Log: overloaded2.sml,v $
Revision 1.3  1996/09/23 14:15:31  andreww
[Bug #1605]
updating.

 * Revision 1.2  1994/05/12  15:32:27  daveb
 * Overloading is now resolved at Rule 57.
 *
Revision 1.1  1993/11/16  20:58:37  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

structure S = struct fun foo x y = x + y fun bar x y = foo x y = 3 end;
