(*  ==== BASIS EXAMPLES : Normal structure ====
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
 *  This module calculates probabilities in a normal distribution.  It
 *  illustrates the use of the Math structure in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: __normal.sml,v $
 *  Revision 1.4  1997/04/02 14:33:07  jkbrook
 *  [Bug #2008]
 *  Replace reference to Real.equal with (synonymous) Real.==
 *
 *  Revision 1.3  1996/11/26  10:48:51  jont
 *  [Bug #1805]
 *  Real no longer an eq type
 *
 *  Revision 1.2  1996/09/04  11:54:06  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/06  10:54:43  davids
 *  new unit
 *
 *
 *)


require "normal";
require "__quadrature";
require "$.basis.__math";
require "$.basis.__real";

structure Normal : NORMAL =
  struct

    (* This is the probability density function for the normal distribution. *)

    val realEq = Real.==
    infix realEq
    fun normal variance mean =
      let
	val sigma = Math.sqrt variance
      in
	fn x => Math.exp (~ (Math.pow ((x - mean) / sigma, 2.0) / 2.0))
	        / (sigma * Math.sqrt (2.0 * Math.pi))
      end


    (* This will provide reasonable accuracy for the calculations. *)
    val accuracy = SOME 0.0001

    
    (* Calculate the probability of lying between 'left' and 'right' in a
     normal distribution with parameters 'mean' and 'variance'.  Infinities
     are coped with by utilising the symmetry of the normal distribution
     curve. *)

    fun prob (mean, variance, left, right) =
      let
	val f = normal variance mean
      in

	if left >= right then
	  0.0
	else

	  if left realEq Real.negInf andalso right realEq Real.posInf then
	    1.0
	  else

	    if left realEq Real.negInf then
	      0.5 + Quadrature.integrate (f, mean, right, accuracy)
	    else

	      if right realEq Real.posInf then
		0.5 + Quadrature.integrate (f, left, mean, accuracy)
	      else

		Quadrature.integrate (f, left, right, accuracy)
      end

  end
