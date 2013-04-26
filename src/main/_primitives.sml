(* _primitives.sml the functor *)
(*
$Log: _primitives.sml,v $
Revision 1.47  1998/02/19 16:45:36  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.46  1997/05/01  13:15:25  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.45  1995/09/13  18:52:39  daveb
 * Corrected the last change.
 *
Revision 1.44  1995/09/13  15:05:05  daveb
Added int32 operations.

Revision 1.43  1995/08/31  10:49:04  daveb
Added eq and ne operators for new numeric types to the list
of overloaded operators found here.

Revision 1.42  1995/08/01  10:03:52  jont
Change setup of overloaded names

Revision 1.41  1995/07/28  16:55:09  jont
Add overloading for div and mod on ints and words

Revision 1.40  1995/07/26  15:01:58  jont
Fix problems with overloaded operator table

Revision 1.39  1995/07/20  16:00:47  jont
Add word functions

Revision 1.38  1995/07/14  10:03:56  jont
Add overloaded char relations

Revision 1.37  1995/05/26  10:09:12  matthew
Extended set of builtins available for compiling the builtin library

Revision 1.36  1994/02/02  14:52:48  nosa
generate_moduler compiler option in strenvs and funenvs for compatibility purposes.

Revision 1.35  1993/07/07  17:59:29  daveb
Removed exception environments.

Revision 1.34  1993/03/10  15:48:19  matthew
Signature revisions

Revision 1.33  1993/03/05  12:50:50  jont
Added builtin string relationals

Revision 1.32  1992/08/26  12:14:56  jont
Removed some redundant structures and sharing

Revision 1.31  1992/08/17  14:18:59  jont
Added inline ordof

Revision 1.30  1992/06/18  16:55:18  jont
Added call_ml_value to list of imperative builtins

Revision 1.29  1992/06/10  14:14:39  jont
changed to use newmap

Revision 1.28  1992/05/15  16:23:22  clive
Tried to neaten

Revision 1.27  1992/05/13  10:58:41  clive
Added the Bits structure

Revision 1.26  1992/03/23  11:42:42  jont
Added require for crash

Revision 1.25  1992/03/03  11:16:30  richard
Added EQFUN to initial valenv.

Revision 1.24  1992/03/02  16:03:14  richard
Changed pervasive EQ to EQFUN.  EQ is the inline version.  See Mir_Cg.

Revision 1.23  1992/02/12  15:22:13  clive
New pervasive library

Revision 1.22  1992/01/31  11:11:09  clive
Array-problems - the structure was missing

Revision 1.21  1992/01/16  16:44:33  clive
Added arrays to the initial basis - needed to mark them as imperative

Revision 1.20  1992/01/10  14:30:42  richard
Added a SUBSTRING pervasive as a temporary measure so that the same code
can be compiled under under both New Jersey and MLWorks.

Revision 1.19  1992/01/09  17:55:17  jont
Updated to use Lists.foldl and new stuff from environ

Revision 1.18  1991/11/28  17:07:49  richard
Removed MAKE_NEW_UNIQUE from the list of primitives.

Revision 1.17  91/11/14  14:10:00  richard
Added System structure containing call_c value to the initial
environment.

Revision 1.16  91/10/22  15:09:47  davidt
Now uses the Crash.impossible function instead of raising an exception.

Revision 1.15  91/10/16  16:13:15  jont
Added _call_c to initial value environment

Revision 1.14  91/09/16  16:55:42  davida
Completed spelling corrections properly.

Revision 1.12  91/08/23  11:39:49  jont
Changed to use pervasives

Revision 1.11  91/08/22  13:52:52  jont
Added associative_primitives and made abs overloaded

Revision 1.10  91/08/09  14:27:05  jont
Added primitive for ~, plus overloaded versions

Revision 1.9  91/08/07  14:25:07  jont
Added int, real and string equality and inequality primitives

Revision 1.8  91/08/02  14:47:34  jont
Added the i/o primitives

Revision 1.7  91/07/24  12:15:10  jont
Added commutative primitives to assist in lambda expression optimisation

Revision 1.6  91/07/22  13:41:04  jont
Added ! to list of imperative primitives

Revision 1.5  91/07/19  16:52:57  jont
First attempt at abstracting out external arguments

Revision 1.4  91/07/15  13:05:27  jont
Placed builtin exceptions in the exception environment

Revision 1.3  91/07/12  16:27:36  jont
Added _make_unique for generating exceptions

Revision 1.2  91/07/11  17:06:34  jont
Added = to list of builtins

Revision 1.1  91/07/10  12:00:11  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/lists";
require "../utils/crash";
require "../lambda/environ";
require "pervasives";
require "primitives";

functor Primitives
  (structure Crash : CRASH
   structure Lists : LISTS
   structure Environ : ENVIRON
   structure Pervasives : PERVASIVES

   sharing type Pervasives.pervasive = Environ.EnvironTypes.LambdaTypes.Primitive
     ) : PRIMITIVES =
struct
  structure EnvironTypes = Environ.EnvironTypes
  structure LambdaTypes = EnvironTypes.LambdaTypes
  structure Ident = LambdaTypes.Ident
  structure Set = LambdaTypes.Set
  structure Symbol = Ident.Symbol
  structure NewMap = EnvironTypes.NewMap

  (* This is a (hopefully) complete list of the builtins that can be used in compiling *)
  (* the builtin library -- only inline builtins that do not raise builtin exceptions *)
  (* are allowed *)

  (* This list could be compiled using is_inline and _implicit_references from machperv *)
  (* but I didn't want to make it machine dependent *)

  val values_for_builtin_library =
    [("call_c",Pervasives.CALL_C),
     ("length", Pervasives.LENGTH),
     ("unsafe_sub", Pervasives.UNSAFE_SUB),
     ("unsafe_update", Pervasives.UNSAFE_UPDATE),
     ("real", Pervasives.REAL),
     ("int_equal", Pervasives.INTEQ),
     ("int_greater", Pervasives.INTGREATER),
     ("int_greater_or_equal", Pervasives.INTGREATEREQ),
     ("int_less", Pervasives.INTLESS),
     ("int_less_or_equal", Pervasives.INTLESSEQ),
     ("int_not_equal", Pervasives.INTNE),
     ("char_equal", Pervasives.CHAREQ),
     ("char_greater", Pervasives.CHARGT),
     ("char_greater_or_equal", Pervasives.CHARGE),
     ("char_less", Pervasives.CHARLT),
     ("char_less_or_equal", Pervasives.CHARLE),
     ("char_not_equal", Pervasives.CHARNE),
     ("word_equal", Pervasives.WORDEQ),
     ("word_greater", Pervasives.WORDGT),
     ("word_greater_or_equal", Pervasives.WORDGE),
     ("word_less", Pervasives.WORDLT),
     ("word_less_or_equal", Pervasives.WORDLE),
     ("word_not_equal", Pervasives.WORDNE),
     ("unsafe_int_plus", Pervasives.UNSAFEINTPLUS),
     ("unsafe_int_minus", Pervasives.UNSAFEINTMINUS),
     ("!", Pervasives.DEREF),
     (":=", Pervasives.BECOMES),
     ("size", Pervasives.SIZE),
     ("bytearray_unsafe_sub", Pervasives.BYTEARRAY_UNSAFE_SUB),
     ("bytearray_unsafe_update", Pervasives.BYTEARRAY_UNSAFE_UPDATE),
     ("vector_length", Pervasives.VECTOR_LENGTH),
     ("andb", Pervasives.ANDB),
     ("lshift", Pervasives.LSHIFT),
     ("notb", Pervasives.NOTB),
     ("orb", Pervasives.ORB),
     ("rshift", Pervasives.RSHIFT),
     ("arshift", Pervasives.ARSHIFT),
     ("xorb", Pervasives.XORB),
     ("cast", Pervasives.CAST),
     ("alloc_string", Pervasives.ALLOC_STRING),
     ("alloc_vector", Pervasives.ALLOC_VECTOR),
     ("alloc_pair", Pervasives.ALLOC_PAIR),
     ("record_unsafe_sub", Pervasives.RECORD_UNSAFE_SUB),
     ("record_unsafe_update", Pervasives.RECORD_UNSAFE_UPDATE),
     ("string_unsafe_sub", Pervasives.STRING_UNSAFE_SUB),
     ("string_unsafe_update", Pervasives.STRING_UNSAFE_UPDATE),
     ("get_implicit", Pervasives.GET_IMPLICIT)]
    
  val overload_table_for_lambda =
    [("_real+", Pervasives.REALPLUS),
     ("_int+", Pervasives.INTPLUS),
     ("_int32+", Pervasives.INT32PLUS),
     ("_word+", Pervasives.WORDPLUS),
     ("_word32+", Pervasives.WORD32PLUS),
     ("_real*", Pervasives.REALSTAR),
     ("_int*", Pervasives.INTSTAR),
     ("_int32*", Pervasives.INT32STAR),
     ("_word*", Pervasives.WORDSTAR),
     ("_word32*", Pervasives.WORD32STAR),
     ("_real-", Pervasives.REALMINUS),
     ("_int-", Pervasives.INTMINUS),
     ("_int32-", Pervasives.INT32MINUS),
     ("_word-", Pervasives.WORDMINUS),
     ("_word32-", Pervasives.WORD32MINUS),
     ("_real~", Pervasives.REALUMINUS),
     ("_int~", Pervasives.INTUMINUS),
     ("_int32~", Pervasives.INT32UMINUS),
     ("_int<", Pervasives.INTLESS),
     ("_real<", Pervasives.REALLESS),
     ("_int>", Pervasives.INTGREATER),
     ("_real>", Pervasives.REALGREATER),
     ("_int<=", Pervasives.INTLESSEQ),
     ("_real<=", Pervasives.REALLESSEQ),
     ("_int>=", Pervasives.INTGREATEREQ),
     ("_real>=", Pervasives.REALGREATEREQ),
     ("_int=", Pervasives.INTEQ),
     ("_int<>", Pervasives.INTNE),
     ("_real=", Pervasives.REALEQ),
     ("_real<>", Pervasives.REALNE),
     ("_string=", Pervasives.STRINGEQ),
     ("_string<>", Pervasives.STRINGNE),
     ("_string<", Pervasives.STRINGLT),
     ("_string>", Pervasives.STRINGGT),
     ("_string<=", Pervasives.STRINGLE),
     ("_string>=", Pervasives.STRINGGE),
     ("_char=", Pervasives.CHAREQ),
     ("_char<>", Pervasives.CHARNE),
     ("_char<", Pervasives.CHARLT),
     ("_char>", Pervasives.CHARGT),
     ("_char<=", Pervasives.CHARLE),
     ("_char>=", Pervasives.CHARGE),
     ("_word=", Pervasives.WORDEQ),
     ("_word<>", Pervasives.WORDNE),
     ("_word<", Pervasives.WORDLT),
     ("_word>", Pervasives.WORDGT),
     ("_word<=", Pervasives.WORDLE),
     ("_word>=", Pervasives.WORDGE),
     ("_word32=", Pervasives.WORD32EQ),
     ("_word32<>", Pervasives.WORD32NE),
     ("_word32<", Pervasives.WORD32LT),
     ("_word32>", Pervasives.WORD32GT),
     ("_word32<=", Pervasives.WORD32LE),
     ("_word32>=", Pervasives.WORD32GE),
     ("_int32=", Pervasives.INT32EQ),
     ("_int32<>", Pervasives.INT32NE),
     ("_int32<", Pervasives.INT32LESS),
     ("_int32>", Pervasives.INT32GREATER),
     ("_int32<=", Pervasives.INT32LESSEQ),
     ("_int32>=", Pervasives.INT32GREATEREQ),
     ("_intabs", Pervasives.INTABS),
     ("_int32abs", Pervasives.INT32ABS),
     ("_realabs", Pervasives.REALABS),
     ("_intmod", Pervasives.INTMOD),
     ("_intdiv", Pervasives.INTDIV),
     ("_int32mod", Pervasives.INT32MOD),
     ("_int32div", Pervasives.INT32DIV),
     ("_wordmod", Pervasives.WORDMOD),
     ("_worddiv", Pervasives.WORDDIV),
     ("_word32mod", Pervasives.WORD32MOD),
     ("_word32div", Pervasives.WORD32DIV)
     ]    
    
  fun add_cons(env, names) =
    Lists.reducel
    (fn (env, (name, prim)) =>
     Environ.add_valid_env(env, (Ident.CON(Symbol.find_symbol name),
                                 EnvironTypes.PRIM prim)))
    (env, names)

  fun add_exns(env, names) =
    Lists.reducel
    (fn (env, (name, prim)) =>
     Environ.add_valid_env(env, (Ident.EXCON(Symbol.find_symbol name),
                                 EnvironTypes.PRIM prim)))
    (env, names)

  fun add_strs(env, names) =
    Lists.reducel
    (fn (env, (name, prim, inner_env)) =>
     Environ.add_strid_env(env, (Ident.STRID(Symbol.find_symbol name),
                                 (inner_env, prim, false))))
    (env, names)

  fun add_vals(env, names) =
    Lists.reducel
    (fn (env, (name, prim)) =>
     Environ.add_valid_env(env, (Ident.VAR(Symbol.find_symbol name),
                                 EnvironTypes.PRIM prim)))
    (env, names)

  fun add_overloads env ov_list =
    let
      val _ = Environ.define_overloaded_ops ov_list
    in
      add_vals(env, ov_list)
    end

  val initial_env =
    add_vals
    (add_exns
     (add_cons (Environ.empty_env, map (fn (x,y) => (y,x)) Pervasives.constructor_name_list), 
      map (fn (x,y) => (y,x)) Pervasives.exception_name_list), 
     map (fn (x,y) => (y,x)) Pervasives.value_name_list)

  (* make an env of the valid ids for compiling __builtin_library *)
  val initial_env_for_builtin_library =
    add_vals
     (add_exns
       (add_cons (Environ.empty_env, []), []), values_for_builtin_library)

  val builtin_library_strname =
    Ident.STRID(Symbol.find_symbol "BuiltinLibrary_")

  val env_after_builtin =
    Environ.add_strid_env
      (Environ.empty_env,
       (builtin_library_strname,
        (initial_env, EnvironTypes.FIELD {index=0,size=1}, false)))

  (* This checks that the argument (which should be the environment returned
     from the compilation of the builtin library) matches the internal
     builtins.  *)

  fun check_builtin_env {error_fn, topenv = EnvironTypes.TOP_ENV (env, _)} =
    let
      val EnvironTypes.ENV (top_ve, top_se) = env

      val flag =
        if NewMap.size top_ve <> 0 then
	  (ignore(error_fn "builtin library defines values at top_level");
	   false)
        else
	  true
    in
      case NewMap.tryApply' (top_se, builtin_library_strname)
      of SOME (EnvironTypes.ENV (ve, se), _, _) =>
	if NewMap.size top_se <> 1 orelse NewMap.size se <> 0 then
	  (ignore(error_fn "builtin library defines extra structures");
	   false)
        else
	  let
	    val EnvironTypes.ENV (initial_ve, _) = initial_env

	    fun check_new (flag, valId as Ident.VAR sym, _) =
	      (case NewMap.tryApply' (ve, valId)
	       of SOME _ => flag
	       |  NONE =>
	         (ignore(error_fn
	            ("can't find value " ^ Ident.Symbol.symbol_name sym
		     ^ " in builtin library"));
	          false))
	    |   check_new (flag, valId as Ident.EXCON sym, _) =
	      (case NewMap.tryApply' (ve, valId)
	       of SOME _ => flag
	       |  NONE =>
	         (ignore(error_fn
	            ("can't find exception " ^ Ident.Symbol.symbol_name sym
		     ^ " in builtin library"));
	          false))
	    |  check_new (flag, _, _) = flag    (* ignore constructors *)

	    fun check_internal (flag, valId as Ident.VAR sym, _) =
	      (case NewMap.tryApply' (initial_ve, valId)
	       of SOME _ => flag
	       |  NONE =>
	         (ignore(error_fn
	 	    ("builtin library defines unknown value " ^
		     Ident.Symbol.symbol_name sym
		     ^ " - see main._primitives"));
	          false))
	    |   check_internal (flag, valId as Ident.EXCON sym, _) =
	      (case NewMap.tryApply' (initial_ve, valId)
	       of SOME _ => flag
	       |  NONE =>
	         (ignore(error_fn
	 	    ("builtin library defines unknown exception " ^
		     Ident.Symbol.symbol_name sym
		     ^ " - see main._primitives"));
	          false))
	    |  check_internal (flag, _, _) = flag    (* ignore constructors *)
	     
	    val flag = NewMap.fold check_new (flag, initial_ve)
          in
	    NewMap.fold check_internal (flag, ve)
          end
      |  NONE => 
	(ignore(error_fn
	   "builtin library does not define structure BuiltinLibrary_!");
         false)
    end


  local
    val ml_non_definable_values =
      [("=", Pervasives.EQ)]
    val ml_non_definable_overloads =
      [("~", Pervasives.UMINUS),
       ("abs", Pervasives.ABS),
       ("+", Pervasives.PLUS),
       ("*", Pervasives.STAR),
       ("-", Pervasives.MINUS),
       ("mod", Pervasives.MOD),
       ("div", Pervasives.DIV),
       ("<", Pervasives.LESS),
       (">", Pervasives.GREATER),
       ("<=", Pervasives.LESSEQ),
       (">=", Pervasives.GREATEREQ)]
  in
    val env_for_not_ml_definable_builtins =
      add_cons
      ((add_overloads
        (add_vals
         (add_exns
          (add_cons (Environ.empty_env, []), []), 
           ml_non_definable_values))
(* 
        ["~", "+", "-", "*", "mod", "div", "<", ">", "<=", ">=", "abs"]
*)
        ml_non_definable_overloads), 
      map (fn (x,y) => (y,x)) Pervasives.constructor_name_list)
  end
    
  val env_for_lookup_in_lambda =
    add_vals(Environ.empty_env,overload_table_for_lambda)

end
