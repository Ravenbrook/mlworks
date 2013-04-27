(* _debugger_types the functor *)
(*
$Log: _debugger_types.sml,v $
Revision 1.45  1998/08/24 11:27:49  jont
[Bug #70168]
Resolve overloading when printing types if necessary

 * Revision 1.44  1996/11/06  11:22:14  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.43  1996/10/30  19:23:22  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.42  1996/10/30  19:21:23  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.41  1996/08/05  17:10:17  andreww
 * [Bug #1521]
 * Porpagating changes to typechecker/_types.sml
 *
 * Revision 1.40  1996/08/01  12:01:38  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.39  1996/04/30  16:11:04  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.38  1996/04/29  15:04:15  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.37  1996/03/19  14:37:47  matthew
 * Changed type of Map.merge
 *
 * Revision 1.36  1996/02/23  17:13:24  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.35  1996/02/22  13:17:55  jont
 * Replacing Map with NewMap
 *
 * Revision 1.34  1995/12/27  11:57:16  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.33  1995/08/10  14:53:02  daveb
Replaced redundant construction of int_type.

Revision 1.32  1995/03/17  14:40:01  matthew
Replacing make_string with Integer.makestring

Revision 1.31  1995/03/02  11:35:28  matthew
Removed Options structure, changes type of augment_information

Revision 1.30  1995/02/17  11:40:58  daveb
Replaced string_tyvar with IdentPrint.printTyVar.

Revision 1.29  1995/01/30  11:14:26  matthew
Renaming debugger_env to runtime_env

Revision 1.28  1994/09/13  10:06:13  matthew
Abstraction of debug information

Revision 1.27  1994/06/22  11:32:38  jont
Ensure debug info can be cleared when required

Revision 1.26  1994/06/14  15:46:15  daveb
Removed Jon's fix - overloading should be resolved by the time this is
called.

Revision 1.25  1994/06/10  15:52:18  jont
Fix printing of overloaded types in lambda calculus

Revision 1.24  1994/05/05  13:48:46  daveb
META_OVERLOADED takes an extra argument.

Revision 1.23  1994/02/28  07:39:16  nosa
Deleted compiler option debug_polyvariables in Debugger_Types.INFO.

Revision 1.22  1994/02/25  15:57:31  daveb
Removed string_information function, added clear_information.

Revision 1.21  1993/12/09  19:27:11  jont
Added copyright message

Revision 1.20  1993/09/22  16:01:05  nosa
Record compiler option debug_polyvariables in Debugger_Types.INFO
for recompilation purposes.

Revision 1.19  1993/07/12  08:56:17  nosa
Debugger Environments for local and closure variable inspection
in the debugger.

Revision 1.18  1993/05/18  13:42:16  jont
Removed integer parameter

Revision 1.17  1993/03/11  12:04:43  matthew
Signature revisions

Revision 1.16  1993/03/04  12:12:36  matthew
Options & Info changes

Revision 1.15  1993/03/02  17:14:08  matthew
empty_rec_type to empty_rectype

Revision 1.14  1992/12/07  16:38:37  jont
Anel's last changes

Revision 1.13  1992/11/26  19:17:21  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.12  1992/11/26  16:53:23  clive
Changed the function to print debugger information

Revision 1.11  1992/11/18  12:06:21  clive
Added a to_string function for debug information

Revision 1.10  1992/10/09  14:10:00  clive
Tynames now have a slot recording their definition point

Revision 1.9  1992/10/05  15:16:11  richard
Added empty_information.

Revision 1.8  1992/09/10  10:00:56  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.7  1992/07/20  16:45:32  clive
More work on the debugger

Revision 1.6  1992/07/16  16:29:26  clive
Added an error element to the type

Revision 1.5  1992/07/06  14:09:13  clive
Changes when implementing call point annotation

Revision 1.4  1992/06/30  10:17:10  clive
Forgot the signature constraint

Revision 1.2  1992/06/30  09:34:46  clive
I forget the Integer structure argument

Revision 1.1  1992/06/29  11:08:27  clive
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

require "../basis/__int";

require "../typechecker/types";
require "../basics/identprint";
require "../utils/crash";
require "runtime_env";

require "debugger_types";

functor Debugger_Types(
  structure Types : TYPES
  structure Crash : CRASH
  structure IdentPrint : IDENTPRINT
  structure RuntimeEnv : RUNTIMEENV

  sharing Types.Datatypes.Ident = IdentPrint.Ident
  sharing Types.Options = IdentPrint.Options
) : DEBUGGER_TYPES =

  struct

    structure Datatypes = Types.Datatypes
    structure NewMap = Datatypes.NewMap
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure Options = IdentPrint.Options
    structure RuntimeEnv = RuntimeEnv

    type ('a,'b) Map = ('a,'b) NewMap.map
    type Type = Datatypes.Type
    type Instance = Datatypes.Instance
    type Tyname = Datatypes.Tyname

    type printOptions = Options.print_options

    (* Datatype that gives a method for calculating the output type from the
       input type *)

    datatype Recipe =

      SELECT of int * Recipe  | (* Select from a record *)
      MAKERECORD of (string * Recipe) list |

      NOP |  (* Just the parameter type *)
      ERROR of string |

      FUNARG of Recipe | (* Argument of the funtype *)
      FUNRES of Recipe | (* Result of this function type *)
      MAKEFUNTYPE of Recipe * Recipe |

      DECONS of int * Recipe | (* For the types in a constructor *)
      MAKECONSTYPE of Recipe list * Types.Datatypes.Tyname

    type Backend_Annotation = Recipe

    datatype FunInfo = 
      FUNINFO of
      {ty : Type,
       is_leaf : bool,
       has_saved_arg : bool,
       annotations : (int * Backend_Annotation) list, (* Sub function annotations *)
       runtime_env : RuntimeEnv.RuntimeEnv, (* Variable debug info *)
       is_exn : bool}

    datatype information =
     INFO of (string,FunInfo) NewMap.map

    val empty_information = INFO (Datatypes.NewMap.empty' ((op<):string*string->bool))
              
    fun augment_information (debug,INFO info, INFO more_info) =
      if debug
        then INFO (Datatypes.NewMap.union (info, more_info))
      else
        (* Add in information for exceptions.  Undefine any new stuff *)
        (* Exceptions always have debug info generated *)
	INFO(Datatypes.NewMap.fold
	     (fn (info, name, funinfo as FUNINFO {is_exn,...}) =>
              if is_exn then NewMap.define (info,name,funinfo)
              else NewMap.undefine(info, name))
             (info, more_info))
      
    fun clear_information (name, INFO (info)) =
      INFO (NewMap.undefine (info, name))

    val null_backend_annotation = NOP
    val empty_runtime_env = RuntimeEnv.EMPTY

    fun print_backend_annotation options NOP = "Nop"

      | print_backend_annotation options (ERROR s) = "Error: " ^ s

      | print_backend_annotation options (SELECT(x,recipe)) =
        "Select{" ^ Int.toString x ^ "," ^ 
                       print_backend_annotation options recipe ^ "}"
      | print_backend_annotation options (MAKERECORD(recipes)) =
        let
          fun join [] = ""
            | join [(name,h)] = name ^ "=" ^ print_backend_annotation
                                                     options h
            | join ((name,h)::t) = name ^ "=" ^ print_backend_annotation 
                                                      options h ^ "," ^ join t
        in
          "MakeRecord{" ^ join recipes ^ "}"
        end

      | print_backend_annotation options (FUNARG x) = 
        "Funarg{" ^ print_backend_annotation options x ^ "}"
      | print_backend_annotation options (FUNRES x) = 
        "Funres{" ^ print_backend_annotation options x ^ "}"
      | print_backend_annotation options (MAKEFUNTYPE(from,to)) =
        "(" ^ print_backend_annotation options from ^ " -> " ^ 
              print_backend_annotation options to ^ ")"
        
      | print_backend_annotation options (DECONS(n,recipe)) =
        "DeCons{" ^ Int.toString n ^ "," ^ 
                           print_backend_annotation options recipe ^ "}"
      | print_backend_annotation options (MAKECONSTYPE(recipe_list,tyname)) =
        let
          fun join [] = ""
            | join [x] = x
            | join (h::t) = h ^ "," ^ join t
        in
          "MakeConsType{" ^ 
          Types.debug_print_type options (Types.Datatypes.CONSTYPE([],tyname))
          ^
          (case recipe_list of
             [] => ""
           | _ => "," ^ join(map (fn x => print_backend_annotation options x)
                              recipe_list)) ^ 
          "}"
        end

    local
      fun tostring options print_recipes (name,FUNINFO {annotations,...}) =
        if print_recipes
          then
            concat (name ::
                     map 
                     (fn (i,recipe) => 
                      "\n   " ^ Int.toString i ^ ":" ^ 
                       print_backend_annotation options recipe)
                     (rev annotations))
        else name
    in
      fun print_information options (INFO debug_info,print_recipes) =
        map (tostring options print_recipes) 
                                  (NewMap.to_list_ordered debug_info)
      fun print_function_information options
        (name,INFO debug_info,print_recipes) =
        case NewMap.tryApply' (debug_info,name) of
          SOME info => tostring options print_recipes
                                                              (name,info)
            | _ => "No info for " ^ name
    end

    val print_type = Types.debug_print_type

    (* A few useful type definitions for the optimiser to use *)
  fun make_pair(ty1,ty2) =
    Types.add_to_rectype(Ident.LAB (Symbol.find_symbol "1"),
                         ty1,
                         Types.add_to_rectype(Ident.LAB (Symbol.find_symbol "2"),
                                              ty2,
                                              Types.empty_rectype))

    val null_type = Datatypes.NULLTYPE
    val int_type = Types.int_type
    val int_pair_type = make_pair(int_type,int_type)
    val string_type = Datatypes.CONSTYPE([],Types.string_tyname)
    val string_pair_type = make_pair(string_type,string_type)
    val string_list_type = Datatypes.CONSTYPE([string_type],Types.list_tyname)
    val exn_type = Datatypes.CONSTYPE([],Types.exn_tyname)

  (* Utility to print the type of an expression - modifed the version 
     from _types to allow printing the different FN's within a piece of
     lambda code *)
      
    fun string_metatyvar (t as Datatypes.METATYVAR (_,eq,imp),metastack) =
      let 
	val (how_deep,metastack') = find_depth (t,metastack)
        val alpha = "meta-" ^ (Int.toString how_deep) 
	val eq_bit = if eq then "'" else ""
	val imp_bit = if imp then "_" else ""
      in
	("'"^ eq_bit ^ imp_bit ^ alpha,metastack')
      end 
      | string_metatyvar _ = Crash.impossible "string_metatyvar in _debugger_types"        

    and string_overloaded _ = Crash.impossible "string_overloaded in _debugger_types"

    and find_depth (Datatypes.METATYVAR(code,_,_),metastack) = 
      let
        fun find_depth' [] = (length metastack + 1,code::metastack)
          | find_depth'(code'::rest) = 
            if code = code'
              then (length rest + 1,metastack)
            else find_depth' rest
      in
        find_depth' metastack
      end

      | find_depth _ = Crash.impossible "find_depth in _debugger_types"        

    and string_metarec _ = Crash.impossible "string_metarec in _debugger_types"        

    and string_constype options (t as (Datatypes.CONSTYPE ([],name)),stack,acc_string)  =
      if acc_string = "" 
        then
          (Types.print_name options name,stack)
      else
        ("(" ^ acc_string ^ ")" ^ (Types.print_name options name),stack)
	| string_constype options (Datatypes.CONSTYPE (h::t,name),stack,acc_string) =
	  let 
	    val (s,stack') = string_types options (h,stack)
	  in
	    if acc_string = "" then 
	      string_constype options (Datatypes.CONSTYPE (t, name), stack', s)
	    else
	      string_constype options (Datatypes.CONSTYPE (t,name),
			               stack',acc_string ^ ", " ^ s)
	  end
      
      | string_constype _ _ = Crash.impossible "string_constype in _debugger_types"        

    and string_types options (t as (Datatypes.METATYVAR (ref(_,Datatypes.NULLTYPE,_),_,_)),stack) =
	string_metatyvar (t,stack)
	| string_types options (Datatypes.METATYVAR (ref(_,t,_),_,_),stack) =
	  string_types options (t,stack)
	| string_types options (t as (Datatypes.META_OVERLOADED {1=ref Datatypes.NULLTYPE,...}), stack) =
(*
	  string_overloaded (t,stack)
*)
	  let
	    fun error_fn _ = Crash.impossible"_debugger_types: string_types"
	    val _ = Types.resolve_overloading(true, t, error_fn)
	  in
	    string_types options(t, stack)
	  end
	| string_types options
	    (Datatypes.META_OVERLOADED {1=ref t,...},stack) =
	  string_types options (t,stack)
	| string_types options (Datatypes.METARECTYPE (ref (_,true,t as Datatypes.METARECTYPE _,_,_)),stack) = 
          string_types options (t,stack)
	| string_types options (t as (Datatypes.METARECTYPE (ref (_,true,_,_,_))),stack) =
	  string_metarec (t,stack)
	| string_types options (Datatypes.METARECTYPE (ref(_,_,t,_,_)),stack) =
	  string_types options (t,stack)
	| string_types options (Datatypes.DEBRUIJN n,stack) =
          ("Debruijn found",stack)
	| string_types options (Datatypes.TYVAR (_,t),stack) =
	  ((IdentPrint.printTyVar t),stack)
	| string_types options (Datatypes.NULLTYPE,stack) = ("Nulltype ",stack)
	| string_types options (Datatypes.FUNTYPE (a,r),stack) =
	  let
	    val (s,m) = string_types options (a,stack)
	    val (s',m') = string_types options (r,m)
	  in
	    ("(" ^ s ^ ") -> " ^ s',m')
	  end
	| string_types options (t as (Datatypes.CONSTYPE _),stack) =
	  string_constype options (t,stack,"")
	| string_types options (Datatypes.RECTYPE amap,stack) =
	  let
	    val stack_ref = ref stack
	    fun ref_printer t =
	      let 
		val ref stack = stack_ref
		val (s,new_stack) = string_types options (t,stack)
	      in
		(stack_ref := new_stack;
		 s)
	      end
	    val comma_rec_string = NewMap.string
	      (fn x => "," ^ (IdentPrint.printLab x))
	      ref_printer
	      {start="", domSep=" : ", itemSep="", finish=""}
	      amap
	    fun rec_list([]) = []
	      | rec_list(_::t) = t
	  in
	    ("{"^ (implode (rec_list(explode comma_rec_string))) ^ "}",
	     !stack_ref)
          end

    (* Set runtime_env and leafness *)
    fun set_proc_data (name,is_leaf,has_saved_arg,runtime_env,INFO debug_map) =
      (case NewMap.tryApply' (debug_map, name) of
         SOME 
         (FUNINFO {ty,annotations,is_exn,...}) =>
           (INFO (NewMap.define(debug_map, 
                                name,
                                (FUNINFO
                                 {ty=ty,
                                  is_leaf=is_leaf,
				  has_saved_arg=has_saved_arg,
                                  annotations=annotations,
                                  runtime_env=runtime_env,
                                  is_exn=is_exn}))))
       | _ => 
           (INFO (NewMap.define(debug_map, 
                                name,
                                (FUNINFO
                                 {ty=null_type,
                                  is_leaf=is_leaf,
				  has_saved_arg=has_saved_arg,
                                  annotations=nil,
                                  runtime_env=runtime_env,
                                  is_exn=false})))))

    fun add_debug_info (INFO map,name,funinfo) = INFO (NewMap.define (map,name,funinfo))

    fun lookup_debug_info (INFO map,name) = NewMap.tryApply' (map,name)

    (* Maybe this shouldn't add entries for NOPs as this can be made the default *)
    (* The lookup function should be defined here also *)

    fun add_annotation (name,count,debug,INFO debug_map) =
      case NewMap.tryApply'(debug_map, name) of
        SOME (FUNINFO {ty,is_leaf,has_saved_arg,annotations,runtime_env, is_exn}) =>
          INFO (NewMap.define
                (debug_map, name, 
                 FUNINFO {ty=ty,
                          is_leaf=is_leaf,
			  has_saved_arg=has_saved_arg,
                          annotations=(count,debug)::annotations,
                          runtime_env=runtime_env,
                          is_exn=is_exn}))
      | _ => INFO debug_map

  (* Conversion to and from lists *)

    fun debug_info_to_list (INFO map) =
      NewMap.to_list map

    fun debug_info_from_list list =
      INFO (NewMap.from_list ((op<):string*string->bool, op=) list)
  end
