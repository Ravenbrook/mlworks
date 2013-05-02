(*   ==== SCON EQAULITY OF MEANING ====
 *              FUNCTOR
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
 *  This module contains an Ident.SCon equality of meaning function
 *
 *  $Log: _scons.sml,v $
 *  Revision 1.8  1997/03/06 16:03:22  jont
 *  [Bug #1938]
 *  Remove __pre_basis from require list
 *
 * Revision 1.7  1996/11/04  14:45:51  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.6  1996/10/29  17:49:08  io
 * moving String from toplevel
 *
 * Revision 1.5  1996/04/30  16:22:44  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.4  1996/01/03  16:57:34  matthew
 * Take account of negative hex scons
 *
 *  Revision 1.3  1995/07/26  11:03:07  jont
 *  Handle unrepresentable bignums in scon_eqval
 *
 *  Revision 1.2  1995/07/25  11:39:53  jont
 *  Add comparisons on words and hex words
 *
 *  Revision 1.1  1995/07/19  16:49:42  jont
 *  new unit
 *  No reason given
 *
 *)

require "ident.sml";
require "^.basis.__string";
require "^.utils.bignum";
require "scons";

functor Scons(
  structure Ident : IDENT
  structure BigNum : BIGNUM) : SCONS =
  struct

    type SCon = Ident.SCon

    fun is_hex_int (s:string):bool = 
      String.isPrefix "0x" s orelse String.isPrefix "~0x" s
      
    (* Words aren't signed *)
    fun is_hex_word (s:string):bool = String.isPrefix "0wx" s

    fun sign (s:string) = String.sub(s,0) = #"~"

    fun strip_zeroes(s, i) =
      if i >= size s then ""
      else if String.sub(s, i) = #"0" then
	strip_zeroes (s, i+1)
      else
	String.extract (s, i, NONE)

    fun int_is_zero s =
      let
	val ptr = if sign s then 1 else 0
      in
	strip_zeroes(s, if is_hex_int s then 2+ptr else ptr) = ""
      end

    fun word_is_zero s =
      let
	val ptr = if sign s then 1 else 0
      in
	strip_zeroes(s, if is_hex_word s then 3+ptr else ptr) = ""
      end

    fun scon_eqval(Ident.INT(s, _), Ident.INT(t, _)) =
      s = t orelse
      (int_is_zero s andalso int_is_zero t)
      orelse
      (* Tricky one. There may be leading zeroes, or even hex representation *)
      (* First fail if signs different since not both zero *)
      ((sign s = sign t) andalso
       let
	 val s_is_hex = is_hex_int s
	 val t_is_hex = is_hex_int t
       in
	 if s_is_hex = t_is_hex then
	   let
	     val ptr = if sign s then 1 else 0
	     val ptr = if s_is_hex then ptr+2 else ptr
	   in
	     strip_zeroes(s, ptr) = strip_zeroes(t, ptr)
	   end
	 else
	   (* One hex, one decimal *)
	   (if s_is_hex then
	      BigNum.eq(BigNum.hex_string_to_bignum s, BigNum.string_to_bignum t)
	    else
	      BigNum.eq(BigNum.hex_string_to_bignum t, BigNum.string_to_bignum s))
	      handle BigNum.Unrepresentable => false
       (* Regard too big values as unequal, they will fail later *)
       end)

      | scon_eqval(Ident.WORD(s, _), Ident.WORD(t, _)) =
	s = t orelse
	(word_is_zero s andalso word_is_zero t)
	orelse
	(* Tricky one. There may be leading zeroes, or even hex representation *)
	(* First fail if signs different since not both zero *)
	((sign s = sign t) andalso
	 let
	   val s_is_hex = is_hex_word s
	   val t_is_hex = is_hex_word t
	 in
	   if s_is_hex = t_is_hex then
	     let
	       val ptr = if sign s then 1 else 0
	       val ptr = if s_is_hex then ptr+3 else ptr
	     in
	       strip_zeroes(s, ptr) = strip_zeroes(t, ptr)
	     end
	   else
	     (* One hex, one decimal *)
	     (if s_is_hex then
		BigNum.eq(BigNum.hex_word_string_to_bignum s,
			  BigNum.word_string_to_bignum t)
	      else
		BigNum.eq(BigNum.hex_word_string_to_bignum t,
			  BigNum.word_string_to_bignum s))
		handle BigNum.Unrepresentable => false
	 (* Regard too big values as unequal, they will fail later *)
	 end)
      | scon_eqval (Ident.REAL(s, _), Ident.REAL(t, _)) = s = t
      | scon_eqval (Ident.STRING s, Ident.STRING t) = s = t
      | scon_eqval (Ident.CHAR s, Ident.CHAR t) = s = t
      | scon_eqval (_, _) = false

  end
