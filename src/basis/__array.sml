(*  ==== INITIAL BASIS : ARRAYS ====
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
 *  Revision Log
 *  ------------
 *  $Log: __array.sml,v $
 *  Revision 1.6  1998/02/19 19:54:24  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.5  1996/10/03  14:45:31  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.4  1996/10/03  13:24:00  io
 *  [Bug #1614]
 *  remove redundant require
 *
 *  Revision 1.3  1996/05/21  12:21:49  matthew
 *  Updating
 *
 *  Revision 1.2  1996/05/17  11:40:53  jont
 *  maxint has become maxInt
 *
 *  Revision 1.1  1996/05/07  15:54:54  jont
 *  new unit
 *
 *
 *)

require "array";

structure Array : ARRAY =
  struct
    structure Bits = MLWorks.Internal.Bits

    type 'a array = 'a MLWorks.Internal.Array.array
    type 'a vector = 'a MLWorks.Internal.Vector.vector

    val maxLen = MLWorks.Internal.ExtendedArray.maxLen

    fun check_size n =
      if n < 0 orelse n > maxLen then raise Size else n

    fun fromList l = 
      (ignore(check_size (length l));
       MLWorks.Internal.Array.arrayoflist l)

    val length = MLWorks.Internal.Array.length

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

    fun array (n,i) = 
      MLWorks.Internal.Array.array (check_size n,i)
    fun tabulate (n,f) = 
      MLWorks.Internal.Array.tabulate (check_size n,f)

    val sub = MLWorks.Internal.Array.sub
    val update = MLWorks.Internal.Array.update

    fun extract(array, i, j) =
      let
        val len = check_slice (array,i,j)
      in
        MLWorks.Internal.Vector.tabulate(len, fn n => sub (array, n+i))
      end

    fun copy {src, si, len, dst, di} =
      let
	val len = check_slice (src,si,len)
      in
	MLWorks.Internal.ExtendedArray.copy(src, si, si+len, dst, di)
      end

    fun copyVec{src : 'a vector, si : int, len, dst : 'a array, di : int} =
      let
	val len = case len of
	  SOME len => len
	| NONE => MLWorks.Internal.Vector.length src-si

	fun copy (from, start, finish, to, start') =
	  let
	    val l1 = MLWorks.Internal.Vector.length from
	    val l2 = length to
	  in
	    if start < 0 orelse start > l1 orelse finish > l1 orelse
	      start > finish orelse
	      start' < 0 orelse start' + finish - start > l2 then
	      raise Subscript
	    else
	      let
		fun copy' 0 = ()
		  | copy' n =
		    let
		      val n' = n-1
		    in
		      (update (to, start'+n', MLWorks.Internal.Vector.sub (from, start+n'));
		       copy' n')
		    end
	      in
		copy' (finish - start)
	      end
	  end
      in
	copy(src, si, si+len, dst, di)
      end

    val app = MLWorks.Internal.ExtendedArray.iterate

    fun appi f (array, i, j) =
      let
        val len = check_slice (array,i,j)
	fun iterate' n =
	  if n >= i + len then
	    ()
	  else
	    (ignore(f (n, sub (array, n)));
	     iterate'(n+1))
      in
	iterate' i
      end

    val foldl = fn f => fn b => fn array => MLWorks.Internal.ExtendedArray.reducel (fn (a, b) => f (b, a)) (b, array)

    val foldr = fn f => fn b => fn array => MLWorks.Internal.ExtendedArray.reducer f (array, b)

    fun foldli f b (array, i, j) =
      let
	val l = length array
        val len = check_slice (array,i,j)
	fun reduce (n, x) =
	  if n = i + len then
	    x
	  else
	    reduce(n + 1, f(n, sub(array, n), x))
      in
	reduce(i, b)
      end

    fun foldri f b (array, i, j) =
      let
        val len = check_slice (array,i,j)
	fun reduce (n, x) =
	  if n < i then
	    x
	  else
	    reduce(n-1, f(n, sub(array, n), x))
      in
	reduce(i + len-1, b)
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
        val len = check_slice (array,i,j)
	fun iterate n =
	  if n = len then () (* we have done *)
	  else
	    (update(array, i+n, f (i+n, sub (array, i+n)));
	     iterate(n+1))
      in
	iterate 0
      end

  end
