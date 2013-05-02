(*

Result: OK
 
$Log: profile1.sml,v $
Revision 1.2  1995/08/21 14:40:41  nickb
Update to new profiler.

Revision 1.1  1993/06/22  16:02:19  jont
Initial revision

Revision 1.1  1993/06/22  15:34:33  jont
Initial revision

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
