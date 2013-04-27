(*
We were getting a spurious redundancy warning.

Result: OK
 
$Log: redundant.sml,v $
Revision 1.1  1994/06/17 12:27:43  daveb
new file


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

    datatype identifier =
      A of int |
      B of int |
      C of int |
      D of int |
      E of int

    fun compare (A i, A i') = i < i'
    |   compare (A _, _) = true
    |   compare (_, A _) = false
    |   compare (B i, B i') = i < i'
    |   compare (B _, _) = true
    |   compare (_, B _) = false
    |   compare (C i, C i') = i < i'
    |   compare (C _, _) = true
    |   compare (_, C _) = false
    |   compare (D i, D i') = i < i'
    |   compare (D _, _) = true
    |   compare (_, D _) = false
    |   compare (E i, E i') = i < i'

