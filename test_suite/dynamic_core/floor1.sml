(*
 *
 * Result: OK
 *
 * $Log: floor1.sml,v $
 * Revision 1.1  1998/02/12 15:06:06  jont
 * new unit
 * Test for 70022
 *
 * Copyright (c) 1997 Harlequin Group plc
 *
 * Test for bug 70022
 *
 *)

val a = 16807.0;
val m = 2147483647.0;
fun nextrand seed =
  let
    val t = a*seed
    val res = t - m * real(floor(t/m))
  in
    res
  end;
fun myfloor x =
  floor x handle OverFlow => myfloor(x/2.0)
fun randlist(n, seed, tail) =
  if n = 0 then
    tail
  else
    let
      val x = myfloor seed
    in
      randlist(n-1, nextrand seed, x :: tail)
    end
val sort_list = randlist(100,1.0, [])
