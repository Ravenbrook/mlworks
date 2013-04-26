(* __builtin_library.sml *)
(*
$Log: __builtin_library.sml,v $
Revision 1.48  1998/02/17 13:59:31  mitchell
[Bug #30349]
Warn when lhs of semicolon does not have type unit

 * Revision 1.47  1997/01/06  15:55:38  andreww
 * [Bug #1818]
 * Adding new floatArray primitives.sml
 *
 * Revision 1.46  1996/05/20  10:04:01  matthew
 * Changing type of word32 shift operations
 *
 * Revision 1.45  1996/04/19  14:28:10  matthew
 * Removing some exceptions
 *
 * Revision 1.44  1996/03/20  10:58:16  matthew
 * Changes for value polymorphism
 *
 * Revision 1.43  1996/03/08  12:11:34  daveb
 * Changed MLWorks.Internal.Dynamic types to new identifier convention.
 *
 * Revision 1.42  1995/09/15  15:24:06  matthew
 * Adding append (l,nil) case
 *
Revision 1.41  1995/09/12  15:03:26  daveb
Added types for different sizes of words and integers.

Revision 1.40  1995/07/28  14:51:03  jont
Remove div and mod as these are now overloaded

Revision 1.39  1995/07/20  15:39:00  jont
Add word operations

Revision 1.38  1995/07/14  09:42:59  jont
Adding chr and ord for char type
Also add relationals

Revision 1.37  1995/05/31  14:42:58  matthew
Removing unnecessary op

Revision 1.36  1995/05/25  11:05:05  matthew
Extending available builtins when compiling this file
Adding ML definitions of append and explode

Revision 1.35  1995/04/28  16:30:49  matthew
Adding CAST and UMAP primitives
Adding new append function
Removing stuff from debugger structure

Revision 1.34  1995/02/10  15:56:30  matthew
Added get_implicit pervasive for use by the debugger

Revision 1.33  1994/11/18  16:55:33  matthew
Added new "unsafe" pervasives

Revision 1.32  1994/11/10  13:36:29  matthew
Bind sqrt to a C function

Revision 1.31  1994/08/31  15:52:44  matthew
Speedups to map

Revision 1.30  1994/07/11  12:51:12  matthew
Use "internal string less" and "internal string greater" for the builtin string operations.
This is sort of a hack for the new lambda optimiser to distinguish when the call_c is
returning an object for the builtin environment and when it is returning something that is to
be used as an ML function.

Revision 1.29  1994/03/09  17:14:37  nickh
Delete not_equal, which is unused and causes a thinning.

Revision 1.28  1993/07/20  13:53:31  jont
Added unsafeintplus primitive

Revision 1.27  1993/04/21  16:57:38  matthew
Added pervasive types in.

Revision 1.26  1993/03/23  12:45:54  jont
Added vector primitives

Revision 1.25  1993/03/04  17:06:30  jont
Added builtin string relationals

Revision 1.24  1993/01/06  10:39:57  richard
Removed some redundant calls to C versions of real number operations.

Revision 1.23  1992/11/25  15:17:05  clive
Made append check for simple cases before entering the stub

Revision 1.22  1992/09/30  12:08:47  clive
Actually defined compose

Revision 1.21  1992/08/27  10:48:15  richard
Removed unnecessary ops and marked some bindings as obsolete.

Revision 1.20  1992/08/24  07:48:41  richard
Added ByteArray primitives.

Revision 1.19  1992/08/20  12:24:43  richard
Added unsafe_sub and unsafe_updated, and changed the bound name
of ml_require.

Revision 1.18  1992/08/17  13:25:12  jont
Added inline ordof

Revision 1.17  1992/08/14  20:10:23  jont
Minor improvements to map

Revision 1.16  1992/08/13  16:34:08  davidt
Added a few extra cases to do simple reverse and map
calls more quickly.

Revision 1.15  1992/07/28  13:45:09  richard
Rewrote everything to communicate with C using the runtime environment
rather than numeric codes.

Revision 1.14  1992/06/23  14:15:30  jont
Changed types of ml_require and call_ml_value to reflect what they
really should be

Revision 1.13  1992/06/19  15:47:23  jont
Added ML_REQUIRE builtin for interpreter

Revision 1.12  1992/06/18  16:21:22  jont
Added new builtin ml_value_from_offset for getting pointers into
middles of code vectors for letrecs

Revision 1.11  1992/06/17  09:40:58  jont
Removed call to c for call_ml_value, now in line

Revision 1.10  1992/06/16  17:03:26  jont
Removed the abstype, wasn't necessary

Revision 1.9  1992/06/15  15:43:07  jont
Added extra functions load_var, load_exn, load_struct, load_funct for
interpreter

Revision 1.8  1992/06/12  18:32:37  jont
Added functions required for interpretive system

Revision 1.7  1992/05/20  10:25:41  clive
Added Bits.arshift - arithmetic right shift

Revision 1.6  1992/05/13  12:02:25  clive
Added the Bits structure

Revision 1.5  1992/03/03  11:19:50  richard
Added inline and external equality.

Revision 1.4  1992/02/24  18:14:27  clive
Mod and Div defined to call the wrong c functions

Revision 1.3  1992/02/19  17:27:03  clive
Neatened the comments

Revision 1.2  1992/02/18  09:53:18  clive
call_c was before equality and hence overrode the builtin call_c

Revision 1.1  1992/02/13  18:05:00  clive
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

(*
    This models the file main/_primitives - there should be an entry for each of the builtin's.
    This file is compiled in a type basis consisting of only the datatypes int,read,string,bool
    with constructors true,false,::,nil and ref defined

 The following are implicitly defined and are not to be used or defined here
            =,~,abs,*,+,-,<,>,<=,>=

 The environment returned by this file is specially adjusted, so dont change the name of the
 BuiltinLibrary_ without a lot of care

 The type signatures given in this file are not very safe, but this is no problem as they may be
 made safer in the real __pervasive_library file

WARNING: there is an implicit assumption in _mir_cg that the exceptions given here are unit
         exceptions - in exn_for_prim there is no attempt to apply the exception to an argument
         this ought to be checked for in the safety code in _toplevel

*)

structure BuiltinLibrary_ :

  sig
    eqtype ml_value
    eqtype 'a array
    eqtype 'a vector
    eqtype bytearray
    eqtype floatarray
    type dynamic
    type type_rep
    type int8
    type word8
    type int16
    type word16
    type int32
    type word32

    exception Bind
    exception Chr
    exception Div
    exception Exp
    exception Interrupt
    exception Io of string
    exception Ln
    exception Match
    exception Ord
    exception Overflow
    exception Range of int
    exception Size
    exception Sqrt
    exception Subscript

    val !			: 'a ref -> 'a
    val /			: real * real -> real
    val :=			: 'a ref * 'a -> unit
    val <>			: ''a * ''a -> bool
    val @			: 'a list * 'a list -> 'a list
    val ^			: string * string -> string
    val alloc_pair		: unit -> 'a
    val alloc_string		: int -> string
    val alloc_vector		: int -> 'a
    val andb			: int * int -> int
    val arctan			: real -> real
    val array			: int * '_a -> '_b
    val arshift			: int * int -> int
    val bytearray		: int * int -> bytearray
    val bytearray_length	: bytearray -> int
    val bytearray_sub		: bytearray * int -> int
    val bytearray_unsafe_sub	: bytearray * int -> int
    val bytearray_unsafe_update	: bytearray * int * int -> unit
    val bytearray_update	: bytearray * int * int -> unit
    val floatarray		: int * real -> floatarray
    val floatarray_length	: floatarray -> int
    val floatarray_sub		: floatarray * int -> real
    val floatarray_unsafe_sub	: floatarray * int -> real
    val floatarray_unsafe_update	: floatarray * int * real -> unit
    val floatarray_update	: floatarray * int * real -> unit
    val call_c			: string -> 'a
    val call_ml_value		: ml_value -> ml_value list
    val cast                    : 'a -> 'b
    val chr			: int -> string
    val char_chr		: int -> char
    val char_equal		: char * char -> bool
    val char_not_equal		: char * char -> bool
    val char_less		: char * char -> bool
    val char_less_equal		: char * char -> bool
    val char_greater		: char * char -> bool
    val char_greater_equal	: char * char -> bool
    val cos			: real -> real
    val exp			: real -> real
    val explode			: string -> string list
    val external_equality	: ''a * ''a -> bool
    val get_implicit		: int -> ml_value
    val floor			: real -> int
    val implode			: string list -> string
    val inline_equality		: ''a * ''a -> bool
    val int_abs			: int -> int
    val int_div			: int * int -> int
    val int_equal		: int * int -> bool
    val int_greater		: int * int -> bool
    val int_greater_or_equal	: int * int -> bool
    val int_less		: int * int -> bool
    val int_less_or_equal	: int * int -> bool
    val int_minus		: int * int -> int
    val int_mod			: int * int -> int
    val int_multiply		: int * int -> int
    val int_negate		: int -> int
    val int_not_equal		: int * int -> bool
    val int_plus		: int * int -> int
    val int32_abs		: int32 -> int32
    val int32_div		: int32 * int32 -> int32
    val int32_equal		: int32 * int32 -> bool
    val int32_greater		: int32 * int32 -> bool
    val int32_greater_equal	: int32 * int32 -> bool
    val int32_less		: int32 * int32 -> bool
    val int32_less_equal	: int32 * int32 -> bool
    val int32_minus		: int32 * int32 -> int32
    val int32_mod		: int32 * int32 -> int32
    val int32_multiply		: int32 * int32 -> int32
    val int32_negate		: int32 -> int32
    val int32_not_equal		: int32 * int32 -> bool
    val int32_plus		: int32 * int32 -> int32
    val length			: 'a  array -> int
    val ln			: real -> real
    val load_exn		: string -> unit
    val load_funct		: string -> unit
    val load_string		: string -> unit
    val load_struct		: string -> unit
    val load_var		: string -> unit
    val lshift			: int * int -> int
    val make_ml_value		: 'a -> ml_value
    val make_ml_value_tuple	: ml_value list -> ml_value
    val map			: ('a -> 'b) -> 'a list -> 'b list
    val umap			: (('a -> 'b) * 'a list) -> 'b list
    val ml_require		: string -> ml_value
    val ml_value_from_offset	: ml_value * int -> ml_value
    val not			: bool -> bool
    val notb			: int -> int
    val o			: ('b -> 'c) * ('a -> 'b) -> ('a -> 'c)
    val orb			: int * int -> int
    val ord			: string -> int
    val char_ord		: char -> int
    val ordof			: string * int -> int
    val real			: int -> real
    val real_abs		: real -> real
    val real_equal		: real * real -> bool
    val real_greater		: real * real -> bool
    val real_greater_or_equal	: real * real -> bool
    val real_less		: real * real -> bool
    val real_less_or_equal	: real * real -> bool
    val real_minus		: real * real -> real
    val real_multiply		: real * real -> real
    val real_negate		: real -> real
    val real_not_equal		: real * real -> bool
    val real_plus		: real * real -> real
    val record_unsafe_sub	: 'a  * int -> 'b
    val record_unsafe_update	: 'a  * int * 'b -> unit
    val rev			: 'a list -> 'a list
    val rshift			: int * int -> int
    val sin			: real -> real
    val size			: string -> int
    val sqrt			: real -> real
    val string_equal		: string * string -> bool
    val string_not_equal	: string * string -> bool
    val string_less		: string * string -> bool
    val string_less_equal	: string * string -> bool
    val string_greater		: string * string -> bool
    val string_greater_equal	: string * string -> bool
    val string_unsafe_sub	: string * int -> int
    val string_unsafe_update	: string * int * int -> unit
    val sub			: 'a array * int -> 'a
    val unsafe_int_plus		: int * int -> int
    val unsafe_int_minus	: int * int -> int
    val unsafe_sub		: 'a array * int -> 'a
    val unsafe_update		: 'a array * int * 'a -> unit
    val update			: 'a array * int * 'a -> unit
    val vector			: 'a list -> 'a vector
    val vector_length		: 'a vector -> int
    val vector_sub		: 'a vector * int -> 'a
    val word32_orb		: word32 * word32 -> word32
    val word32_xorb		: word32 * word32 -> word32
    val word32_andb		: word32 * word32 -> word32
    val word32_notb		: word32 -> word32
    val word32_lshift		: word32 * word -> word32
    val word32_rshift		: word32 * word -> word32
    val word32_arshift		: word32 * word -> word32
    val word32_plus		: word32 * word32 -> word32
    val word32_minus		: word32 * word32 -> word32
    val word32_star		: word32 * word32 -> word32
    val word32_div		: word32 * word32 -> word32
    val word32_mod		: word32 * word32 -> word32
    val word32_equal		: word32 * word32 -> bool
    val word32_not_equal	: word32 * word32 -> bool
    val word32_less		: word32 * word32 -> bool
    val word32_less_equal	: word32 * word32 -> bool
    val word32_greater		: word32 * word32 -> bool
    val word32_greater_equal	: word32 * word32 -> bool
    val word_orb		: word * word -> word
    val word_xorb		: word * word -> word
    val word_andb		: word * word -> word
    val word_notb		: word -> word
    val word_lshift		: word * word -> word
    val word_rshift		: word * word -> word
    val word_arshift		: word * word -> word
    val word_plus		: word * word -> word
    val word_minus		: word * word -> word
    val word_star		: word * word -> word
    val word_div		: word * word -> word
    val word_mod		: word * word -> word
    val word_equal		: word * word -> bool
    val word_not_equal		: word * word -> bool
    val word_less		: word * word -> bool
    val word_less_equal		: word * word -> bool
    val word_greater		: word * word -> bool
    val word_greater_equal	: word * word -> bool
    val xorb			: int * int -> int
  end

=

  struct

    local

      exception LibraryError of string
      val yes : string -> 'a = call_c
      fun no message = fn _ => raise LibraryError message
      val obsolete = no

    in

      exception Bind
      exception Chr
      exception Div
      exception Exp
      exception Interrupt
      exception Io of string
      exception Ln
      exception Match
      exception Ord
      exception Overflow
      exception Range of int
      exception Size
      exception Sqrt
      exception Subscript

      type ml_value = ml_value
      type 'a array = 'a array
      type 'a vector = 'a vector
      type bytearray = bytearray
      type floatarray = floatarray
      type dynamic = dynamic
      type type_rep = type_rep
      type int8 = int8
      type word8 = word8
      type int16 = int16
      type word16 = word16
      type int32 = int32
      type word32 = word32

      (* Some ML definitions of various functions *)
      (* These definitions can use a limited range of builtins *)
      (* In the initial environment they all have type 'a so we *)
      (* locally constrain them to the correct type *)

      (* (we can only use builtins that are compiled inline and do not reference *)
      (* builtin exceptions) *)

      local
        infix 6 + -
        infix 4 <> < > <= >= =
        val int_equal : int * int -> bool = int_equal
        val op <> : int * int -> bool = int_not_equal
        val op > : int * int -> bool = int_greater
        val op >= : int * int -> bool = int_greater_or_equal
        val op < : int * int -> bool = int_less
        val op <= : int * int -> bool = int_less_or_equal
        val op + : int * int -> int = unsafe_int_plus
        val op - : int * int -> int = unsafe_int_minus
        val alloc_vector : int -> 'a vector = alloc_vector
        val vector_unsafe_sub : 'a vector * int -> 'a = record_unsafe_sub
        val vector_unsafe_update : 'a vector * int * 'a -> unit = record_unsafe_update
        val alloc_string : int -> string = alloc_string
        val size : string -> int = size
        val string_unsafe_update : string * int * int -> unit = string_unsafe_update
        val string_unsafe_sub : string * int -> int = string_unsafe_sub
        val cast : 'a -> 'b = cast
        val length : 'a array -> int = length
        val unsafe_sub : '_a array * int -> '_a = unsafe_sub
        val unsafe_update : '_a array * int * '_a -> unit = unsafe_update
        val real : int -> real = real
      (* There are more here -- see _primitives *)
      in

        (* And now we redefine append *)
        (* This function does 2 scans of the first list *)
        (* The first scan, aux1, builds a list of cons cells on *)
        (* the front of the second list *)
        (* The second scan, aux2, destructively updates the new cells *)
        (* to the contents of the first list *)
        (* Note that this is safe for GC *)
        local
          fun aux2 ([],_,res) = res
            | aux2 (a::b,cell,res) =
              let val _ = record_unsafe_update (cell,0,a) 
               in aux2 (b,record_unsafe_sub (cell,1),res) end
            
          fun aux1 ([],res,x) = aux2 (x,res,res)
            | aux1 (a::b,y,x) = 
              let
                val cell = cast (0,y)
              in
                aux1 (b,cell,x)
              end
        in
          (* Wrap this in a test for short cases *)
          fun @ (nil,l) = l
            | @ (l,nil) = l
            | @ ([a],l) = a::l
            | @ ([a,b],l) = a::b::l
            | @ ([a,b,c],l) = a::b::c::l
            | @ ([a,b,c,d],l) = a::b::c::d::l
            | @ ([a,b,c,d,e],l) = a::b::c::d::e::l
            | @ ([a,b,c,d,e,f],l) = a::b::c::d::e::f::l
            | @ ([a,b,c,d,e,f,g],l) = a::b::c::d::e::f::g::l
            | @ ([a,b,c,d,e,f,g,h],l) = a::b::c::d::e::f::g::h::l
            | @ (a::b::c::d::e::f::g::h::r,l) = a::b::c::d::e::f::g::h:: aux1(r,l,r)
        end 

        (* Redefine the explode function!! *)
        local
          fun make_chars (0,acc) = acc
            | make_chars (n,acc) =
              let
                val s = alloc_string 2
              in
                string_unsafe_update (s,0,n-1);
                string_unsafe_update (s,1,0);
                make_chars (n-1,s::acc)
              end
          val char_list = make_chars (256,[])
          val chars = alloc_vector 256
          fun update ([],n) = ()
            | update (c::rest,n) =
              (vector_unsafe_update (chars,n,c);
               update (rest,n+1))
          val _ = update (char_list,0)
        in
          fun explode s : string list =
            let
              (* loop unrolled once *)
              (* chars passed as function argument (so goes in register) *)
              fun aux (n,acc,chars) =
                if n <= 1
                  then
                    if int_equal (n,1)
                      then vector_unsafe_sub (chars,string_unsafe_sub (s,0)) :: acc
                    else acc
                else
                  let
                    val n' = n-1
                    val n'' = n-2
                  in
                    aux (n'',
                         vector_unsafe_sub (chars,string_unsafe_sub (s,n'')) ::
                         vector_unsafe_sub (chars,string_unsafe_sub (s,n')) :: 
                         acc,
                         chars)
                  end
            in
              aux (size s, [], chars)
            end
        end
      end


      fun not true = false
        | not false = true

      local
        fun rev' (done, []) = done
          | rev' (done, x::xs) = rev' (x::done, xs)
      in
        fun rev [] = []
	  | rev (l as [_]) = l
	  | rev l = rev' ([], l)

        (* We seem to use map with short lists a lot so... *)
	fun map f [] = []
	  | map f [x] = [f x]
	  | map f [x,y] = [f x, f y]
	  | map f [x,y,z] = [f x, f y, f z]
	  | map f [x,y,z,w] = [f x, f y, f z, f w]
	  | map f (x :: y :: z :: w :: rest) =
            let
              fun map_sub([], done) = rev' ([], done)
                | map_sub(x :: xs, done) = map_sub (xs, f x :: done)
            in
              f x :: f y :: f z :: f w :: map_sub(rest, [])
            end

        (* We seem to use map with short lists a lot so... *)
	fun umap (f, []) = []
	  | umap (f, [x]) = [f x]
	  | umap (f, [x,y]) = [f x, f y]
	  | umap (f, [x,y,z]) = [f x, f y, f z]
	  | umap (f, [x,y,z,w]) = [f x, f y, f z, f w]
	  | umap (f,(x :: y :: z :: w :: rest)) =
            let
              fun map_sub([], done) = rev' ([], done)
                | map_sub(x :: xs, done) = map_sub (xs, f x :: done)
            in
              f x :: f y :: f z :: f w :: map_sub(rest, [])
            end
      end

      val ! : 'a ref -> 'a =			fn x => no  "deref" x
      val / : real * real -> real =		no  "real divide"
      val := : 'a ref * 'a -> unit =		fn x => no  "becomes" x
      val <> : ''a * ''a -> bool =		fn x => yes "polymorphic inequality" x
      val ^ : string * string ->string  =	yes "string concatenate"
      val o : ('b -> 'c) * ('a -> 'b) -> 'a -> 'c  =	(fn (f,g) => fn x => f(g(x)))
      val alloc_pair : unit -> 'a =	fn x => no  "alloc pair" x
      val alloc_string : int -> string =	no  "alloc string"
      val alloc_vector : int -> 'a =		fn x => no  "alloc_vector" x
      val andb : int * int -> int =		no  "integer bit and"
      val arctan : real -> real =		yes "real arctan"
      val array : int * '_a -> '_b =	fn x => no  "array" x
      val arshift : int * int -> int =		no  "integer bit shift right arithmetic"
      val bytearray : int * int -> bytearray =	no  "bytearray"
      val bytearray_length : bytearray ->int =  no  "bytearray length"
      val bytearray_sub : bytearray * int -> int = no  "bytearray sub"
      val bytearray_unsafe_sub : bytearray * int -> int =
                                            no  "bytearray sub unsafe"
      val bytearray_unsafe_update : bytearray * int * int -> unit =
                                            no  "bytearray update unsafe"
      val bytearray_update : bytearray * int * int -> unit = 
                                            no  "bytearray update"

      val floatarray : int * real -> floatarray =
                                            no  "floatarray"
      val floatarray_length : floatarray -> int =
                                            no  "floatarray length"
      val floatarray_sub : floatarray * int -> real = 
                                            no  "floatarray sub"
      val floatarray_unsafe_sub : floatarray * int -> real = 
                                            no  "floatarray sub unsafe"
      val floatarray_unsafe_update : floatarray * int * real -> unit = 
                                            no  "floatarray update unsafe"
      val floatarray_update : floatarray * int * real -> unit = 
                                            no  "floatarray update"

      val call_c : string -> 'a =		fn x => no  "call_c" x
      val call_ml_value : ml_value -> ml_value list =	obsolete "system call"
      val cast : 'a -> 'b =			fn x => no  "cast" x
      val chr : int -> string =			no  "string chr"
      val char_chr : int -> char =		no  "char chr"
      val char_equal : char * char -> bool =	no  "char equal"
      val char_not_equal : char * char -> bool =no  "char not equal"
      val char_less : char * char -> bool =		no  "char less"
      val char_greater : char * char -> bool =		no  "char greater"
      val char_less_equal : char * char -> bool =	no  "char less equal"
      val char_greater_equal : char * char -> bool =	no  "char greater equal"
      val cos : real -> real =		        yes "real cos"
      val exp : real -> real =                  yes "real exp"
      val external_equality : ''a * ''a -> bool =	fn x => yes "polymorphic equality" x
      val get_implicit : int -> ml_value =		no  "get implicit"
      val floor : real -> int =	no  "real floor" 
      val implode : string list -> string =		yes "string implode"
      val inline_equality : ''a * ''a -> bool =fn x => no  "inline equality" x
      val int_abs : int -> int =		no  "integer abs" 
      val int_div : int * int -> int =			yes "integer divide"
      val int_equal : int * int -> bool =			no  "integer equal"
      val int_greater : int * int -> bool =			no  "integer greater"
      val int_greater_or_equal : int * int -> bool = 	no  "integer greater or equal"
      val int_less : int * int -> bool = 			no  "integer less"
      val int_less_or_equal : int * int -> bool = 		no  "integer less or equal"
      val int_minus : int * int -> int = 			no  "integer minus"
      val int_mod : int * int -> int =			yes "integer modulo"
      val int_multiply : int * int -> int =		yes "integer multiply"
      val int_negate : int -> int =			no  "integer negate"
      val int_not_equal : int * int -> bool =		no  "integer not equal"
      val int_plus : int * int -> int = 		no  "integer plus"
      val unsafe_int_plus : int * int -> int =		no  "unsafe integer plus"
      val unsafe_int_minus : int * int -> int =		no  "unsafe integer minus"
      val int32_abs : int32 -> int32 =			no  "int32 abs"
      val int32_div : int32 * int32 -> int32 =			yes "int32 divide"
      val int32_equal : int32 * int32 -> bool =			no  "int32 equal"
      val int32_greater : int32 * int32 -> bool =		no  "int32 greater"
      val int32_greater_equal : int32 * int32 -> bool = 	no  "int32 greater or equal"
      val int32_less : int32 * int32 -> bool = 			no  "int32 less"
      val int32_less_equal : int32 * int32 -> bool = 		no  "int32 less or equal"
      val int32_minus : int32 * int32 -> int32 = 		no  "int32 minus"
      val int32_mod : int32 * int32 -> int32 =			yes "int32 modulo"
      val int32_multiply : int32 * int32 -> int32 =		yes "int32 multiply"
      val int32_negate : int32 -> int32 =		no  "int32 negate"
      val int32_not_equal : int32 * int32 -> bool =		no  "int32 not equal"
      val int32_plus : int32 * int32 -> int32 = 			no  "int32 plus"
      val length : 'a array -> int =			fn x => no  "array length" x
      val ln : real -> real =				yes "real ln"
      val load_exn : string -> unit =			no  "load exn"
      val load_funct : string -> unit =			no  "load funct"
      val load_string : string -> unit =			no  "load string"
      val load_struct : string -> unit =			no  "load struct"
      val load_var : string -> unit =			no  "load var"
      val lshift : int * int -> int =no  "integer bit shift left"
      val make_ml_value : 'a -> ml_value =	fn x => obsolete "system make ml value" x
      val make_ml_value_tuple : ml_value list -> ml_value =obsolete "system tuple"
      val ml_require : string -> ml_value =			obsolete "system module require"
      val ml_value_from_offset : ml_value * int -> ml_value =no  "system ml value from offset"
      val notb : int -> int =			no  "integer bit not"
      val orb : int * int -> int =		no  "integer bit or"
      val ord : string -> int =		no  "string ord"
      val char_ord : char -> int =	no  "string ord"
      val ordof : string * int -> int =	 	no  "string ordof"
      val real : int -> real =			no  "real"
      val real_abs : real -> real =			no  "real absolute"
      val real_equal : real * real -> bool =			no  "real equal"
      val real_greater : real * real -> bool =		no  "real greater"
      val real_greater_or_equal : real * real -> bool =	no  "real greater or equal"
      val real_less : real * real -> bool =			no  "real less"
      val real_less_or_equal : real * real -> bool =		no  "real less or equal"
      val real_minus : real * real -> real =			no  "real minus"
      val real_multiply : real * real -> real =		no  "real multiply"
      val real_negate : real -> real =			no  "real negate"
      val real_not_equal : real * real -> bool =		no  "real not equal"
      val real_plus : real * real -> real =			no  "real plus"
      val record_unsafe_sub : 'a * int -> 'b =		fn x => no  "record unsafe sub" x
      val record_unsafe_update : 'a * int * 'b -> unit =	fn x => no  "record unsafe update" x
      val rshift : int * int -> int =			no  "integer shift right"
      val sin : real -> real =			yes "real sin"
      val size : string -> int =			no  "string size"
      val sqrt : real -> real =			yes "real square root"
      val string_equal : string * string -> bool =		yes "string equal"
      val string_not_equal : string * string -> bool =            yes "string not equal"
      val string_less : string * string -> bool =			yes "string less"
      val string_greater : string * string -> bool =		yes "string greater"
      val string_unsafe_sub : string * int -> int =		no  "string unsafe sub"
      val string_unsafe_update : string * int * int -> unit =	no  "string unsafe update"
      val sub : 'a array * int -> 'a =				fn x => no  "array sub" x
      val unsafe_sub : 'a array * int -> 'a =			fn x => no  "array sub unsafe" x
      val unsafe_update : 'a array * int * 'a -> unit =		fn x => no  "array update unsafe" x
      val update : 'a array * int * 'a -> unit =			fn x => no  "array update" x
      val vector : 'a list -> 'a vector =			fn x => no  "vector" x
      val vector_length : 'a vector -> int =		fn x => no  "vector length" x
      val vector_sub : 'a vector * int -> 'a =			fn x => no  "vector sub" x
      val word32_orb : word32 * word32 -> word32 =			no  "word32 orb"
      val word32_xorb : word32 * word32 -> word32 =			no  "word32 xorb"
      val word32_andb : word32 * word32 -> word32 =			no  "word32 andb"
      val word32_notb : word32 -> word32 =			no  "word32 notb"
      val word32_lshift : word32 * word -> word32 =		no  "word32 lshift"
      val word32_rshift : word32 * word -> word32 =		no  "word32 rshift"
      val word32_arshift : word32 * word -> word32 =		no  "word32 arshift"
      val word32_plus : word32 * word32 -> word32 =			no  "word32 plus"
      val word32_minus : word32 * word32 -> word32 =		no  "word32 minus"
      val word32_star : word32 * word32 -> word32 =			yes "word32 times"
      val word32_div : word32 * word32 -> word32 =			yes "word32 div"
      val word32_mod : word32 * word32 -> word32 =			yes "word32 mod"
      val word32_equal : word32 * word32 -> bool =		no  "word32 equal"
      val word32_not_equal : word32 * word32 -> bool =		no  "word32 not equal"
      val word32_less : word32 * word32 -> bool =			no  "word32 less"
      val word32_less_equal : word32 * word32 -> bool =		no  "word32 less or equal"
      val word32_greater : word32 * word32 -> bool =		no  "word32 greater"
      val word32_greater_equal : word32 * word32 -> bool =	no  "word32 greater or equal"
      val word_orb : word * word -> word =			no  "word orb"
      val word_xorb : word * word -> word =			no  "word xorb"
      val word_andb : word * word -> word =			no  "word andb"
      val word_notb : word -> word =			no  "word notb"
      val word_lshift : word * word -> word =			no  "word lshift"
      val word_rshift : word * word -> word =			no  "word rshift"
      val word_arshift : word * word -> word =		no  "word arshift"
      val word_plus : word * word -> word =			no  "word plus"
      val word_minus : word * word -> word =			no  "word minus"
      val word_star : word * word -> word =			yes "word multiply"
      val word_div : word * word -> word =			yes "word divide"
      val word_mod : word * word -> word =			yes "word modulus"
      val word_equal : word * word -> bool =			no  "word equal"
      val word_not_equal : word * word -> bool =		no  "word not equal"
      val word_less : word * word -> bool =			no  "word less"
      val word_less_equal : word * word -> bool =		no  "word less or equal"
      val word_greater : word * word -> bool =		no  "word greater"
      val word_greater_equal : word * word -> bool =		no  "word greater or equal"
      val xorb : int * int -> int =			no  "integer bit or exclusive"

      fun string_greater_equal arg = not(string_less arg)
      fun string_less_equal arg = not(string_greater arg)

    end

  end
