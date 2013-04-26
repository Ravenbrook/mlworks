(*
 * Result: OK
 * 
 * $Log: profile_sel.sml,v $
 * Revision 1.1  1996/11/28 15:55:48  nickb
 * new unit
 * Addresses MLWorks bug 1808.
 *
 * 
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

(* MLWorks bug 1808: if selector functions allocate at all, there
 * could be a fatal failure in the profiler. If they allocate
 * much, and cause a GC, there could be a different fatal failure in the
 * profiler.
 *)

local
  val lr : int list ref = ref []
  fun mklist (0,l) = lr := l
    | mklist (n,l) = mklist(n-1,n::l)
  val manner = MLWorks.Profile.make_manner {time = false,
					    space = true,
			                    calls = false,
					    copies = false,
					    depth = 0,
					    breakdown = []};
  fun selector _ = (mklist(10,[]);
		    manner)
  val options = MLWorks.Profile.Options {scan = 0, selector = selector}
  val (result, profile) = MLWorks.Profile.profile options (fn () => ()) ()
in
  val result = "Success"
end
