(* This tests that the TextIO.inputLine function correctly adds newlines.
 *
 *

Result: OK

 * $Log: text_io_3.sml,v $
 * Revision 1.4  1997/11/21 10:49:54  daveb
 * [Bug #30323]
 *
 *  Revision 1.3  1997/04/01  16:49:33  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.2  1996/11/16  02:05:47  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.1  1996/10/07  10:21:17  andreww
 *  new unit
 *  tests that TextIO.inputLine adds newline chars after every nonempty
 *  lien.
 *
 *
 * Copyright (c) 1996 Harlequin Ltd.
 *
 *)


local
  open General
  open TextIO
in


  fun reportOK true = "test succeeded."
    | reportOK false = "test failed."


  val _ = let val out = openOut "123"
              val _ = output(out,"123\n456")
           in
              closeOut out
          end

  val inp = openIn "123"
             
  val test1 = reportOK(inputLine inp = "123\n")
  val test2 = reportOK(inputLine inp = "456\n")
  val test3 = reportOK(inputLine inp = "")
   
  val _ = closeIn inp

  val _ = OS.FileSys.remove "123" handle _ => () (*remove it*)

end



