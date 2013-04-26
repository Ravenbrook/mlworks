(* _lists.sml the functor *)
(*
$Log: _lists.sml,v $
Revision 1.21  1998/02/19 16:24:11  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.20  1997/11/25  18:37:28  jont
 * [Bug #30328]
 * Add early exit fold function findOption
 *
 * Revision 1.19  1995/03/29  16:10:25  brianm
 * Added adjoin, rev_append, nthtail.  Changed signature entry for `last'
 * so that it doesn't use equality types.  Noted that `filter' is actually
 * a `reverse and remove duplicates' function - so added `rev_remove_dups'.
 * Incidentally, the new Initial Basis uses `filter' for what we have
 * named `filterp'.
 *
Revision 1.18  1994/05/26  13:56:12  jont
Added msort and check_order

Revision 1.17  1994/03/10  12:16:36  io
adding last

Revision 1.16  1993/10/28  15:34:35  nickh
Merging fixes.

Revision 1.15.1.2  1993/10/27  16:19:15  nickh
Removed function number_with_size, which was (a) difficult to figure out,
(b) inefficient, and (c) only used in particular places in the lambda
optimiser.

Revision 1.15.1.1  1992/09/25  14:55:25  jont
Fork for bug fixing

Revision 1.15  1992/09/25  14:55:25  clive
Tried to optimise the dorting function a bit

Revision 1.14  1992/08/13  16:39:46  davidt
Removed foldl and foldr functions (use reducel and reducer
instead, they are much faster).

Revision 1.13  1992/07/28  13:10:33  jont
Removed internal currying from filter_length. Modified filter to
make less calls to member

Revision 1.12  1992/06/25  08:58:00  davida
Added filter_outp - it's more elegant and efficient
than filterp (not o P).

Revision 1.11  1992/04/16  12:12:44  jont
Added subset function

Revision 1.10  1992/02/03  12:33:29  clive
Added a new version of assoc

Revision 1.9  1991/11/21  17:01:32  jont
Added copyright message

Revision 1.8  91/10/09  11:11:01  davidt

Put in the functions unzip, iterate, filter_length and
number_with_size. Also made a few of the existing implementations
tail recursive.

Revision 1.7  91/10/08  11:13:36  jont
Added number_from and number_from_by_one

Revision 1.6  91/09/30  11:41:05  richard
Added list printing function.

Revision 1.6  91/09/30  10:42:22  richard
Added list print function.

Revision 1.5  91/09/20  16:40:25  davida
Added qsort

Revision 1.4  91/09/17  13:48:31  richard
Added findp function.

Revision 1.3  91/09/05  11:52:49  davida
Added new functions, improved length

Revision 1.2  91/06/13  19:42:00  jont
Added zip function for joining two lists of equal length
Also exception Tl for tl([])

Revision 1.1  91/06/07  15:57:13  colin
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "lists";

functor Lists() :LISTS =
  struct
    exception Assoc
    exception Find
    exception Hd
    exception Last
    exception Nth
    exception Tl
    exception Zip

    fun length ([], acc) = acc
	 | length (_::t, acc) = length(t, 1+acc)

    fun member (_,[]) = false
	 | member (a,h::t) = (a=h) orelse member(a,t)

    fun last [x] = x
	 | last (_::xs) = last xs
	 | last [] = raise Last


    fun rev_append ([],ys) = ys
      | rev_append (x::xs,ys) = rev_append(xs,x::ys)

    fun adjoin(a,l) = if member(a,l) then l else a::l     

    local

      fun adjoin2(a,b,acc) = if a = b then acc else adjoin(a,acc)

      fun filter_sub([],acc) = acc
        | filter_sub([a],acc) = adjoin(a,acc)
        | filter_sub(a::(l as b :: _),acc) = filter_sub(l,adjoin2(a,b,acc))

    in

	 fun filter [] = []
	   | filter(arg as [_]) = arg
	   | filter(x :: xs) = filter_sub(xs, [x])

    end

    val rev_remove_dups = filter
 
    fun filter_length filter_fun filter_list =
	 let
	   fun loop([], n) = n
	     | loop(h :: t, n) = loop(t, if filter_fun h then n+1 else n)
	 in
	   loop(filter_list, 0)
	 end

    fun hd ([]) = raise Hd
	 | hd (h::t) = h
	   
    fun tl ([]) = raise Tl
	 | tl (h::t) = t
	   
    fun difference (nil,x) = nil
	 | difference (hd::tl,x) = 
	   if member (hd,x) then
	      difference (tl,x)
	   else
	      hd :: difference(tl,x)
	      
    fun sublist ([],l2) = true
	 | sublist (h::t,l2) = 
	   member (h,l2) andalso sublist (t,l2)

    fun iterate f [] = ()
	 | iterate f (h :: t) = (ignore(f h); iterate f t)
			  
    fun zip (L1,L2) =
	 let
	   fun loop ([], [], res) = rev res
	     | loop (h1 :: t1, h2 :: t2, res) = loop (t1, t2, (h1, h2) :: res)
	     | loop _ = raise Zip
	 in
	   loop (L1,L2,[])
	 end

    fun unzip L =
	 let
	   fun loop ([], res1, res2) = (rev res1, rev res2)
	     | loop ((p,q)::xs, res1, res2) = loop(xs, p :: res1, q :: res2)
	 in
	   loop (L,[],[])
	 end


    (*  Find the nth element, starting from zero  *)

    fun nth (0, x::_) = x
	 | nth (n, _::t) = nth(n-1,t)
	 | nth _ = raise Nth

    fun nthtail (_,[]) = raise Nth
      | nthtail (0,_::t) = t
      | nthtail (n,_::t) = nthtail(n-1,t)


    (*  Return the number of elements before the given one  *)

    fun find (x,xs) = 
	  let
	     fun count (n,z::zs) = if x=z then n else count(n+1,zs)
	       | count _ = raise Find
	  in 
	     count (0,xs)
	  end


    (*  Find and return an element satisfying a predicate *)

    fun findp predicate list =
	 let
	   fun f [] = raise Find
	     | f (x::xs) =
	       if predicate x then x else f xs
	 in
	   f list
	 end


    (*  filterp: keep elements satisfying P *)

    fun filterp P list =
	  let
	     fun filter (acc,[]) = rev acc
	       | filter (acc,x::xs) = if P x
					 then filter(x::acc,xs)
				      else filter(acc,xs)
	  in
	     filter ([],list)
	  end


    (*  filter_outp: remove elements satisfying P *)

    fun filter_outp P list =
	  let
	     fun filter (acc,[]) = rev acc
	       | filter (acc,x::xs) = if P x
					 then filter(acc,xs)
				      else filter(x::acc,xs)
	  in
	     filter ([],list)
	  end


    (*  Partition a into elements satisfying P and those not  *)

    fun partition P list =
	  let
	     fun part (ys,ns,[]) = (rev ys, rev ns)
	       | part (ys,ns,x::xs) = if P x 
					 then part(x::ys,ns,xs)
				      else part(ys,x::ns,xs)
	  in 
	     part ([],[],list)
	  end

    (* Produce a list with the elements numbered *)

    fun number_from (L, start : int, inc : int, num_fun) =
	 let
	   fun loop ([], result, next) = (rev result, next)
	     | loop (x :: xs, result, i) =
	       loop (xs, (x, num_fun i) :: result, i+inc)
	 in
	   loop (L, [], start)
	 end

    fun number_from_by_one (l, i, f) = number_from (l, i, 1, f)

    (*  Test if a predicate holds for all elements  *)
 
    fun forall P =
	  let 
	     fun test [] = true
	       | test (x::xs) = (P x) andalso test xs
	  in
	     test
	  end;
  

    (*  Test if a predicate holds for at least one element  *)

    fun exists P =
	  let 
	     fun test [] = false
	       | test (x::xs) = (P x) orelse test xs
	  in
	     test
	  end
  

    (*  Lookup in an association list  *)

    fun assoc (key, list) =
	  let
	     fun ass [] = raise Assoc
	       | ass ((thiskey,value)::kvs) = if thiskey=key
						 then value
					      else ass kvs
	  in
	     ass list
	  end


     fun assoc_returning_others(key,list) = 
       let
         fun ass (others,[]) = raise Assoc
           | ass (others,(this as (thiskey,value))::kvs) = if thiskey=key
             then (rev_append(others, kvs),value)
               else ass(this::others,kvs)
       in
         ass([],list)
       end

    (*  Left associative fold on binary functions  *)

    fun reducel f = 
	  let
	    fun red (acc, []) = acc
	      | red (acc, x::xs) = red (f(acc,x), xs)
	  in 
	    red
	  end

    (*  Right associate fold on binary functions  *)

    fun reducer f (list,i) = 
	 let
	   fun red ([], acc) = acc
	     | red (x::xs, acc) = red (xs, f(x,acc))
	 in
	   red (rev list,i)
	 end

    (* Early exit fold function *)

    fun findOption element_fn =
      let
	   fun search [] = NONE
	     | search (x :: xs) = case element_fn x of
	         NONE => search xs
            | x => x
      in
	   search
      end

    (* quicksort *)

    fun merge (order_fn,args) =
	 let
	   fun do_merge (x,[]) = x
	     | do_merge ([],x) = x
	     | do_merge (arg as (h::t),arg' as (a::b)) =
	       if order_fn (h,a) 
		 then h :: do_merge(t,arg')
	       else a :: do_merge(arg,b)
	 in
	   do_merge args
	 end
      
    fun qsort order_fn [] = []
      | qsort order_fn (arg as [x]) = arg
      | qsort order_fn (arg as [a,b]) =
        if order_fn (a,b)
          then arg
        else [b,a]
      | qsort order_fn (a::(rest as [b,c])) =
        merge(order_fn,([a],if order_fn(b,c) then rest else [c,b]))
      | qsort order_fn [a,b,c,d] =
        merge(order_fn,
              (if order_fn(a,b) 
                 then [a,b] 
               else [b,a],
                 if order_fn(c,d)
                   then [c,d] 
                 else [d,c]))
      | qsort order_fn yukky_list =
        let
          fun qs ([],nice_list) = nice_list
            | qs (pivot::xs, sofar) = 
              let
                fun part (left,right,[]) = qs(left, pivot::(qs (right, sofar)))
                  | part (left,right,y::ys) = if order_fn(y,pivot)
                                                then part (y::left,right,ys)
                                              else part (left,y::right,ys)
              in
                part([],[],xs)
              end
        in
          qs (yukky_list,[])
        end

    local
	 fun split' (0,a,b) = (a,b)
	   | split' (n,a::b,c) = split' (n-1,b,a::c)
	   | split' (n,[],res) = ([],res)

	 fun split l =
	   split' (length (l,0) div 2,l,[])
    in
	 fun msort order_fn l =
	   let
	     fun merge ([],l,acc) = rev_append (acc,l)
	       | merge (l,[],acc) = rev_append (acc,l)
	       | merge (l1 as (a::b),l2 as (c::d),acc) =
		 if order_fn (a,c) then 
		   merge (b,l2,a::acc)
		 else
		   merge (l1,d,c::acc)

	     fun mergesort [] = []
	       | mergesort (arg as [x]) = arg
	       | mergesort (arg as [a,b]) =
		 if order_fn (a,b)
		   then arg
		 else [b,a]
	       | mergesort (arg as [a,b,c]) =
		 if order_fn (a,b)
		   then if order_fn (b,c) then arg
			else
			  if order_fn (a,c) then [a,c,b]
			  else [c,a,b]
		 else
		   if order_fn (a,c) then [b,a,c]
		   else
		     if order_fn (b,c) then [b,c,a]
		     else [c,b,a]
	       | mergesort l =
		 let
		   val (l1,l2) = split (l)
		 in
		   merge (mergesort l1,
			  mergesort l2,
			  [])
		 end
	   in
	     mergesort l
	   end
    end

   (* Print nicely *)

    fun to_string _ [] = "[]"
	 | to_string print_element list =
	   let
	     fun p (s,[]) = s
	       | p (s,[x]) = s ^ print_element x
	       | p (s,x::xs) = p(s ^ print_element x ^ ", " , xs)
	   in
	     "[" ^ p ("", list) ^ "]"
	   end

    fun check_order order_fn =
	 let
	   fun check [] = true
	     | check [_] = true
	     | check (x :: (rest as (y :: z))) =
	       order_fn(x, y) andalso check rest
	 in
	   check
	 end

    val length =
	 fn [] => 0
	  | (_ :: xs) => length(xs, 1)

  end
