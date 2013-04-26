(*  ==== BASIS EXAMPLES : QUADRATURE signature ====
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
 *  This module performs automatic quadrature using Simpson's rule.  It
 *  illustrates the use of the Real structure in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: quadrature.sml,v $
 *  Revision 1.1  1996/08/09 18:12:05  davids
 *  new unit
 *
 *
 *)

signature QUADRATURE =
  sig

    (* integrate (f, a, b, accuracy)
     Integrate the function 'f' between limits 'a' and 'b', to the accuracy
     specified.  If 'accuracy' is NONE then maximum accuracy will be used.
     If either of the limits is infinity or NaN, then Overflow or Div will
     be raised respectively.  If any value in the integral cannot be evaluated
     then Eval will be raised for that point. *)

    val integrate : (real -> real) * real * real * real option -> real

      
    (* differentiate f x
     Differentiate the function 'f' at the point 'x'. *)

    val differentiate : (real -> real) -> real -> real

  end

