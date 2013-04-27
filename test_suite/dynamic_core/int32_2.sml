(*

Result: OK
 
$Log: int32_2.sml,v $
Revision 1.2  1996/02/09 14:53:09  jont
Modifying now that divide overflow raise Overflow

 *  Revision 1.1  1996/02/06  15:16:29  jont
 *  new unit
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

(* First some addition/subtraction tests, with overflow handling *)
val a : MLWorks.Internal.Types.int32 = 12
val b = a + 7
val c = b + ~4
val d = a - 3
val e = d - ~5
val f : MLWorks.Internal.Types.int32 = 0x40000000
val g = f + f handle Overflow => 3
val h = ~f
val i = h + h
val j = i - 1 handle Overflow => 1
val k = i + ~1 handle Overflow => 5
val l = f - h handle Overflow => 7

(* Now some multiplication overflow tests *)
val m = f * f handle Overflow => 11
val n : MLWorks.Internal.Types.int32 = 0x8000
val oo = n*2
val p = n * oo handle Overflow => 13
val q = n * ~oo
val r = oo * ~oo handle Overflow => 15

(* Now some division overflow tests *)
val s = n div 0 handle Div => 17
val t = q div 1
val u = q div ~1 handle Overflow => 19
val w = q div ~3

(* Now some mod overflow tests *)
val x = q mod 0 handle Mod => 23

(* Now some abs and ~ overflow tests *)
val y = abs q handle Overflow => 29
val z = ~q handle Overflow => 31
