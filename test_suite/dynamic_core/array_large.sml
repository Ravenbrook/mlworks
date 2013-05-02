(*
 *
 * Tests large arrays and some real arithmetic.
 *
 *
 * Result: OK
 *
 * $Log: array_large.sml,v $
 * Revision 1.7  1997/11/21 10:52:01  daveb
 * [Bug #30323]
 *
 * Revision 1.6  1997/05/28  11:35:54  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.5  1996/05/31  11:40:51  jont
 * cos and sin have moved into basis/__math
 *
 * Revision 1.4  1996/05/08  11:19:13  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.3  1996/05/01  16:51:35  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1995/07/13  15:21:48  jont
 * Modify to avoid slight result inaccuracies
 *
 * Revision 1.1  1995/03/07  16:16:39  nickb
 * new unit
 * No reason given
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


local
  val pi = 3.141592653589793;

  fun integrate (f,start,finish,num_steps) =
    let
      val r_num_steps = real num_steps
      val range = finish - start
      val step = range / r_num_steps
      val values = MLWorks.Internal.Array.array (num_steps+1,0.0)
      fun fill_values n =
	if n > num_steps then ()
	else 
	  let
	    val x = (real n / r_num_steps) * range
	  in
	    (MLWorks.Internal.Array.update (values,n,f x);
	     fill_values (n+1))
	  end
      val _ = fill_values 0
      fun do_sum (n,acc) =
	if n = num_steps then acc
	else 
	  do_sum (n+1,acc + (step * ((MLWorks.Internal.Array.sub (values,n) + MLWorks.Internal.Array.sub (values,n+1)) / 2.0)))
    in
      do_sum (0,0.0)
    end
  
  val limit = 1000000
  val res1 = integrate (fn x => x, 0.0,1.0,limit)
  val ans1 = 0.5
  val res2 = integrate (fn x => x * x, 0.0,10.0,limit)
  val ans2 = 1000.0/3.0
  val res3 = integrate (Math.cos, 0.0,pi/2.0,limit)
  val ans3 = 1.0
  val res4 = integrate (Math.sin, 0.0,pi/2.0,limit)
  val ans4 = 1.0
  val results = [(res1,ans1),(res2,ans2),(res3,ans3),(res4,ans4)]
  val tolerance = 1E~10
  fun close_to(a,b) = abs((a-b)/a) < tolerance
  fun all [] = true
    | all (x::xs) = x andalso (all xs)
  val maps = map close_to results
  val string = if (all maps) then "Pass\n" else "Fail\n"
in
  val _ = print string
end
