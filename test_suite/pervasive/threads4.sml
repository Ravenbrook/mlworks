(*
Result: OK
 
$Log: threads4.sml,v $
Revision 1.3  1997/05/28 12:22:22  jont
[Bug #30090]
Remove uses of MLWorks.IO

 *  Revision 1.2  1997/04/02  10:37:44  andreww
 *  making test non SunOS-specific
 *
 *  Revision 1.1  1997/04/01  13:27:15  andreww
 *  new unit
 *  [Bug #1894]
 *  test.
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.

Checks that we can raise an exception in another thread.
*)

exception DontFail;
val hasFailed = ref false;

local
  fun failed () = hasFailed:=true;
  val failThread = MLWorks.Threads.fork failed ();
in
  val _ = MLWorks.Threads.Internal.raise_in (failThread,DontFail);
  val _ = MLWorks.Threads.Internal.yield_to failThread;
  val _ = print(if !hasFailed then "test failed\n"else "test succeeded\n")
end;