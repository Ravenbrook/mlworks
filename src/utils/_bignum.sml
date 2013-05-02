(* _bignum.sml the functor *)
(*
   Integer Arithmetic to Arbitrary Size.

$Log: _bignum.sml,v $
Revision 1.28  1999/02/02 16:02:02  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.27  1998/02/02  10:07:00  jont
 * [Bug #70056]
 * Fix ~(n+1) div n yields zero bug
 *
 * Revision 1.26  1997/01/14  17:49:19  io
 * [Bug #1757]
 * rename __preinteger to __pre_int
 *
 * Revision 1.25  1997/01/06  14:45:45  matthew
 * Using PreInt instead of Int structure.
 *
 * Revision 1.24  1996/10/28  15:05:31  io
 * moving String from toplevel
 *
 * Revision 1.23  1996/04/30  16:21:18  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.22  1996/04/19  11:07:50  matthew
 * Changes to exceptions
 *
 * Revision 1.21  1996/02/06  16:46:43  jont
 * Fix conversion of negative hex integers to bignums to avoid
 * overflowing as positive (ie convert directly to negative
 * rather than negating the conversin to positive)
 *
Revision 1.20  1996/01/04  12:57:09  matthew
Adding bignum to int function.

Revision 1.19  1995/09/19  14:11:44  daveb
Corrected a mistaken change I made to hex_string_to_bignum.

Revision 1.18  1995/09/15  14:55:02  daveb
Corrected offsets in hex_string_to_bignum.

Revision 1.17  1995/08/24  14:15:53  daveb
Made int_to_bignum handle zero correctly.

Revision 1.16  1995/08/15  12:17:50  jont
Get correct exceptions out for range checking failures on hex conversions

Revision 1.14  1995/08/14  14:55:34  jont
Working on allowing multiple ranges

Revision 1.13  1995/07/27  14:57:09  jont
Fix mod problem with two negative arguments

Revision 1.12  1995/07/27  12:17:47  jont
Modify mod to use divilists so as to avoid overflows on words

Revision 1.11  1995/07/26  13:56:57  jont
Fix problems with word_string_to_bignum

Revision 1.10  1995/07/25  11:38:18  jont
Add operations for words (unsigned ints)

Revision 1.9  1995/07/17  16:49:21  jont
Add hex_string_to_bignum

Revision 1.8  1995/07/17  14:42:35  jont
Add int_to_bignum function

Revision 1.7  1993/07/20  11:44:53  jont
Changed the base integer size to 256 to ensure multiplications can be done
safely

Revision 1.6  1992/03/27  11:20:52  jont
Added require "crash". Disambiguated an integer <

Revision 1.5  1992/02/20  10:15:52  clive
The case    Zero          < (Positive _) = true
was missed out

Revision 1.4  1991/11/21  17:00:19  jont
Added copyright message

Revision 1.3  91/10/22  15:02:53  davidt
Now uses Crash.impossible instead of raising an exception.

Revision 1.2  91/08/30  15:24:22  davida
Added div and mod, fixed conversion
routines to cope with any base.

Revision 1.1  91/08/19  18:24:33  davida
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

require "crash";
require "bignum";
require "^.basis.__string";
require "^.basis.__char";
require "^.basis.__list";

functor BigNumFun
  (structure Crash  : CRASH
   val check_range  : bool
   val largest_int  : string
   val smallest_int : string
   val largest_word : string) : BIGNUM =
struct

  (*  miscellany  *)

  fun int_plus(x, y: int) = x + y

  fun int_minus(x, y: int) = x - y

  fun int_less_eq(x, y: int) = x <= y

  fun strip_zeros (#"0" :: (xs as #"0"::_)) = strip_zeros xs
    | strip_zeros (#"0" :: (xs as _::_)) = xs
    | strip_zeros x = x
     
  (*   Representation is by reversed list of integers representing   *)
  (*   digits in the given radix.  Functions assume they are called  *)
  (*   with correctly represented bignums, in normal form - i.e.     *)
  (*   Zero, or Positive/Negative of some list with no trailing      *)
  (*   (most significant) zeroes.				     *)

  datatype bignum = Positive of int list | Negative of int list | Zero

  val base = 256
  val bigone = Positive [1]

  fun int_to_bignum 0 = Zero
  |   int_to_bignum i =
    if i > 0 andalso i < base then Positive[i]
    else if i < 0 andalso i > ~base then Negative [~i]
    else
      Crash.impossible"int_to_bignum:int too big for simple conversion"

  fun fromHexChar (c:char):int = 
      if #"0" <= c andalso c <= #"9" then
        ord c - ord #"0"
      else if #"A" <= c andalso c <= #"F" then
        ord c - ord #"A" + 10
      else if #"a" <= c andalso c <= #"f" then
        (ord c) - ord #"a" + 10
      else raise Fail ("fromHexChar " ^ (str c))
				 
  (* raise Unrepresentable if the conversion cannot be done *) 
  exception Unrepresentable

  local
    fun convert_intlist ([],acc) = acc
      | convert_intlist (a::rest,acc) =
        convert_intlist (rest,a + base * acc)
        handle Overflow => raise Unrepresentable
  in
    fun bignum_to_int Zero = 0
      | bignum_to_int (Positive l) =
        convert_intlist (rev l,0)
      | bignum_to_int (Negative l) =
        ~ (convert_intlist (rev l,0))
  end

  exception Runtime of string
 
  val Prod_exn = Runtime "Prod"
  and Sum_exn  = Runtime "Sum"
  and Diff_exn = Runtime "Diff"
  and Mod_exn  = Runtime "Mod"
  and Div_exn  = Runtime "Div"
  and Neg_exn  = Runtime "Neg"
  and Abs_exn  = Runtime "Abs"

  (*  operations on digit lists  *)

  fun normilist l =
    let 
      fun strip_zero (0::xs) = strip_zero xs
	| strip_zero xs = xs
    in 
      rev (strip_zero (rev l))
    end
   
  fun addilists (x,y) =
    let 
      fun add (acc, x::xs, y::ys, carry) = add((x+y+carry) mod base :: acc,
					       xs, ys,
					       (x+y+carry) div base)
	| add (acc, [], [], carry) = if carry=0 then rev acc
				     else add(acc,[carry],[],0)
	| add (acc, x::xs, [], carry) = add((x+carry) mod base :: acc,
					    xs, [], (x+carry) div base)
	| add (acc, [], ys, carry) = add(acc, ys, [], carry)
    in 
      normilist(add ([], x, y, 0))
    end
   
  fun subilists (x,y) = 
    let
      fun sbt (acc, x::xs, y::ys, carry) = sbt((x-y+carry) mod base :: acc,
					       xs, ys,
					       (x-y+carry) div base)
	| sbt (acc, [], [], carry) = if carry=0 
				       then rev acc
				     else sbt(acc,[carry],[],0)
	| sbt (acc, xs, [], carry) = if carry=0 
				       then rev acc @ xs
				     else sbt(acc,xs,[~carry],0)
	| sbt (acc, [], y::ys, carry) = sbt((~y+carry) mod base :: acc,
					    [], ys,
					    (~y+carry) div base)
    in
      normilist(sbt ([],x,y,0))
    end


  fun multilists(x: int list, y:int list) =
    let
      val lx = length x and ly = length y

      fun buildpps (shortlist, longlist) = 
	let
	  fun pp dig =
	    let
	      fun formpp (acc,x::xs,carry) = 
		formpp((x*dig+carry) mod base :: acc,
		       xs,
		       (x*dig+carry) div base)
		| formpp (acc,[],carry) = 
		  if carry=0 
		    then rev acc
		  else formpp(acc,[0],carry)
	    in 
	      normilist(formpp ([],longlist,0))
	    end

	  fun shiftleft (pref,acc,[]) = rev acc
	    | shiftleft (pref,acc,x::xs) = shiftleft(0::pref,
						     (pref@x)::acc,
						     xs)
	in
	  shiftleft([],[],map pp shortlist)
	end
    in
      foldl addilists [] (buildpps (if lx<ly then (x,y) else (y,x)))
      (* Lists.reducel addilists ([],buildpps (if lx<ly then (x,y) else (y,x))) *)
    end

  fun ltilists(x:int list, y:int list) = 
    let
      val lx=(length x) and ly=(length y)

      fun lt ([],[]) = false
	| lt ([x:int],[y]) = x<y
	| lt (x::xs,y::ys) = x<y orelse (x=y andalso lt(xs,ys))
	| lt _ = Crash.impossible "ltilists"
    in
      (lx < ly) orelse (lx=ly andalso lt(rev x,rev y))
    end

 (*  With hearty thanks for the next one due to  *)
 (*  that ol' prankster, Don E. Knuth himself.   *) (*<Ref ACP, Vol2, 4.3.1>*)

 (*  ...and also to nickh for suggesting that Knuth was bound to have an  *)
 (*  ace way of doing long division.  If any one dares to say "overkill", *)
 (*  well... 								  *)

  local
    fun fst (x,_) = x

    fun split (n,xs) =
      let
	fun take(0, acc, xs) = (rev acc, xs)
	  | take(n, acc, x::xs) = take(n-1, x::acc, xs)
	  | take(_, _, []) = Crash.impossible "split"
      in
	take (n, [], xs)
      end

    fun pad (n,xs) = 
      let
	fun padzero (0,xs) = xs
	  | padzero (n,xs) = padzero(n-1,0::xs)
      in
	if (length xs<n)
	  then padzero(n - (length xs),xs) 
	else xs
      end

  in
    (*  divilists takes a pair (u,v) of reversed digit lists, and  *)
    (*  returns a pair (q,r) where q = u div v and r = u mod v     *)
    (*  Division by zero (empty list) returns (0,u).               *)

    fun divilists ([]:int list, v:int list) = ([],[])
      | divilists (u, [v]) =
    (* the Noddy Algorithm *)
	let 
	  fun noddy(qs,u::us,r) = noddy(((r*base+u) div v)::qs, 
					us, 
					(r*base+u) mod v)
	    | noddy(qs,[],r) = (normilist qs, normilist [r])
	in
	  noddy ([],rev u,0)
	end
      | divilists (u', v') =
	if (length u') >= (length v')
	  then
	    (* the Well-Hard Algorithm *)
	    let
	      val n = length v'
	      val m = (length u') - n
	      val b = base

	      (* Normalise *)

	      val d = b div (hd (rev v') + 1)

	      val u = let
			val u'' = multilists(u',[d])
		      in 
			if (length u'')=(length u')
			  then u''@[0]
			else u''
		      end

	      val v = multilists(v',[d])
	      val (v1,v2) = case (rev v) of
		(v1::v2::_) => (v1,v2)
	      | _ => Crash.impossible "size of v in divilists"


	      (* Division Loop *) 

	      fun well_hard (us, qs, ~1) = (normilist qs, 
					    fst(divilists(normilist
							  (rev us), [d])))

		| well_hard (us as uj::uj1::uj2::_, qs, jm) = 
		  let 
		    val (u,urest) = split(n+1,us)

		    (* Calculate qhat *)

		    fun fiddle_qhat qhat = 
		      if (qhat*v2) > ((uj*b + uj1 - qhat*v1) * b + uj2)
			then fiddle_qhat (qhat-1)
		      else qhat

		    val qhat = fiddle_qhat (if uj=v1
					      then b-1
					    else (uj*b + uj1) div v1)

		    (* Multiply and Subtract *)

		    val (qj,u) =
		       let
			 val qhv = multilists(v, [qhat])
		       in
			  if ltilists(normilist (rev u), qhv)
			    then
			      let
				val u' = addilists(pad(n+1,[1]),
						   normilist (rev u))
				val bcomp = subilists(u',qhv)
			      in
				(qhat-1, rev(addilists(v,bcomp)))
			      end
			  else
			    (qhat, rev (subilists(normilist (rev u), qhv)))
		       end
		  in
		    well_hard((tl (pad(n+1,u)))@urest, qj::qs, jm-1)
		  end
		| well_hard (us,qs,jm) = Crash.impossible "well hard"
	    in
	      well_hard (rev u, [], m)
	    end
	else ([],u')
  end


 (*  converting to and from strings  *)

  fun bignum_to_string bn =
    let
      fun barbeque (digs, value) = 
	let 
	  val (q,r) = divilists(value, [10])
	in 
	  if q=[] (* i.e. zero *)
	    then (r@digs)
	  else barbeque((case r of []=>0 | [r]=>r | _=> 
			   Crash.impossible "base in b_to_s")::digs, q)
	end

      fun chargrill il = implode (strip_zeros (map (fn c=>chr (c + ord #"0"))
					       (barbeque([],il))))
    in
      case bn of
	Positive il => chargrill il
      | Negative il => str #"~" ^ (chargrill il)
      | Zero => "0"
    end

  fun string_to_bignum s =  (* NB: assumes base>10 *)
    let
      val (signval,rest) = case explode s of
	(#"~" :: ss) => (false,strip_zeros ss)
      | ss => (true,strip_zeros ss)

      fun make_big (biglist, []) = biglist
	| make_big (biglist, c::cs) = 
	  let
	    val digval = ord c - ord #"0"
	    val biglist' = addilists(multilists(biglist, [10]),
				     [digval])
	  in
	    make_big (biglist',cs)
	  end
    in
      if List.all Char.isDigit rest then
	case rest of
	  [#"0"]  => Zero
	| _ => let
		 val ilist = make_big ([],rest)
	       in
		 if signval then
		   Positive ilist
		 else 
		   Negative ilist
	       end
      else
	Crash.impossible ("string_to_bignum: bad characters in string '" ^ s ^ "'")
(*
      else
	(output(std_out, "string_to_bignum: bad characters in string '" ^ s ^ "'\n");
	 raise Match)
*)
    end

  (************************)
  (*  THE BIGNUM ROUTINES *)
  (************************)

  infix 4  eq <>  <  >  <=  >=
  infix 6  +  -
  infix 7  div  mod  *

  (************************)
  (* Relational Operators *)
  (************************)
   
  fun Zero         eq Zero         = true
    | (Positive x) eq (Positive y) = x=y
    | (Negative x) eq (Negative y) = x=y
    |      _       eq      _       = false

  fun x <> y = not(x eq y)

  fun Zero          < Zero         = false
    | Zero          < (Positive _) = true
    | (Positive x)  < (Positive y) = ltilists(x,y)
    | (Negative x)  < (Negative y) = ltilists(y,x)
    | (Negative x)  <     _        = true
    |      _        <     _        = false

  fun x <= y = (x eq y) orelse (x < y)

  fun x > y = not(x <= y)

  fun x >= y = not(x < y)


  (*  range_check also normalises bignums - normal form is Zero else  *)
  (*  shortest possible list of ints  (i.e. no trailing zeros)        *)
  (* word_range_check does the same but for unsigned values           *)
  local
    val maximum_positive = string_to_bignum largest_int
    val minimum_negative = string_to_bignum smallest_int
    val maximum_positive_word = string_to_bignum largest_word
  in
    fun normalise x =          (* ensure in normal form *)
      case x of 
	Zero => Zero
      | Positive l => (case normilist l of
			   [] => Zero
			 | x => Positive x)
      | Negative l => (case normilist l of
			   [] => Zero
			 | x => Negative x)

    fun range_check(bignum, exn) =
      let
	val rc =
	  if check_range then
	    fn Zero => Zero
	     | (n as Positive _) =>
		 if n <= maximum_positive then n else
		   ((*output(std_out, "Raising on " ^ bignum_to_string n ^ "\n");*)
		    raise exn)
	     | (n as Negative _) =>
		 if n >= minimum_negative then n else
		   ((*output(std_out, "Raising on " ^ bignum_to_string n ^ "\n");*)
		    raise exn)
	  else
	    fn x => x
      in
	rc(normalise bignum)
      end

    fun word_range_check(bignum, exn) =
      let
	val rc =
	  if check_range then
	    fn Zero => Zero
	     | (n as Positive _) =>
		 if n <= maximum_positive_word then n else
		   ((*output(std_out, "Raising on " ^ bignum_to_string n ^ "\n");*)
		    raise exn)
	     | (n as Negative _) => raise exn
	  else
	    fn x => x
      in
	rc(normalise bignum)
      end
  end

  (****************)   
  (*  Arithmetic  *)
  (****************)   

  fun neg Zero = Zero                   (*  for internal use  *)
    | neg (Positive x) = Negative x
    | neg (Negative x) = Positive x

  fun ~x = range_check(neg x, Neg_exn)

  fun abs Zero = Zero
    | abs (Positive x) = Positive x
    | abs (Negative x) = range_check(Positive x, Abs_exn)

  fun (Positive x) + (Positive y) =range_check(Positive(addilists(x,y)),Sum_exn)
    | (Negative x) + (Negative y) =range_check(Negative(addilists(x,y)),Sum_exn)
    | (Positive x) + (Negative y) = 
      if x=y then Zero 
      else if (Positive x) > (Positive y) 
	     then range_check(Positive(subilists(x,y)),Sum_exn)
	   else range_check(Negative(subilists(y,x)),Sum_exn)
    | Zero         + anything     = anything
    | x + y = y + x

  fun x - y = (x + (neg y)) handle Runtime "Sum" => raise Diff_exn

  fun Zero        * anything    = Zero
    | anything    * Zero        = Zero
    | (Positive x)*(Positive y) =range_check(Positive(multilists(x,y)),Prod_exn)
    | (Negative x)*(Negative y) =range_check(Positive(multilists(x,y)),Prod_exn)
    | (Positive x)*(Negative y) =range_check(Negative(multilists(x,y)),Prod_exn)
    | (Negative x)*(Positive y) =range_check(Negative(multilists(x,y)),Prod_exn)

  fun word_plus((Positive x), (Positive y)) =
    word_range_check(Positive(addilists(x,y)), Sum_exn)
    | word_plus(x as Positive _, Zero) = x
    | word_plus(x as Negative _, _) = Crash.impossible"word_plus: negative values"
    | word_plus(Zero, Zero) = Zero
    | word_plus(x, y) = word_plus(y, x)

  fun word_star(Zero, _) = Zero
    | word_star(Positive x, Positive y) =
      word_range_check(Positive(multilists(x, y)), Prod_exn)
    | word_star(Negative _, _) =
      Crash.impossible"word_star: negative values"
    | word_star(x, y) = word_star(y, x)

  fun is_positive (Positive _) = true
    | is_positive _ = false

  local
    fun divit((u,v), sign) =
      if u=v then sign [1]
      else if ltilists(u,v) then Zero
	   else 
	     let 
	       val (quotient,_) = divilists(u,v)
	     in 
	       range_check (sign quotient, Runtime "div range")
	     end
  in
    fun            _ div Zero         = raise Div_exn
      |         Zero div _            = Zero
      | (Positive i) div (Positive d) = divit((i,d), Positive)
      | (Negative i) div (Negative d) = divit((i,d), Positive)
      | (Positive i) div (Negative d) =
	divit((subilists(i,[1]),d), Negative) - bigone
      | (Negative i) div (Positive d) =
	divit((subilists(i,[1]),d), Negative) - bigone
  end

  fun _ mod Zero = raise Mod_exn
    | Zero mod _ = Zero
    | i mod d    =
      let
	fun modi(i, d) =
	  let
	    val (_, r) = divilists(i, d)
	  in
	    r
	  end

	val r = case (i, d) of
	  (Positive i', Positive d') => normalise(Positive(modi(i', d')))
	| (Negative i', Positive d') =>
	    let
	      val r = Positive(modi(i', d'))
	    in
	      case normalise r of
		Zero => Zero
	      | _ => d - r
	    end
	| (Positive i', Negative d') =>
	    let
	      val r = Positive(modi(i', d'))
	    in
	      case normalise r of
		Zero => Zero
	      | _ => r + d
	    end
	| (Negative i', Negative d') =>
	    let
	      val r = Positive(modi(i', d'))
	    in
	      case normalise r of
		Zero => Zero
	      | r => neg r
	    end
	| _ => Crash.impossible"mod: unexpected case"
      in
	r
      end

    fun quot(a, b) =
      let
        val q = a div b
        val r = a mod b
      in
        if r = Zero orelse (a > Zero andalso b > Zero) orelse
	   (a < Zero andalso b < Zero) then
          q
        else
          q + bigone
      end

    fun rem(a, b) =
      let
        val r = a mod b
      in
        if r = Zero orelse (a > Zero andalso b > Zero) orelse
	   (a < Zero andalso b < Zero) then
          r 
        else
          r - b
      end

  val bignum_sixteen = int_to_bignum 16

  fun convert_hex_to_bignum(chars, ptr) =
    let
      val size = size chars
      fun do_hex_digit(ptr', acc) =
	if int_less_eq(size, ptr') then acc
	else
	  let
	    val digit =
	      fromHexChar (String.sub (chars, ptr'))
	  in
	    do_hex_digit(int_plus(ptr', 1), (bignum_sixteen * acc) +
			 int_to_bignum digit)
	  end
    in
      do_hex_digit(ptr, Zero)
    end

  fun neg_convert_hex_to_bignum(chars, ptr) =
    let
      val size = size chars
      fun do_hex_digit(ptr', acc) =
	if int_less_eq(size, ptr') then acc
	else
	  let
	    val digit = fromHexChar (String.sub (chars, ptr'))
	  in
	    do_hex_digit(int_plus(ptr', 1), (bignum_sixteen * acc) -
			 int_to_bignum digit)
	  end
    in
      do_hex_digit(ptr, Zero)
    end

  fun convert_hex_word_to_bignum(chars, ptr) =
    let
      val size = size chars
      fun do_hex_digit(ptr', acc) =
	if int_less_eq(size, ptr') then acc
	else
	  let
	    val digit = fromHexChar (String.sub (chars, ptr'))
	  in
	    do_hex_digit(int_plus(ptr', 1),
			 word_plus(word_star(bignum_sixteen, acc),
				   int_to_bignum digit))
	  end
    in
      do_hex_digit(ptr, Zero)
    end

  (*  for export  *)

  fun hex_string_to_bignum (chars:string) =
    (if String.sub (chars, 0) = #"~" then
       neg_convert_hex_to_bignum (chars, 3)
     else
       convert_hex_to_bignum(chars, 2))
       handle Runtime _ => raise Unrepresentable

  fun hex_word_string_to_bignum chars =
    (convert_hex_word_to_bignum(chars, 3))
    handle Runtime _ => raise Unrepresentable
      

  fun word_string_to_bignum (x:string) = 
    if String.isPrefix "0w" x then
      word_range_check (string_to_bignum (substring (x, 2, int_minus(size x, 2))),
			Unrepresentable)
    else
      Crash.impossible ("word_string_to_bignum:bad word string '" ^ x ^ "'")
      
  val string_to_bignum = fn s=>range_check(string_to_bignum s, Unrepresentable)
    
end (* functor BigNumFun *)
