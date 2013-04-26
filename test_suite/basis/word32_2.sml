(* tests that Word32.fromInt sign-extends properly.
 *
 * Result: OK
 *
 *
 * Revision Log
 * ------------
 * $Log: word32_2.sml,v $
 * Revision 1.2  1997/11/21 10:51:10  daveb
 * [Bug #30323]
 *
 *  Revision 1.1  1997/04/15  14:05:36  andreww
 *  new unit
 *  [Bug #2044]
 *  test
 *
 *
 * Copyright (C) 1997 Harlequin Ltd.
 *)




if Word32.>>(Word32.fromInt(~1),0w30) = 0w0 then "test failed"
else "test succeeded"
