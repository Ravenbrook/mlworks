(*  Test to show that closeIn and closeOut close system resources
 *  on terminated and truncated streams.

Result: OK

 * $Log: stream_io_2.sml,v $
 * Revision 1.6  1998/02/18 11:56:01  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.5  1997/11/21  10:48:55  daveb
 *  [Bug #30323]
 *
 *  Revision 1.4  1997/04/01  16:46:29  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1997/03/26  17:00:26  jont
 *  [Bug #0]
 *  Revise so stream chunkSize (which is system dependent) doesn't get into the answer
 *
 *  Revision 1.2  1996/09/25  09:45:36  andreww
 *  When we moved our test suite to run on Solaris rather than on SunOS
 *  it meant that the various "test succeeded" messages were being
 *  printed out at different places on the output file on different
 *  machines.  Therefore this change is simply not to print out the
 *  message, just to pass the "test succeeded" message as a string.
 *
 *  Revision 1.1  1996/08/23  09:20:26  andreww
 *  new unit
 *  [Bug #1566]
 *  Tests that streamIO close actually closes the primitive IO device
 *  associated with terminated or truncated streams.
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


fun reportOK true = "test succeeded."
  | reportOK false = "test failed.";

        (* check that output devices connected to terminated streams
         * are closed
         *)

local
  val file = TextIO.openOut "foo";
  val _ = TextIO.outputSubstr (file, Substring.all "abc");
  val stream = TextIO.getOutstream file;
  val (write, close) = case TextIO.StreamIO.getWriter stream of
    (TextPrimIO.WR {writeVec= SOME write, close, ...}, _) => (write, close)
  | _ => raise Match
  val _ = TextIO.StreamIO.closeOut stream;
in
  val ans1 = reportOK((ignore(write {buf= "def", i=0, sz=NONE}); 
		      close(); false) handle OS.SysErr _ => true);
end

local
  (* check that input devices connected to truncated streams
   * are closed.
   *)

  val file = TextIO.openIn "foo";
  val (read, close) = case TextIO.StreamIO.getReader(TextIO.getInstream file) of
    (TextPrimIO.RD{readVec=SOME read, close,...},_) => (read, close)
  | _ => raise Match
  val _ = TextIO.closeIn file;
in
  val ans2 = reportOK((ignore(read 1); close(); false) handle OS.SysErr _ => true);
end

        (* now remove the file "foo" *)

val _ = OS.FileSys.remove "foo";
