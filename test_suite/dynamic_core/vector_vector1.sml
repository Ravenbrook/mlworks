(*

Result: OK
 
$Log: vector_vector1.sml,v $
Revision 1.7  1997/11/21 10:52:57  daveb
[Bug #30323]

 * Revision 1.6  1997/05/28  12:17:15  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.5  1996/11/06  12:01:09  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.4  1996/05/22  10:55:01  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.3  1996/05/08  12:20:33  jont
 * Vectors have moved
 *
 * Revision 1.2  1996/05/01  17:39:35  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1995/09/19  18:10:26  jont
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

let
  fun foo(x, 0) = (x, 0)
    | foo(x, n) = foo(MLWorks.Internal.Vector.vector [1,2,3,4,5,6] :: x, n-1)

  val y = foo([], 1000000)
in
  print("Pass " ^ Int.toString(#2 y) ^ "\n")
end
