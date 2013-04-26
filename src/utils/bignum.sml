(*
 * Integer Arithmetic to Arbitrary Size.
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

(*
$Log: bignum.sml,v $
Revision 1.7  1996/01/04 12:49:42  matthew
Adding bignum to int function.

Revision 1.6  1995/09/15  14:42:57  daveb
Added rem and quot operations.

Revision 1.5  1995/07/25  11:12:01  jont
Add word_string_to_bignum and hex_word_string_to_bignum

Revision 1.4  1995/07/17  16:22:51  jont
Add hex_string_to_bignum

Revision 1.3  1995/07/17  14:44:58  jont
Add int_to_bignum function

Revision 1.2  1991/10/22  15:04:33  davidt
Took out the impossible exception.

Revision 1.1  91/08/19  18:23:40  davida
Initial revision
*)

signature BIGNUM =
  sig
    type bignum

    exception Unrepresentable
    val int_to_bignum : int -> bignum
    val bignum_to_int : bignum -> int

    val string_to_bignum : string -> bignum
    (* For use with conversion from hex *)
    val hex_string_to_bignum : string -> bignum
    val word_string_to_bignum : string -> bignum
    val hex_word_string_to_bignum : string -> bignum

    val bignum_to_string : bignum -> string

    exception Runtime of string        (*  Sum, Prod, Diff, Mod, *)
    				       (*  Div, Neg, Abs         *)

    val ~   : bignum -> bignum
    val abs : bignum -> bignum

    val +   : bignum * bignum -> bignum
    val -   : bignum * bignum -> bignum
    val *   : bignum * bignum -> bignum
    val div : bignum * bignum -> bignum
    val mod : bignum * bignum -> bignum
    val quot : bignum * bignum -> bignum
    val rem : bignum * bignum -> bignum

    val <  : bignum * bignum -> bool
    val >  : bignum * bignum -> bool
    val <= : bignum * bignum -> bool
    val >= : bignum * bignum -> bool
    val eq : bignum * bignum -> bool
    val <> : bignum * bignum -> bool
  end;
