(*  ==== INITIAL BASIS : WORD 8 VECTOR ====
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
 *  Implementation
 *  --------------
 *  Word 8 vectors are identified with MLWorks strings.
 *
 *  Revision Log
 *  ------------
 *  $Log: __word8_vector.sml,v $
 *  Revision 1.6  1998/11/13 10:36:47  mitchell
 *  [Bug #70225]
 *  Make the vector type admit equality whilst remaining opaque
 *
 *  Revision 1.5  1998/11/12  14:06:26  mitchell
 *  [Bug #70225]
 *  Word8 vectors should admit equality
 *
 *  Revision 1.4  1998/02/19  16:20:37  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.3  1997/08/08  16:20:48  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.2  1997/03/06  16:53:41  jont
 *  [Bug #1938]
 *  Get rid of unsafe stuff from PreBasis where possible
 *
 *  Revision 1.1  1997/01/15  11:42:16  io
 *  new unit
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.8  1996/11/04  15:54:19  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.7  1996/10/03  13:02:57  io
 * [Bug #1614]
 * convert MLWorks.String
 *
 * Revision 1.6  1996/08/09  11:21:03  daveb
 * [Bug #1536]
 * [Bug #1536]
 * Made the signature opaque, so that the vector type does not actually share
 * with string.
 *
 * Revision 1.5  1996/05/21  12:21:16  matthew
 * Updating
 *
 * Revision 1.4  1996/05/15  13:01:54  jont
 * pack_words moved to pack_word
 *
 * Revision 1.3  1996/05/01  11:29:09  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.2  1996/04/23  16:14:20  matthew
 * Defining properly.
 *
 * Revision 1.1  1996/04/18  11:37:19  jont
 * new unit
 *
 *  Revision 1.3  1995/05/16  14:18:29  daveb
 *  Removed commented out old code.
 *
 *  Revision 1.1  1995/03/22  20:22:34  brianm
 *  new unit
 *  New file.
 *
 *
 *)


require "mono_vector";
require "__pre_basis";
require "__word8";
require "__string";

structure Word8Vector :> EQ_MONO_VECTOR 
    where type elem = Word8.word =
  struct
      
    type elem = Word8.word
    type vector = string

    val etoc : elem -> char = chr o Word8.toInt
    val ctoe : char -> elem = Word8.fromInt o ord

    val maxLen = PreBasis.maxSize + 1
    fun check_size n = if n < 0 orelse n > maxLen then raise Size else n
      
    (* vector creation functions *)
    val str : elem -> string = str o etoc
    fun fromList (xs:elem list):vector = implode (map etoc xs)

    fun tabulate(len, f) =
      let
	val _ = check_size len
	fun next(n, acc) =
	  if n = len then acc else next(n+1, str(f n) :: acc)
      in
	concat(rev(next(0, [])))
      end
  
    val length = size
    fun sub (v,i) = 
      if i < 0 orelse i >= size v
        then raise Subscript
      else ctoe(String.sub(v,i))

    fun check_slice (array,i,SOME j) =
      if i < 0 orelse j < 0 orelse i + j > length array
        then raise Subscript
      else j
      | check_slice (array,i,NONE) =
        let
          val l = length array
        in
          if i < 0 orelse i > l
            then raise Subscript
          else l - i
        end

    fun extract (s, 0, NONE) = s
    |   extract (s, i, len) = 
      let
        val len = check_slice (s, i, len)
      in 
        String.substring(s, i, len)
      end

    val concat = concat (* toplevel string concat *)

    fun appi f (vector, i, j) =
      let
	val l = length vector
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun iterate n =
	  if n >= l then
	    ()
	  else
	    (ignore(f(n, sub(vector, n)));
	     iterate(n+1))
      in
	iterate i
      end

    fun app f vector =
      let
	val l = length vector
	fun iterate n =
	  if n = l then
	    ()
	  else
	    (ignore(f(sub(vector, n)));
	     iterate(n+1))
      in
	iterate 0
      end

    fun foldl f b vector =
      let
	val l = length vector
	fun reduce(n, x) =
	  if n = l then
	    x
	  else
	    reduce(n+1, f(sub(vector, n), x))
      in
	reduce(0, b)
      end

    fun foldr f b vector =
      let
	val l = length vector
	fun reduce(n, x) =
	  if n < 0 then
	    x
	  else
	    reduce(n-1, f(sub(vector, n), x))
      in
	reduce(l-1, b)
      end

    fun foldli f b (vector, i, j) =
      let
	val l = length vector
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun reduce(n, x) =
	  if n >= len then
	    x
	  else
	    reduce(n+1, f(n, sub(vector, n), x))
      in
	reduce(0, b)
      end

    fun foldri f b (vector, i, j) =
      let
	val l = length vector
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun reduce(n, x) =
	  if n < 0 then
	    x
	  else
	    reduce(n-1, f(n, sub(vector, n), x))
      in
	reduce(len-1, b)
      end

    fun map f v =
      let
        val l = size v
        val newS = MLWorks.Internal.Value.alloc_string (l+1)
        val i = ref 0
        val _ =
          while (!i<l) do(
            MLWorks.Internal.Value.unsafe_string_update
             (newS, !i, 
              Word8.toInt(
                f(
                  Word8.fromInt(
                    MLWorks.Internal.Value.unsafe_string_sub (v,!i)))));
            i := !i + 1 )
        val _ = 
          MLWorks.Internal.Value.unsafe_string_update(newS, l, 0)
      in
        newS
      end

    fun mapi f (v, s, l) =
      let
         val l' = check_slice (v, s, l)
         val newS = MLWorks.Internal.Value.alloc_string (l'+1)
         val i = ref 0
         val _ =
           while (!i<l') do (
             MLWorks.Internal.Value.unsafe_string_update
               (newS, !i,
                Word8.toInt (
                  f(
                    !i + s, 
                    Word8.fromInt(
                      MLWorks.Internal.Value.unsafe_string_sub(v, !i+s )))));
             i := !i + 1)
         val _ = 
          MLWorks.Internal.Value.unsafe_string_update(newS, l', 0)
      in
         newS
      end
    
  end
