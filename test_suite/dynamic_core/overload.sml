(*
 *
 * Result: OK
 *
 * $Log: overload.sml,v $
 * Revision 1.1  1995/08/01 15:53:55  jont
 * new unit
 *
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *)

val op- = op+ : int * int -> int;

val x = 1-1;

val op mod = op* : real * real -> real;

val y = 1.0 mod 2.0;
