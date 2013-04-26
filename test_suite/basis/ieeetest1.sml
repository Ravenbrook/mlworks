(*  ==== Testing ====
 *  this tests that the IEEEReal rounding modes can be set and read
 *  Copyright (C) 1997 The Harlequin Group Ltd.
 *
    Result: OK
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: ieeetest1.sml,v $
 *  Revision 1.2  1997/11/21 10:44:03  daveb
 *  [Bug #30323]
 *
 *  Revision 1.1  1997/04/11  13:16:41  jont
 *  new unit
 *  Test for set/get rounding mode
 *
 *
 *)


local
  fun test_mode(mode) =
    let
      val _ = IEEEReal.setRoundingMode mode;
    in
      mode = IEEEReal.getRoundingMode()
    end

  fun check s func arg =
    if func arg then
      s ^ ": OK"
    else
    s ^ ": Wrong"

  val test = check "Rounding mode" test_mode
in
  val t1 = test IEEEReal.TO_NEAREST;
  val t2 = test IEEEReal.TO_ZERO;
  val t3 = test IEEEReal.TO_NEGINF;
  val t4 = test IEEEReal.TO_POSINF;
end
