(* Tests for shifts

Result: OK
 
$Log: shifts.sml,v $
Revision 1.2  1996/05/20 10:10:38  jont
Bits moved to MLWorks.Internal

 * Revision 1.1  1995/07/11  13:43:57  jont
 * new unit
 * No reason given
 *

Copyright (c) 1995 Harlequin Ltd.
*)

(* Start with shifts by constants *)

local

  val two_to_28 = MLWorks.Internal.Bits.lshift(1, 28)
  val maxint = two_to_28 + (two_to_28-1)
  val minint = ~maxint - 1

  fun a x = MLWorks.Internal.Bits.lshift(x, 1)
  fun b x = MLWorks.Internal.Bits.lshift(x, 2)
  fun c x = MLWorks.Internal.Bits.lshift(x, 3)
  fun d x = MLWorks.Internal.Bits.lshift(x, 4)
  fun e x = MLWorks.Internal.Bits.lshift(x, 5)
  fun f x = MLWorks.Internal.Bits.lshift(x, 6)
  fun g x = MLWorks.Internal.Bits.lshift(x, 29)
  fun h x = MLWorks.Internal.Bits.lshift(x, 30)

in
  val ok1 = a 1 = 2 andalso b 1 = 4 andalso c 1 = 8 andalso d 1 = 16 andalso e 1 = 32 andalso f 1 = 64 andalso a ~1 = ~2 andalso b ~1 = ~4 andalso c ~1 = ~8 andalso d ~1 = ~16 andalso e ~1 = ~32 andalso f ~1 = ~64 andalso g 1 = minint andalso g ~1 = minint andalso h 1 = 0 andalso h ~1 = 0

  local
    fun a x = MLWorks.Internal.Bits.rshift(x, 1)
    fun b x = MLWorks.Internal.Bits.rshift(x, 2)
    fun g x = MLWorks.Internal.Bits.rshift(x, 29)
    fun h x = MLWorks.Internal.Bits.rshift(x, 30)
  in
    val ok2 = a 1 = 0 andalso a ~1 = maxint andalso a 2 = 1 andalso a ~2 = maxint andalso a ~3 = maxint-1
    val ok3 = b 1 = 0 andalso b 2 = 0 andalso b 3 = 0 andalso b 4 = 1 andalso b ~1 = two_to_28-1
    val ok3 = ok3 andalso g maxint = 0 andalso g ~1 = 1 andalso h maxint = 0 andalso h minint = 0
  end

  local
    fun a x = MLWorks.Internal.Bits.arshift(x, 1)
    fun b x = MLWorks.Internal.Bits.arshift(x, 2)
    fun g x = MLWorks.Internal.Bits.arshift(x, 29)
    fun h x = MLWorks.Internal.Bits.arshift(x, 30)
    fun i x = MLWorks.Internal.Bits.arshift(x, 32)
  in
    val ok4 = a 1 = 0 andalso a 2 = 1 andalso a 3 = 1 andalso a 4 = 2 andalso a ~1 = ~1 andalso a ~2 = ~1 andalso a ~3 = ~2 andalso a ~4 = ~2

    val ok5 = b 1 = 0 andalso b ~1 = ~1 andalso b 2 = 0 andalso b ~2 = ~1 andalso b 4 = 1 andalso b ~3 = ~ 1 andalso b ~4 = ~1 andalso b ~5 = ~2

    val ok6 = g maxint = 0 andalso g minint = ~1
    val ok7 = h maxint = 0 andalso h minint = ~1
    val ok8 = i maxint = 0 andalso i minint = ~1
  end

  local
    fun l(x, y) = MLWorks.Internal.Bits.lshift(x, y)
    fun r(x, y) = MLWorks.Internal.Bits.rshift(x, y)
    fun ar(x, y) = MLWorks.Internal.Bits.arshift(x, y)
  in
    val ok9 = l(1, l(1, 2)) = 16 andalso r(16, l(1, 2)) = 1 andalso r(~1, l(1, 2)) = l(1, 26) - 1
    val ok10 = l(l(1, 2), l(1, 2)) = l(1, 6) andalso r(l(1, 4), l(1, 2)) = 1
    val ok11 = ar(~1, l(1, 2)) = ~1 andalso ar(16, l(1, 2)) = 1
  end
end
