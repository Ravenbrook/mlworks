(* lambdatypes.sml the signature *)
(*
$Log: lambdatypes.sml,v $
Revision 1.56  1999/02/09 09:50:01  mitchell
[Bug #190505]
Support for precompilation of subprojects

 * Revision 1.55  1996/12/02  13:36:44  matthew
 * Adding isLocalFn function
 *
 * Revision 1.54  1996/10/04  13:47:06  matthew
 * [Bug #1634]
 *
 * Tidying up
 *
 * Revision 1.53  1996/02/26  11:20:26  jont
 * Change newhashtable to hashtable
 *
 * Revision 1.52  1995/12/22  16:52:16  jont
 * Remove references to option structure
 * in favour of MLWorks.Option
 *
Revision 1.51  1995/12/13  13:59:56  jont
Add lvar_to_int function for using lvars with int hash tables

Revision 1.50  1995/12/04  13:36:45  matthew
Simplifying

Revision 1.49  1995/08/21  11:36:23  daveb
Added types for different lengths of words, ints and reals.

Revision 1.48  1995/02/28  11:40:55  matthew
More information in FunInfo types

Revision 1.47  1994/10/10  09:31:35  matthew
Simplifications of lambda expressions

Revision 1.46  1994/09/22  09:32:25  matthew
Abstraction of debug information

Revision 1.45  1994/07/20  14:39:02  matthew
Functions and applications take a list of parameters

Revision 1.44  1993/12/08  16:31:17  nosa
Type function spills for Modules Debugger.

Revision 1.43  1993/08/13  15:42:29  nosa
FNs now passed closed-over type variables and
stack frame-offset for runtime-instance for polymorphic debugger.

Revision 1.42  1993/07/12  09:57:02  nosa
Changed Tags and LETs for local and closure variable inspection
in the debugger.

Revision 1.41  1993/03/10  16:01:16  matthew
Signature revisions

Revision 1.40  1993/03/04  11:58:26  jont
Removed LVar_eq in favour of polymorphic equality, which work rather better
on MLWorks.

Revision 1.39  1993/03/01  14:01:03  matthew
Added MLVALUE lambda exp

Revision 1.38  1992/11/03  11:47:59  daveb
Changed type of SWITCH; pointer defaults are no longer used, but information
about value-carrying and constant constructors is added.

Revision 1.37  1992/10/29  18:01:47  jont
Added IntNewMap parameter for constructing more efficient maps

Revision 1.36  1992/10/02  16:14:10  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.35  1992/09/21  10:39:20  clive
Changed hashtables to a single structure implementation

Revision 1.34  1992/08/26  11:45:43  jont
Removed some redundant structures and sharing

Revision 1.33  1992/08/19  16:26:28  davidt
Added LVar_ordering function.

Revision 1.32  1992/07/29  09:54:34  clive
Changed the bindingtable to be a hashtable

Revision 1.31  1992/07/17  10:44:08  clive
null_type_annotation is no longer a function

Revision 1.30  1992/07/01  12:42:06  davida
Added LET constructor and new slot to APP.

Revision 1.29  1992/06/23  09:24:17  clive
Added an annotation slot to HANDLE

Revision 1.28  1992/06/11  08:34:18  clive
Added datatype recording to the FNexp for the debugger and annotated LETs with
a string to be used as the annotation when they are converted into Fnexps

Revision 1.27  1992/04/22  13:24:24  clive
Speed improvement

Revision 1.26  1992/04/14  16:07:03  clive
First version of the profiler

Revision 1.25  1992/02/26  11:54:24  jont
Added an lvar equality function, since polymorphic equality is so slow

Revision 1.24  1992/01/29  11:15:03  clive
Added the routines for calculating the next and previous Lvar after
a given lvar

Revision 1.23  1992/01/28  12:32:28  clive
Added a function to give the previous lambda variable

Revision 1.22  1992/01/06  11:49:38  jont
Added datatype binding to allow lets and recursive lets

Revision 1.21  1991/11/28  10:59:01  richard
Removed an unnecessary constraint on the Ident structure.

Revision 1.20  91/10/22  14:57:08  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.19  91/10/08  18:54:44  davidt
Changed the type LambdaExp so that record selection now retains the total
size of the record as well as just the index.

Revision 1.18  91/09/06  10:21:44  davida
Added LambdaInfo type for optimiser
and code-generator.

Revision 1.17  91/08/23  11:04:02  jont
Changed to use pervasives
Removed init_prim

Revision 1.16  91/08/23  09:36:39  davida
Added ordering on lambda-expressions.

Revision 1.15  91/08/15  10:33:22  davida
Added a comment to int_of_LVar to indicate the
assumptions made elsewhere about the values it
will return; namely that they will be positive
integers, increasing in order of calling new_LVar

Revision 1.14  91/08/14  12:40:44  davida
Added int_of_LVar function to help hashing on
lambda-expressions.

Revision 1.13  91/08/13  10:15:59  davida
Added comment to LVar_order ordering function to make
explicit the assumption made elsewhere about the
ordering  (i.e. older lambda variables order before
newer ones).

Revision 1.12  91/07/25  09:56:20  jont
Added ordering on LVars and Primitives to allow them to be domains in maps

Revision 1.11  91/07/16  14:32:59  jont
> Added EXP_TAG type to Construc and changed its name to Tag,
in order to code generate dynamic switches for exception matching

Revision 1.10  91/07/11  11:02:34  jont
New LETREC with expression in it again.

Revision 1.9  91/07/10  11:15:07  jont
Corrected definition of new_Prim to return Primitive rather than LVar

Revision 1.8  91/07/09  12:10:06  jont
Added fromField to get ints back from Fields

Revision 1.7  91/06/26  18:35:03  jont
Added primitive generation for unique ids

Revision 1.6  91/06/26  16:12:26  jont
Changed LETERC to reflect declarative nature of ML ie no "in" expression

Revision 1.5  91/06/19  11:41:00  jont
Made LVar, Field, Primitive eqtypes to allow comparison in _lambda

Revision 1.4  91/06/18  19:05:00  jont
Added second default case to SWITCH statement to allow easy distinction
of tag from not a tag cases, eg when deconstructing a value carrying
constructor

Revision 1.3  91/06/18  13:37:00  jont
Added INT to lambda calculus for nullary constructors in expressions

Revision 1.2  91/06/11  16:56:12  jont
Abstracted out the types from the functions

Revision 1.1  91/06/11  11:40:18  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/set";
require "../basics/ident";

signature LAMBDATYPES = sig
  structure Set : SET
  structure Ident : IDENT

  type Type
  type Tyfun
  type Instance
  type Structure
  type DebuggerStr
  type FunInfo
  type VarInfo

  eqtype LVar
  eqtype Field
  eqtype Primitive

  datatype StructType = STRUCTURE | TUPLE | CONSTRUCTOR

  datatype Status = ENTRY | BODY | FUNC

  datatype Tag =
    VCC_TAG of string * int     (* value carrying constructor *)
  | IMM_TAG of string * int     (* constant constructor *)
  | SCON_TAG of Ident.SCon * int option
			(* simple int, real, string ... *)
			(* The int option gives the size of numeric types *)
  | EXP_TAG of LambdaExp(* more complex tag, for dynamic switching *)

  and LambdaExp =
    VAR of LVar         (* variable lookup *)
  | FN of ((LVar list * LVar list) * LambdaExp * Status * string * Type * FunInfo)
                        (* Function definition *)
  | LET of (LVar * VarInfo ref option * LambdaExp) * LambdaExp
  | LETREC of (LVar * VarInfo ref option) list * LambdaExp list * LambdaExp
  | APP of (LambdaExp * (LambdaExp list * LambdaExp list) * Type ref option)
    			(* Function application.  Input to the optimiser should
			   have a single argument (make a struct for functions
			   that take multiple arguments). *)
  | SCON of Ident.SCon * int option     
			(* int, real, string as strings *)
			(* The int option gives the size of numeric types *)
  | MLVALUE of MLWorks.Internal.Value.ml_value (* immediate constants *)
  | INT of int          (* int as int (for tags) *)
  | SWITCH of LambdaExp * {num_vccs: int, num_imms: int} option *
		(Tag * LambdaExp) list * LambdaExp option
  			(* The second argument contains enough information
			   about the type being matched for the code generator
			   to choose an appropriate representation.  *)
  | STRUCT of LambdaExp list * StructType 
			(* structure definition *)
  | SELECT of {index : int, size : int, selecttype : StructType} * LambdaExp
			(* field selector *)
  | RAISE of LambdaExp  (* Exceptions --- throw ... *)
  | HANDLE of (LambdaExp * LambdaExp * string)
			(* ... and catch *)
  | BUILTIN of Primitive(* built-in functions -- These functions are
			   primitive to the abstract machine. *)

  datatype binding =
    LETB of (LVar * VarInfo ref option * LambdaExp) |
    RECLETB of (LVar * VarInfo ref option) list * LambdaExp list

  datatype Dec = 
    VAL of LambdaExp |
    FUNCTOR of LVar * string * ((LVar * VarInfo ref option * Dec) list * LambdaExp)
      
  datatype program =
    PROGRAM of (LVar * VarInfo ref option * Dec) list * LambdaExp
      
  val do_binding : binding * LambdaExp -> LambdaExp

  val new_LVar: unit -> LVar
  val init_LVar: unit -> unit
  val reset_counter: int -> unit
  val read_counter: unit -> int

  val lvar_to_int : LVar -> int

  val printLVar: LVar -> string
  val printPrim: Primitive -> string
  val printField: {index : int, size : int,selecttype : StructType} -> string

  val null_type_annotation : Type 
  val user_funinfo : FunInfo
  val internal_funinfo : FunInfo
  val isLocalFn : FunInfo -> bool

  val telfun : (LambdaExp -> LambdaExp) -> (Tag * LambdaExp) -> (Tag * LambdaExp)

end
