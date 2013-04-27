(*
spurious redundancy warnings.

Result: OK
 
$Log: redundant1.sml,v $
Revision 1.2  1994/06/27 16:56:32  nosa
new test


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
      E of int;

    fun compare (A _, A _,A _, A _) = 1
    |   compare (A _, A _, A _, _) = 2
    |   compare (A _, A _, _, A _) = 3
    |   compare (A _, _, A _, A _) = 4
    |   compare (_, A _, A _, A _) = 5
    |   compare (A _, A _, _, _) = 6
    |   compare (A _, _, A _, _) = 7
    |   compare (_, A _, A _, _) = 8
    |   compare (A _, _, _, A _) = 9
    |   compare (_, A _, _, A _) = 10
    |   compare (_, _, A _, A _) = 11
    |   compare (A _, _, _, _) = 12
    |   compare (_, A _, _, _) = 13
    |   compare (_, _, A _, _) = 14
    |   compare (_, _, _, A _) = 15
    |   compare (B _, B _,B _, B _) = 16
    |   compare (B _, B _, B _, _) = 17
    |   compare (B _, B _, _, B _) = 18
    |   compare (B _, _, B _, B _) = 19
    |   compare (_, B _, B _, B _) = 20
    |   compare (B _, B _, _, _) = 21
    |   compare (B _, _, B _, _) = 22
    |   compare (_, B _, B _, _) = 23
    |   compare (B _, _, _, B _) = 24
    |   compare (_, B _, _, B _) = 25
    |   compare (_, _, B _, B _) = 26
    |   compare (B _, _, _, _) = 27
    |   compare (_, B _, _, _) = 28
    |   compare (_, _, B _, _) = 29
    |   compare (_, _, _, B _) = 30
    |   compare (C _, C _,C _, C _) = 31
    |   compare (C _, C _, C _, _) = 32
    |   compare (C _, C _, _, C _) = 33
    |   compare (C _, _, C _, C _) = 34
    |   compare (_, C _, C _, C _) = 35
    |   compare (C _, C _, _, _) = 36
    |   compare (C _, _, C _, _) = 37
    |   compare (_, C _, C _, _) = 38
    |   compare (C _, _, _, C _) = 39
    |   compare (_, C _, _, C _) = 40
    |   compare (_, _, C _, C _) = 41
    |   compare (C _, _, _, _) = 42
    |   compare (_, C _, _, _) = 43
    |   compare (_, _, C _, _) = 44
    |   compare (_, _, _, C _) = 45
    |   compare (D _, D _,D _, D _) = 46
    |   compare (D _, D _, D _, _) = 47
    |   compare (D _, D _, _, D _) = 48
    |   compare (D _, _, D _, D _) = 49
    |   compare (_, D _, D _, D _) = 50
    |   compare (D _, D _, _, _) = 51
    |   compare (D _, _, D _, _) = 52
    |   compare (_, D _, D _, _) = 53
    |   compare (D _, _, _, D _) = 54
    |   compare (_, D _, _, D _) = 55
    |   compare (_, _, D _, D _) = 56
    |   compare (D _, _, _, _) = 57
    |   compare (_, D _, _, _) = 58
    |   compare (_, _, D _, _) = 59
    |   compare (_, _, _, D _) = 60
    |   compare (E _, E _,E _, E _) = 61;
