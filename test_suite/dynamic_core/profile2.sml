(*

Result: OK
 
$Log: profile2.sml,v $
Revision 1.5  1996/11/01 11:39:53  io
[Bug #1614]
remove toplevel String.

 * Revision 1.4  1996/05/01  17:17:28  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.3  1995/08/21  15:20:12  nickb
 * Fix bogus string.
 *
Revision 1.2  1995/08/21  15:09:42  nickb
Update to new profiler.

Revision 1.1  1993/06/22  16:03:50  jont
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

(* test that results of time-profiling 'fib' are reasonable *)

local
  val manner = MLWorks.Profile.make_manner
    {time = true,
     space = false,
     calls = false,
     copies = false,
     depth = 0,
     breakdown = []}
  val null_manner = MLWorks.Profile.make_manner
    {time = false,
     space = false,
     calls = false,
     copies = false,
     depth = 0,
     breakdown = []}

  fun is_fib s =
    MLWorks.String.ordof (s,0) = ord #"f"
    andalso MLWorks.String.ordof (s,1) = ord #"i"
    andalso MLWorks.String.ordof (s,2) = ord #"b"
    
  fun selector s = if is_fib s then manner else null_manner

  val options = MLWorks.Profile.Options {scan = 10, selector = selector}

  fun get_scans (MLWorks.Profile.Function_Time_Profile {scans,...}) = scans

  fun matching_scans pred (total,
			   MLWorks.Profile.Function_Profile {id, time,...}) =
    if pred id then total + (get_scans time) else total

  fun fold f z [] = z
    | fold f z (x::xs) = fold f (f(z,x)) xs

  local
    fun length' (a,[]) = a | length' (a,x::xs) = length'(a+1,xs)
  in
    fun length l = length'(0,l)
  end

  fun fib 0 = 1
    | fib 1 = 1
    | fib n = (fib (n-1)) + (fib (n-2))

  val (result,profile) = MLWorks.Profile.profile options fib 35

  val MLWorks.Profile.Profile {time = MLWorks.Profile.Time time_header,
			       functions,...} = profile
  val {scans = total_scans,...} = time_header
  val fib_scans = fold (matching_scans is_fib) 0 functions
 in
   val it =
     if fib_scans < 0 then
       "Nonsense profiling result for fib 35 : fib_scans < 0"
     else if total_scans < 0 then
       "Nonsense profiling result for fib 35 : total_scans < 0"
     else if fib_scans > total_scans then
       "Nonsense profiling result for fib 35 : fib_scans > total_scans"
     else if length functions > 10 then
       "Unexpected profiling result for fib 35 : more than 10 'fib...' fns"
      else if total_scans < 100 (* 1 second, in theory *) then 
       "Unexpected profiling result for fib 35 : fewer than 100 scans"
     else if fib_scans < floor ((real total_scans) * 0.8) then
       "Unexpected result for fib 35 : less than 80% time spent in 'fib...'"
     else "Profiling fib 35 has a reasonable result"
end
