(* __bignum_inf.sml the structure *)
(*
   Integer Arithmetic to Arbitrary Size with no range checking

$Log: __bignum_inf.sml,v $
Revision 1.2  1996/10/28 15:08:56  io
[Bug #1614]
basifying String

 * Revision 1.1  1995/08/14  16:08:57  jont
 * new unit
 * Infinite precision (no range checking) bignums
 *

Copyright (c) 1995 Harlequin Ltd.
*)

require "_bignum";
require "__crash";

structure BigNum_Inf_ =
  BigNumFun(structure Crash = Crash_
	    val check_range = false
	    val smallest_int = ""
	    val largest_int = ""
	    val largest_word = "");
