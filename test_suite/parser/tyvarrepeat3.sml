(*
Type variables may not be repeated in datatype specifications.

Result: FAIL

$Log: tyvarrepeat3.sml,v $
Revision 1.1  1993/01/19 16:54:00  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

signature S =
sig
  datatype ('a,'a, 'b) t = T of 'a -> 'a
end
