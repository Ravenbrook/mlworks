(*
 * Integer Arithmetic to Arbitrary Size.
 *
 * Copyright (c) 1991 Harlequin Ltd.
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
