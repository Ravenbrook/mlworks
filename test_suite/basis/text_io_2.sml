(* This tests that the TextIO.openString function correctly reads the
 * specified string.
 *

Result: OK

 * $Log: text_io_2.sml,v $
 * Revision 1.5  1997/11/21 10:49:46  daveb
 * [Bug #30323]
 *
 *  Revision 1.4  1997/05/28  11:22:29  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.3  1997/04/01  16:47:38  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.2  1996/11/16  02:06:23  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.1  1996/08/05  16:23:21  andreww
 *  new unit
 *  Test for TextIO.openString.
 *
 *
 * Copyright (c) 1996 Harlequin Ltd.
 *
 *)


local
  open General
  open TextIO
in


  fun reportOK true = print"test succeeded.\n"
    | reportOK false = print"test failed.\n"


  val x = openString "Blah"

  val _ = reportOK (SOME #"B" = (input1 x))
  val _ = reportOK (SOME #"l" = (input1 x))
  val _ = reportOK (SOME #"a" = (input1 x))
  val _ = reportOK (SOME #"h" = (input1 x))
  val _ = reportOK (NONE = (input1 x))




end



