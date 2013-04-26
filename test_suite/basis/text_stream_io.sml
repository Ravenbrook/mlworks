(* This tests that the TextIO.inputLine function correctly adds newlines.
 *
 *

Result: OK

 * Revision Log:
 * -------------
 * $Log: text_stream_io.sml,v $
 * Revision 1.3  1997/11/24 11:00:58  daveb
 * [Bug #30323]
 *
 *  Revision 1.2  1997/04/01  16:49:29  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.1  1997/02/27  11:50:43  andreww
 *  new unit
 *  [Bug #1759]
 *  new test.
 *
 *
 *
 * Copyright (c) 1997 Harlequin Ltd.
 *
 *)


local
  open General
in


  fun reportOK true = "test succeeded."
    | reportOK false = "test failed."


  val _ = let val out = TextIO.openOut "123"
              val _ = TextIO.output(out,"123\n456")
           in
              TextIO.closeOut out
          end

  val inp = TextIO.getInstream(TextIO.openIn "123")
             
  val (data,inp') = TextIO.StreamIO.inputLine inp
  val test1 = reportOK(data="123\n")
  val (data,inp'') = TextIO.StreamIO.inputLine inp'
  val test2 = reportOK(data = "456\n")  
  val (data,inp''') = TextIO.StreamIO.inputLine inp''
  val test3 = reportOK(data = "")
   
  val _ = TextIO.StreamIO.closeIn inp

  val _ = OS.FileSys.remove "123" handle _ => () (*remove it*)

end



