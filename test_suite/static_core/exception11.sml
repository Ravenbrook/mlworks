(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  WARNING

$Log: exception11.sml,v $
Revision 1.1  1994/01/24 16:56:06  nosa
Initial revision

Revision 1.1  1994/01/24  16:56:06  nosa
Initial revision



Copyright (c) 1993 Harlequin Ltd.
*)

exception A0 of int;
exception A1 of int;
exception A2 of int;
exception A3 of int;
exception B0 = A3;
exception B1 of int;
exception B2 = A1;
exception B3 = A0;
exception B4 = A3;
exception B5 = A2;
exception B6 of int;
exception B7 = A0;
exception B8 = A3;
exception B9 = A2;
exception B10 = A1;
exception B11 of int;

fun f (A0 1) = 1
|   f (A0 _) = 1
|   f (A1 1) = 2
|   f (A1 _) = 2
|   f (A2 1) = 3
|   f (A2 _) = 3
|   f (A3 1) = 4
|   f (A3 _) = 4
|   f (B0 1) = 5(* redundant *)
|   f (B0 _) = 5(* redundant *)
|   f (B1 1) = 6
|   f (B1 _) = 6
|   f (B2 1) = 7(* redundant *)
|   f (B2 _) = 7(* redundant *)
|   f (B3 1) = 8(* redundant *)
|   f (B3 _) = 8(* redundant *)
|   f (B4 1) = 9(* redundant *)
|   f (B4 _) = 9(* redundant *)
|   f (B5 1) = 10(* redundant *)
|   f (B5 _) = 10(* redundant *)
|   f (B6 1) = 11
|   f (B6 _) = 11
|   f (B7 1) = 12(* redundant *)
|   f (B7 _) = 12(* redundant *)
|   f (B8 1) = 13(* redundant *)
|   f (B8 _) = 13(* redundant *)
|   f (B9 1) = 14(* redundant *)
|   f (B9 _) = 14(* redundant *)
|   f (B10 1) = 15(* redundant *)
|   f (B10 _) = 15(* redundant *)
|   f (B11 1) = 16
|   f _ = 17;
