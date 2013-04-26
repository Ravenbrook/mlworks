(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  WARNING

$Log: exception10.sml,v $
Revision 1.1  1993/12/17 15:45:37  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

exception E of int
exception F = E

fun myfun (E _) = 3
  | myfun (F 4) = 4 (* should warn that this is redundant *)
  | myfun _ = 5

val x = myfun (F 3); (* 3 *)
val y = myfun (F 4); (* 3 *)
val z = myfun (E 4); (* 3 *)
val w = myfun (E 3); (* 3 *)
val v = myfun (Div); (* 5 *)

  
