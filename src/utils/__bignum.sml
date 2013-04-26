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

Copyright (c) 1991 Harlequin Ltd.
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
