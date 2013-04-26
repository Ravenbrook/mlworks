(*

Result: OK
 
$Log: int16.sml,v $
Revision 1.1  1996/02/09 17:29:16  jont
new unit


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

val a : MLWorks.Internal.Types.int16 = 12
val b = a mod 5
val c = a div 5
val d = a mod ~5
val e = a div ~5
val f = 0 - a
val g = f mod 5
val h = f div 5
val i = f mod ~5
val j = f div ~5

(* First some addition/subtraction tests, with overflow handling *)
val aa : MLWorks.Internal.Types.int16 = 12
val ab = aa + 7
val ac = ab + ~4
val ad = aa - 3
val ae = ad - ~5
val af : MLWorks.Internal.Types.int16 = 16384
val ag = af + af handle Overflow => 3
val ah = ~af
val ai = ah + ah
val aj = ai - 1 handle Overflow => 1
val ak = ai + ~1 handle Overflow => 5
val al = af - ah handle Overflow => 7

(* Now some multiplication overflow tests *)
val am = af * af handle Overflow => 11
val an : MLWorks.Internal.Types.int16 = 0x80
val ao = an*2
val ap = an * ao handle Overflow => 13
val aq = an * ~ao
val ar = ao * ~ao handle Overflow => 15

(* Now some division overflow tests *)
val ss = an div 0 handle Div => 17
val at = aq div 1
val au = aq div ~1 handle Overflow => 19
val aw = aq div ~3

(* Now some mod overflow tests *)
val ax = aq mod 0 handle Mod => 23

(* Now some abs and ~ overflow tests *)
val ay = abs aq handle Overflow => 29
val az = ~aq handle Overflow => 31
