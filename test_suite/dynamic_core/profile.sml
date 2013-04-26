(*

Result: OK
 
$Log: profile.sml,v $
Revision 1.2  1995/08/21 14:32:27  nickb
Update to new profiler.

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

(* test exception behaviour inside profiler *)

local
  val manner = MLWorks.Profile.make_manner
    {time = true,
     space = false,
     calls = false,
     copies = false,
     depth = 2,
     breakdown = []}
  fun selector _ = manner

  val options = MLWorks.Profile.Options {scan = 3, selector = selector}
    
  exception Profile_Test

  fun fromList [] = []
    | fromList _ = raise Profile_Test
  fun mkList 0 = []
    |   mkList n = n :: mkList (n-1);
  fun give_result (MLWorks.Profile.Result r) = r
    | give_result (MLWorks.Profile.Exception e) = raise e
  val (result,profile) = MLWorks.Profile.profile options fromList (mkList 42)
  val my_list = give_result result handle Profile_Test => [42]
in
  val it = case my_list of
    [42] => "Profiling handles exceptions OK."
  | _ => "Profiling doesn't handle exceptions well."
end

