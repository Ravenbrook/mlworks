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
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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



