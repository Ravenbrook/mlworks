(*  ==== INITIAL BASIS : Unconstrinaed Integer structure ====
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
 *  $Log: __pre_int.sml,v $
 *  Revision 1.18  1999/02/17 14:35:20  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.17  1997/03/06  16:29:00  jont
 * [Bug #1938]
 * Qualify names from PreBasis
 *
 * Revision 1.16  1997/01/06  10:57:26  matthew
 * Adding structure PreInt
 *
 * Revision 1.15  1996/11/04  15:51:46  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.14  1996/10/03  14:54:04  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.13  1996/10/03  12:35:58  io
 * [Bug #1614]
 * basifying MLWorks.String
 *
 * Revision 1.12  1996/10/02  17:19:25  io
 * [Bug #1628]
 * revise scan() to support Hex
 *
 * Revision 1.11  1996/06/04  15:28:11  io
 * stringcvt -> string_cvt
 *
 * Revision 1.10  1996/05/30  11:28:10  daveb
 * ord is now at top level
 *
 * Revision 1.9  1996/05/17  11:06:37  jont
 * Revise to latest signature
 *
 * Revision 1.8  1996/05/10  12:41:48  matthew
 * Adding scan function
 *
 * Revision 1.7  1996/05/10  09:18:23  matthew
 * Enhancing fromString
 *
 * Revision 1.6  1996/05/02  11:17:39  stephenb
 * Undo the last two changes since by the time this is checked in
 * the boostrap compiler will contain the necessary runtime routines.
 *
 * Revision 1.5  1996/05/02  09:47:39  jont
 * Change toLarge and fromLarge to exception raising functions
 *
 * Revision 1.4  1996/05/01  13:49:29  matthew
 * Hack to enable bootstrapping
 *
 * Revision 1.3  1996/04/30  15:43:55  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.2  1996/04/30  12:58:13  matthew
 * Adding LargeInteger
 *
 * Revision 1.1  1996/04/18  11:32:58  jont
 * new unit
 *
 *  Revision 1.3  1995/09/19  10:41:38  daveb
 *  Replaced real literals with their fractional equivalents, so that the
 *  overnight build can cope.
 *
 *  Revision 1.2  1995/09/15  13:24:26  daveb
 *  Added makestring
 *
 *  Revision 1.1  1995/04/13  13:27:33  jont
 *  new unit
 *  No reason given
 *
 *
 *)
require "__pre_string_cvt";
require "__pre_basis";

structure PreInt =
  struct

    type int = int

    (* Convert to and from int32's *)
    local
      val env = MLWorks.Internal.Runtime.environment
    in
      val toLarge : int -> MLWorks.Internal.Types.int32 =
	env "int int_to_int32"
      val fromLarge : MLWorks.Internal.Types.int32 ->int = 
	env "int int32_to_int"
    end

    val toInt = fn x :int => x
    val fromInt = fn x : int => x

    val precision = SOME 30
    val minInt = SOME ~536870912
    val maxInt = SOME 536870911
    val ~ : int -> int = ~
    val op* : int * int -> int = op*
    val op div : int * int -> int = op div
    val op mod : int * int -> int = op mod
    fun quot (a,b) =
      let
	val q = a div b
	val r = a mod b
      in
	if r = 0 orelse (a > 0 andalso b > 0) orelse (a < 0 andalso b < 0) then q
	else q + 1
      end
    fun rem (a,b) =
      let
	val q = a div b
	val r = a mod b
      in
	if r = 0 orelse (a > 0 andalso b > 0) orelse (a < 0 andalso b < 0) then r
	else r - b
      end

    val op + : int * int -> int = op +
    val op - : int * int -> int = op -
    val op > : int * int -> bool = op >
    val op >= : int * int -> bool = op >=
    val op < : int * int -> bool = op <
    val abs : int -> int = abs

    val compare = 
      fn (n,m) =>
      if n < m then LESS
      else if n > m then GREATER
      else EQUAL

    fun min(a, b) = if a < b then a else b
    fun max(a, b) = if a < b then b else a
    fun sign x = if x < 0 then ~1 else if x = 0 then 0 else 1
    fun sameSign(a, b) = sign a = sign b

    fun makeString (base,n) =
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
              val acc' = make_digit digit :: acc
            in 
              if n' <> 0
                then makedigits (n',acc')
              else acc'
            end
      in
	  implode (if n < 0 then #"~" :: makedigits(n,[]) else makedigits(n,[]))
      end

    fun tobase PreStringCvt.BIN = 2
      | tobase PreStringCvt.OCT = 8
      | tobase PreStringCvt.DEC = 10
      | tobase PreStringCvt.HEX = 16
      
    fun fmt radix n =
      makeString (tobase radix,n)

    fun toString n = fmt PreStringCvt.DEC n

    (* toDigit is unsafe with isAlphanumeric characters
     * eg toDigit #"c" = 51
     *    toDigit #"a" = 10
     *    toDigit #"1" = 1
     *)
    fun toDigit radix = 
      if tobase radix <= 10 then
	fn c=> (ord c) - (ord #"0")
      else
	fn c=> 
	if #"0" <= c andalso c <= #"9" then
	  ord c - ord #"0"
	else if #"A" <= c andalso c <= #"Z" then
	  ord c - ord #"A" + 10
	else if #"a" <= c andalso c <= #"z" then
	  (ord c) - ord #"a" + 10
	     else raise Fail ("toDigit" ^ (str c))
	       
    fun scan radix getc src = 
      let
	val toDigit : char -> int = toDigit radix
	fun isSign #"+" = true
	  | isSign #"-" = true
	  | isSign #"~" = true
	  | isSign _ = false
	  
	fun convertSign "~" = 1
	  | convertSign "-" = 1
	  | convertSign _ = ~1
	  
	val base = tobase radix
	val isDigit =
	  case radix of
	    PreStringCvt.OCT=> PreBasis.isOctDigit
	  | PreStringCvt.DEC => PreBasis.isDigit
	  | PreStringCvt.HEX => PreBasis.isHexDigit
	  | PreStringCvt.BIN => (fn c=>c = #"0" orelse c = #"1")
	      
	fun convertDigit s = 
	  let val sz = size s 
	    fun scan (i,acc) = 
	      if i < sz then
		let
		  val c = chr(MLWorks.String.ordof(s,i))
		in
		  scan (i+1, (acc * base) - (toDigit c))
		end
	      else 
		acc
	  in
	    scan (0, 0)
	  end
	
	val (sign,src) = 
	  case PreStringCvt.splitlN 1 isSign getc (PreStringCvt.skipWS getc src) of
	    (sign, src) => (sign,
			    (case radix of
			       PreStringCvt.HEX =>
				 (case getc src of 
				    SOME (#"0", src') =>
				      (case getc src' of
					 SOME (#"x", src'') => src''
				       | SOME (#"X", src'') => src''
				       | SOME _ => src
				       | NONE => src)
				  | _ => src)
			     | _ => src))
      in
	case PreStringCvt.splitl isDigit getc src of
	  ("", _) => NONE
	| (digit, src) =>
	    SOME (convertSign sign * (convertDigit digit), src)
      end
    
    val fromString = PreStringCvt.scanString (scan PreStringCvt.DEC)
    val op <= : int * int -> bool = op <=

  end

