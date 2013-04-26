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

Copyright (c) 1997 Harlequin Ltd.

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