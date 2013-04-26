(*
Result: OK
 
$Log: threads3.sml,v $
Revision 1.3  1997/05/28 12:21:52  jont
[Bug #30090]
Remove uses of MLWorks.IO

 *  Revision 1.2  1997/04/02  10:37:09  andreww
 *  making test non SunOS-specific
 *
 *  Revision 1.1  1997/04/01  11:16:55  andreww
 *  new unit
 *  [Bug #1895]
 *  new test.
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.

Checks that kill actually kills the required thread.
*)

local
  fun failed () = print"test failed.\n"
  val failThread = MLWorks.Threads.fork failed ();
in
  val _ = MLWorks.Threads.Internal.kill failThread;
  val _ = print"test succeeded.\n"
end;
(* this last message won't be printed if the current thread is killed. *)