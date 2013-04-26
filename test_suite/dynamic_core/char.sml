(*

Result: OK
 
$Log: char.sml,v $
Revision 1.3  1997/11/21 10:52:06  daveb
[Bug #30323]

 * Revision 1.2  1996/05/31  11:56:03  jont
 * Char is no longer in MLWorks. Use Char in revised basis
 *
 * Revision 1.1  1995/07/19  14:08:10  jont
 * new unit
 * No reason given
 *

Copyright (c) 1995 Harlequin Ltd.
*)


val x = #"a"
val y = #"\000"
val z = #"\t"
val a = #"\009"

val b = Char.ord a
val c = Char.chr 9
val d = Char.chr 97

val #"a" = #"a"

fun f #"a" = 1
  | f #"b" = 2
  | f _ = 3

val e = f #"a"

val g = f #"\000"
