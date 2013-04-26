(*

Result: OK
 
$Log: inline.sml,v $
Revision 1.2  1993/01/21 12:02:59  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun list_eq([], []) = true
  | list_eq(x :: xs, y :: ys) = x = y andalso list_eq(xs, ys)
  | list_eq _ = false
