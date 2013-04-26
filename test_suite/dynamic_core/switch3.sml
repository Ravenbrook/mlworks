(*
Some cases that have broken the switch translation: 3 and 3a

Result: OK

$Log: switch3.sml,v $
Revision 1.2  1993/01/21 12:05:09  daveb
Updated header.

Revision 1.1  1992/11/04  17:11:54  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


(* Case 3:
   2 VCCs and 2 IMMs.
   Need VCC in switch.  Extra one doesn't affect things.
   Need 0 IMMs in switch.
*)

datatype Action =
      Shift
    | Reduce of int * int * int
    | Funcall of int * int * Action * Action
    | NoAction

fun convert_action a =
  if a = ~1 then
    NoAction
  else
    Reduce (2,3,4)

fun is_reduction n =
  case (convert_action n) of
    Reduce _ => true
  | _ => false

fun f _ = is_reduction 3 


(* Case 3a:
   2 VCCs and 2 IMMs.
   Need IMM in switch.  Extra one doesn't affect things.
   Need 0 VCCs in switch.
*)

datatype Action =
      Shift
    | Reduce of int * int * int
    | Funcall of int * int * Action * Action
    | NoAction

fun convert_action a =
  if a = ~1 then
    NoAction
  else
    Reduce (2,3,4)

fun is_reduction n =
  case (convert_action n) of
    Shift => true
  | _ => false

fun f _ = is_reduction 3 

