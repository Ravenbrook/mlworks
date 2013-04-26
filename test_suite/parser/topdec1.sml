(*
Signatures, structures and functors should be separated by semicolons.

Result: OK

$Log: topdec1.sml,v $
Revision 1.3  1995/06/08 13:22:18  jont
Change status to OK

Revision 1.2  1993/01/19  16:28:52  daveb
Added header.


Revision 1.1  1992/11/04  17:12:04  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

signature S = sig end

functor F (S: S) =
struct
  type t = int
end

structure S = struct end

signature S = sig end

structure S = struct end

functor F (S: S) =
struct
  type t = int
end

signature S = sig end
