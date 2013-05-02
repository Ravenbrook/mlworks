(*  ==== INITIAL BASIS : IEEE_REAL ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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

      

