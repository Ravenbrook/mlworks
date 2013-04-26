(*  ==== INITIAL BASIS : chararray structure ====
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
 *  $Log: __char_array.sml,v $
 *  Revision 1.4  1999/03/20 21:45:45  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.3  1998/02/19  16:18:54  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.2  1997/01/21  18:29:21  io
 *  [Bug #1892]
 *  update comment
 *
 *  Revision 1.1  1997/01/14  10:36:59  io
 *  new unit
 *  [Bug #1757]
 *  renamed __chararray to __char_array
 *
 * Revision 1.8  1996/10/03  14:46:14  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.7  1996/09/18  15:23:56  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.6  1996/08/16  15:53:40  daveb
 * Removed unused reference to ByteArray.from_string.
 *
 * Revision 1.5  1996/05/21  12:11:37  matthew
 * Updating
 *
 * Revision 1.4  1996/05/17  09:37:54  matthew
 * Moved Bits to MLWorks.Internal.Bits
 *
 * Revision 1.3  1996/05/15  13:09:02  jont
 * pack_words moved to pack_word
 *
 * Revision 1.2  1996/04/23  15:43:36  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:24:40  jont
 * new unit
 *
 *  Revision 1.3  1995/05/16  12:55:35  daveb
 *  Removed commented out old code.
 *
 * Revision 1.1  1995/04/13  13:14:35  jont
 * new unit
 * No reason given
 *
 *
 *)

require "mono_array";
require "__char_vector";

structure CharArray : MONO_ARRAY =
  struct
    val cast = MLWorks.Internal.Value.cast
    type elem = char
    type vector = CharVector.vector

    (* <URI:basis/__word8_array> duplicated here *)
    datatype array = A of MLWorks.Internal.ByteArray.bytearray

    val maxLen = MLWorks.Internal.ByteArray.maxLen

    (* 
     * unsigned comparison is used in the same manner as
     * <URI:basis/__string.sml#extract> 
     * 
     *)
    fun check_size n =
      if (cast n:word) < (cast maxLen:word) then n else raise Size 

    fun array (i: int, e: elem) : array =
      A (MLWorks.Internal.ByteArray.array (check_size i, cast e))

    fun tabulate (i : int, f : int -> elem) : array =
      A (MLWorks.Internal.ByteArray.tabulate (check_size i,cast f))

    (* uses toplevel List.length which is overridden afterwords *)
    fun fromList (l : elem list) : array =
      (ignore(check_size (length l));
       A (MLWorks.Internal.ByteArray.arrayoflist (cast l)))

    val length   : array -> int                     = cast(MLWorks.Internal.ByteArray.length)
    val sub      : (array * int) -> elem            = cast(MLWorks.Internal.ByteArray.sub)
    val update   : (array * int * elem) -> unit     = cast(MLWorks.Internal.ByteArray.update)

    val extract  : (array * int * int option ) -> vector =
      fn (A a,i,len) =>
      let
        val len =
          case len of
            SOME l => l
          | NONE => MLWorks.Internal.ByteArray.length a - i
      in 
        if i >= 0 andalso len >= 0 andalso i + len <= MLWorks.Internal.ByteArray.length a
          then cast(MLWorks.Internal.ByteArray.substring (a,i,len))
        else raise Subscript
      end

    
    fun copy { src=A(src_ba), si, len, dst=A(dst_ba), di } =
      let
        val l = case len of
          SOME l => l
        | NONE => MLWorks.Internal.ByteArray.length src_ba - si
      in
        if si >= 0 andalso l >= 0 andalso si + l <= MLWorks.Internal.ByteArray.length src_ba
          andalso di >= 0 andalso di + l <= MLWorks.Internal.ByteArray.length dst_ba
          then MLWorks.Internal.ByteArray.copy(src_ba, si, si+l, dst_ba, di)
        else raise Subscript
      end

    fun copyv_ba (from, start, len, to, start') =
      let
        val finish = start+len
        val l1 = CharVector.length from
        val l2 = MLWorks.Internal.ByteArray.length to
        val unsafe_update = MLWorks.Internal.Value.unsafe_bytearray_update
        val unsafe_sub = MLWorks.Internal.Value.unsafe_string_sub
      in
        if start < 0 orelse start > l1 orelse start+len > l1 orelse
           start' < 0 orelse start' + len  > l2 then
          raise Subscript
        else
          let
            fun copy' 0 = ()
              | copy' n =
                let
                  val n' = n-1
                in
                  (unsafe_update (to, start'+n', unsafe_sub (from, start+n'));
                   copy' n')
                end
          in
            copy' len
          end
      end

    fun copyVec {src, si, len, dst=A(dst_ba), di} =
      let
        val len =
          case len of
            SOME l => l
          | _ => CharVector.length src - si
      in
        copyv_ba(src, si, len, dst_ba, di)
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

    fun appi f (array, i, j) =
      let
	val l = length array
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun iterate' n =
	  if n >= len then
	    ()
	  else
	    (ignore(f (n, sub (array, n)));
	     iterate'(n+1))
      in
	iterate' i
      end

    fun foldl f b array =
      let
	val l = length array
	fun reduce(n, x) =
	  if n = l then
	    x
	  else
	    reduce(n+1, f(sub(array, n), x))
      in
	reduce(0, b)
      end

    fun foldr f b array =
      let
	val l = length array
	fun reduce(n, x) =
	  if n < 0 then
	    x
	  else
	    reduce(n-1, f(sub(array, n), x))
      in
	reduce(l-1, b)
      end

    fun foldli f b (array, i, j) =
      let
	val l = length array
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun reduce (n, x) =
	  if n >= l then
	    x
	  else
	    reduce(n+1, f(n, sub(array, n), x))
      in
	reduce(i, b)
      end

    fun foldri f b (array, i, j) =
      let
	val l = length array
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun reduce (n, x) =
	  if n < i then
	    x
	  else
	    reduce(n-1, f(n, sub(array, n), x))
      in
	reduce(len-1, b)
      end

    fun modify f array =
      let
	val l = length array
	fun iterate n =
	  if n = l then
	    ()
	  else
	    (update(array, n, f(sub(array, n)));
	     iterate(n+1))
      in
	iterate 0
      end

    fun modifyi f (array, i, j) =
      let
	val l = length array
	val len = case j of
	  SOME len => i+len
	| NONE => l
	fun iterate n =
	  if n >= l then
	    ()
	  else
	    (update(array, n, f(n, sub(array, n)));
	     iterate(n+1))
      in
	iterate i
      end

  end (* structure CharArray *)
