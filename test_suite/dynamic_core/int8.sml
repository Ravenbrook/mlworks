(*

Result: OK
 
$Log: int8.sml,v $
Revision 1.1  1996/02/09 16:25:05  jont
new unit


Copyright (c) 1996 Harlequin Ltd.
*)

val a : MLWorks.Internal.Types.int8 = 12
val b = a mod 5
val c = a div 5
val d = a mod ~5
val e = a div ~5
val f = 0 - a
val g = f mod 5
val h = f div 5
val i = f mod ~5
val j = f div ~5

(* First some addition/subtraction tests, with overflow handling *)
val aa : MLWorks.Internal.Types.int8 = 12
val ab = aa + 7
val ac = ab + ~4
val ad = aa - 3
val ae = ad - ~5
val af : MLWorks.Internal.Types.int8 = 64
val ag = af + af handle Overflow => 3
val ah = ~af
val ai = ah + ah
val aj = ai - 1 handle Overflow => 1
val ak = ai + ~1 handle Overflow => 5
val al = af - ah handle Overflow => 7

(* Now some multiplication overflow tests *)
val am = af * af handle Overflow => 11
val an : MLWorks.Internal.Types.int8 = 8
val ao = an*2
val ap = an * ao handle Overflow => 13
val aq = an * ~ao
val ar = ao * ~ao handle Overflow => 15

(* Now some division overflow tests *)
val ss = an div 0 handle Div => 17
val at = aq div 1
val au = aq div ~1 handle Overflow => 19
val aw = aq div ~3

(* Now some mod overflow tests *)
val ax = aq mod 0 handle Mod => 23

(* Now some abs and ~ overflow tests *)
val ay = abs aq handle Overflow => 29
val az = ~aq handle Overflow => 31
