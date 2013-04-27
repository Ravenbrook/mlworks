(*  ==== INITIAL BASIS : 32-bit Integer structure ====
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
 *  $Log: __pre_int32.sml,v $
 *  Revision 1.12  1999/02/17 14:35:31  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.11  1997/05/01  17:03:40  jont
 *  [Bug #30096]
 *  Change type of precision
 *
 *  Revision 1.10  1997/01/14  17:52:21  io
 *  [Bug #1892]
 *  rename __pre{integer,int32,real,word{,32}} to
 *         __pre_{int{,32},real,word{,32}}
 *
 *  Revision 1.9  1996/10/03  14:53:27  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.8  1996/10/03  12:26:42  io
 *  [Bug #1614]
 *  update MLWorks.String
 *
 *  Revision 1.7  1996/06/04  15:32:27  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.6  1996/05/30  11:32:55  daveb
 *  ord is now at top level.
 *
 *  Revision 1.5  1996/05/17  11:22:24  jont
 *  Revise to latest signature
 *
 *  Revision 1.4  1996/05/10  12:41:08  matthew
 *  Adding scan
 *
 *  Revision 1.3  1996/05/09  09:38:13  matthew
 *  Adding scan, cvt
 *
 *  Revision 1.2  1996/04/30  15:46:02  jont
 *  String functions explode, implode, chr and ord now only available from String
 *  io functions and types
 *  instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 *  now only available from MLWorks.IO
 *
 *  Revision 1.1  1996/04/30  14:40:42  matthew
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:27:39  jont
 * new unit
 *
 * Revision 1.2  1996/03/19  16:53:14  matthew
 * Changes for value polymorphism
 *
 * Revision 1.1  1995/09/15  16:56:50  daveb
 * new unit
 * 32-bit integers.
 *
 *)

require "__pre_int";
require "__string_cvt";

structure PreInt32 =
  struct
    type int = MLWorks.Internal.Types.int32
    val cast = MLWorks.Internal.Value.cast
    val precision = SOME 32
    val minInt = SOME (~2147483648: int)
    val maxInt = SOME (2147483647: int)

    val toInt = PreInt.fromLarge
    val fromInt = PreInt.toLarge

    fun toLarge x = x
    fun fromLarge x = x

    fun tobase StringCvt.BIN = 2 : int
      | tobase StringCvt.OCT = 8 : int
      | tobase StringCvt.DEC = 10 : int
      | tobase StringCvt.HEX = 16 : int
      
    fun scan radix getc src =
      let
        val base = tobase radix
        val ibase = toInt base

        (* Handy predicates *)
        fun isSign c =
          case c of
            #"+" => true
          | #"~" => true
          | #"-" => true
          | _ => false

        fun isDigit a =
          if ibase <= 10
            then 
              a >= ord #"0" andalso
              a < ord #"0" + ibase
          else
            (a >= ord #"0" andalso a < ord #"0" + 10) orelse
            (a >= ord #"A" andalso a < ord #"A" + ibase - 10) orelse
            (a >= ord #"a" andalso a < ord #"a" + ibase - 10)

        exception Valof
        fun valof n =
          if n >= ord #"0" andalso n <= ord #"9"
            then n - ord #"0"
          else if n >= ord #"a" andalso n <= ord #"z"
                 then n - ord #"a" + 10
          else if n >= ord #"A" andalso n <= ord #"Z"
                 then n - ord #"A" + 10
               else raise Valof

        fun convert_digits s =
          let
            fun convert ([],acc) = acc
              | convert (c :: rest,acc) =
                convert (rest,acc * base - fromInt (valof c))
          in
            convert (map ord (explode s),0)
          end

        fun convert_sign "~" = 1
          | convert_sign "-" = 1
          | convert_sign _ = ~1

        val (sign,src) = StringCvt.splitl isSign getc (StringCvt.skipWS getc src)
      in
        if size sign > 1 then NONE
        else
          case StringCvt.splitl (isDigit o ord) getc src of
            ("",src) => NONE
          | (digits,src) => 
              SOME (convert_sign sign * convert_digits digits,src)
      end

    val fromString = StringCvt.scanString (scan StringCvt.DEC)

    fun makeString (base : int, n : int) =
      let
        fun make_digit digit =
          if digit >= 10 then chr (ord #"A" + digit - 10)
          else chr (ord #"0" + digit)
        fun makedigits (n,acc) =
            let
              val digit = 
                if n >= 0 
                  then n mod base
                else 
                  let
                    val res = n mod base
                  in
                    if res = 0 then 0 else base - res
                  end
              val n' = 
                if n >= 0 orelse digit = 0 then 
                  n div base
                else 1 + n div base
              val acc' = make_digit (toInt digit) :: acc
            in 
              if n' <> 0
                then makedigits (n',acc')
              else acc'
            end
        in
          implode (if n < 0 then #"~" :: makedigits (n,[]) else makedigits (n,[]))
        end

    fun fmt radix n =
      makeString (tobase radix,n)

    fun toString n = fmt StringCvt.DEC n

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

    fun min(a, b) = if a < b then a else b: int
    fun max(a, b) = if a < b then b else a: int
    fun sign x = if x < 0 then ~1 else if x = 0 then 0 else 1: PreInt.int

    fun sameSign(a, b) = sign a = sign b


  end

structure PreLargeInt = PreInt32

