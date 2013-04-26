(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  OK

$Log: exception9.sml,v $
Revision 1.1  1993/12/17 15:37:30  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

exception E of int
exception F = E

fun myfun (E _) = 3
  | myfun _ = 4

val x = myfun (F 3);
  
(* should be caught by the first pattern branch *)
