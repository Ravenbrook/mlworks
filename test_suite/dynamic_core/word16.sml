(*

Result: OK
 
$Log: word16.sml,v $
Revision 1.1  1996/02/09 17:27:33  jont
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

val a : MLWorks.Internal.Types.word16 = 0w12
val b = a mod 0w5
val c = a div 0w5
val f = 0w0 - a
val g = f mod 0w5
val h = f div 0w5

(* First some addition/subtraction tests, with overflow handling *)
val aa : MLWorks.Internal.Types.word16 = 0w12
val ab = aa + 0w7
val ad = aa - 0w3
val af : MLWorks.Internal.Types.word16 = 0w32768
val ag = af + af handle Overflow => 0w3
val ah = 0w0 - af
val ai = ah + ah
val aj = ai - 0w1 handle Overflow => 0w1
val al = af - ah handle Overflow => 0w7

(* Now some multiplication overflow tests *)
val am = af * af handle Overflow => 0w11
val an : MLWorks.Internal.Types.word16 = 0w8
val ao = an*0w2
val ap = an * ao handle Overflow => 0w13
val aq = an * (0w0 - ao)
val ar = ao * (0w0 - ao) handle Overflow => 0w15

(* Now some division overflow tests *)
val ss = an div 0w0 handle Div => 0w17
val at = aq div 0w1

(* Now some mod overflow tests *)
val ax = aq mod 0w0 handle Div => 0w23
