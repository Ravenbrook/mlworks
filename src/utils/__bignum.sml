(* __bignum.sml the structure *)
(*
   Integer Arithmetic to Arbitrary Size.

$Log: __bignum.sml,v $
Revision 1.8  1996/10/07 13:25:52  io
[Bug #1614]
remove Lists

 * Revision 1.7  1995/08/17  10:46:35  daveb
 * Added BigNum32_ and BigNum64_ structures.
 *
Revision 1.6  1995/08/14  11:51:44  jont
Add check_range parameter

Revision 1.5  1995/07/25  10:40:57  jont
Add Lists and largest_word to functor parameter

Revision 1.4  1994/03/08  17:57:35  jont
Moved use of machtypes to machspec

Revision 1.3  1991/11/21  16:57:36  jont
Added copyright message

Revision 1.2  91/10/22  16:21:06  davidt
Now builds using the Crash_ structure.

Revision 1.1  91/08/19  18:24:46  davida
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

require "_bignumsize";
require "__crash";
require "__bignum_inf";
require "^.machine.__machspec";

structure BigNum_ =
  BigNumSize(structure Crash = Crash_
	     structure BigNum = BigNum_Inf_
	     val check_range = true
	     val bits_per_word = MachSpec_.bits_per_word);

structure BigNum32_ =
  BigNumSize(structure Crash = Crash_
	     structure BigNum = BigNum_Inf_
	     val check_range = true
	     val bits_per_word = 32);

structure BigNum64_ =
  BigNumSize(structure Crash = Crash_
	     structure BigNum = BigNum_Inf_
	     val check_range = true
	     val bits_per_word = 64);
