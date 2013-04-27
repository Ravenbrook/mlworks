(* Test for Windows.execute and Windows.simpleExecute
 *
 * Result: OK
 *
 * $Log: execute.sml,v $
 * Revision 1.2  1999/03/19 10:52:20  daveb
 * Automatic checkin:
 * changed attribute _comment to ''
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

let
  val _ = print "calling simpleExecute\n";
  val _ = Windows.simpleExecute ("basis\\win32\\execute", []);
  val _ = print "calling execute\n";
  val p = Windows.execute ("basis\\win32\\execute", [])
  val _ = print "finding streams\n";
  val ins = Windows.textInstreamOf p;
  val outs = Windows.textOutstreamOf p;
in
  print "testing stdOut\n";
  print (TextIO.inputLine ins);
  print "testing stdIn\n";
  TextIO.output (outs, "Test input\n");
  print (TextIO.inputLine ins);
  Windows.fromStatus (Windows.reap p) = 0w78
end
