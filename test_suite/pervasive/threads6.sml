(*
Result: OK
 
$Log: threads6.sml,v $
Revision 1.3  1997/05/28 12:23:04  jont
[Bug #30090]
Remove uses of MLWorks.IO

 *  Revision 1.2  1997/04/02  10:57:50  andreww
 *  making test non SunOS-specific
 *
 *  Revision 1.1  1997/04/01  14:25:17  andreww
 *  new unit
 *  [Bug #1900]
 *  test.
 *
 *
 *

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Checks that we don't run sleeping processes when finished.
*)


(* thread is used to allow the failure thread to sleep the successful
 * thread should it ever be yielded to.  Note that failure has to go
 * before success on the scheduler queue to test that we have skipped
 * it.
 *)

local
  val thread = ref []: MLWorks.Threads.Internal.thread_id list ref

  fun failure () =  (MLWorks.Threads.sleep (hd(!thread));
                    print"test failed\n")

  fun success id =  print"test succeeded\n"

  val failureThread = MLWorks.Threads.fork failure ();
  val successfulThread = MLWorks.Threads.fork success failureThread;
  val _ = thread:=[MLWorks.Threads.Internal.get_id successfulThread];
in
  val _ = MLWorks.Threads.sleep failureThread;
  val _ = MLWorks.Threads.yield();
  val _ = MLWorks.Threads.yield();
  val _ = MLWorks.Threads.Internal.kill failureThread;
end;