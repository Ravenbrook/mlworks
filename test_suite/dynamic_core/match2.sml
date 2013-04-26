(*
 *
 * Result: OK
 *
 * $Log: match2.sml,v $
 * Revision 1.2  1997/11/21 10:52:47  daveb
 * [Bug #30323]
 *
 *  Revision 1.1  1997/04/14  13:45:51  jont
 *  new unit
 *  Test for bug 2048
 *
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

datatype other = GLOBAL | SPECIAL | LOCAL of int

fun cmp(LOCAL m, LOCAL n) = Int.compare(m, n)
  | cmp(LOCAL _, _) = LESS
  | cmp(_, LOCAL _) = GREATER
  | cmp(GLOBAL, GLOBAL) = EQUAL
  | cmp(GLOBAL, _) = GREATER
  | cmp(_, GLOBAL) = LESS
  | cmp(SPECIAL, SPECIAL) = EQUAL

fun cmp1(LOCAL m, LOCAL n) = Int.compare(m, n)
  | cmp1(LOCAL _, _) = LESS
  | cmp1(GLOBAL, GLOBAL) = EQUAL
  | cmp1(GLOBAL, _) = GREATER
  | cmp1(SPECIAL, SPECIAL) = EQUAL
  | cmp1(SPECIAL, LOCAL _) = GREATER
  | cmp1(SPECIAL, GLOBAL) = LESS;
