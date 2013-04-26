(*  ==== INITIAL BASIS : charvector structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __char_vector.sml,v $
 *  Revision 1.5  1998/02/19 16:17:28  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.4  1997/08/08  16:15:10  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.3  1997/03/06  17:44:24  jont
 *  [Bug #1938]
 *  Get rid of nasty stuff from __pre_basis
 *
 *  Revision 1.2  1997/01/21  18:29:05  io
 *  [Bug #1892]
 *  update comment
 *
 *  Revision 1.1  1997/01/14  10:37:06  io
 *  new unit
 *  [Bug #1757]
 *  renamed __charvector to __char_vector
 *
 * Revision 1.7  1996/11/04  16:45:03  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.6  1996/10/21  15:22:18  jont
 * Remove references to basis.toplevel
 *
 * Revision 1.5  1996/10/03  13:15:35  io
 * [Bug #1614]
 * convert MLWorks.String
 *
 * Revision 1.4  1996/05/21  12:24:27  matthew
 * UPdating
 *
 * Revision 1.3  1996/05/15  13:07:57  jont
 * pack_words moved to pack_word
 *
 * Revision 1.2  1996/05/01  11:33:58  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1996/04/18  11:25:09  jont
 * new unit
 *
 *  Revision 1.4  1995/05/16  14:37:01  daveb
 *  Removed commented out old code.
 *
 *  Revision 1.1  1995/04/13  16:40:38  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "mono_vector";
require "__string";
require "__pre_basis";

structure CharVector : MONO_VECTOR =
  struct
    type elem = char

    (* The rest is directly copied from __word8_vector *)
    type vector = string 
    val maxLen = PreBasis.maxSize + 1
    fun check_size n = if n < 0 orelse n > maxLen then raise Size else n
    val toint : elem -> int = ord
    val fromint : int -> elem = chr

    (* vector creation functions *)
    fun fromList x = (ignore(check_size (length x)); implode x)
    fun tabulate(len, f) =
      let
	val _ = check_size len
	fun next(n, acc) =
	  if n = len then acc else next(n+1, (f n) :: acc)
      in
	implode(rev(next(0, [])))
      end

    val length = size
    fun sub (v,i) = 
      if i < 0 orelse i >= size v
        then raise Subscript
(*
      else fromint(unsafe_string_sub (v,i))
*)
      else String.sub(v, i)

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

    val extract = 
      fn (s,i,len) =>
      let
        val len = check_slice (s,i,len)
      in 
        String.substring (s,i,len)
      end
    val concat = concat

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

    val map = String.map and mapi = String.mapi

  end
