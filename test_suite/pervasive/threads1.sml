(*
Result: OK
 
$Log: threads1.sml,v $
Revision 1.2  1997/01/29 10:22:34  andreww
[Bug #1900]
Have to kill all sleeping threads before terminating

 *  Revision 1.1  1996/10/21  16:21:10  andreww
 *  new unit
 *  [bug 1666]
 *

Copyright (c) 1996 Harlequin Ltd.

Checks that Threads exception is actually raised.
*)


let
  fun f 0 = () | f n = (print "."; f (n-1))
  val t = MLWorks.Threads.fork f 100
  val ans = 
    let
      val _ = MLWorks.Threads.sleep t
      val _ = MLWorks.Threads.sleep t
    in
      5
    end
  handle MLWorks.Threads.Threads _ =>
    (MLWorks.Threads.Internal.kill t; 6);
in
ans
end
