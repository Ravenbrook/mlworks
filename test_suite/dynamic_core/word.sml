(*
 *
 * Result: OK
 *
 * $Log: word.sml,v $
 * Revision 1.3  1995/09/19 14:19:38  daveb
 * Removed conversion functions.
 *
 * Revision 1.2  1995/07/31  12:48:01  jont
 * Add mod and div tests
 *
 * Revision 1.1  1995/07/27  13:21:09  jont
 * new unit
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *)

val x = 0w0
val y = 0w9
val z = 0w16
val a = 0wx10

val 0w0 = x
val 0wx0 = x

fun f 0w0 = 1
  | f 0w2 = 2
  | f 0wx10 = 4
  | f _ = 3

val e = f 0w16

val g = f 0wx11

val h = (x + y) * z - a

val i = z div y

val j = z mod y
