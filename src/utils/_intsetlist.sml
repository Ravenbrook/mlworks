(*  ==== INTEGER SET ABSTRACT TYPE ====
 *   ===    LIST IMPLEMENTATION    ===
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
 *  Implementation
 *  --------------
 *  This is a straightforward implementation of integer sets using unordered
 *  lists.  Care has been taken to provide an _efficient_ implementation, so
 *  the definition of `remove', for example, may be counter-intuitive.
 *  Redundant cases which check for empty lists are included in several
 *  places.
 *
 *  Revision Log
 *  ------------
 *  $Log: _intsetlist.sml,v $
 *  Revision 1.7  1998/02/19 16:59:01  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 * Revision 1.6  1992/08/04  11:01:01  jont
 * Removed integer parameter
 *
 *  Revision 1.5  1992/06/04  09:05:10  richard
 *  Added is_empty.
 *
 *  Revision 1.4  1992/05/18  14:05:06  richard
 *  Added int_to_text parameter to functor.
 *
 *  Revision 1.3  1992/05/05  10:17:17  richard
 *  Added `filter'.
 *
 *  Revision 1.2  1992/02/28  14:22:58  richard
 *  Corrected the definition of `union' and added `subset', `equal', and
 *  `reduce' & `iterate'.
 *
 *  Revision 1.1  1992/02/27  14:31:10  richard
 *  Initial revision
 *
 *)


require "text";
require "intset";


functor IntSetList (

  structure Text	: TEXT

  val int_to_text : int -> Text.T

) : INTSET =

  struct

    structure Text = Text

    type T = int list
    type element = int

    val empty = []

    fun singleton (x : int) = [x]

    fun member (set, x : int) =
      let
        fun member' [] = false
          | member' (e::es) = if e = x then true else member' es
      in
        member' set
      end

    fun add (set, x) = if member (set, x) then set else x::set

    fun remove (set, x : int) =
      let
        fun find (n, []) = (0, set)
          | find (n, e::es) = if e = x then (n, es) else find (n+1, es)
        fun head (done, 0, _) = done
          | head (done, n, []) = done
          | head (done, n, e::es) = head (e::done, n-1, es)
        val (n, tail) = find (0, set)
      in
        head (tail, n, set)
      end

    fun intersection (_, []) = []
      | intersection ([], _) = []
      | intersection (set, set') =
        let
          fun intersection' (passed, []) = passed
            | intersection' (passed, e::es) =
              if member (set', e) then
                intersection' (e::passed, es)
              else
                intersection' (passed, es)
        in
          intersection' ([], set)
        end

    fun union (set, []) = set
      | union ([], set) = set
      | union (set, set') =
        let
          fun union' (done, []) = done
            | union' (done, e::es) =
              if member (set', e) then
                union' (done, es)
              else
                union' (e::done, es)
        in
          union' (set', set)
        end

    fun difference (set, []) = set
      | difference ([], _) = []
      | difference (set, set') =
        let
          fun difference' (done, []) = done
            | difference' (done, e::es) =
              if member (set', e) then
                difference' (done, es)
              else
                difference' (e::done, es)
        in
          difference' ([], set)
        end

    fun cardinality [] = 0
      | cardinality (e::es) =
        let
          fun length (n, []) = n
            | length (n, e::es) = length (n+1, es)
        in
          length (1, es)
        end

    fun subset ([], _) = true
      | subset (_, []) = false
      | subset (set, set') =
        let
          fun subset' [] = true
            | subset' (e::es) = member (set', e) andalso subset' es
        in
          subset' set
        end

    fun is_empty [] = true
      | is_empty _  = false

    fun equal ([], []) = true
      | equal ([], _) = false
      | equal (_, []) = false
      | equal (set, set') = cardinality set = cardinality set' andalso subset (set, set')

    fun reduce _ (i, []) = i
      | reduce f (i, set) =
        let
          fun reduce' (i, []) = i
            | reduce' (i, e::es) =
              reduce' (f (i, e), es)
        in
          reduce' (i, set)
        end

    fun iterate f [] = ()
      | iterate f set =
        let
          fun iterate' [] = ()
            | iterate' (e::es) = (ignore(f e); iterate' es)
        in
          iterate' set
        end

    fun filter f [] = []
      | filter f set =
        let
          fun filter' (passed, []) = passed
            | filter' (passed, e::es) = 
              filter' (if f e then e::passed else passed, es)
        in
          filter' ([], set)
        end

    fun to_list set = set

    fun from_list [] = []
      | from_list list =
        let
          fun from_list' (done, []) = done
            | from_list' (done, x::xs) =
              if member (done, x) then
                from_list' (done, xs)
              else
                from_list' (x::done, xs)
        in
          from_list' ([], list)
        end

    fun to_text set =
      let
        infix ^^
        val (op^^) = Text.concatenate
        val $ = Text.from_string

        fun to_text' (text, []) = text
          | to_text' (text, [e]) = text ^^ int_to_text e
          | to_text' (text, e::es) =
            to_text' (text ^^ int_to_text e ^^ $", ", es)
      in
        to_text' ($"{", set) ^^ $"}"
      end

  end
