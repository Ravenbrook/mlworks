(*
 *
 * Result: OK
 *
 * $Log: match1.sml,v $
 * Revision 1.2  1997/11/21 10:52:42  daveb
 * [Bug #30323]
 *
 *  Revision 1.1  1997/04/14  13:34:14  jont
 *  new unit
 *  Test for bug 2048
 *
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

datatype other = GLOBAL of int | SPECIAL of int | LOCAL

fun cmp(LOCAL, LOCAL) = EQUAL
  | cmp(LOCAL, _) = LESS
  | cmp(_, LOCAL) = GREATER
  | cmp(GLOBAL pid1, GLOBAL pid2) = Int.compare(pid1, pid2)
  | cmp(GLOBAL _, _) = GREATER
  | cmp(_, GLOBAL _) = LESS
  | cmp(SPECIAL s1, SPECIAL s2) = Int.compare(s1, s2)

fun cmp1(LOCAL,LOCAL) = EQUAL
  | cmp1(LOCAL,_) = LESS
  | cmp1(GLOBAL m,GLOBAL n) = Int.compare (m,n)
  | cmp1(GLOBAL _,_) = GREATER
  | cmp1(SPECIAL m, SPECIAL n) = Int.compare (m,n)
  | cmp1(SPECIAL _,LOCAL) = GREATER
  | cmp1(SPECIAL _,GLOBAL _) = LESS;
