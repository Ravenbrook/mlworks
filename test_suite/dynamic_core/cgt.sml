(*
Test for a computed goto bug

Result: OK

$Log: cgt.sml,v $
Revision 1.1  1996/09/24 10:31:56  matthew
new unit
New test


Copyright (c) 1994 Harlequin Ltd.
*)

datatype tag = A | B | C | D;
fun mergeTags C _ = C
  | mergeTags _ C = C
  | mergeTags A _ = A
  | mergeTags _ A = A
  | mergeTags B B = B
  | mergeTags D B = D
  | mergeTags D tag = tag;
