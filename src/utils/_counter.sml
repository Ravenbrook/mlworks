(* _counter.sml the functor *)
(*
$Log: _counter.sml,v $
Revision 1.4  1992/01/29 11:12:55  clive
Added code to compute the next value that a counter would take given
its existing value

Revision 1.3  1992/01/28  12:30:58  clive
Added a previous counter function

Revision 1.2  1991/11/21  17:00:29  jont
Added copyright message

Revision 1.1  91/06/07  15:56:28  colin
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
require "counter";

functor Counter (): COUNTER =
    struct
	local 
	    val count = ref 0
	in
	    fun counter () = 
		let val ref x = count
		in
		    (count := (x + 1);
		     x)
		end 

              fun previous_count x =
                (x-1)
                
              fun next_count x =
                (x+1)

	    fun reset_counter n =
	      (count := n;
	       ())

	    fun read_counter () = !count
	      
	end
    end
