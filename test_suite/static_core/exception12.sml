(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  WARNING

$Log: exception12.sml,v $
Revision 1.1  1994/01/24 16:55:32  nosa
Initial revision

Revision 1.1  1994/01/24  16:55:32  nosa
Initial revision



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

exception E of exn;
exception A of exn;
exception B = A;
exception C of exn;
exception D = C;
exception F;

fun f (E(E(E(A(E(E(E(C(E(E(E(B(E(E(E(D(F))))))))))))))))) = 1
|   f (E(E(E(B(E(E(E(D(E(E(E(A(E(E(E(C(F))))))))))))))))) = 2(* redundant *)
|   f (E(E(E(C(E(E(E(E(B(E(E(E(E(E(E(B(F))))))))))))))))) = 3
|   f (E(E(E(D(E(E(E(E(A(E(E(E(E(E(E(C(F))))))))))))))))) = 4;

f (E(E(E(B(E(E(E(D(E(E(E(A(E(E(E(C(F))))))))))))))))); (* 1 *)
f (E(E(E(B(E(E(E(D(E(E(E(A(E(E(E(C(F))))))))))))))))); (* 1 *)
f (E(E(E(D(E(E(E(E(A(E(E(E(E(E(E(A(F))))))))))))))))); (* 3 *)
f (E(E(E(C(E(E(E(E(B(E(E(E(E(E(E(D(F))))))))))))))))); (* 4 *)
