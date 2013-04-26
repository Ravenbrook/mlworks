(*  ==== INITIAL BASIS : REAL VECTOR ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Real vectors are identified with MLWorks FloatArrays.
 *
 *  Revision Log
 *  ------------
 *  $Log: __real_vector.sml,v $
 *  Revision 1.4  1999/02/17 14:40:20  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.3  1998/02/19  19:55:03  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.2  1997/08/08  10:56:53  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.1  1997/01/30  14:51:17  andreww
 *  new unit
 *  new real vector stuff which uses builtin floatarray primitives.
 *
 *
 *
 *)


require "mono_vector";
require "__pre_real";

structure RealVector :> MONO_VECTOR where type elem = PreReal.real =
  struct
    structure F = MLWorks.Internal.FloatArray

    type elem = PreReal.real
    type vector = F.floatarray

    val maxLen = F.maxLen

    fun checkSize l = if l<0 orelse l>maxLen then raise Size else l

    fun fromList l =
      if length l>maxLen then raise Size
      else F.from_list l

    fun tabulate (n,f) = F.tabulate(checkSize n,f)

    val length = F.length
    val sub = F.sub

    fun check_slice (vector,i,SOME j) =
      if i < 0 orelse j < 0 orelse i + j > length vector
        then raise Subscript
      else j
      | check_slice (vector,i,NONE) =
        let
          val l = length vector
        in
          if i < 0 orelse i > l
            then raise Subscript
          else l - i
        end


    fun extract(vector,i,j) =
      let
        val len = check_slice(vector,i,j)
      in
        F.tabulate(len,fn n => sub(vector,n+i))
      end

    
    fun concat [] = F.array(0,0.0)
      | concat l =
        let 
          fun addSizes ([],acc) = acc
            | addSizes (h::t,acc) = 
            let val l = length h + acc
            in  if l>maxLen then raise Size
              else addSizes(t,l)
            end
         
          val f = F.array(addSizes(l,0),0.0)
          
          fun copyAll(_,[]) = ()
            | copyAll(idx,h::t) =
            let
              val l = length h
              val _ = F.copy(h,0,l,f,idx)
            in
              copyAll(idx+l,t)
            end
        in
          copyAll(0,l); f
        end


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
	val len = check_slice(vector,i,j)

	fun reduce(n, x) =
	  if n = i+len then
	    x
	  else
	    reduce(n+1, f(n, sub(vector, n), x))
      in
	reduce(i, b)
      end

    fun foldri f b (vector, i, j) =
      let
	val len = check_slice(vector,i,j)

	fun reduce(n, x) =
	  if n < i then
	    x
	  else
	    reduce(n-1, f(n, sub(vector, n), x))
      in
	reduce(i+len-1, b)
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

  end
