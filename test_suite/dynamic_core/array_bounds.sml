(*

Result: OK
 
 * $Log: array_bounds.sml,v $
 * Revision 1.3  1996/05/08 12:05:57  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1995/09/11  16:42:02  jont
 * poo
 *
 * Revision 1.1  1995/08/30  16:17:20  jont
 * new unit
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
  val a = MLWorks.Internal.ExtendedArray.array(10, 0)
in
  val x = (MLWorks.Internal.Array.update(a, 9, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val y = (MLWorks.Internal.Array.update(a, 0, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val z = (MLWorks.Internal.Array.update(a, ~1, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val b = (MLWorks.Internal.Array.update(a, 10, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val c = (MLWorks.Internal.Array.sub(a, 9)) handle MLWorks.Internal.Array.Subscript => 1
  val d = (MLWorks.Internal.Array.sub(a, 0)) handle MLWorks.Internal.Array.Subscript => 1
  val e = (MLWorks.Internal.Array.sub(a, ~1)) handle MLWorks.Internal.Array.Subscript => 1
  val f = (MLWorks.Internal.Array.sub(a, 10)) handle MLWorks.Internal.Array.Subscript => 1
end

