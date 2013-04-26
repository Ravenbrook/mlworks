(* _lambdatypes.sml the functor *)
(*
$Log: _lambdatypes.sml,v $
Revision 1.59  1999/02/09 09:50:00  mitchell
[Bug #190505]
Support for precompilation of subprojects

 * Revision 1.58  1996/12/02  13:37:16  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.57  1996/11/06  11:02:25  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.56  1996/04/29  13:45:22  matthew
 * Integer changes
 *
 * Revision 1.55  1995/12/22  16:52:39  jont
 * Remove references to option structure
 * in favour of MLWorks.Option
 *
Revision 1.54  1995/12/13  14:00:20  jont
Add lvar_to_int function for using lvars with int hash tables

Revision 1.53  1995/12/04  13:36:53  matthew
Simplifying

Revision 1.52  1995/08/10  17:17:09  daveb
Added types for different lengths of words, ints and reals.

Revision 1.51  1995/03/22  14:07:19  daveb
Removed redundant requires, and unused Crash and Lists parameters.

Revision 1.50  1995/02/28  11:44:54  matthew
More information in FunInfo types

Revision 1.49  1995/01/17  11:18:10  matthew
Renaming debugger_env to runtime_env

Revision 1.48  1994/10/10  09:33:24  matthew
Various simplifications
Added module annotations to lambda syntax.

Revision 1.47  1994/09/22  09:31:17  matthew
Abstraction of debug information

Revision 1.46  1994/07/20  14:39:23  matthew
Functions and applications take a list of parameters

Revision 1.45  1993/12/08  16:31:28  nosa
Type function spills for Modules Debugger.

Revision 1.44  1993/08/13  15:43:44  nosa
FNs now passed closed-over type variables and
stack frame-offset for runtime-instance for polymorphic debugger.

Revision 1.43  1993/07/12  10:00:35  nosa
Types of constructors LET and LETREC have changed for
local and closure variable inspection in the debugger.

Revision 1.42  1993/05/18  15:52:05  jont
Removed integer parameter

Revision 1.41  1993/03/10  14:29:12  matthew
Signature revisions

Revision 1.40  1993/03/04  11:59:51  jont
Removed LVar_eq in favour of polymorphic equality, which work rather better
on MLWorks.

Revision 1.39  1993/03/01  14:35:27  matthew
Added MLVALUE lambda exp

Revision 1.38  1992/11/07  11:39:19  richard
Added a missing require.

Revision 1.37  1992/11/04  16:32:20  daveb
Fixed typo: mononewmap -> intnewmap

Revision 1.36  1992/11/03  11:49:14  daveb
Changed type of SWITCH; pointer defaults are no longer used, but information
about value-carrying and constant constructors is added.

Revision 1.35  1992/10/29  18:03:23  jont
Added IntNewMap parameter for constructing more efficient maps

Revision 1.34  1992/10/02  16:14:34  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.33  1992/09/21  10:41:54  clive
Changed hashtables to a single structure implementation

Revision 1.32  1992/08/26  11:53:05  jont
Removed some redundant structures and sharing

Revision 1.31  1992/08/19  16:35:53  davidt
Added LVar_ordering function.

Revision 1.30  1992/07/29  09:55:41  clive
Changed the bindingtable to be a hashtable

Revision 1.29  1992/07/17  10:44:23  clive
null_type_annotation is no longer a function

Revision 1.28  1992/07/01  12:41:56  davida
Added LET constructor and new slot to APP.

Revision 1.27  1992/06/23  09:24:31  clive
Added an annotation slot to HANDLE

Revision 1.26  1992/06/22  16:08:29  davida
Made string of field select a bit shorter.

Revision 1.25  1992/06/11  08:36:48  clive
Added datatype recording to the FNexp for the debugger and annotated LETs with
a string to be used as the annotation when they are converted into Fnexps

Revision 1.24  1992/04/22  13:24:14  clive
Speed improvements

Revision 1.23  1992/04/13  14:18:00  clive
First version of the profiler

Revision 1.22  1992/03/21  14:17:53  jont
Added require "../utils/set"

Revision 1.21  1992/02/26  11:56:07  jont
Added an lvar equality function, since polymorphic equality is so slow

Revision 1.20  1992/01/29  11:14:41  clive
Added the routines for calculating the next and previous Lvar after
a given lvar

Revision 1.19  1992/01/28  14:11:58  clive
Added a function to give the previous lambda variable

Revision 1.18  1992/01/06  11:51:59  jont
Added datatype binding to allow lets and recursive lets

Revision 1.17  1991/11/28  11:50:14  richard
Removed an unnecessary constraint on the Ident structure.

Revision 1.16  91/10/22  14:57:25  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.15  91/10/08  18:54:52  davidt
Changed the type LambdaExp so that record selection now retains the total
size of the record as well as just the index.

Revision 1.14  91/09/06  10:21:53  davida
Added LambdaInfo type for optimisations,
info for code-generator, etc.

Revision 1.13  91/08/23  11:04:51  jont
Changed to use pervasives

Revision 1.12  91/08/23  10:29:22  davida
Added ordering on lambda-expressions.

Revision 1.11  91/08/14  12:41:17  davida
Added int_of_LVar function to help hashing on
lambda-expressions.

Revision 1.10  91/07/25  10:04:57  jont
Added ordering on LVars and Primitives to allow them to be domains in maps

Revision 1.9  91/07/16  14:34:51  jont
Added EXP_TAG type to Construc and changed its name to Tag,
in order to code generate dynamic switches for exception matching

Revision 1.8  91/07/11  11:03:01  jont
New style LETREC

Revision 1.7  91/07/09  12:10:27  jont
Added fromField to get ints back from Fields

Revision 1.6  91/06/27  09:51:30  jont
Changed use multiple counter instances

Revision 1.5  91/06/26  18:35:56  jont
Added primitive generation for unique ids

Revision 1.4  91/06/26  16:13:53  jont
Changed LETERC to reflect declarative nature of ML ie no "in" expression

Revision 1.3  91/06/18  19:06:00  jont
Added second default case to SWITCH statement to allow easy distinction
of tag from not a tag cases, eg when deconstructing a value carrying
constructor

Revision 1.2  91/06/18  13:38:00  jont
Added INT to lambda calculus for nullary constructors in expressions

Revision 1.1  91/06/11  16:14:00  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basis/__int";

require "../utils/set";
require "../utils/counter";
require "../main/pervasives";
require "../typechecker/datatypes" ;
require "../debugger/runtime_env";
require "lambdatypes";

functor LambdaTypes(
  structure Set : SET
  structure Counter: COUNTER
  structure Pervasives: PERVASIVES
  structure Datatypes : DATATYPES
  structure RuntimeEnv : RUNTIMEENV
) : LAMBDATYPES =
struct
  structure Set = Set
  structure Ident = Datatypes.Ident
  structure Datatypes = Datatypes

  type Type = Datatypes.Type
  type Tyfun = Datatypes.Tyfun
  type Instance = Datatypes.Instance
  type Structure = Datatypes.Structure
  type DebuggerStr = Datatypes.DebuggerStr
  type FunInfo = RuntimeEnv.FunInfo
  type VarInfo = RuntimeEnv.VarInfo

  type LVar = int
  type Field = int
  type Primitive = Pervasives.pervasive

  datatype StructType = STRUCTURE | TUPLE | CONSTRUCTOR

  datatype Status = ENTRY | BODY | FUNC

  datatype Tag =
    VCC_TAG of string * int           (* value carrying constructor *)
  | IMM_TAG of string * int           (* constant constructor *)
  | SCON_TAG of Ident.SCon * int option   (* simple int, real, string ... *)
				      (* The int option gives the size of numeric types *)
  | EXP_TAG of LambdaExp     (* more complex tag, for dynamic switching *)

  and LambdaExp =
    VAR of LVar                       (* variable lookup *)
                                      (* function definition *)
  | FN of ((LVar list * LVar list) * LambdaExp * Status * string * Type * FunInfo)
  | LET of (LVar * VarInfo ref option * LambdaExp) * LambdaExp
  | LETREC of ((LVar * VarInfo ref option) list * LambdaExp list * LambdaExp)
  | APP of (LambdaExp * (LambdaExp list * LambdaExp list) * Type ref option)  (* function application *)
  | SCON of Ident.SCon * int option      (* int, real, string as strings *)
				      (* The int option gives the size of numeric types *)
  | MLVALUE of MLWorks.Internal.Value.ml_value (* immediate constants *)
  | INT of int                        (* int as int (for tags) *)
  | SWITCH of                         (* like a case statement *)
      LambdaExp *
      {num_vccs: int, num_imms: int} option *
      (Tag * LambdaExp) list *
      LambdaExp option
  (* The second argument contains enough information about the type being
     matched for the code generator to choose an appropriate representation.
     The LVar is bound to the argument of a value carrying constructor.
  *)
  | STRUCT of LambdaExp list * StructType         (* structure definition *)
  | SELECT of {index : int, size : int, selecttype : StructType} * LambdaExp     (* field selector *)
  | RAISE of LambdaExp              (* Exceptions --- throw ... *)
  | HANDLE of (LambdaExp * LambdaExp * string) (*            ... and catch *)
  | BUILTIN of Primitive              (* built-in functions --
				         These functions are
				         primitive to the abstract
				         machine. *)
  datatype binding =
    LETB of (LVar * VarInfo ref option * LambdaExp) |
    RECLETB of ((LVar * VarInfo ref option) list * LambdaExp list)

  fun do_binding(LETB(lv,info,le), exp) = LET((lv,info,le),exp)
    | do_binding(RECLETB(lv_list, le_list), exp)= LETREC(lv_list, le_list, exp)

  fun new_LVar () = Counter.counter () (* : unit -> LVar *)
  fun init_LVar () = Counter.reset_counter 0
  fun lvar_to_int x = x
  fun printLVar lvar = Int.toString lvar
  val read_counter = Counter.read_counter
  val reset_counter = Counter.reset_counter

  fun printPrim prim = Pervasives.print_pervasive prim
  fun printField {index : int, size : int,selecttype : StructType} =
	(*"index : " ^*) Int.toString index ^ "/" ^
        (*" size : " ^*) Int.toString size;
    

  val null_type_annotation = Datatypes.NULLTYPE

  val user_funinfo = RuntimeEnv.USER_FUNCTION
  val internal_funinfo = RuntimeEnv.INTERNAL_FUNCTION
  fun isLocalFn (RuntimeEnv.LOCAL_FUNCTION) = true
    | isLocalFn _ = false

  (* New stuff from simple*** *)
    datatype Dec = 
      VAL of LambdaExp |
      FUNCTOR of LVar * string * ((LVar * VarInfo ref option * Dec) list * LambdaExp)
      
    datatype program =
      PROGRAM of (LVar * VarInfo ref option * Dec) list * LambdaExp

    fun telfun f (EXP_TAG e, e') = (EXP_TAG (f e), f e')
      | telfun f (t,e) = (t,f e)

    (* Dispensers of unique ids *)
    val new_valid = new_LVar

end
