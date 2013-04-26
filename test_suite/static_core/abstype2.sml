(*
Abstypes don't admit equality.

Result: FAIL
 
$Log: abstype2.sml,v $
Revision 1.2  1993/01/20 11:34:07  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

abstype t = A | B | C
with
  fun equal A A = true
    | equal B B = true
    | equal C C = true
    | equal _ _ = false
  fun make_t 1 = A
    | make_t 2 = B
    | make_t _ = C
end

val eq1 = make_t 1 = make_t 3

val eq2 = A = B
