(* _bignumsize.sml the functor *)
(*
   Integer arithmetic to given size.

$Log: _bignumsize.sml,v $
Revision 1.2  1996/10/05 14:13:57  io
[Bug #1614]
basifying String

 * Revision 1.1  1995/08/14  16:07:36  jont
 * new unit
 * Parameterise on target word size
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

require "crash";
require "bignum";
require "_bignum";

functor BigNumSize
  (structure Crash  : CRASH
   structure BigNum : BIGNUM
   val bits_per_word : int
     ) : BIGNUM =
struct
  fun power(acc, base, index) =
    if index <= 0 then acc else power(BigNum.*(acc, base), base, index-1)

  val bignum_one = BigNum.int_to_bignum 1
  val intpower = power(bignum_one, BigNum.int_to_bignum 2, bits_per_word-1)
  val largest_int =
    BigNum.bignum_to_string(BigNum.-(intpower, bignum_one))
  val smallest_int = BigNum.bignum_to_string(BigNum.~ intpower)
  val largest_word =
    BigNum.bignum_to_string
    (BigNum.-(BigNum.*(intpower, BigNum.int_to_bignum 2), bignum_one))

  structure BigNumSize = BigNumFun
    (structure Crash = Crash
     val check_range = true
     val smallest_int = smallest_int
     val largest_int = largest_int
     val largest_word = largest_word)

  open BigNumSize

end
