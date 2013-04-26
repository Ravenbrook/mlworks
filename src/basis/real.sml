(*  ==== INITIAL BASIS : REAL ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: real.sml,v $
 *  Revision 1.14  1999/02/17 14:42:22  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.13  1997/05/27  14:08:57  matthew
 * [Bug #30093]
 *
 * Removing Real.<>
 *
 * Revision 1.12  1997/05/27  13:15:34  jkbrook
 * [Bug #01749]
 * Changed to use __large_int for synonym structure LargeInt
 *
 * Revision 1.11  1997/03/03  17:35:58  matthew
 * Updating for yet more basis revisions
 *
 * Revision 1.10  1997/01/14  17:51:22  io
 * [Bug #1757]
 * rename __pre{integer,int32,real} to __pre_{int{,32},real}
 *
 * Revision 1.9  1996/11/16  00:52:56  io
 * [Bug #1757]
 * renamed __ieeereal to __ieee_real
 *
 * Revision 1.8  1996/11/04  19:03:37  andreww
 * [Bug #1711]
 * real type loses equality attribute.
 *
 * Revision 1.7  1996/10/03  15:24:45  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.6  1996/06/04  15:57:14  io
 * stringcvt -> string_cvt
 *
 * Revision 1.5  1996/05/10  15:22:51  matthew
 * Changing type of scan
 *
 * Revision 1.4  1996/05/09  10:13:48  matthew
 * Updating.
 *
 * Revision 1.3  1996/05/02  16:05:24  io
 * finis stringcvt
 *
 * Revision 1.2  1996/04/30  11:26:09  matthew
 * Revisions
 *
 * Revision 1.1  1996/04/18  11:45:28  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  14:09:03  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "__string_cvt";
require "__pre_int";
require "__large_int";
require "__pre_real";
require "__ieee_real";
require "math";

signature REAL =
  sig
    type real

    structure Math : MATH
    sharing type Math.real = real

    val radix : int
    val precision : PreInt.int
    val maxFinite : real
    val minPos : real
    val minNormalPos : real

    val posInf : real
    val negInf : real

    val + : real * real -> real
    val - : real * real -> real
    val * : real * real -> real
    val / : real * real -> real

    val *+ : real * real * real -> real
    val *- : real * real * real -> real

    val ~ : real -> real
    val abs : real -> real
    val min : real * real -> real
    val max : real * real -> real

    val sign : real -> int
    val signBit : real -> bool
    val sameSign : real * real -> bool
    val copySign : real * real -> real

    val compare : real * real -> order
    val compareReal : real * real -> IEEEReal.real_order

    val < : real * real -> bool
    val <= : real * real -> bool
    val > : real * real -> bool
    val >= : real * real -> bool

    val == : (real * real) -> bool		(* IEEE "=" *)
    val != : (real * real) -> bool		(* IEEE "?<>" *)
    val ?= : (real * real) -> bool		(* IEEE "?=" *)

    val unordered : real * real -> bool
    val isFinite : real -> bool
    val isNan : real -> bool
    val isNormal : real -> bool
    val class : real -> IEEEReal.float_class
    val fmt : StringCvt.realfmt -> real -> string 
    val toString : real -> string
    val fromString : string -> real option
    val scan : (char, 'a) StringCvt.reader -> 'a -> (real * 'a) option
    val toManExp : real -> {man : real, exp : int}
    val fromManExp : {man : real, exp : int} -> real
    val split : real -> {whole : real, frac : real}
    val realMod : real -> real
    val rem : real * real -> real
    val nextAfter : real * real -> real
    val checkFloat : real -> real

    val realFloor : real -> real
    val realCeil : real -> real
    val realTrunc : real -> real
    val floor : real -> PreInt.int
    val ceil : real -> PreInt.int (* round towards positive infinity *)
    val trunc : real -> PreInt.int (* round towards zero *)
    val round : real -> PreInt.int (* round towards nearest, ties towards even *)
      
    val toInt : IEEEReal.rounding_mode -> real -> int
    val toLargeInt : IEEEReal.rounding_mode -> real -> LargeInt.int
    val fromInt : int -> real
    val fromLargeInt : LargeInt.int -> real
    val toLarge : real -> PreLargeReal.real
    val fromLarge : IEEEReal.rounding_mode -> PreLargeReal.real -> real
    val toDecimal : real -> IEEEReal.decimal_approx
    val fromDecimal : IEEEReal.decimal_approx -> real
  end
