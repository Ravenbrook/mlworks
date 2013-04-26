(*

Result: OK
 
$Log: profile1.sml,v $
Revision 1.2  1995/08/21 14:40:41  nickb
Update to new profiler.

Revision 1.1  1993/06/22  16:02:19  jont
Initial revision

Revision 1.1  1993/06/22  15:34:33  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

(* test that profiling does not interfere with regular results *)

local
  val manner = MLWorks.Profile.make_manner
    {time = true,
     space = false,
     calls = false,
     copies = false,
     depth = 2,
     breakdown = []}
  fun selector _ = manner

  val options = MLWorks.Profile.Options {scan = 10, selector = selector}
    
  fun fib 0 = 1
    | fib 1 = 1
      | fib n = (fib (n-1)) + (fib (n-2))
  val (result,profile) = MLWorks.Profile.profile options fib 35
in
  val it = case result of
    MLWorks.Profile.Result 14930352 =>
      "Profiling does not interfere with computation of fib 35"
  | _ => 
      "Profiling interferes with computation of fib 35"
end
