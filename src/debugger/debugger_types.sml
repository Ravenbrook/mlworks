(* debugger_types the signature *)
(*
$Log: debugger_types.sml,v $
Revision 1.26  1997/05/01 15:13:07  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.25  1996/08/05  17:10:41  andreww
 * [Bug #1521]
 * Porpagating changes to typechecker/_types.sml
 *
 * Revision 1.24  1996/08/01  12:00:15  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.23  1995/11/08  12:38:36  jont
 * Add comments on recipe mechanism
 *
Revision 1.22  1995/02/28  11:42:20  matthew
information type now abstract

Revision 1.21  1995/01/13  16:59:03  matthew
Renaming debugger_env to runtime_env

Revision 1.20  1994/09/13  10:05:22  matthew
Abstraction of debug information

Revision 1.19  1994/06/22  11:26:49  jont
Ensure debug info can be cleared when required

Revision 1.18  1994/02/28  06:45:26  nosa
Deleted compiler option debug_polyvariables in Debugger_Types.INFO.

Revision 1.17  1994/02/25  15:55:46  daveb
Removed string_information function, added clear_information.

Revision 1.16  1993/12/09  19:27:35  jont
Added copyright message

Revision 1.15  1993/09/03  11:33:22  nosa
Record compiler option debug_polyvariables in Debugger_Types.INFO
for recompilation purposes.

Revision 1.14  1993/07/12  08:56:03  nosa
Debugger Environments for local and closure variable inspection
in the debugger.

Revision 1.13  1993/03/11  12:04:09  matthew
Signature revisions

Revision 1.12  1993/03/04  12:11:59  matthew
Options & Info changes

Revision 1.11  1993/02/01  16:22:32  matthew
Added sharing.

Revision 1.10  1992/11/26  19:18:46  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.9  1992/11/18  11:57:04  clive
Added a to_strinmg for debugger information

Revision 1.8  1992/10/05  15:16:14  richard
Added empty_information.

Revision 1.7  1992/09/10  08:50:30  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.6  1992/08/26  10:52:31  jont
Removed some redundant structures and sharing

Revision 1.5  1992/07/20  15:48:23  clive
More work on the debugger

Revision 1.4  1992/07/16  16:31:59  clive
Added an error element to the type

Revision 1.3  1992/07/06  14:08:38  clive
Changes when implementing call point annotation

Revision 1.2  1992/06/30  09:52:32  clive
Minor changes
,

Revision 1.1  1992/06/29  11:08:09  clive
Initial revision

 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "runtime_env";
require "^.main.options";

signature DEBUGGER_TYPES =

  sig

    structure RuntimeEnv : RUNTIMEENV

    structure Options: OPTIONS

    (* These are just the corresponding types in Datatypes *)
    type Type
    type Instance
    eqtype Tyname

    (*
     * A recipe is a way of transferring instantiations of type variables
     * from one type to another. So given type ty, ty' with common type variables
     * and an instantiation of some of the type variables of ty to give
     * a type ty'', a recipe for (ty, ty') will construct from ty'' a type
     * ty''' where the type variables of ty' have been instantiated in the
     * same way. Eg, if ty is 'a * 'b, and ty' is 'b * 'a * string, and ty is
     * instantiated to int * (bool * real), the recipe will instantiate
     * ty' to (bool * real) * int * string.
     *)

    (* Datatype that gives a method for calculating the output type from the
       input type *)

    datatype Recipe =

      SELECT of int * Recipe  | (* Select from a record *)
      MAKERECORD of (string * Recipe) list |

      NOP | (* Just the parameter type *)
      ERROR of string | (* Ooops *)

      FUNARG of Recipe | (* Argument of the funtype *)
      FUNRES of Recipe | (* Result of this function type *)
      MAKEFUNTYPE of Recipe * Recipe |

      DECONS of int * Recipe | (* For the types in a constructor *)
      MAKECONSTYPE of Recipe list * Tyname

    type information
    type Backend_Annotation 
    sharing type Backend_Annotation = Recipe

    datatype FunInfo = 
      FUNINFO of
      {ty : Type,
       is_leaf : bool,
       has_saved_arg : bool,
       annotations : (int * Backend_Annotation) list, (* Sub function annotations *)
       runtime_env : RuntimeEnv.RuntimeEnv, (* Variable debug info *)
       is_exn : bool}


    (* Second bool is exception constructor indicator *)

    (* bool determines if recipes are shown *)
    val print_information : Options.options -> 
                                information * bool -> string list
    val print_function_information : 
      Options.options -> string * information * bool -> string

    val empty_information   : information

    (* bool is true if we are in debug mode here *)
    val augment_information : bool * information * information -> information
    val clear_information   : string * information -> information

    val null_backend_annotation : Backend_Annotation
    val empty_runtime_env : RuntimeEnv.RuntimeEnv

    val print_backend_annotation : Options.options ->
                                       Backend_Annotation -> string
    val print_type : Options.options -> Type -> string

    val null_type : Type

    (* These only seem to be used by the old optimizer *)
    val int_type : Type
    val int_pair_type : Type
    val string_pair_type : Type
    val string_list_type : Type
    val exn_type : Type

    val string_types :
      Options.options ->
      Type * (int * Type * Instance) ref list ->
      string * (int * Type * Instance) ref list

    val set_proc_data : string * bool * bool * RuntimeEnv.RuntimeEnv * information -> information
    val add_debug_info : information * string * FunInfo -> information
    val add_annotation : string * int * Backend_Annotation * information -> information

    val lookup_debug_info : information * string -> FunInfo option

  (* Conversion to and from lists *)

    val debug_info_to_list : information -> (string * FunInfo) list
    val debug_info_from_list : (string * FunInfo) list -> information

  end

