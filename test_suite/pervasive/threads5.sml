(*
Result: OK
 
$Log: threads5.sml,v $
Revision 1.3  1997/05/28 12:22:43  jont
[Bug #30090]
Remove uses of MLWorks.IO

 *  Revision 1.2  1997/04/02  10:38:08  andreww
 *  making test non SunOS-specific
 *
 *  Revision 1.1  1997/04/01  13:54:44  andreww
 *  new unit
 *  [Bug #1896]
 *  new test.
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.

Checks that we can kill sleeping processes without screwing up our
count of the number of runnable threads.
*)


local
  fun heyBibble i:unit = heyBibble (i+1);
  val bibbleThread = MLWorks.Threads.fork heyBibble 0;
in
  val _ = MLWorks.Threads.sleep bibbleThread;
  val _ = MLWorks.Threads.Internal.kill bibbleThread;
  val _ = print"test succeeded\n"
  (* won't get this far if crashed *)
end;