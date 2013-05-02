(*  ==== INITIAL BASIS : Math structure ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __math.sml,v $
 *  Revision 1.12  1999/02/02 15:57:46  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.11  1997/10/21  10:52:49  daveb
 *  [Bug #70011]
 *  Added checks for odd integer values in definition of pow.
 *
 *  Revision 1.10  1997/09/25  10:55:52  jont
 *  [Bug #70011]
 *  Deal more sensibly with 0.0 ** n (n <> 0)
 *
 *  Revision 1.9  1997/06/12  11:58:32  matthew
 *  [Bug #30101]
 *
 *  Revision 1.8  1996/11/18  10:33:11  matthew
 *  Improving real equality (again).
 *
 *  Revision 1.7  1996/11/07  17:12:14  matthew
 *  Correcting bungle in equal
 *
 *  Revision 1.6  1996/11/05  18:42:17  andreww
 *  [Bug #1711]
 *  real no longer equality type in sml'96.
 *
 *  Revision 1.5  1996/05/30  13:50:15  daveb
 *  Math functions are no longer at top level.
 *
 *  Revision 1.4  1996/05/21  13:46:06  matthew
 *  Problems with pow and atan2
 *
 *  Revision 1.3  1996/04/30  15:38:02  matthew
 *  Revisions
 *
 *  Revision 1.2  1996/04/25  09:07:59  jont
 *  Change maths to math
 *
 *  Revision 1.1  1996/04/23  10:23:01  matthew
 *  new unit
 *  Renamed from __maths.sml
 *
 * Revision 1.1  1996/04/18  11:30:34  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  13:24:14  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "math";

structure Math : MATH =
  struct

    type real = real

    (* first, we must make an equality function for the non-eqtype real *)
    val realEq : real * real -> bool = MLWorks.Internal.Value.real_equal

    infix realEq

    val env = MLWorks.Internal.Runtime.environment

    val atan : real -> real = MLWorks.Internal.Value.arctan
    val sqrt : real -> real = MLWorks.Internal.Value.sqrt
    val sin : real -> real = MLWorks.Internal.Value.sin
    val cos : real -> real = MLWorks.Internal.Value.cos
    val exp : real -> real = MLWorks.Internal.Value.exp

    val pi : real = 4.0 * atan 1.0
    val e : real = exp 1.0

    val tan : real -> real =
      fn x => (sin x / cos x)


    val atan2 : real * real -> real =
      fn (x, y) =>
      if x realEq 0.0 then
	if y realEq 0.0 then
	  0.0
	else
	  if y < 0.0 then
	    ~ pi / 2.0
	  else
	    pi / 2.0
      else
	let
	  val at = atan(y/x)
	in
	  if x > 0.0 then
	    at
	  else
	    if y < 0.0 then
	      at - pi
	    else
	      at + pi
	end

    val asin : real -> real =
      fn y =>
      let
        val x = sqrt(1.0 - y*y)
      in
        atan2(x, y)
      end

    val acos : real -> real =
      fn x =>
      let
        val y = sqrt(1.0 - x*x)
      in
        atan2(x, y)
      end


    val cpow : real * real -> real = env "real pow"

    local
      fun odd_integer y =
        let val y_over_2 = y/2.0
        in
          y realEq real (floor y) andalso
          not (y_over_2 realEq real (floor y_over_2))
        end
    in
      (* Need hacks since C doesn't necessarily implement what we want *)
      fun pow (x,y) =
        if y realEq 0.0 then
	  1.0
        else if not (y realEq y) then
	  y (* NaN *)
        else if x realEq 0.0 then
	  if y > 0.0 then
            if odd_integer y then
              (* preserve sign of zero*)
              x
            else
	      0.0
	  else  (* y < 0.0 *)
            if odd_integer y then
              (* copy sign of zero when y is an odd integer *)
	      1.0/x
            else
	      1.0/0.0
        else
	  cpow (x,y)
    end

    val ln : real -> real = env "real ln"
    val log10 : real -> real = fn x => ln x / ln 10.0

    fun sinh x = (exp x - exp (~x)) / 2.0
    fun cosh x = (exp x + exp (~x)) / 2.0
    fun tanh x = sinh x / cosh x

  end
