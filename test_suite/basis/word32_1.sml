(* Tests that toInt doesn't lose precision.
 *
 * Result: OK
 *
 * Revision Log
 * ------------
 * $Log: word32_1.sml,v $
 * Revision 1.2  1997/11/21 10:51:06  daveb
 * [Bug #30323]
 *
 *  Revision 1.1  1997/04/15  13:43:48  andreww
 *  new unit
 *  [Bug #2043]
 *  test.
 *
 *
 * Copyright (C) 1997 Harlequin Ltd.
 *)

let
  val _ = Word32.toIntX(Word32.fromInt(valOf Int.minInt))
in
 "test succeeded"
end
 handle Overflow => "test failed"
