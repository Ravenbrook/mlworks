(*  ==== INITIAL BASIS : IEEE_REAL ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: ieee_real.sml,v $
 *  Revision 1.3  1998/02/23 11:37:49  mitchell
 *  [Bug #30335]
 *  Replace IEEEReal.decimal_approx by an abstract type
 *
 *  Revision 1.2  1997/02/14  13:02:53  matthew
 *  Updating for new basis
 *
 *  Revision 1.1  1997/01/14  10:38:45  io
 *  new unit
 *  [Bug #1757]
 *  renamed ieeereal to ieee_real
 *
 *  Revision 1.1  1996/04/23  10:41:23  matthew
 *  new unit
 *
 *
 *
 *)

signature IEEE_REAL =
  sig
    exception Unordered
    datatype real_order = LESS | EQUAL | GREATER | UNORDERED
    datatype float_class = 
      NAN |
      INF |
      ZERO |
      NORMAL |
      SUBNORMAL
    datatype rounding_mode = TO_NEAREST | TO_NEGINF | TO_POSINF | TO_ZERO
    val setRoundingMode : rounding_mode -> unit
    val getRoundingMode : unit -> rounding_mode
    type decimal_approx
    val class : decimal_approx -> float_class
    val signBit : decimal_approx -> bool
    val digits : decimal_approx -> int list
    val exp : decimal_approx -> int
    val toString : decimal_approx -> string
    val fromString : string -> decimal_approx option
  end

      

