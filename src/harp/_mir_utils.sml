(* _mir_utils.sml the functor *)
(*
$Log: _mir_utils.sml,v $
Revision 1.67  1998/08/26 13:43:21  jont
[Bug #20119]
Stop combine creating empty blocks

 * Revision 1.66  1997/03/06  16:03:34  jont
 * [Bug #1938]
 * Remove __pre_basis from require list
 *
 * Revision 1.65  1997/01/16  11:53:58  matthew
 * Rationalizing MIR arithmetic.
 *
 * Revision 1.64  1997/01/03  13:55:00  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.63  1996/11/06  11:08:09  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.62  1996/11/04  15:07:15  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.61  1996/10/30  21:23:21  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.60  1996/05/21  15:37:19  matthew
 * WORD32LSHIFT takes a word second argument now.
 *
 * Revision 1.59  1996/04/30  16:51:39  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.57  1996/04/29  14:47:05  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.56  1996/04/19  14:14:31  matthew
 * Exception changes
 *
 * Revision 1.55  1996/01/31  16:18:52  jont
 * Add functions for saving raw 32 bit values as boxed values
 *
Revision 1.54  1995/12/20  13:05:34  jont
Removing Option in favour of MLWorks.Option

Revision 1.53  1995/09/15  16:17:51  daveb
The routines for converting long integers were failing to handle minint.

Revision 1.52  1995/09/12  18:05:54  daveb
Added new types for different sizes of ints, words, and reals.

Revision 1.51  1995/07/27  12:17:06  jont
Get use of sign correct in convert_word

Revision 1.50  1995/07/25  13:40:00  jont
Add word conversion functions

Revision 1.49  1995/07/18  11:16:43  jont
convert_hex_to_bignum moved into bignum module

Revision 1.48  1995/07/17  14:43:46  jont
Allow conversion of hex integers
including outsize integers

Revision 1.47  1995/05/23  10:12:52  matthew
Removed check on GCness of function
This caused a compiler fault with eg. (cast 0) 0

Revision 1.46  1995/03/17  19:50:56  daveb
Removed ununsed parameter Print.

Revision 1.45  1995/02/15  14:55:05  matthew
Removed NewMap from Debugger_Types

Revision 1.44  1995/02/07  17:07:24  matthew
Removing unused LambdaSub

Revision 1.43  1995/01/05  11:18:31  matthew
Rationalizing debugger

Revision 1.42  1994/11/04  17:59:05  jont
Remove superfluous adds when calculating self closure

Revision 1.41  1994/10/14  14:55:05  matthew
Make lookup_in_closure return an Option value
Some efficiency improvements -- reduce number of lookups of variables
and diddled about with appending lists of lists.

Revision 1.40  1994/10/10  10:12:33  matthew
Changes to lambda calculus

Revision 1.39  1994/09/19  13:53:05  matthew
Changes to lambdatypes

Revision 1.38  1994/08/25  11:12:30  matthew
Adding stuff for multiple argument passing

Revision 1.37  1994/08/09  15:30:07  nickh
Mistake in lift_externals.

Revision 1.36  1994/07/25  11:41:04  matthew
Added support for multiple arguments to functions.
Not complete yet, but should be OK for single argument case.

Revision 1.35  1994/06/03  12:51:38  jont
Fix register undefined following self tail call problem

Revision 1.34  1994/03/04  13:07:33  jont
Log: Changes for automatic_callee mechanism removal
and moving machspec from machine to main

Revision 1.33  1994/01/19  10:43:23  matthew
Added ConvertInt exception to MirUtils

Revision 1.33  1994/01/19  10:43:23  matthew
Convert_int raises ConvertInt exception

Revision 1.32  1993/09/06  09:15:52  nosa
FNs now passed closed-over type variables and
stack frame-offset for runtime-instance for polymorphic debugger.

Revision 1.31  1993/08/19  14:50:47  jont
Fixed bug in needs_transform to look inside the arguments to builtins

Revision 1.30  1993/08/18  16:28:04  jont
Moved some more functions here from _mir_cg.sml

Revision 1.29  1993/07/30  14:50:25  nosa
Changed type of new_do_app for local and closure variable
inspection in the debugger;
structure Option.

Revision 1.28  1993/07/26  16:57:57  jont
Fixed bug where host longest int might be unrepresentable in target

Revision 1.27  1993/07/20  12:08:55  jont
Added support for code generation of long ints by transforming the lambda
calculus to expressions involving shifts and adds

Revision 1.26  1993/05/18  14:14:58  jont
Removed Integer parameter

Revision 1.25  1993/04/27  10:46:10  richard
Removed unused option refs.

Revision 1.24  1993/03/10  17:15:40  matthew
Signature revisions

Revision 1.23  1993/03/01  15:01:13  matthew
Added MLVALUE lambda exp

Revision 1.22  1993/01/21  18:30:33  jont
Made copy_n tail recursive

Revision 1.21  1992/12/01  11:48:55  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.20  1992/11/30  10:36:22  jont
Removed a large number of unnecessary map operations

Revision 1.19  1992/11/25  14:37:55  daveb
Fixed bug in tail optimisation code.
Also removed redefinition of append.

Revision 1.18  1992/10/07  12:51:45  clive
Convert on most negative integer failed

Revision 1.17  1992/09/01  11:28:51  clive
Added switches for self call optimisation

Revision 1.16  1992/08/26  14:44:10  jont
Removed some redundant structures and sharing

Revision 1.15  1992/08/19  18:06:33  davidt
Mir_Env now uses Map instead of Map.

Revision 1.14  1992/08/14  13:48:08  davidt
Changed ord(substring ...) to ordof.

Revision 1.13  1992/08/07  17:59:46  davidt
String structure is now pervasive.

Revision 1.12  1992/08/07  11:36:02  clive
Added a flag to turn off tail-call optimisation

Revision 1.11  1992/07/27  15:12:05  jont
Shortened various exit blocks (should be done by expression analyser)

Revision 1.10  1992/07/21  11:41:13  jont
Rewrote cg_lvar to use exceptions instead of is_in...

Revision 1.9  1992/07/01  14:27:00  davida
Added LET constructor and new slot to APP.

Revision 1.8  1992/06/29  09:20:54  clive
Added type annotation information at application points

Revision 1.7  1992/06/11  09:22:45  clive
Added slot for slot in FNexp

Revision 1.6  1992/05/13  09:30:41  jont
Changed to use augmented lambda calculus, and sexpressions to avoid
duplicated append operations.

Revision 1.5  1992/05/06  13:50:55  jont
Removed some no longer used functions. Tidied up in places, using
reducer for appends instead of reducel. Accidentally fixed a problem
in build_args_for_tail caused by the int_reg_list being in reverse order
(real fix is in _interproc)

Revision 1.4  1992/04/24  16:28:00  jont
Changed reducel op @ to reducer op @ to avoid quadratic behaviour

Revision 1.3  1992/04/14  09:04:19  clive
First version of the profiler

Revision 1.2  1992/04/10  17:31:10  jont
Fixed minor potential problem with tupling real values

Revision 1.1  1992/04/07  19:56:36  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "^.basis.__int";
require "^.basis.__string";
require "^.basis.__char";

require "../utils/sexpr";
require "../utils/diagnostic";
require "../utils/lists";
require "../utils/crash";
require "../utils/bignum";
require "../main/pervasives";
require "../main/library";
require "../typechecker/types";
require "mirregisters";
require "mir_env";
require "mir_utils";


functor Mir_Utils(
  structure Sexpr : SEXPR
  structure Diagnostic : DIAGNOSTIC
  structure Lists : LISTS
  structure Crash : CRASH
  structure BigNum : BIGNUM
  structure BigNum32 : BIGNUM
  structure Pervasives : PERVASIVES
  structure Library : LIBRARY
  structure Types : TYPES
  structure MirRegisters : MIRREGISTERS
  structure Mir_Env : MIR_ENV

  sharing Mir_Env.LambdaTypes = Library.AugLambda.LambdaTypes
  sharing Mir_Env.LambdaTypes.Ident = Types.Datatypes.Ident
  sharing Mir_Env.MirTypes = MirRegisters.MirTypes
  sharing type Pervasives.pervasive = Mir_Env.LambdaTypes.Primitive
  sharing type Types.Datatypes.Type = Mir_Env.LambdaTypes.Type
) : MIR_UTILS =
struct
  structure Sexpr = Sexpr
  structure Diagnostic = Diagnostic
  structure AugLambda = Library.AugLambda
  structure LambdaTypes = Mir_Env.LambdaTypes
  structure Debugger_Types = AugLambda.Debugger_Types
  structure Pervasives = Pervasives
  structure Mir_Env = Mir_Env
  structure MirTypes = Mir_Env.MirTypes
  structure Set = LambdaTypes.Set
  structure Ident = LambdaTypes.Ident
  structure Symbol = Ident.Symbol
  structure Datatypes = Types.Datatypes
  structure Map = Datatypes.NewMap

  type bignum = BigNum.bignum
  (* This functor exports biggest_num. *)

  exception Unrepresentable = BigNum.Unrepresentable

  fun appendl [] = []
    | appendl [l] = l
    | appendl [l1,l2] = l1 @ l2
    | appendl ll =
      let
        fun rev' ([],acc) = acc
          | rev' (a::l,acc) = rev' (l,a::acc)
        fun aux ([],acc) = rev' (acc,[])
          | aux ([l],acc) = rev' (acc,l)
          | aux (l::ll,acc) = aux (ll,rev' (l,acc))
      in
        aux (ll,[])
      end

  val real_offset = 3

  val caller_arg = MirRegisters.caller_arg
  (* The argument register for all functions *)

  val callee_arg = MirRegisters.callee_arg
  (* The local copy of the argument register *)

  val caller_closure = MirRegisters.caller_closure
  (* The closure pointer for all function calls *)

  val callee_closure = MirRegisters.callee_closure
  (* The local copy of the closure pointer *)

  fun find_largest_power(n, i) =
    (find_largest_power(n+1, i*2)) handle Overflow => n

  val longest_string_length = find_largest_power(0, 1)
  (* How much to chop strings up into *)

  fun gp_from_reg(MirTypes.GC_REG x) = MirTypes.GP_GC_REG x
    | gp_from_reg(MirTypes.NON_GC_REG x) = MirTypes.GP_NON_GC_REG x

  fun reg_from_gp(MirTypes.GP_GC_REG x) = MirTypes.GC_REG x
    | reg_from_gp(MirTypes.GP_NON_GC_REG x) = MirTypes.NON_GC_REG x
    | reg_from_gp _ = Crash.impossible"reg_from_gp(IMM)"

  datatype reg_result =
    INT of MirTypes.gp_operand |
    REAL of MirTypes.fp_operand

  fun get_real(REAL fp_op) = (fp_op, [])
    | get_real(INT(MirTypes.GP_GC_REG reg_op)) =
      let
        val fp_op = MirTypes.FP_REG(MirTypes.FP.new())
      in
        (fp_op,
         [MirTypes.STOREFPOP(MirTypes.FLD, fp_op, MirTypes.GC_REG reg_op,
                             MirTypes.GP_IMM_ANY real_offset)])
      end
    | get_real _ = Crash.impossible"get_real bad value"

  fun get_word32(INT(MirTypes.GP_GC_REG reg_op)) =
      let
        val res = MirTypes.GC.new()
        val res1 = MirTypes.GC_REG res
        val res2 = MirTypes.GP_GC_REG res
      in
        (res2,
         [MirTypes.STOREOP(MirTypes.LD, res1, MirTypes.GC_REG reg_op,
                             MirTypes.GP_IMM_ANY ~1)],
	 [MirTypes.NULLARY(MirTypes.CLEAN, res1)])
      end
  |   get_word32(INT(MirTypes.GP_NON_GC_REG _)) =
  	Crash.impossible "get_word32 GP_NON_GC_REG"
  |   get_word32(INT(MirTypes.GP_IMM_INT i)) =
  	Crash.impossible ("get_word32 GP_IMM_INT " ^ Int.toString i)
  |   get_word32(INT(MirTypes.GP_IMM_ANY _)) =
  	Crash.impossible "get_word32 GP_IMM_ANY"
  |   get_word32(INT(MirTypes.GP_IMM_SYMB _)) =
  	Crash.impossible "get_word32 GP_IMM_SYMB"
  |   get_word32 _ = Crash.impossible "get_word32 bad value"

  fun save_real_to_reg(fp_op, reg) =
    (* Store as to a pointer (tag 1) *)
    [MirTypes.ALLOCATE(MirTypes.ALLOC_REAL, reg, MirTypes.GP_IMM_INT 0),
     MirTypes.STOREFPOP(MirTypes.FST, fp_op, reg,
			MirTypes.GP_IMM_ANY real_offset)]

  fun save_real(fp_op) =
    let
      val new_reg = MirTypes.GC.new()
      val new_r = MirTypes.GC_REG new_reg
    in
      (new_reg, save_real_to_reg(fp_op, new_r))
    end

  fun tuple_up_in_reg(reg_list, new_reg) =
  let
    val len = length reg_list
    (* Get the offset right for the pointer type used *)
    val alloc_op =
      MirTypes.ALLOCATE(MirTypes.ALLOC, MirTypes.GC_REG new_reg, MirTypes.GP_IMM_INT len)
    val reg_code_list =
      map
      (fn (REAL fp_op) =>
       let
	 val (reg, code) = save_real(fp_op)
       in
	 (INT(MirTypes.GP_GC_REG reg), code)
       end
       | reg => (reg, []))
      reg_list
    val reg_list = map #1 reg_code_list
    val start_code =
      appendl (map #2 reg_code_list)
(*
      Lists.reducer
      (fn ((y, z), x) => z @ x)
      (reg_code_list, [])
*)
    val (number_list, _) =
      Lists.number_from(reg_list, ~1, 4, MirTypes.GP_IMM_ANY)
  in
    (new_reg, 
     appendl
     ((start_code @ [alloc_op]) ::
        map (fn (INT(MirTypes.GP_GC_REG reg), imm) =>
	     [MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG reg,
			  MirTypes.GC_REG new_reg, imm)]
	     | (INT(MirTypes.GP_NON_GC_REG reg), imm) =>
	       [MirTypes.STOREOP(MirTypes.ST, MirTypes.NON_GC_REG reg,
		 MirTypes.GC_REG new_reg, imm)]
	     | (INT(i as MirTypes.GP_IMM_INT _), imm) =>
	       let
		 val new_reg' = MirTypes.GC.new()
	       in
		 [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG new_reg', i),
		   MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG new_reg',
		   MirTypes.GC_REG new_reg, imm)]
	       end
	     | (INT(i as MirTypes.GP_IMM_SYMB _), imm) =>
	       let
		 val new_reg' = MirTypes.GC.new()
	       in
		 [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG new_reg', i),
		   MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG new_reg',
		   MirTypes.GC_REG new_reg, imm)]
	       end
	     | (REAL _, _) =>
		 Crash.impossible"tuple_up_in_reg of unhandled REAL"
	     | _ => Crash.impossible"Tuple_up_in_reg untagged value")
      number_list))
  end

  fun stack_tuple_up_in_reg(reg_list, new_reg) =
  let
    val len = length reg_list
    val alloc_op =
      MirTypes.ALLOCATE_STACK(MirTypes.ALLOC, MirTypes.GC_REG new_reg, len,
			      NONE)
    val (number_list, _) =
      Lists.number_from(reg_list, ~1, 4, MirTypes.GP_IMM_ANY)
  in
    (new_reg, 
     appendl
     ([alloc_op] ::
        map (fn (INT(MirTypes.GP_GC_REG reg), imm) =>
	     [MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG reg,
			  MirTypes.GC_REG new_reg, imm)]
	     | (INT(MirTypes.GP_NON_GC_REG reg), imm) =>
	       [MirTypes.STOREOP(MirTypes.ST, MirTypes.NON_GC_REG reg,
		 MirTypes.GC_REG new_reg, imm)]
	     | (INT(i as MirTypes.GP_IMM_INT _), imm) =>
	       let
		 val new_reg' = MirTypes.GC.new()
	       in
		 [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG new_reg', i),
		   MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG new_reg',
		   MirTypes.GC_REG new_reg, imm)]
	       end
	     | (INT(i as MirTypes.GP_IMM_SYMB _), imm) =>
	       let
		 val new_reg' = MirTypes.GC.new()
	       in
		 [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG new_reg', i),
		   MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG new_reg',
		   MirTypes.GC_REG new_reg, imm)]
	       end
	     | (REAL fp_op, imm) =>
	       let
		 val (new_reg', code) = save_real(fp_op)
	       in
		 code @
		 [MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG new_reg',
				   MirTypes.GC_REG new_reg,
				   imm)]
	       end
	     | _ => Crash.impossible"Tuple_up untagged value")
      number_list))
  end

  fun tuple_up reg_list =
    tuple_up_in_reg(reg_list, MirTypes.GC.new())

  exception ConvertInt

  fun convert chars =
    let
      val char_size = size chars
      fun convert' (sign, ptr, value) =
	if ptr >= char_size then value
	else
	  let
	    val new_digit = (MLWorks.String.ordof (chars, ptr)) - ord #"0"
	  in
	    convert' (sign,ptr+1, 10 * value + (if sign then new_digit else ~new_digit))
	  end
    in
      convert' 
    end

  fun convert_hex chars =
    let
      val char_size = size chars
      fun convert_hex_int(sign, ptr, value) =
	if ptr >= char_size then value
	else
	  let
	    val digit = chr (MLWorks.String.ordof (chars, ptr))
	    val new_digit =
	      if Char.isDigit digit then 
		ord digit - ord #"0"
	      else if digit >= #"a" andalso digit <= #"f" then
		ord digit - ord #"a" + 10
		   else
		     if digit >= #"A" andalso digit <= #"F" then
		       ord digit - ord #"A" + 10
		     else
		       Crash.impossible("convert_hex:bad digit: " ^ (str digit))
	  in
	    convert_hex_int(sign,ptr+1, 16 * value + (if sign then new_digit else ~new_digit))
	  end
    in
      convert_hex_int
    end

  fun power(n, x, a:int) =
    if n <= 0 then a else power(n-1, x, a*x)

  fun convert_int (chars, max_size_opt) = 
    let
      val (sign, ptr) = if MLWorks.String.ordof (chars, 0) = ord #"~" then (false, 1) else (true, 0)
      val is_short = size chars - ptr < 2
      
      val number =
	if is_short then
	  convert chars (sign, ptr, 0)
        else
	  (if MLWorks.String.ordof (chars, ptr) = ord #"0" andalso MLWorks.String.ordof (chars, ptr+1) = ord #"x" then
	     convert_hex chars (sign, ptr + 2, 0)
	   else
	     convert chars (sign, ptr, 0))
    in
      case max_size_opt of
	NONE =>
	  number
      |  SOME max_size => 
	  let
	    val max_int = power (max_size - 1, 2, 1)
	    val min_int = ~max_int
	  in
	    if number >= max_int orelse number < min_int then
	      raise Unrepresentable
	    else
	      number
	  end
        handle	(* if power raises Overflow, then the number must fit *)
	Overflow => number
    end
  handle Overflow => raise ConvertInt

  fun convert_word (chars, max_size_opt) =
    let
      val is_short = size chars < 3
      val sign = true

      val number =
        if is_short then
	  convert chars (sign, 2, 0)
        else
	  if String.isPrefix "0wx" chars then
	    convert_hex chars (sign, 3, 0)
	  else
	    convert chars (sign, 2, 0)
    in
      case max_size_opt
      of NONE => number
      |  SOME max_size => 
	let
	  val max_int = power (max_size, 2, 1)
	in
	  if number >= max_int then
	    raise Unrepresentable
	  else
	    number
        end
        handle	(* if power raises Overflow, then the number must fit *)
	  Overflow => number
    end
  handle Overflow => raise ConvertInt

  fun string_is_zero (s:string):bool = 
    let
      val sz = size s
      fun scan i = 
	if i < sz then
	  if (String.sub(s, i) = #"0") then
	    scan (i+1)
	  else
	    false
	else
	  true
    in
      scan 0
    end

  fun to_lab string = Ident.LAB(Symbol.find_symbol string)

  val binary_int_function_type =
    Datatypes.FUNTYPE(Types.add_to_rectype
		      (to_lab"1", Types.int_type,
		       Types.add_to_rectype(to_lab"2", Types.int_type,
					    Types.empty_rectype)), Types.int_type)

  fun longest_representable_int longest_string_length =
    let
      val longest_int = power(longest_string_length, 2, 1)
      val biggest_num = BigNum.string_to_bignum(Int.toString longest_int)
    in
      (longest_string_length, longest_int, biggest_num)
    end handle BigNum.Unrepresentable =>
      longest_representable_int(longest_string_length-1)

  val (longest_string_length, longest_int, biggest_num) =
    longest_representable_int longest_string_length

  val bignum_zero = BigNum.int_to_bignum 0

  fun add_sign(arg as (chars, location), sign) =
    if sign then
      ("~" ^ chars, location)
    else
      arg

  (* This function returns an expression that calculates the desired value,
     without overflowing on the compiling machine. *)
  fun convert_long(bignum, arg as (_, location)) =
    if BigNum.<=(bignum, biggest_num) andalso
       BigNum.>=(bignum, BigNum.~ biggest_num) then
      (* Terminate the recursion *)
      AugLambda.SCON
	(LambdaTypes.Ident.INT (BigNum.bignum_to_string bignum, location),
	 NONE)
	 (* I think the maximum size is irrelevant now, hence the NONE. *)
    else
      let
	val head = BigNum.quot(bignum, biggest_num)
	val tail = BigNum.rem(bignum, biggest_num)
      in
	if BigNum.eq(head, bignum_zero) then
	  AugLambda.SCON
	    (LambdaTypes.Ident.INT (BigNum.bignum_to_string tail, location),
	     NONE)
	 (* I think the maximum size is irrelevant now, hence the NONE. *)
	else
	  AugLambda.APP
	  ({size=0,
	    lexp=AugLambda.BUILTIN
	    (Pervasives.UNSAFEINTPLUS, binary_int_function_type)},
	   ([{size=0,
	     lexp=
	     AugLambda.STRUCT
	     [{size=0,
	       (* head * 2 ** longest_string_length *)
	       lexp=AugLambda.APP
	       ({size=0,
		 lexp=AugLambda.BUILTIN
		 (Pervasives.LSHIFT, binary_int_function_type)},
		([{size=0,
		  lexp=
		  AugLambda.STRUCT
		  [{size=0, lexp=convert_long(head, arg)},
		   {size=0, lexp=AugLambda.INT longest_string_length}]
		  }],[]),
		Debugger_Types.SELECT
		(0, Debugger_Types.NOP))
	       },
	     {size=0, lexp=convert_long(tail, arg)}]
	     }],[]),
	   Debugger_Types.SELECT
	   (0, Debugger_Types.NOP))
      end

  fun convert_long_int (arg as (chars, _)) =
    let
      val ptr = if MLWorks.String.ordof (chars, 0) = ord #"~" then 1 else 0

      val is_short = size chars < 2 + ptr
      (* This is very unlikely ever to hold, because this function is only
	 called if the integer can't be held in an int value. *)

      val bignum =
	if is_short then
	  BigNum.string_to_bignum chars
	else if MLWorks.String.ordof (chars, ptr) = ord #"0" andalso
	  MLWorks.String.ordof (chars, ptr+1) = ord #"x" then
	  BigNum.hex_string_to_bignum chars
	else
	  BigNum.string_to_bignum chars
    in
      convert_long(bignum, arg)
    end

  fun convert_long_word (arg as (chars, _)) =
    let
      val is_short = size chars < 3
      (* This is very unlikely ever to hold, because this function is only
	 called if the word can't be held in an int value. *)
      val bignum =
	if is_short then
	  BigNum.word_string_to_bignum chars
	else
	  if String.isPrefix "0wx" chars then
	    BigNum.hex_word_string_to_bignum chars
	  else
	    BigNum.word_string_to_bignum chars
    in
      convert_long(bignum, arg)
    end


  (* 32-bit conversions *)

  val binary_word32_function_type =
    Datatypes.FUNTYPE
      (Types.add_to_rectype
         (to_lab"1", Types.word32_type,
	  Types.add_to_rectype
 	    (to_lab"2", Types.word32_type,
	     Types.empty_rectype)),
       Types.word32_type)

  fun longest_representable_int32 num_bits =
    let
      val longest_int = power(num_bits, 2, 1)
      val biggest_num =
        BigNum32.string_to_bignum(Int.toString longest_int)
    in
      biggest_num
    end
    handle
       BigNum32.Unrepresentable =>
      longest_representable_int32 (num_bits - 1)
    |  Overflow =>
      longest_representable_int32 (num_bits - 1)

  val biggest_num32 =
    longest_representable_int32 28

  val bignum32_zero = BigNum32.int_to_bignum 0

  val longest_string_length_str =
    Int.toString longest_string_length

  (* N.B. This is supposed to handle both Int32 and Word32.  It requires that
     mir_cg is able to handle Int32 literals, as it creates them here.
     It uses Word32 operations because that's all I've implemented so far;
     it may be a good idea to keep these because they don't check for Overflow
     (which should be impossible). *)
  fun convert_long32 (bignum, arg as (_, location)) =
    if BigNum32.<=(bignum, biggest_num32) andalso
       BigNum32.>=(bignum, BigNum32.~ biggest_num32) then
      (* Terminate the recursion *)
      AugLambda.SCON
	(LambdaTypes.Ident.INT (BigNum32.bignum_to_string bignum, location),
	 SOME 32)
    else
      let
	val head = BigNum32.quot (bignum, biggest_num32)
	val tail = BigNum32.rem(bignum, biggest_num32)
      in
	if BigNum32.eq(head, bignum32_zero) then
	  AugLambda.SCON
	    (LambdaTypes.Ident.INT (BigNum32.bignum_to_string tail, location),
	     SOME 32)
	else
	  AugLambda.APP
	  ({size=0,
	    lexp=AugLambda.BUILTIN
	    (Pervasives.WORD32PLUS, binary_word32_function_type)},
	   ([{size=0,
	     lexp=
	     AugLambda.STRUCT
	     [{size=0,
	       (* head * 2 ** longest_string_length *)
	       lexp=AugLambda.APP
	       ({size=0,
		 lexp=AugLambda.BUILTIN
		        (Pervasives.WORD32LSHIFT, binary_word32_function_type)},
		([{size=0,
		  lexp=
		  AugLambda.STRUCT
		  [{size=0, lexp=convert_long32(head, arg)},
		   {size=0,
		    lexp=
		      AugLambda.SCON
			(LambdaTypes.Ident.INT
			   (longest_string_length_str, location),
			 NONE)
		   }]
		 }],[]),
		Debugger_Types.SELECT
		(0, Debugger_Types.NOP))
	       },
	     {size=0, lexp= convert_long32(tail, arg)}]
	     }],[]),
	   Debugger_Types.SELECT
	   (0, Debugger_Types.NOP))
      end

  fun convert_long_int32 (arg as (chars, _)) =
    let
      val ptr = if MLWorks.String.ordof (chars, 0) = ord #"~" then 1 else 0

      val is_short = size chars < 2 + ptr
      (* This is very unlikely ever to hold, because this function is only
	 called if the integer can't be held in an int value. *)

      val bignum =
	if is_short then
	  BigNum32.string_to_bignum chars
	else
	  case substring (* could raise Substring *)(chars, ptr, 2) of
	    "0x" => BigNum32.hex_string_to_bignum chars
	  | _ => BigNum32.string_to_bignum chars
    in
      convert_long32(bignum, arg)
    end
    handle
      BigNum32.Unrepresentable =>
	raise Unrepresentable

  fun convert_long_word32 (arg as (chars, _)) =
    let
      val is_short = size chars < 3
      (* This is very unlikely ever to hold, because this function is only
	 called if the word can't be held in an int value. *)
      val bignum =
	if is_short then
	  BigNum32.word_string_to_bignum chars
	else
	  if String.isPrefix "0wx" chars then
	    BigNum32.hex_word_string_to_bignum chars
	  else
	    BigNum32.word_string_to_bignum chars
    in
      convert_long32(bignum, arg)
    end
    handle
      BigNum32.Unrepresentable =>
	raise Unrepresentable

  val convert_long_int =
    fn (Ident.INT arg, SOME 32) => convert_long_int32 arg
    |  (Ident.INT arg, max_size) => convert_long_int arg
    |  _ => Crash.impossible "Convert_long_int of non-int"

  val convert_long_word =
    fn (Ident.WORD arg, SOME 32) => convert_long_word32 arg
    |  (Ident.WORD arg, max_size) => convert_long_word arg
    |  _ => Crash.impossible "Convert_long_word of non-word"

  datatype cg_result =
    ONE of reg_result |
    LIST of reg_result list

  fun get_any_register (INT(MirTypes.GP_GC_REG reg)) = MirTypes.GC reg
    | get_any_register (INT(MirTypes.GP_NON_GC_REG reg)) = MirTypes.NON_GC reg
    | get_any_register (REAL(MirTypes.FP_REG reg)) = MirTypes.FLOAT reg
    | get_any_register _ = Crash.impossible"Bad value to get_any_register"

  fun cg_lvar(lvar, env, closure, funs_in_closure) =
    (* first look up in the lambda environment *)
    (case Mir_Env.lookup_lambda(lvar, env) of
       SOME (MirTypes.GC reg) => 
         (((INT(MirTypes.GP_GC_REG reg)),[]), 0,false)
     | SOME (MirTypes.NON_GC reg) => 
         (((INT(MirTypes.GP_NON_GC_REG reg)),[]),0,false)
     | SOME (MirTypes.FLOAT reg) => 
         (((REAL(MirTypes.FP_REG reg)),[]),0,false)
     | NONE =>
         (* else look up in the closure *)
         (* This loads in an object from the closure *)
         (case Mir_Env.lookup_in_closure(lvar, closure) of
            SOME offset =>
              let
                val is_same_set = offset < funs_in_closure * 2 - 1
                val new_reg = MirTypes.GC.new()
              in
                (* Because the function pointers in a closure are interspersed *)
                (* with zeroes, we must halve offset_in_closure above *)
                ((INT(MirTypes.GP_GC_REG new_reg),
                  [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
                                    MirTypes.GC_REG callee_closure,
                                    MirTypes.GP_IMM_ANY(~1 + 4*offset))]),
                offset div 2, is_same_set)
              end
          | NONE => 
              Crash.impossible("cg_lvar: Lambda variable " ^
                               LambdaTypes.printLVar lvar ^
                               " is neither in the closure nor the local bindings")))

  (* If its a function value we want, just add offset onto current closure *)
  fun cg_lvar_fn(lvar, env, closure, funs_in_closure) =
    let
      val ((reg, code), pos, is_same_set) =
	cg_lvar(lvar, env, closure, funs_in_closure)
    in
      if is_same_set then
	let
	  val new_reg = MirTypes.GC.new()
	in
	  (INT(MirTypes.GP_GC_REG new_reg),
	    [MirTypes.BINARY(MirTypes.ADDU, MirTypes.GC_REG new_reg,
			     MirTypes.GP_GC_REG callee_closure,
			     MirTypes.GP_IMM_INT (pos*2))])
	(* Note use of recursive call info for dynamic access *)
	end
      else
	(reg, code)
    end

  fun list_of(i, v) =
    let
      fun list_sub(i, done) =
	if i <= 0 then done
	else list_sub(i-1, v :: done)
    in
      list_sub(i, [])
    end

  fun list_of_tags n =
    let
      fun list_sub(n, done) =
	if n <= 0 then done
	else list_sub(n-1, MirTypes.new_tag() :: done)
    in
      list_sub(n, [])
    end

  fun destruct_2_tuple(MirTypes.GP_GC_REG gc_reg) =
    let
      val reg1 = MirTypes.GC.new()
      val reg2 = MirTypes.GC.new() (* reasonable assumption *)
    in
      (MirTypes.GP_GC_REG reg1,
       MirTypes.GP_GC_REG reg2,
       [MirTypes.STOREOP(MirTypes.LD,
			 MirTypes.GC_REG reg1, MirTypes.GC_REG gc_reg,
			 MirTypes.GP_IMM_ANY ~1),
	MirTypes.STOREOP(MirTypes.LD,
			 MirTypes.GC_REG reg2, MirTypes.GC_REG gc_reg,
			 MirTypes.GP_IMM_ANY 3)])
    end
  | destruct_2_tuple _ = Crash.impossible"destruct_2_tuple"

  fun contract_sexpr(Sexpr.NIL, [], acc) = appendl (rev acc) (* Lists.reducel (fn (x, y) => y @ x) ([], acc) *)
  | contract_sexpr(Sexpr.NIL, x :: xs, acc) = contract_sexpr(x, xs, acc)
  | contract_sexpr(Sexpr.ATOM x, to_do, acc) =
    contract_sexpr(Sexpr.NIL, to_do, x :: acc)
  | contract_sexpr(Sexpr.CONS(x, y), to_do, acc) =
    contract_sexpr(x, y :: to_do, acc)

  val contract_sexpr =
    fn x => contract_sexpr(x, [], [])

  fun empty_sexpr Sexpr.NIL = true
    | empty_sexpr(Sexpr.ATOM []) = true
    | empty_sexpr(Sexpr.CONS(x, y)) = empty_sexpr x andalso empty_sexpr y
    | empty_sexpr _ = false

  fun combine(((first, blocks, tag, last), values, set),
	      ((first', blocks', tag', last'), values', set')) =
    let
      val code =
        case tag of
          NONE =>
            if empty_sexpr last then
              (Sexpr.CONS (first, first'), blocks @ blocks', tag', last')
            else
              Crash.impossible"non-empty last with no tag"
        | SOME tag_val =>
            (case tag' of
               NONE =>
                 if empty_sexpr last' then
                   (first, blocks @ blocks', tag, Sexpr.CONS(last, first'))
                 else
                   Crash.impossible"non-empty last' with no tag"
             | SOME tag_val' =>
                 (first,
		  let
		    val list = contract_sexpr(Sexpr.CONS(last,first'))
		    val tail = blocks @ blocks'
		  in
		    case list of
		      [] => tail
		    | _ => MirTypes.BLOCK(tag_val,list) :: tail
		  end,
		  tag', last'))
    in
      (code,values @ values',set @ set')
    end

  fun send_to_given_reg_with_allocate(tuple_fn, (cg_res, gc_reg)) =
    case cg_res of
      ONE reg =>
	(case reg of
	  INT(arg as MirTypes.GP_IMM_INT _) =>
	    [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG gc_reg, arg)]
	| INT(arg as MirTypes.GP_IMM_SYMB _) =>
	    [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG gc_reg, arg)]
	| INT(MirTypes.GP_IMM_ANY _) =>
	  Crash.impossible"GP_IMM_ANY"
	| INT(arg as MirTypes.GP_GC_REG gc_reg') =>
	    if (gc_reg' = gc_reg) then []
	    else [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG gc_reg, arg)]
	| INT(arg as MirTypes.GP_NON_GC_REG non_gc_reg) =>
	    [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG gc_reg, arg)]
	| REAL fp_op =>
	    save_real_to_reg(fp_op, MirTypes.GC_REG gc_reg))
    | LIST many =>
	let
	  val (_, code) = tuple_fn(many, gc_reg)
	in
	  code
	end

  fun send_to_given_reg arg =
    send_to_given_reg_with_allocate(tuple_up_in_reg, arg)

  fun stack_send_to_given_reg arg =
    send_to_given_reg_with_allocate(stack_tuple_up_in_reg, arg)

  fun send_to_new_reg x =
    let
      val new_reg = MirTypes.GC.new()
    in
      (MirTypes.GP_GC_REG new_reg,send_to_given_reg(x, new_reg))
    end

  fun send_to_reg(ONE reg) =
    (case reg of
       INT(arg as MirTypes.GP_IMM_INT _) =>
	 let val new_reg = MirTypes.GC.new()
	 in
	   (MirTypes.GP_GC_REG new_reg,
	    [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG new_reg, arg)])
	 end
     | INT(arg as MirTypes.GP_IMM_SYMB _) =>
	 let val new_reg = MirTypes.GC.new()
	 in
	   (MirTypes.GP_GC_REG new_reg,
	    [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG new_reg, arg)])
	 end
     | INT(MirTypes.GP_IMM_ANY _) =>
	 Crash.impossible"GP_IMM_ANY"
     | INT x => (x, [])
     | REAL fp_op =>
	 let
	   val (reg, code) = save_real(fp_op)
	 in
	   (MirTypes.GP_GC_REG reg, code)
	 end)
  | send_to_reg(LIST many) =
    let val (gc_reg, code) = tuple_up(many)
    in
      (MirTypes.GP_GC_REG gc_reg, code)
    end

  fun save_word32_in_reg(source, target) =
    let
      val source1 = MirTypes.GC_REG source
      val target1 = MirTypes.GC_REG target
    in
      [MirTypes.ALLOCATE
       (MirTypes.ALLOC_STRING, target1, MirTypes.GP_IMM_INT 4),
       MirTypes.STOREOP
       (MirTypes.ST, source1, target1, MirTypes.GP_IMM_ANY ~1)]
    end

  fun save_word32 source =
    let
      val target = MirTypes.GC.new()
    in
      (target, save_word32_in_reg(source, target))
    end

  val ident_fn = fn x => x

  fun make_closure(tags, free, statics, offset, env, closure,
		   funs_in_closure) =
    (* tags, the function tags this closure is for
     free, the list of free variables.
     statics, how many static gc objects to allow for in this closure.
     offset, where these live in the surrounding closure.
     env, the old env.
     closure, the old closure. *)
    let
      (* This is being changed to interlace code pointers in the closure *)
      (* with zeroes, in order to preserve the double word alignment *)
      val funs = 2 * length tags - 1
      (* Changed above n => 2*n-1 *)
      val free_size = length free
      val (tags, _) =
	Lists.number_from(tags, 0, 2, ident_fn)
      (* Changed above (1 for 2) *)
      val lambda_offset_list_list =
	map
	(fn (_, n) => #1 (Lists.number_from_by_one(free, 
                                                   statics+funs-n,
                                                   ident_fn)))
	tags
      (* This produces numberings of the free variables assuming the pointer
       (caller_closure) is some distance before the first free variable, as required
       for common closures for mutually recursive functions and functions
       containing static gc objects within them *)
      (* Pointer to newly created closure *)
      val reg_operand = MirTypes.GC_REG(MirTypes.GC.new())
      val cl_code_list =
	map
	(fn lv => cg_lvar_fn(lv, env, closure, funs_in_closure))
	free
      val (num_cl_code, _) =
	Lists.number_from_by_one(cl_code_list, funs + statics, ident_fn)
      val closure_size = funs + statics + free_size
      val start = ~1
      val clean_dynamics =
	map
	(fn arg as ((reg, code), i) =>
	 (case reg of
	    INT reg => ((reg, code), i)
	  | REAL _ =>
	      let
		val (reg', code') = send_to_reg(ONE reg)
	      in
		((reg', code @ code'), i)
	      end
	    ))
	num_cl_code
      val copy_dynamics =
        appendl
	([MirTypes.COMMENT"Dynamic closure elements"] ::
	  map (fn ((reg, _), i) =>
	       [MirTypes.STOREOP(MirTypes.ST, reg_from_gp reg, reg_operand,
				 MirTypes.GP_IMM_ANY(start + 4*i))])
	  clean_dynamics)
      val setup_dynamics = appendl (map (#2 o #1) clean_dynamics)
(*
	Lists.reducer
	(fn (((_, code), _), l) => code @ l)
	(clean_dynamics, [])
*)
      val copy_statics =
	let
	  val new_reg = MirTypes.GC.new()
	  fun copy_n(acc, how_many, from, to) =
	    if how_many <= 0 then acc
	    else
	      copy_n
	      (MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
				MirTypes.GC_REG callee_closure,
				MirTypes.GP_IMM_ANY(start + 4*from)) ::
	       MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG new_reg,
				reg_operand,
				MirTypes.GP_IMM_ANY(start + 4*to)) :: acc,
	       how_many-1, from+1, to+1)
	in
	  MirTypes.COMMENT"Static closure elements" ::
	  copy_n([], statics, offset, funs)
	end
      val closure_env_list (* as Mir_Env.CLOSURE_ENV map_map :: _ *) =
	map
	(fn x =>
	 Lists.reducel
	 (fn (x, y) => Mir_Env.add_closure_env(y, x))
	 (Mir_Env.empty_closure_env, x))
	lambda_offset_list_list
    in
      (reg_operand,
       Sexpr.CONS(Sexpr.ATOM setup_dynamics,
		  Sexpr.CONS
		  (Sexpr.ATOM(MirTypes.ALLOCATE
			      (MirTypes.ALLOC, reg_operand,
			       MirTypes.GP_IMM_INT closure_size) ::
			      copy_dynamics),
		   Sexpr.ATOM copy_statics)),
	closure_env_list)
    end

  (* Map function parameters onto a fixed set of registers *)
  local
    val caller_arg_regs = MirRegisters.caller_arg_regs
    val tail_arg_regs = MirRegisters.tail_arg_regs

    fun assign_regs regs args =
      let
        fun assign ([],regs,acc) = rev acc
          | assign (arg::rest,[reg],acc) = rev (reg::acc)
          | assign (arg::rest,reg::restregs,acc) = assign (rest,restregs,reg::acc)
          | assign (_,[],acc) = Crash.impossible "Not enough arg regs"
      in
        assign (args,regs,[])
      end
  in
    val assign_caller_regs = assign_regs caller_arg_regs
    val assign_tail_regs = assign_regs tail_arg_regs
    val assign_fp_regs = assign_regs MirRegisters.fp_arg_regs
  end

  fun do_app(debugger_information,
             regs, the_code as ((first, blocks, opt, last), values, procs),
	     regs', the_code' as ((first', blocks', opt', last'), values', procs')) =
    let
      (* First code generate to evaluate which function should be called, *)
      (* then evaluate the argument, then call the function *)

      val (fn_reg, fn_code) =
	case (regs, the_code) of
	  (ONE(INT reg), ((first, blocks, opt, last), values, procs)) =>
	    (reg,
	      ((Sexpr.CONS
		(Sexpr.ATOM[MirTypes.COMMENT"Evaluate function to be called"],
		 first),
	        blocks, opt, last), values, procs))
	| _ => Crash.impossible"STRUCT or NON_GC as FN"
      val arg_code =
	((Sexpr.CONS
	  (Sexpr.ATOM[MirTypes.COMMENT"Evaluate function argument"],
	   first'),
	  blocks', opt', last'), values', procs')
      val extra_code = send_to_given_reg(regs', caller_arg)
      val fn_reg_op = reg_from_gp fn_reg
      val res_reg = MirTypes.GC.new()
      val call_code =
	  [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG caller_closure,
			  fn_reg),
	   MirTypes.COMMENT("Set up new closure pointer"),
	   MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG MirRegisters.global,
			    MirTypes.GC_REG caller_closure,
			    MirTypes.GP_IMM_ANY ~1),
	   MirTypes.COMMENT("Get address of code"),
	   let
	     val dest = MirTypes.REG(MirTypes.GC_REG MirRegisters.global)
	   in
	     MirTypes.BRANCH_AND_LINK(MirTypes.BLR, dest,debugger_information,[MirTypes.GC caller_arg])
	   end,
	   MirTypes.COMMENT("Call the function"),
	   MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
			   MirTypes.GP_GC_REG caller_arg),
	   MirTypes.COMMENT("And acquire result")]
    in
      (ONE(INT(MirTypes.GP_GC_REG res_reg)),
        combine(fn_code,
	  combine(arg_code,
	    ((Sexpr.CONS(Sexpr.ATOM extra_code, Sexpr.ATOM call_code), [],
	      NONE, Sexpr.NIL), [], []))))
    end

  datatype CallType = 
    LOCAL of Mir_Env.MirTypes.tag * Mir_Env.MirTypes.GC.T list * Mir_Env.MirTypes.FP.T list
  | SAMESET of int (* position in closure *)
  | EXTERNAL

  fun do_multi_app(debugger_information,
                   regs, ((first, blocks, opt, last), values, procs),
                   regs', ((first', blocks', opt', last'), values', procs'),
                   regs'', ((first'', blocks'', opt'', last''), values'', procs''),
                   calltype,
                   funs_in_closure, tag_list,
                   do_tail) =
    let
      (* Annotate the fn and arg code with some comments *)
      val fn_code =
        ((Sexpr.CONS
          (Sexpr.ATOM[MirTypes.COMMENT "Evaluate function to be called"],
           first),
          blocks, opt, last), values, procs)

      val arg_code =
	((Sexpr.CONS
	  (Sexpr.ATOM [MirTypes.COMMENT "Evaluate function argument"],
	   first'),
	  blocks', opt', last'), values', procs')

      val fp_arg_code =
	((Sexpr.CONS
	  (Sexpr.ATOM [MirTypes.COMMENT "Evaluate function argument"],
	   first''),
	  blocks'', opt'', last''), values'', procs'')

      (* Get the function and argument registers *)
      val fn_reg =
        case regs of
	  (ONE (INT reg)) => reg
	| _ => Crash.impossible"STRUCT or NON_GC as FN"

      val arg_register_list =
	case regs' of
          LIST many => many
        | ONE (INT(MirTypes.GP_IMM_INT 0)) => []
        | _ => Crash.impossible "Bad structure for multi arg call"

      val fp_arg_register_list =
        case regs'' of
          LIST many => many
        | ONE (INT(MirTypes.GP_IMM_INT 0)) => []
        | _ => Crash.impossible "Bad fp structure for multi arg call"

      (* Now put the argument into the right form for the function call *)
      val (real_arg_regs, real_fp_regs, real_closure_reg) =
        case calltype of
          LOCAL (_,regs,fp_regs) =>
            (regs, fp_regs,MirRegisters.tail_closure)
	| _ =>
            if do_tail 
              then (assign_tail_regs arg_register_list, 
                    assign_fp_regs fp_arg_register_list, 
                    MirRegisters.tail_closure)
            else (assign_caller_regs arg_register_list, 
                  assign_fp_regs fp_arg_register_list, 
                  caller_closure)

      val gp_arg_regs = map MirTypes.GC real_arg_regs @ map MirTypes.FLOAT real_fp_regs

      val cleaned_regs_and_code =
        map
        (fn reg =>
         let
           val new_reg = MirTypes.GC.new()
           val code = send_to_given_reg(ONE reg, new_reg)
         in
           (INT(MirTypes.GP_GC_REG new_reg), code)
         end)
        arg_register_list
      val gc_regs = map #1 cleaned_regs_and_code
      val clean_code = appendl (map #2 cleaned_regs_and_code)

      val real_offset = 3

      fun send_to_given_fp_reg (REAL fp_reg,to_reg) =
        [MirTypes.UNARYFP(MirTypes.FMOVE, 
                          MirTypes.FP_REG to_reg,
                          fp_reg)]
        | send_to_given_fp_reg (INT (MirTypes.GP_GC_REG gc_reg),to_reg) =
        [MirTypes.STOREFPOP(MirTypes.FLD, MirTypes.FP_REG to_reg,
                            MirTypes.GC_REG gc_reg,
                            MirTypes.GP_IMM_ANY real_offset)]
        | send_to_given_fp_reg _ = Crash.impossible ("send_to_given_fp_reg")

      val fp_cleaned_regs_and_code =
        map
        (fn reg =>
         let
           val new_reg = MirTypes.FP.new()
           val code = send_to_given_fp_reg(reg, new_reg)
         in
           (REAL(MirTypes.FP_REG new_reg), code)
         end)
        fp_arg_register_list
      val fp_regs = map #1 fp_cleaned_regs_and_code
      val fp_clean_code = appendl (map #2 fp_cleaned_regs_and_code)
        
      (* The first clause deals with the situation where we have run out of *)
      (* real registers to pass arguments in, so we need to stack allocate *)
      val (setup_code,deallocate_size) =
        let
          fun make_setup_code (regs as (_::_::_),[r],acc) =
            let
              val (tuple_code,deallocate_size) =
                if do_tail 
                  (* If its a tail then alas we must heap allocate it *)
                  then (send_to_given_reg (LIST regs,r),0)
                else (stack_send_to_given_reg (LIST regs,r),Lists.length regs)
            in
              (rev (tuple_code::acc),deallocate_size)
            end
            | make_setup_code (reg::restreg,r::restr,acc) =
              make_setup_code (restreg,restr,send_to_given_reg(ONE reg, r)::acc)
            | make_setup_code ([],[],acc) = (rev acc,0)
            | make_setup_code _ = Crash.impossible "make_setup_code: formal & actual parameter mismatch"
        in
          make_setup_code (gc_regs,real_arg_regs,[])
        end

      val fp_setup_code =
        let
          fun make_setup_code (reg::restreg,r::restr,acc) =
              make_setup_code (restreg,restr,send_to_given_fp_reg(reg, r)::acc)
            | make_setup_code ([],[],acc) = rev acc
            | make_setup_code _ = Crash.impossible "make_setup_code: formal & actual parameter mismatch"
        in
          make_setup_code (fp_regs,real_fp_regs,[])
        end

      fun deallocate_code () =
	if deallocate_size > 0  then
	  [MirTypes.DEALLOCATE_STACK(MirTypes.ALLOC, deallocate_size)]
	else
	  []

      (* arg_code computes the function arguments, this code actual moves the args *)
      (* into the expected places *)
      val full_arg_code =
	combine(arg_code,
                combine (fp_arg_code,
                         ((Sexpr.ATOM (clean_code @ fp_clean_code @ 
                                       appendl setup_code @ appendl fp_setup_code),
                           [], NONE, Sexpr.NIL),
                          [], [])))

      val res_reg = MirTypes.GC.new ()

      (* Code for a local function call *)
      fun local_tail_code (loop_tag) =
	[MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG real_closure_reg,
			MirTypes.GP_GC_REG callee_closure),
	 MirTypes.COMMENT("Set up new closure pointer"),
	 MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG loop_tag),
         (* The following code is required to keep the register allocator happy *)
	 (* It serves no other purpose, and will be discarded by the optimiser *)
	 (* as it is unreachable *)
         (* Unless it is here, RegisterPack can fail because res_reg is undefined *)
	 MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
			MirTypes.GP_GC_REG caller_arg),
	 MirTypes.COMMENT"And acquire result"]

      fun relative_code (pos) =
        (if pos = 0 then
           MirTypes.UNARY(MirTypes.MOVE, 
                          MirTypes.GC_REG real_closure_reg,
                           MirTypes.GP_GC_REG callee_closure)
         else
           MirTypes.BINARY(MirTypes.ADDU, MirTypes.GC_REG real_closure_reg,
                           MirTypes.GP_GC_REG callee_closure,
                           MirTypes.GP_IMM_INT(pos*2))) ::
        MirTypes.COMMENT("Set up new closure pointer") ::
        let
          val dest = MirTypes.TAG(Lists.nth(Lists.length tag_list + pos -
                                            funs_in_closure, tag_list))
                     handle Lists.Nth => Crash.impossible "nth in relative_code"
        in
          if do_tail then
            MirTypes.TAIL_CALL(MirTypes.TAIL, dest,gp_arg_regs)
          else
            MirTypes.BRANCH_AND_LINK(MirTypes.BLR, dest,debugger_information,gp_arg_regs)
        end ::
      MirTypes.COMMENT(if do_tail then
                         "Tail to the function"
                       else "Call the function") ::
      MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
                     MirTypes.GP_GC_REG caller_arg) ::
      MirTypes.COMMENT"And acquire result" ::
      deallocate_code ()

      fun indirect_code () =
	MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG real_closure_reg,
		       fn_reg) ::
	MirTypes.COMMENT("Set up new closure pointer") ::
	MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG MirRegisters.global,
			 MirTypes.GC_REG real_closure_reg,
			 MirTypes.GP_IMM_ANY ~1) ::
	MirTypes.COMMENT("Get address of code") ::
	let
	  val dest = MirTypes.REG(MirTypes.GC_REG MirRegisters.global)
	in
	  if do_tail then
	    MirTypes.TAIL_CALL(MirTypes.TAIL, dest, gp_arg_regs)
	  else
	    MirTypes.BRANCH_AND_LINK(MirTypes.BLR, dest,debugger_information,gp_arg_regs)
	end ::
        MirTypes.COMMENT(if do_tail then
			   "Tail to the function"
			 else "Call the function") ::
	MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
		       MirTypes.GP_GC_REG caller_arg) ::
	MirTypes.COMMENT("And acquire result")::
        deallocate_code ()

      val call_code =
        case calltype of
          LOCAL (tag, regs, fp_regs) =>
            local_tail_code (tag)
        | SAMESET (pos) => 
            relative_code pos 
        | EXTERNAL => 
            indirect_code()
    in
      (ONE(INT(MirTypes.GP_GC_REG res_reg)), fn_code, full_arg_code, 
       ((Sexpr.ATOM (call_code), [], NONE,
         Sexpr.NIL), [], []))
    end (* of do_multi_app *)

    val empty_string_tree = Map.empty (String.<,op= : string * string -> bool)

    fun find_var(trees as (var_tree, exn_tree, str_tree, fun_tree, string_tree), string) =
      case Map.tryApply'(var_tree, string) of
	SOME lv => (trees, lv)
      | _ =>
	  let
	    val lv = LambdaTypes.new_LVar()
	  in
	    ((Map.define(var_tree, string, lv), exn_tree, str_tree, fun_tree, string_tree),
	     lv)
	  end

    fun find_exn(trees as (var_tree, exn_tree, str_tree, fun_tree, string_tree), string) =
      case Map.tryApply'(exn_tree, string) of
	SOME lv => (trees, lv)
      | _ =>
	  let
	    val lv = LambdaTypes.new_LVar()
	  in
	    ((var_tree, Map.define(exn_tree, string, lv), str_tree, fun_tree, string_tree),
	     lv)
	  end

    fun find_str(trees as (var_tree, exn_tree, str_tree, fun_tree, string_tree), string) =
      case Map.tryApply'(str_tree, string) of
	SOME lv => (trees, lv)
      | _ =>
	  let
	    val lv = LambdaTypes.new_LVar()
	  in
	    ((var_tree, exn_tree, Map.define(str_tree, string, lv), fun_tree, string_tree),
	     lv)
	  end

    fun find_fun(trees as (var_tree, exn_tree, str_tree, fun_tree, string_tree), string) =
      case Map.tryApply'(fun_tree, string) of
	SOME lv => (trees, lv)
      | _ =>
	  let
	    val lv = LambdaTypes.new_LVar()
	  in
	    ((var_tree, exn_tree, str_tree, Map.define(fun_tree, string, lv), string_tree),
	     lv)
	  end

    fun find_ext(trees as (var_tree, exn_tree, str_tree, fun_tree, string_tree), string) =
      case Map.tryApply'(string_tree, string) of
	SOME lv => (trees, lv)
      | _ =>
	  let
	    val lv = LambdaTypes.new_LVar()
	  in
	    ((var_tree, exn_tree, str_tree, fun_tree, Map.define(string_tree, string, lv)),
	     lv)
	  end

    fun lift_externals(arg as (trees, {lexp=AugLambda.APP
				       ({lexp=AugLambda.BUILTIN(prim,_), ...},
					([{lexp=AugLambda.SCON(Ident.STRING chars, NONE),
                                           ...}],[]),
                                        _),
                                       ...})) =
      (case prim of
	 Pervasives.LOAD_VAR =>
	   let
	     val (trees, lv) = find_var(trees, chars)
	   in
	     (trees, {lexp=AugLambda.VAR lv, size=0})
	   end
       | Pervasives.LOAD_EXN =>
	   let
	     val (trees, lv) = find_exn(trees, chars)
	   in
	     (trees, {lexp=AugLambda.VAR lv, size=0})
	   end
       | Pervasives.LOAD_STRUCT =>
	   let
	     val (trees, lv) = find_str(trees, chars)
	   in
	     (trees, {lexp=AugLambda.VAR lv, size=0})
	   end
       | Pervasives.LOAD_FUNCT =>
	   let
	     val (trees, lv) = find_fun(trees, chars)
	   in
	     (trees, {lexp=AugLambda.VAR lv, size=0})
	   end
       | Pervasives.LOAD_STRING =>
	   let
	     val (trees, lv) = find_ext(trees, chars)
	   in
	     (trees, {lexp=AugLambda.VAR lv, size=0})
	   end
       | _ => arg)
      | lift_externals(trees, {lexp=AugLambda.APP(le, (lel,fpel),debug), size=size}) =
	let
	  val (trees, le) = lift_externals(trees, le)
	  val (trees, lel) = lift_externals_list (trees, [], lel)
	  val (trees, fpel) = lift_externals_list (trees, [], fpel)
	in
	  (trees, {lexp=AugLambda.APP(le, (lel,fpel),debug), size=size})
	end
      | lift_externals(trees, {lexp=AugLambda.LET((lv, info,lb), le), size=size}) =
	let
	  val (trees, lb) = lift_externals(trees, lb)
	  val (trees, le) = lift_externals(trees, le)
	in
	  (trees, {lexp=AugLambda.LET((lv,info,lb),le), size=size})
	end
      | lift_externals(trees, {lexp=AugLambda.FN(lv, le, name, instances), size=size}) =
	let
	  val (trees, le) = lift_externals(trees, le)
	in
	  (trees, {lexp=AugLambda.FN(lv, le, name, instances), size=size})
	end
      | lift_externals(trees, {lexp=AugLambda.STRUCT le_list, size=size}) =
	let
	  val (trees, le_list) = lift_externals_list(trees, [], le_list)
	in
	  (trees, {lexp=AugLambda.STRUCT le_list, size=size})
	end
      | lift_externals(trees, {lexp=AugLambda.SELECT(field, le), size=size}) =
	let
	  val (trees, le) = lift_externals(trees, le)
	in
	  (trees, {lexp=AugLambda.SELECT(field, le), size=size})
	end
      | lift_externals(trees, {lexp=AugLambda.SWITCH(le, info, tag_le_list, opt),
			       size=size}) =
	let
	  val (trees, opt) = case opt of
	    SOME le =>
	      let
		val (trees, le) = lift_externals(trees, le)
	      in
		(trees, SOME le)
	      end
	  | _ => (trees, opt)
	  val (trees, le) = lift_externals(trees, le)
	  val (trees, tag_le_list) =
	    lift_externals_tag_le_list(trees, [], tag_le_list)
	in
	  (trees, {lexp=AugLambda.SWITCH(le, info, tag_le_list, opt),
		   size=size})
	end
      | lift_externals(arg as (_, {lexp=AugLambda.VAR _, ...})) =
	arg
      | lift_externals(trees, {lexp=AugLambda.LETREC(lv_list, le_list, le),
			       size=size}) =
	let
	  val (trees, le) = lift_externals(trees, le)
	  val (trees, le_list) = lift_externals_list(trees, [], le_list)
	in
	  (trees, {lexp=AugLambda.LETREC(lv_list, le_list, le), size=size})
	end
      | lift_externals(arg as (_, {lexp=AugLambda.INT _, ...})) = arg
      | lift_externals(arg as (_, {lexp=AugLambda.SCON _, ...})) = arg
      | lift_externals(arg as (_, {lexp=AugLambda.MLVALUE _, ...})) = arg
      | lift_externals(trees, {lexp=AugLambda.HANDLE(le, le'), size=size}) =
	let
	  val (trees, le) = lift_externals(trees, le)
	  val (trees, le') = lift_externals(trees, le')
	in
	  (trees, {lexp=AugLambda.HANDLE(le, le'), size=size})
	end
      | lift_externals(trees, {lexp=AugLambda.RAISE (le), size=size}) =
	let
	  val (trees, le) = lift_externals(trees, le)
	in
	  (trees, {lexp=AugLambda.RAISE (le), size=size})
	end
      | lift_externals(arg as (_, {lexp=AugLambda.BUILTIN _, ...})) = arg

    and lift_externals_list(trees, acc, []) = (trees, rev acc)
      | lift_externals_list(trees, acc, x :: xs) =
	let
	  val (trees, x) = lift_externals(trees, x)
	in
	  lift_externals_list(trees, x :: acc, xs)
	end

    and lift_externals_tag_le_list(trees, acc, []) = (trees, rev acc)
      | lift_externals_tag_le_list(trees, acc, (tag, le) :: rest) =
	let
	  val (trees, tag) = case tag of
	    AugLambda.EXP_TAG le =>
	      let
		val (trees, le) = lift_externals(trees, le)
	      in
		(trees, AugLambda.EXP_TAG le)
	      end
	  | _ => (trees, tag)
	  val (trees, le) = lift_externals(trees, le)
	in
	  lift_externals_tag_le_list(trees, (tag, le) :: acc, rest)
	end

    fun get_string{lexp=AugLambda.APP
		   ({lexp=AugLambda.BUILTIN(prim,_), ...},
		    ([{lexp=AugLambda.SCON(Ident.STRING chars, NONE), ...}],[]),_), ...} =
      if prim = Pervasives.LOAD_STRING then Set.singleton chars
      else Set.empty_set
      | get_string{lexp=AugLambda.APP(le, (lel,fpel),_), ...} =
	Lists.reducel
	(fn (set, le) => Set.union(set, get_string le))
	(get_string le, lel @ fpel)
      | get_string{lexp=AugLambda.LET((_,_,lb),le),...} = 
      Set.union(get_string lb, get_string le)
      | get_string{lexp=AugLambda.FN(_, le,_,_), ...} = get_string le
      | get_string{lexp=AugLambda.STRUCT le_list, ...} =
	Lists.reducel
	(fn (set, le) => Set.union(set, get_string le))
	(Set.empty_set, le_list)
      | get_string{lexp=AugLambda.SELECT(_, le), ...} = get_string le
      | get_string{lexp=AugLambda.SWITCH _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.VAR _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.LETREC _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.INT _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.SCON _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.MLVALUE _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.HANDLE _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.RAISE _, ...} = Set.empty_set
      | get_string{lexp=AugLambda.BUILTIN _, ...} = Set.empty_set

    (* See if we must lift out any references in the tree *)
    fun transform_needed(bad, {lexp=AugLambda.APP
			 ({lexp=AugLambda.BUILTIN(prim,_), ...}, (lel,fpel), _), ...}) =
      (case prim of
	 Pervasives.LOAD_STRING => bad
       | Pervasives.LOAD_VAR => true
       | Pervasives.LOAD_EXN => true
       | Pervasives.LOAD_FUNCT => true
       | Pervasives.LOAD_STRUCT => true
       | _ => Lists.exists (fn le => transform_needed(bad, le)) (fpel @ lel))
      | transform_needed(bad, {lexp=AugLambda.APP(le, (lel,fpel),_), ...}) =
	transform_needed(bad, le) orelse  Lists.exists (fn le => transform_needed (bad, le)) (fpel @ lel)
      | transform_needed(bad, {lexp=AugLambda.LET((_,_,lb),le),...}) = 
	transform_needed(bad, lb) orelse transform_needed(bad, le)
      | transform_needed(_, {lexp=AugLambda.FN(_, le,_,_), ...}) = transform_needed(true, le)
      | transform_needed(bad, {lexp=AugLambda.STRUCT le_list, ...}) =
	Lists.exists
	(fn le => transform_needed(bad, le))
	le_list
      | transform_needed(bad, {lexp=AugLambda.SELECT(_, le), ...}) = transform_needed(bad, le)
      | transform_needed(_, {lexp=AugLambda.SWITCH(le, _, tag_le_list, le_opt),
			     ...}) =
	transform_needed(true, le) orelse
	Lists.exists
	(fn (tag, le) =>
	 transform_needed(true, le) orelse
	 (case tag of
	    AugLambda.EXP_TAG le => transform_needed(true, le)
	  | _ => false))
	tag_le_list orelse
	(case le_opt of
	   SOME le => transform_needed(true, le)
	 | _ => false)
      | transform_needed(_, {lexp=AugLambda.VAR _, ...}) = false
      | transform_needed(_, {lexp=AugLambda.LETREC(_, le_list, le), ...}) =
	Lists.exists
	(fn le => transform_needed(true, le))
	(le :: le_list)
      | transform_needed(_, {lexp=AugLambda.INT _, ...}) = false
      | transform_needed(_, {lexp=AugLambda.SCON _, ...}) = false
      | transform_needed(_, {lexp=AugLambda.MLVALUE _, ...}) = false
      | transform_needed(_, {lexp=AugLambda.HANDLE(le, le'), ...}) =
	transform_needed(true, le) orelse transform_needed(true, le')
      | transform_needed(_, {lexp=AugLambda.RAISE le, ...}) =
	transform_needed(true, le)
      | transform_needed(_, {lexp=AugLambda.BUILTIN _, ...}) = false

    fun needs_prim_stringeq(AugLambda.VAR _) = false
      | needs_prim_stringeq(AugLambda.FN(_, {lexp=lexp, ...}, _,_)) =
	needs_prim_stringeq lexp
      | needs_prim_stringeq(AugLambda.LET((_,_, {lexp=bind,...}), {lexp=expr,...})) =
	needs_prim_stringeq bind orelse needs_prim_stringeq expr
      | needs_prim_stringeq(AugLambda.LETREC(_, le_list, {lexp=le, ...})) =
	needs_prim_stringeq le orelse
	Lists.exists
	(fn {lexp=lexp, size=_} => needs_prim_stringeq lexp)
	le_list
      | needs_prim_stringeq(AugLambda.APP({lexp=le, ...}, (el,fpel),_)) =
	needs_prim_stringeq le orelse 
	Lists.exists
	(fn {lexp=lexp, size=_} => needs_prim_stringeq lexp)
	(fpel @ el)
      | needs_prim_stringeq(AugLambda.SCON _) = false
      | needs_prim_stringeq(AugLambda.MLVALUE _) = false
      | needs_prim_stringeq(AugLambda.INT _) = false
      | needs_prim_stringeq(AugLambda.SWITCH({lexp=le, ...}, _, tag_le_list, opt)) =
	needs_prim_stringeq le orelse
	needs_prim_stringeq_opt opt orelse
	Lists.exists needs_prim_stringeq_tag tag_le_list
      | needs_prim_stringeq(AugLambda.STRUCT le_list) =
	Lists.exists
	(fn {lexp=lexp, size=_} => needs_prim_stringeq lexp)
	le_list
      | needs_prim_stringeq(AugLambda.SELECT(_, {lexp=lexp, ...})) =
	needs_prim_stringeq lexp
      | needs_prim_stringeq(AugLambda.RAISE({lexp=lexp, ...})) =
	needs_prim_stringeq lexp
      | needs_prim_stringeq(AugLambda.HANDLE({lexp=le, ...}, {lexp=le', ...})) =
	needs_prim_stringeq le orelse
	needs_prim_stringeq le'
      | needs_prim_stringeq(AugLambda.BUILTIN _) = false

    and needs_prim_stringeq_opt(SOME {lexp=lexp, size=_}) =
      needs_prim_stringeq lexp
      | needs_prim_stringeq_opt NONE = false

    and needs_prim_stringeq_tag(tag, {lexp=lexp, size=_}) =
      case tag of
	AugLambda.SCON_TAG(Ident.STRING _, _) => true
      | _ => needs_prim_stringeq lexp

end
