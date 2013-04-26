(*  ==== INITIAL BASIS : 16-bit Integer structure ====
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
 *  $Log: __int16.sml,v $
 *  Revision 1.7  1997/05/01 17:42:30  jont
 *  [Bug #30096]
 *  Change type of precision
 *
 * Revision 1.6  1996/11/06  10:48:56  matthew
 * Renamed __integer to __int
 *
 * Revision 1.5  1996/10/03  14:49:44  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.4  1996/05/17  11:21:07  jont
 * Revise to latest signature
 *
 * Revision 1.3  1996/05/08  15:31:45  matthew
 * Adding scan,fmt
 *
 * Revision 1.2  1996/04/30  11:51:19  matthew
 * Removed MLWorks.Integer
 *
 * Revision 1.1  1996/04/18  11:27:10  jont
 * new unit
 *
 * Revision 1.2  1996/03/20  14:45:15  matthew
 * Changes for new language definition
 *
 * Revision 1.1  1995/09/15  17:07:31  daveb
 * new unit
 * 16-bit integers.
 *
 *)

require "integer";
require "__int";

structure Int16: INTEGER =
  struct
    type int = MLWorks.Internal.Types.int16

    val precision = SOME 16
    val minInt = SOME (~32768: int)
    val maxInt = SOME (32767: int)

    fun min(a, b) = if a < b then a else b: int
    fun max(a, b) = if a < b then b else a: int
    fun sign (x : int) = if x < 0 then ~1 else if x = 0 then 0 else 1: Int.int

    fun sameSign(a, b) = sign a = sign b

    val intmaxint = (32768 : Int.int)

    val cast = MLWorks.Internal.Value.cast
    fun toInt x = cast x
    fun fromInt (x:Int.int) = 
      if x < intmaxint andalso x >= Int.~ intmaxint
        then cast x
      else raise Overflow

    val toString : int -> string = Int.toString o toInt
    fun fmt radix n = Int.fmt radix (toInt n)
    fun fromString s =
      case Int.fromString s of
        SOME n => SOME (fromInt n)
      | _ => NONE
    fun scan radix getc src =
      case Int.scan radix getc src of
        SOME (i,r) => SOME (fromInt i, r)
      | _ => NONE

    fun toLarge x = Int.toLarge (toInt x)
    fun fromLarge x = 
      let
        val intx = Int.fromLarge x
      in
        fromInt intx
      end

    val ~ : int -> int = ~
    val op* : int * int -> int = op*
    val op div : int * int -> int = op div
    val op mod : int * int -> int = op mod

    fun quot(a, b) =
      let
	val q = a div b
	val r = a mod b
      in
	if r = 0 orelse (a > 0 andalso b > 0) orelse (a < 0 andalso b < 0) then
	  q
	else
	  q + 1
      end

    fun rem(a, b) =
      let
	val r = a mod b
      in
	if r = 0 orelse (a > 0 andalso b > 0) orelse (a < 0 andalso b < 0) then
	  r 
	else
	  r - b
      end

    val op + : int * int -> int = op +
    val op - : int * int -> int = op -
    val op > : int * int -> bool = op >
    val op >= : int * int -> bool = op >=
    val op < : int * int -> bool = op <
    val op <= : int * int -> bool = op <=
    val abs : int -> int = abs

    val compare = 
      fn (n,m) =>
      if n < m then LESS
      else if n > m then GREATER
      else EQUAL

  end
