(*  ==== INITIAL BASIS :  VECTORS ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __vector.sml,v $
 *  Revision 1.6  1998/02/19 16:43:28  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.5  1997/08/08  16:27:32  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.4  1996/10/03  15:00:11  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.3  1996/05/21  12:22:54  matthew
 *  Updating
 *
 *  Revision 1.2  1996/05/17  11:41:01  jont
 *  maxint has become maxInt
 *
 *  Revision 1.1  1996/05/07  16:49:54  jont
 *  new unit
 *
 *
 *)

require "vector";

structure Vector : VECTOR =
  struct
    structure Bits = MLWorks.Internal.Bits
    
    type 'a vector = 'a MLWorks.Internal.Vector.vector

    val maxLen = MLWorks.Internal.Vector.maxLen
    fun check_size n = if n < 0 orelse n > maxLen then raise Size else n
    fun fromList l = 
      (ignore(check_size (length l)); MLWorks.Internal.Vector.vector l)
    fun tabulate (n,f) = MLWorks.Internal.Vector.tabulate (check_size n, f)
    val length = MLWorks.Internal.Vector.length
    val sub = MLWorks.Internal.Vector.sub
    fun extract(vector, i, j) =
      let
        val veclen = length vector
	val len = case j of
	  SOME len => len
	| NONE => veclen - i
      in
        if i < 0 orelse i > veclen orelse len < 0 orelse i + len > veclen
          then raise Subscript
        else
          tabulate(len, fn n => sub(vector, i+n))
      end

    (* Damn fine bit of code this *)
    fun concat [] = fromList []
      | concat (veclist : 'a vector list) =
        let
          fun count ([],acc) = acc
            | count (a::l,acc) = count (l,length a + acc)
          val size = count (veclist,0)
          val _ = check_size size
          val vector : 'a vector =
                MLWorks.Internal.Value.cast
                  (MLWorks.Internal.Value.alloc_vector size)
          fun loop (i,[]) = ()
            | loop (i,a::l) =
              let
                val s = length a
                fun loop2 (j,k) =
                  if k = s then j
                  else
                    (MLWorks.Internal.Value.unsafe_record_update
                      (vector,j,sub (a,k));
                     loop2 (j+1,k+1))
              in
                loop (loop2 (i,0),l)
              end
        in
          loop (0,veclist);
          vector
        end
            
    fun check_slice (v, i, SOME j) =
      if i < 0 orelse j < 0 orelse i + j > length v
        then raise Subscript
      else j
      | check_slice (v, i, NONE) =
        let
          val l = length v
        in
          if i < 0 orelse i > l
            then raise Subscript
          else l - i
        end

    fun appi f (vector, i, j) =
      let
	val len = check_slice(vector, i, j)
	fun iterate n =
	  if n >= i+len then
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
	val len = check_slice(vector, i, j)
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
	val len = check_slice (vector, i, j)
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
        val l = length v
        fun f' i = f (sub(v, i))
      in
        tabulate (l, f')
      end

   fun mapi f (v, s, l) =
     let 
       val l' = check_slice (v, s, l)
       fun f' i = f (i+s, sub(v, i+s))
     in
       tabulate (l', f')
     end

  end (* of structure Vector *)
