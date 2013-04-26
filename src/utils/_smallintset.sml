(*  ==== SMALL INTEGER SETS ====
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
 *  The implementation uses arrays of integers which are used as bitfields.
 *  These sets should only be used for densely packed small non-negative
 *  integers.  This implementation was designed for use with packed virtual
 *  registers in the MIR optimiser.
 *
 *  Notes
 *  -----
 *  The structure below opens NewJersey.Array and NewJersey.Bits in order
 *  that SML/NJ can inline the bit and array operations and produce
 *  reasonable code.
 *
 *  Only 16 bits may be used in each integer as shift operations are used to
 *  do the division into array elements.
 *
 *  This functor should be converted to use ByteArrays as soon as they are
 *  implemented.
 *
 *  Revision Log
 *  ------------
 *  $Log: _smallintset.sml,v $
 *  Revision 1.17  1996/11/06 10:53:02  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 * Revision 1.16  1996/05/17  09:19:28  matthew
 * Moving Bits to MLWorks.Internal
 *
 * Revision 1.15  1996/05/07  10:57:25  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.14  1996/04/29  15:08:29  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.13  1994/08/17  16:20:42  matthew
 * Efficiency improvements -- removed ExtendedArray.reduce functions and used unsafe operations
 *
 *  Revision 1.12  1993/10/11  18:03:54  jont
 *  Improved word function inside iterate to avoid rebuilding chunk
 *
 *  Revision 1.11  1993/05/18  14:56:04  jont
 *  Revision integer parameter
 *
 *  Revision 1.10  1992/12/21  16:11:03  daveb
 *  Chnaged references to Array to ExtendedArray, where appropriate.
 *
 *  Revision 1.9  1992/09/03  15:31:44  jont
 *  Changed to use MLWorks improved array operations
 *
 *  Revision 1.8  1992/08/24  14:17:21  richard
 *  Changed MLWorks.Bits to Bits so that New Jersey can inline it.
 *  Oh well.
 *
 *  Revision 1.7  1992/08/10  17:07:58  davidt
 *  Changed MLworks to MLWorks.
 *
 *  Revision 1.6  1992/08/07  16:49:52  davidt
 *  Took out a number of open statements and changed code to
 *  use MLworks structure instead of NewJersey.
 *
 *  Revision 1.5  1992/08/03  10:22:12  jont
 *  Improved implementation of add'
 *
 *  Revision 1.4  1992/06/18  15:06:28  richard
 *  Implemented some more efficient versions of reduce and iterate.
 *
 *  Revision 1.3  1992/06/09  13:10:07  richard
 *  Added checks for identity of sets.  For example, union (x,x)
 *  returns x.
 *
 *  Revision 1.2  1992/06/04  09:06:02  richard
 *  Added is_empty and copy'.
 *
 *  Revision 1.1  1992/06/01  09:37:13  richard
 *  Initial revision
 *
 *)


require "../basis/__int";

require "text";
require "crash";
require "lists";
require "mutableintset";


functor SmallIntSet (structure Text    : TEXT
                     structure Crash   : CRASH
                     structure Lists   : LISTS
                     val int_to_text   : int -> Text.T) : MUTABLEINTSET =
  struct

    structure Bits = MLWorks.Internal.Bits
    structure Text = Text

    fun crash message = Crash.impossible ("SmallIntSet: " ^ message)
    val % = Int.toString

    type T = int MLWorks.Internal.Array.array
    type element = int

    fun min (x : int, y : int) = if x<y then x else y
    fun max (x : int, y : int) = if x>y then x else y

    val update = MLWorks.Internal.Value.unsafe_array_update
    val sub = MLWorks.Internal.Value.unsafe_array_sub
      
    (* Test whether elements from base to base+size-1 of array are zero. *)

    fun zero (set, base, size) =
      let
        fun zero' 0 = true
          | zero' n = sub (set, base+n-1) = 0 andalso zero' (n-1)
      in
        zero' size
      end

    (* Copy elements base to base+size-1 from `from' to `to', returning *)
    (* `to'. *)

    fun copy (to, from, base, size) =
      let
        fun copy' 0 = to
          | copy' n = (update (to, base+n-1, sub (from, base+n-1)); copy' (n-1))
      in
        copy' size
      end

    (* Copy array `set' and resize it to `size' integers. *)

    fun resize (set, size) =
      let
        val current = MLWorks.Internal.Array.length set
        val new = MLWorks.Internal.Array.array (size, 0)
        fun loop i =
          if i = current
            then ()
          else 
            (update (new,i,sub(set,i));
             loop (i+1))
      in
        loop 0;
	new
      end

    val empty = MLWorks.Internal.Array.array (0, 0)

    fun singleton int =
      let
        val index = Bits.rshift (int, 4)
        val mask = Bits.lshift (1, Bits.andb (int, 15))
        val new = MLWorks.Internal.Array.array (index+1, 0)
      in
        update (new, index, mask);
        new
      end

    fun add (set, int) =
      let
        val index = Bits.rshift (int, 4)
        val mask = Bits.lshift (1, Bits.andb (int, 15))
        val new = resize (set, max (MLWorks.Internal.Array.length set, index+1))
      in
        update (new, index, Bits.orb (sub (new, index), mask));
        new
      end

    fun add' (set, int) =
      let
        val index = Bits.rshift (int, 4)
        val mask = Bits.lshift (1, Bits.andb (int, 15))
      in
	if index < MLWorks.Internal.Array.length set then
	  let
	    val old = sub(set, index)
	  in
	    update(set, index, Bits.orb(old, mask));
	    set
	  end
	else
	  let
	    val new = resize(set, index+1)
	  in
	    update(new, index, mask);
	    new
	  end
      end
	
    fun remove (set, int) =
      let
        val size = MLWorks.Internal.Array.length set
        val index = Bits.rshift (int, 4)
      in
        if index >= size then
          set
        else
          let
            val new = resize (set, size)
            val mask = Bits.notb (Bits.lshift (1, Bits.andb (int, 15)))
          in
            update (new, index, Bits.andb (sub (new, index), mask));
            new
          end
      end

    fun remove' (set, int) =
      let
        val size = MLWorks.Internal.Array.length set
        val index = Bits.rshift (int, 4)
      in
        if index >= size then
          set
        else
          let
            val mask = Bits.notb (Bits.lshift (1, Bits.andb (int, 15)))
          in
            update (set, index, Bits.andb (sub (set, index), mask));
            set
          end
      end

    fun member (set, int) =
      let
        val index = Bits.rshift (int, 4)
      in 
        if index >= MLWorks.Internal.Array.length set orelse index < 0
          then false
        else
          let
            val mask = Bits.lshift (1, Bits.andb (int, 15))
          in
            (case Bits.andb (sub (set, index), mask)
               of 0 => false
                | _ => true)
          end
      end

    fun is_empty set =
      set = empty orelse
      let
        val size = MLWorks.Internal.Array.length set
      in
        zero (set, 0, size)
      end

    fun equal (set, set') =
      set = set' orelse
      let
        val size' = MLWorks.Internal.Array.length set'
        val size  = MLWorks.Internal.Array.length set

        fun compare 0 = true
          | compare n = sub (set, n-1) = sub (set', n-1) andalso compare (n-1)
      in
        if size <= size' then
          compare size  andalso zero (set', size, size'-size)
        else
          compare size' andalso zero (set, size', size-size')
      end

    fun subset (set, set') =
      set = set' orelse
      let
        val size' = MLWorks.Internal.Array.length set'
        val size  = MLWorks.Internal.Array.length set

        fun subset' 0 = true
          | subset' n = Bits.andb (sub (set, n-1), Bits.notb (sub (set', n-1))) = 0 andalso subset' (n-1)
      in
        if size <= size' then
          subset' size
        else
          subset' size' andalso zero (set, size', size-size')
      end

    fun intersection (set, set') =
      if set = set' then set else
        let
          val size = min (MLWorks.Internal.Array.length set, MLWorks.Internal.Array.length set')

          val new = MLWorks.Internal.Array.array (size, 0)

          fun intersection' 0 = new
            | intersection' n =
              (update (new, n-1, Bits.andb (sub (set, n-1), sub (set', n-1)));
               intersection' (n-1))
        in
	  intersection' size
        end

    fun intersection' (set, set') =
      if set = set' then set else
        let
          val size = min (MLWorks.Internal.Array.length set, MLWorks.Internal.Array.length set')

          fun intersection' 0 = set
            | intersection' n =
              (update (set, n-1, Bits.andb (sub (set, n-1), sub (set', n-1)));
               intersection' (n-1))
        in
          intersection' size
        end

    fun union (set, set') =
      if set = set' then set else
        let
          val size' = MLWorks.Internal.Array.length set'
          val size = MLWorks.Internal.Array.length set

          val new = MLWorks.Internal.Array.array (max (size, size'), 0)

          fun union' 0 = new
            | union' n =
              (update (new, n-1, Bits.orb (sub (set, n-1), sub (set', n-1)));
               union' (n-1))
        in
          if size <= size' then
	    (MLWorks.Internal.ExtendedArray.iterate_index
	     (fn (index, a) =>
	      update (new, index, Bits.orb (a, sub (set', index))))
	     set;
	     copy (new, set', size, size'-size))
	  else
	    (MLWorks.Internal.ExtendedArray.iterate_index
	     (fn (index, a) =>
	      update (new, index, Bits.orb (a, sub (set, index))))
	     set';
	     copy (new, set, size', size-size'))
        end

    fun union' (set, set') =
      if set = set' then set else
        let
          val size = MLWorks.Internal.Array.length set
          val size' = MLWorks.Internal.Array.length set'
        in
          if size < size' then
            let
              val new = MLWorks.Internal.Array.array (size', 0)
              fun loop i =
                if i = size then ()
                else
                  (update (new,i,Bits.orb (sub(set,i),sub(set',i)));
                   loop (i+1))
            in
              loop 0;
              copy (new, set', size, size'-size)
            end
          else
            let
              fun loop i =
                if i = size' then ()
                else
                  (update (set,i,Bits.orb(sub (set',i),sub(set,i)));
                   loop (i+1))
            in
              (loop 0;
               set)
            end
        end

    fun difference (set, set') =
      if set = set' then empty else
        let
          val size = MLWorks.Internal.Array.length set
          val size' = min (size, MLWorks.Internal.Array.length set')

          val new = MLWorks.Internal.Array.array (size, 0)

          fun difference' 0 = ()
            | difference' n =
              (update (new, n-1, Bits.andb (sub (set, n-1), Bits.notb (sub (set', n-1))));
               difference' (n-1))
        in
          difference' size';
          copy (new, set, size', size - size')
        end

    fun difference' (set, set') =
      if set = set' then empty else
        let
          val size = min (MLWorks.Internal.Array.length set, MLWorks.Internal.Array.length set')

          fun difference' 0 = set
            | difference' n =
              (update (set, n-1, Bits.andb (sub (set, n-1), Bits.notb (sub (set', n-1))));
               difference' (n-1))
        in
          difference' size
        end

    fun cardinality set =
      let
        fun count (c, 0) = c
          | count (c, w) = count (c+1, Bits.andb (w, w-1))

      in
	MLWorks.Internal.ExtendedArray.reducel count (0, set)
      end

    (* reduce and iterate are time critical *)

    fun reduce f (identity, set) =
      let
        val size = MLWorks.Internal.Array.length set

        fun word (result, p, i) =
          if i = size then
            result
          else
            let
              fun chunk (result, p, 0) = result
                | chunk (result, p, w) =
                  let
                    val result' =
                      case Bits.andb (w, 15)
                        of  0 => result
                         |  1 => f (result, p)
                         |  2 => f (result, p+1)
                         |  3 => f (f (result, p), p+1)
                         |  4 => f (result, p+2)
                         |  5 => f (f (result, p), p+2)
                         |  6 => f (f (result, p+1), p+2)
                         |  7 => f (f (f (result, p), p+1), p+2)
                         |  8 => f (result, p+3)
                         |  9 => f (f (result, p), p+3)
                         | 10 => f (f (result, p+1), p+3)
                         | 11 => f (f (f (result, p), p+1), p+3)
                         | 12 => f (f (result, p+2), p+3)
                         | 13 => f (f (f (result, p), p+2), p+3)
                         | 14 => f (f (f (result, p+1), p+2), p+3)
                         | _  => f (f (f (f (result, p), p+1), p+2), p+3)
                  in
                    chunk (result', p+4, Bits.rshift (w, 4))
                  end
            in
              word (chunk (result, p, sub (set, i)), p+16, i+1)
            end
      in
        word (identity, 0, 0)
      end

    fun iterate f set =
      let
        val size = MLWorks.Internal.Array.length set

        fun word (p, i) =
          if i = size then
            ()
          else
	    (chunk (p, sub (set, i));
	     word (p+16, i+1))

	and chunk (p, 0) = ()
	  | chunk (p, w) =
	    (case Bits.andb (w, 15)
	       of  0 => ()
	     |  1 => f p
	     |  2 => f (p+1)
	     |  3 => (f p; f (p+1))
	     |  4 => f (p+2)
	     |  5 => (f p; f (p+2))
	     |  6 => (f (p+1); f (p+2))
	     |  7 => (f p; f (p+1); f (p+2))
	     |  8 => f (p+3)
	     |  9 => (f p; f (p+3))
	     | 10 => (f (p+1); f (p+3))
	     | 11 => (f p; f (p+1); f (p+3))
	     | 12 => (f (p+2); f (p+3))
	     | 13 => (f p; f (p+2); f (p+3))
	     | 14 => (f (p+1); f (p+2); f (p+3))
	     | _  => (f p; f (p+1); f (p+2); f (p+3));
		 chunk (p+4, Bits.rshift (w, 4)))

      in
        word (0, 0)
      end

    fun filter predicate set =
      let
        val size = MLWorks.Internal.Array.length set
        val new = MLWorks.Internal.Array.array (size, 0)

        fun word 0 = new
          | word i =
            let
              val element = sub (set, i-1)
            in
              case element
                of 0 => word (i-1)
                 | _ => 
                   let
                     val base = Bits.lshift (i-1, 4)

                     fun bit (w, 0) = w
                       | bit (w, b) =
                         let
                           val w' =
                             case Bits.andb (Bits.rshift (element, b-1), 1)
                               of 0 => Bits.lshift (w, 1)
                                | _ => Bits.orb (Bits.lshift (w, 1), if predicate (base + b-1) then 1 else 0)
                         in
                           bit (w', b-1)
                         end
                   in
                     update (new, i-1, bit (0, 16));
                     word (i-1)
                   end
            end
      in
        word size
      end

    fun filter' predicate set =
      let
        val size = MLWorks.Internal.Array.length set

        fun word 0 = set
          | word i =
            let
              val element = sub (set, i-1)
              val base = Bits.lshift (i-1, 4)

              fun bit (w, 0) = w
                | bit (w, b) =
                  let
                    val w' =
                      case Bits.andb (Bits.rshift (element, b-1), 1)
                        of 0 => Bits.lshift (w, 1)
                         | _ => Bits.orb (Bits.lshift (w, 1), if predicate (base + b-1) then 1 else 0)
                  in
                    bit (w', b-1)
                  end
            in
              update (set, i-1, bit (0, 16));
              word (i-1)
            end
      in
        word size
      end

    fun to_list set = reduce (fn (list, int) => int::list) ([], set)

    fun from_list list =
      let
        val largest = Lists.reducel max (0, list)
        val new = MLWorks.Internal.Array.array (Bits.rshift (largest, 4) + 1, 0)
      in
        Lists.iterate
        (fn int =>
         let
           val index = Bits.rshift (int, 4)
           val mask = Bits.lshift (1, Bits.andb (int, 15))
         in
           update (new, index, Bits.orb (sub (new, index), mask))
         end)
        list;
        new
      end

    fun to_text set =
      let
        infix ^^
        val (op^^) = Text.concatenate
        val $ = Text.from_string

        val (_, text) =
          reduce (fn ((0, text), int) => (1, int_to_text int)
                   | ((_, text), int) => (1, text ^^ $"," ^^ int_to_text int)) ((0, $""), set)
      in
        $"{" ^^ text ^^ $"}"
      end

    val copy' = MLWorks.Internal.ExtendedArray.duplicate

  end
