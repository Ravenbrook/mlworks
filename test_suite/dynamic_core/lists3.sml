(*
This uncovered a bug in our tail recursion code when we optimised
the representation of lists.

Result: OK

$Log: lists3.sml,v $
Revision 1.2  1993/01/22 16:28:34  daveb
Fixed unclosed comment and unresolved overloading.

Revision 1.1  1993/01/21  14:00:05  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

(* The problem here was that (n::l) and (n,l) have the same representation. *)

let
  fun max (m, []) = m: int
    | max (m, n::l) =
    if m > n then
      max (m, l)
    else
      max (n, l)
in
  max (0, [1,5,8,2,10,0])
end
