(*  ==== INITIAL BASIS : MATH ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: math.sml,v $
 *  Revision 1.3  1996/11/04 14:54:02  andreww
 *  [Bug #1711]
 *  real is no longer an equality type in sml'96.
 *
 *  Revision 1.2  1996/04/23  10:29:21  matthew
 *  Revisions
 *
 *  Revision 1.1  1996/04/23  10:19:57  matthew
 *  new unit
 *  Renamed from maths.sml
 *
 * Revision 1.1  1996/04/18  11:43:37  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  14:51:51  matthew
 *  Removing duplicated arctan2
 *
 *  Revision 1.1  1995/04/13  14:00:44  jont
 *  new unit
 *  No reason given
 *
 *
 *)

signature MATH =
  sig
    type real

    val pi : real
    val e : real

    val sqrt : real -> real
    val sin : real -> real
    val cos : real -> real
    val tan : real -> real
    val asin : real -> real
    val acos : real -> real
    val atan : real -> real
    val atan2 : real * real -> real
    val exp : real -> real
    val pow : real * real -> real
    val ln : real -> real
    val log10 : real -> real
    val sinh : real -> real
    val cosh : real -> real
    val tanh : real -> real

  end (* signature MATH *)
