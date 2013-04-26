(*

Result: OK
 
$Log: match.sml,v $
Revision 1.1  1995/08/04 14:06:44  jont
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

nonfix o

datatype a =
  A |
  B |
  C |
  D |
  E |
  F |
  G |
  H |
  I |
  J |
  K |
  L |
  M |
  N |
  O |
  P |
  Q |
  R |
  S |
  T |
  U |
  V |
  W |
  X |
  Y |
  Z |
  a |
  b |
  c |
  d |
  e |
  f |
  g |
  h |
  i |
  j |
  k |
  l |
  m |
  n |
  o |
  p |
  q |
  r |
  s |
  t |
  u |
  v |
  w |
  x |
  y |
  z

fun foo A = 0
  | foo B = 1
  | foo C = 2
  | foo D = 3
  | foo E = 4
  | foo F = 5
  | foo G = 6
  | foo H = 7
  | foo I = 8
  | foo J = 9
  | foo K = 0
  | foo L = 1
  | foo M = 2
  | foo N = 3
  | foo O = 4
  | foo P = 5
  | foo Q = 6
  | foo R = 7
  | foo S = 8
  | foo T = 9
  | foo U = 0
  | foo V = 1
  | foo W = 2
  | foo X = 3
  | foo Y = 4
  | foo Z = 5
  | foo a = 6
  | foo b = 7
  | foo c = 8
  | foo d = 9
  | foo e = 0
  | foo f = 1
  | foo g = 2
  | foo h = 3
  | foo i = 4
  | foo j = 5
  | foo k = 6
  | foo l = 7
  | foo m = 8
  | foo n = 9
  | foo o = 0
  | foo p = 1
  | foo q = 2
  | foo r = 3
  | foo s = 4
  | foo t = 5
  | foo u = 6
  | foo v = 7
  | foo w = 8
  | foo x = 9
  | foo y = 0
  | foo z = 1
