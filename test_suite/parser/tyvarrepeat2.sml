(*
Type variables may not be repeated in type specifications.

Result: FAIL

$Log: tyvarrepeat2.sml,v $
Revision 1.1  1993/01/19 16:53:28  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

signature S =
sig
  type ('a,'b,'a) t
end
