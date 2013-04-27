(*  ==== INITIAL BASIS : Lists structure ====
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
 *  $Log: __list.sml,v $
 *  Revision 1.5  1997/05/27 14:27:31  matthew
 *  Adding datatypes
 *
 *  Revision 1.4  1996/10/03  14:51:28  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.3  1996/08/16  14:01:14  io
 *  drop should barf immediately on negative arguments rather than later
 *
 *  Revision 1.2  1996/07/09  12:47:05  andreww
 *  rewriting to use the expanded toplevel functions.
 *
 *  Revision 1.1  1996/05/07  16:17:08  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:30:23  jont
 * new unit
 *
 *  Revision 1.3  1996/03/20  11:13:19  stephenb
 *  Bring up to date with respect to version 1.3 dated 10/1995.
 *  Added take and drop
 *  Removed nthTail
 *
 *  Revision 1.2  1995/05/05  11:32:43  daveb
 *  Removed dependencies on ../utils.
 *
 *  Revision 1.1  1995/04/13  13:22:30  jont
 *  new unit
 *  No reason given
 *
 *
 *)
require "list";

structure List : LIST =
  struct

    datatype list = datatype list

    val op @ = op @
    exception Empty=Empty

(*
    fun hd ([]) = raise Empty
      | hd (h::t) = h

    fun tl ([]) = raise Empty
      | tl (h::t) = t
*)

    val hd = hd
    val tl = tl

    fun last [x] = x
      | last (_::xs) = last xs
      | last [] = raise Empty

    val length = length

(*
    fun length l =
 fun length l =
      let
        fun loop ([], acc) = acc
          | loop (_::t, acc) = loop (t, 1+acc)
      in
        loop (l, 0)
      end
*)
    fun all p [] = true
      | all p (x::xs) = (p x) andalso all p xs

    fun exists P =
      let 
        fun test [] = false
          | test (x::xs) = (P x) orelse test xs
      in
        test
      end

    val app = app

(*
    fun app f [] = ()
      | app f (h :: t) = (f h; app f t)
*)
    fun filter p list =
      let
        fun loop (acc, []) = rev acc
        |   loop (acc, x::xs) =
 	  if p x then loop (x::acc, xs) else loop (acc, xs)
      in
        loop ([], list)
      end

    fun partition p list =
      let
        fun part (ys, ns, []) = (rev ys, rev ns)
        |   part (ys, ns, x::xs) =
          if p x then part (x::ys, ns, xs) else part (ys, x::ns, xs)
      in 
        part ([], [], list)
      end

    fun find f =
      let
	fun red [] = NONE
	  | red (x :: xs) =
	    if f x then SOME x else red xs
      in
	red
      end

    val foldl = foldl
    val foldr = foldr

(*
    fun foldl f i list = 
      let
        fun red (acc, []) = acc
          | red (acc, (x::xs)) = red (f (x, acc), xs)
      in 
        red (i, list)
      end


    fun foldr f i list = 
      let
        fun red (acc, []) = acc
          | red (acc, x::xs) = red (f (x,acc), xs)
      in
        red (i, rev list)
      end
*)
    fun concat x = foldr op@ [] x 

    val map = map

    fun nth ([], _) = raise Subscript
      | nth (x :: _, 0) = x
      | nth (_ :: xs, n) = nth (xs, n-1)


    fun take (_, 0) = []
      | take ([], _) = raise Subscript
      | take (x::xs, n) = x::take (xs, n-1)
	
    fun drop (arg as (xs, n)) = 
      if n < 0 then
	raise Subscript
      else 
	let fun scan (xs, 0) = xs
	      | scan ([], _) = raise Subscript
	      | scan (_::xs, n) = scan (xs, n-1)
	in
	  scan arg
	end

    val null = null

(*
    fun null [] = true
      | null _ = false
*)
    val rev = rev

    fun revAppend([], acc) = acc
      | revAppend(x :: xs, acc) = revAppend(xs, x :: acc)

    fun mapPartial f =
      let
	fun red(acc, []) = rev acc
	  | red(acc, x :: xs) =
	    red((case f x of NONE => acc | SOME x => x :: acc), xs)
      in
	fn list => red([], list)
      end

    fun tabulate(n, f) =
      if n < 0 then
	raise Size
      else
	let
	  fun red(m, acc) = if m = n then rev acc else red(m+1, f m :: acc)
	in
	  red(0, [])
	end

  end (* List *)
