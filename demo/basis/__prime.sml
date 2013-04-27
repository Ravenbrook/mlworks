(*  ==== BASIS EXAMPLES : Prime structure ====
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
 *  This module defines a function to test whether a given integer is a prime
 *  number.  It illustrates the use of the LargeInt structure in the basis
 *  library.
 *
 *  Revision Log
 *  ------------
 *  $Log: __prime.sml,v $
 *  Revision 1.4  1997/05/27 13:31:05  jkbrook
 *  [Bug #01749]
 *  Use synonym file __large_int for LargeInt
 *
 *  Revision 1.3  1996/09/04  11:54:36  jont
 *  Make require statements absolute
 *
 *  Revision 1.2  1996/08/12  10:50:15  davids
 *  ** No reason given. **
 *
 *  Revision 1.1  1996/08/09  16:12:45  davids
 *  new unit
 *
 *
 *)


require "prime";
require "$.basis.__large_int";


structure Prime : PRIME =
  struct


    (* Determine whether n is even. *)

    fun even n = LargeInt.rem (n, 2) = 0


    (* Calculate 'm' to the power of 'n', modulo 'modulo'.  The power is
     calculated by repeatedly squaring, multiplying by 'm' whenever the
     power is odd. *)

    fun largePowerMod (m, n, modulo) =
      let

	fun square () =
	  let
	    val next = largePowerMod (m, LargeInt.quot (n, 2), modulo)
	    val sqr = next * next
	  in
	    LargeInt.rem (sqr, modulo)
	  end

      in

	if n = LargeInt.fromInt 0 then
	  LargeInt.fromInt 1
	else

	  if even n then
	    square ()
	  else
	    LargeInt.rem (LargeInt.* (m, square ()), modulo)
      end


    (* Calculate 'm' to the power of 'n', modulo 'modulo'.  Do the
     calculation using LargeInt.int numbers so that as many int values as 
     possible can be used without overflow. *)

    fun powerMod (m, n, modulo) =
      LargeInt.toInt (largePowerMod (LargeInt.fromInt m,
				     LargeInt.fromInt n,
				     LargeInt.fromInt modulo))
		     

    (* Apply Fermat's theorem to the first 'k' integers.  If it fails for any
     test, 'q' is composite.  However, 'k' successful tests do not guarantee
     that q is prime, but if 'k' is not too small then it is extremely likely
     to be correct. *)

    fun fermat (q, 0) = true
      | fermat (q, k) =	
        if powerMod (k, q - 1, q) = 1
          then fermat (q, k - 1)
        else 
	  false


    (* Test whether or not 'q' is a prime number.  Define any numbers <= 1 as
     not prime. *)

    fun testPrime (q, k) =
      if q <= 1 then 
	false
      else
	if k >= q then
	  fermat (q, q - 1)
	else
	  fermat (q, k)
  end
      
