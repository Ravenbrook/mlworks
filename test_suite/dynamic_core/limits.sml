(* Check machine limits on ints and words
 *
 * Result: OK
 *
 * $Log: limits.sml,v $
 * Revision 1.1  1995/08/15 11:54:23  jont
 * new unit
 *
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *)

val a = 0x1fffffff
val b = 536870911
val c = ~0x20000000
val d = ~536870912
val e = 0wx3fffffff
val f = 0w1073741823
