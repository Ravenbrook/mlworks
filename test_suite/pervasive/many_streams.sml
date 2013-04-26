(*
Result: OK
 
$Log: many_streams.sml,v $
Revision 1.4  1998/03/26 15:22:29  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.3  1997/03/26  10:09:00  jont
 * Choose a filename we can open on Win32 as well as Unix
 *
 * Revision 1.2  1996/05/01  17:24:36  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1994/11/25  11:57:32  nickb
 * new file
 *

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

(*

This is concerned with bug 821, which hung MLWorks in the garbage
collector if collecting generations 0 and 1 when there are no arrays
pointing gen 1 -> gen 0 but there is at least one weakarray pointing
into gen 0, the contents of which have died since the last GC.

This code will trigger the bug, if present (it's now
fixed). Unfortunately the symptom is not an error message or even a
core dump but an infinite loop in the GC.

Nick B, 1994-11-25

*)

(* All streams are kept in a weak array; we need to make and forget a
 * stream (so that the weak array entry becomes 'DEAD'). We use a
 * filename which we should usually be able to read *)

fun discard_stream () = TextIO.closeIn(TextIO.openIn "perl_script");

(* The bug only shows up when collecting generations 0 and 1, so we
need to do a lot of allocation to trigger it. This function allocates
800k of heap and returns a pointer to it. *)

fun makelist () = let fun mkl (0,a) = a
		        | mkl (n,a) = mkl (n-1,n::a)
		  in mkl (100000,[])
		  end

(* Because we want a generation 1 collection fairly soon, we need to
remember most of the allocated data (otherwise nothing gets into gen 1
out of gen 0 and gen 1 fills up very slowly). So this function calls
both the above functions and accumulates the allocated heap. *)

fun body l = (discard_stream ();
	      (makelist ())::l);

(* Now we put that function in a loop, so it can be called many times *)

fun loop n f a = let fun loop' (0,acc) = ()
		       | loop' (n,acc) = loop'(n-1,f acc)
		 in loop'(n,a)
		 end

(* This call should cause the bug if present (it should take about
11-12 seconds on abel, if the bug does not bite). *)

val _ = loop 30 body [];
