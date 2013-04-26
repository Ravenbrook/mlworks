(* auglambda.sml the signature *)
(*
$Log: auglambda.sml,v $
Revision 1.29  1996/12/02 15:42:46  matthew
Removing reference to MLWorks.Option

 * Revision 1.28  1996/08/06  12:10:21  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml (essentially
 * just passing options rather than print_options).
 *
 * Revision 1.27  1995/08/10  16:43:10  daveb
 * Added types for different lengths of words, ints and reals.
 *
Revision 1.26  1995/02/28  12:25:50  matthew
Changes to FunInfo type

Revision 1.25  1995/01/13  16:05:23  matthew
Rationalizing debugger

Revision 1.24  1994/10/10  10:10:25  matthew
Simplifications of lambda expressions

Revision 1.23  1994/09/22  09:39:24  matthew
Abstraction of debug information

Revision 1.22  1994/07/19  13:35:16  matthew
Functions and applications take a list of parameters

Revision 1.21  1993/11/19  16:45:43  nosa
Type function spills for Modules Debugger.

Revision 1.20  1993/08/16  12:04:56  nosa
FNs now passed closed-over type variables and
stack frame-offset for runtime-instance for polymorphic debugger.

Revision 1.19  1993/07/29  16:23:58  nosa
Changed Tags and LETs for local and closure variable inspection
in the debugger.

Revision 1.18  1993/03/10  17:00:49  matthew
Signature revisions

Revision 1.17  1993/03/04  13:14:32  matthew
Options & Info changes

Revision 1.16  1993/03/01  14:02:35  matthew
Added MLVALUE lambda exp

Revision 1.15  1993/02/01  17:18:36  matthew
Rationalised parameter structure

Revision 1.14  1992/11/10  13:39:21  matthew
Changed Error structure to Info

Revision 1.13  1992/10/26  18:17:29  daveb
Changed type of SWITCH; pointer defaults are no longer used, but information
about value-carrying and constant constructors is added.

Revision 1.12  1992/09/10  09:35:19  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.11  1992/09/09  10:40:33  clive
Added a flag to inhibit warning for debugger unable to generate recipe

Revision 1.10  1992/08/26  13:37:16  jont
Removed some redundant structures and sharing

Revision 1.9  1992/08/24  16:12:25  clive
Added details about leafness to the debug information

Revision 1.8  1992/08/05  17:05:12  jont
Removed some structures and sharing

Revision 1.7  1992/08/03  12:54:04  davidt
Added stuff to support optimisation of BECOMES and UPDATE.

Revision 1.6  1992/07/14  10:13:05  clive
Added the debug information recording for the setup function

Revision 1.5  1992/07/06  16:14:48  clive
Generation of function call point debug information

Revision 1.4  1992/07/01  12:04:02  davida
Added LET constructor and new slot to APP.

Revision 1.3  1992/06/29  09:25:56  clive
Added type annotation information at applications

Revision 1.2  1992/06/11  10:50:28  clive
Added types to the fnexp of the lambda tree for the debugger to use

Revision 1.1  1992/05/05  13:13:58  jont
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

require "../lambda/lambdatypes";
require "../debugger/debugger_types";

signature AUGLAMBDA = sig
  structure LambdaTypes : LAMBDATYPES
  structure Debugger_Types : DEBUGGER_TYPES

  datatype Tag =
    VCC_TAG of string * int           (* value carrying constructor *)
  | IMM_TAG of string * int           (* constant constructor *)
  | SCON_TAG of LambdaTypes.Ident.SCon * int option
			     (* simple int, real, string ... *)
			     (* The int option is the size of a numeric type *)
  | EXP_TAG of {size:int, lexp:AugLambdaExp}
  (* more complex tag, for dynamic switching *)

  and AugLambdaExp =
    VAR of LambdaTypes.LVar             (* variable lookup *)
  | FN of ((LambdaTypes.LVar list * LambdaTypes.LVar list) * {size:int, lexp:AugLambdaExp} * string 
           * LambdaTypes.FunInfo)
    (* function definition *)
  | LET of (LambdaTypes.LVar * LambdaTypes.VarInfo ref option * {size:int, lexp:AugLambdaExp}) * 
           {size:int, lexp:AugLambdaExp}
    (* non-rec def's *)
  | LETREC of                           (* allows recursive definitions *)
    ((LambdaTypes.LVar * LambdaTypes.VarInfo ref option) list *
     {size:int, lexp:AugLambdaExp} list *
     {size:int, lexp:AugLambdaExp})
  | APP of ({size:int, lexp:AugLambdaExp} *
	    ({size:int, lexp:AugLambdaExp} list *
             {size:int, lexp:AugLambdaExp} list) *
	    Debugger_Types.Backend_Annotation)
    (* function application *)
  | SCON of LambdaTypes.Ident.SCon * int option
				(* int, real, string as strings *)
			        (* The int option is the size of a numeric type *)
  | MLVALUE of MLWorks.Internal.Value.ml_value (* immediate constants *)
  | INT of int                          (* int as int (for tags) *)
  | SWITCH of                           (* like a case statement *)
    ({size:int, lexp:AugLambdaExp} *
     {num_vccs: int, num_imms: int} option *
     (Tag * {size:int, lexp:AugLambdaExp}) list *
     {size:int, lexp:AugLambdaExp} option)
  (* The second argument contains enough information about the type being
     matched for the code generator to choose an appropriate representation.
     The LVar is bound to the argument of a value carrying constructor.
  *)
  | STRUCT of {size:int, lexp:AugLambdaExp} list
    (* structure definition *)
  | SELECT of {index : int, size : int} * {size:int, lexp:AugLambdaExp}
    (* field selector *)
  | RAISE of {size:int, lexp:AugLambdaExp} 
    (* Exceptions --- throw ... *)
  | HANDLE of ({size:int, lexp:AugLambdaExp} * {size:int, lexp:AugLambdaExp})
    (*            ... and catch *)
  | BUILTIN of LambdaTypes.Primitive * LambdaTypes.Type
		      (* built-in functions -- These functions are
		       primitive to the abstract
		       machine. *)

  val count_gc_objects : Debugger_Types.Options.options *
    LambdaTypes.LambdaExp * bool * Debugger_Types.information * string ->
    {size:int, lexp:AugLambdaExp} * Debugger_Types.information
end
