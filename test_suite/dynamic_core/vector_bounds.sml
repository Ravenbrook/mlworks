(*

Result: OK
 
$Log: vector_bounds.sml,v $
Revision 1.2  1996/05/08 11:31:13  jont
Vectors have moved

 * Revision 1.1  1995/09/01  14:51:43  jont
 * new unit
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

local
  val a = MLWorks.Internal.Vector.tabulate(10, fn _ => 0)
in
  val c = (MLWorks.Internal.Vector.sub(a, 9)) handle MLWorks.Internal.Vector.Subscript => 1
  val d = (MLWorks.Internal.Vector.sub(a, 0)) handle MLWorks.Internal.Vector.Subscript => 1
  val e = (MLWorks.Internal.Vector.sub(a, ~1)) handle MLWorks.Internal.Vector.Subscript => 1
  val f = (MLWorks.Internal.Vector.sub(a, 10)) handle MLWorks.Internal.Vector.Subscript => 1
end

