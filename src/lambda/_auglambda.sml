(* _auglambda.sml the functor *)
(*
$Log: _auglambda.sml,v $
Revision 1.46  1998/02/05 16:25:57  jont
[Bug #30090]
Remove references to MLWorks.IO

 * Revision 1.45  1996/12/02  15:41:41  matthew
 * Adding change for local functions
 *
 * Revision 1.44  1996/10/04  13:01:55  matthew
 * Removing redundant LambdaSub
 *
 * Revision 1.43  1996/08/06  12:11:33  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml (essentially
 * just passing options rather than print_options).
 *
 * Revision 1.42  1996/08/01  12:08:29  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.41  1996/04/30  16:45:57  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.40  1995/08/11  17:04:17  daveb
 * Added types for different lengths of words, ints and reals.
 *
Revision 1.39  1995/07/25  12:07:32  jont
Add WORD SCon

Revision 1.38  1995/07/19  13:10:39  jont
Modify count_gc_objects in light of Ident.CHAR which isn't static gc

Revision 1.37  1995/02/28  12:28:00  matthew
Abstracting debug_info type
Various tidying up

Revision 1.36  1995/01/13  17:18:08  matthew
Renaming debugger_env to runtime_env
Removed warning_issued parameter to everything

Revision 1.35  1994/10/10  10:11:20  matthew
Adding module annotations to lambda syntax.
Lambdatypes changes

Revision 1.34  1994/09/22  09:39:51  matthew
Abstraction of debug information in lambdatypes

Revision 1.33  1994/08/26  14:41:42  matthew
Extensions for argument lists

Revision 1.32  1994/07/19  14:52:59  matthew
Functions and applications take a list of parameters

Revision 1.31  1994/06/22  14:32:10  jont
Update debugger information production

Revision 1.30  1994/02/28  07:00:48  nosa
Deleted compiler option debug_polyvariables in Debugger_Types.INFO;
Type function spills for Modules Debugger.

Revision 1.29  1994/02/25  14:49:52  daveb
Made generation of debug info for setup functions obey flag.

Revision 1.28  1993/09/06  09:02:32  nosa
FNs now passed closed-over type variables and
stack frame-offset for runtime-instance for polymorphic debugger;
change also to Debugger_Types.INFO.

Revision 1.27  1993/07/29  16:26:10  nosa
Local and Closure variable inspection in the debugger;
Changed Tags and LETs.

Revision 1.26  1993/03/10  17:02:43  matthew
Signature revisions

Revision 1.25  1993/03/04  13:14:06  matthew
Option & Info changes
removed options param from count_gc_objects

Revision 1.24  1993/03/02  17:48:38  matthew
Rationalised use of Mapping structure

Revision 1.23  1993/03/01  14:19:48  matthew
Added MLVALUE lambda exp

Revision 1.22  1993/02/04  14:23:22  matthew
Simplified parameter signature

Revision 1.21  1992/11/10  13:41:19  matthew
Changed Error structure to Info

Revision 1.20  1992/10/26  18:15:46  daveb
Changed type of SWITCH; pointer defaults are no longer used, but information
about value-carrying and constant constructors is added.

Revision 1.19  1992/09/10  10:10:34  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.18  1992/09/09  09:59:31  clive
Added a flag to inhibit warning for debugger unable to generate recipe

Revision 1.17  1992/09/01  17:37:45  jont
Removed eta abstraction of exception handlers. This should allow them
to be abstracted.

Revision 1.16  1992/08/26  13:40:30  jont
Removed some redundant structures and sharing

Revision 1.15  1992/08/24  16:13:15  clive
Added details about leafness to the debug information

Revision 1.14  1992/08/07  15:21:06  clive
Added type annotation for handler expressions

Revision 1.13  1992/08/04  14:43:43  davidt
Took out redundant structure arguments. Added stuff to support optimisation of
BECOMES and UPDATE.

Revision 1.12  1992/07/22  09:05:10  clive
Changed type_of_setup

Revision 1.11  1992/07/21  14:21:23  clive
Gather type information

Revision 1.10  1992/07/16  17:00:00  clive
Changed sharing constraint - _debugger_types has datatypes and not types in the structure now

Revision 1.9  1992/07/14  10:14:19  clive
Added the debug information recording for the setup function

Revision 1.8  1992/07/07  14:40:06  clive
Generation of function call point debug information

Revision 1.7  1992/07/02  13:23:10  davida
Added LET constructor and new slot to APP.

Revision 1.6  1992/06/29  09:31:55  clive
Added type annotation information at applications

Revision 1.5  1992/06/25  19:19:23  jont
Stopped count counting strings referenced by load_var etc

Revision 1.4  1992/06/23  10:04:39  clive
Added an annotation slot to HANDLE

Revision 1.3  1992/06/18  10:27:58  jont
Fixed comparison of types problem by using a case statement

Revision 1.2  1992/06/11  11:01:21  clive
Added types to the fnexp of the lambda tree for the debugger to use

Revision 1.1  1992/05/05  13:25:57  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../utils/crash";
require "../lambda/lambdatypes";
require "../main/pervasives";
require "../debugger/debugger_utilities";
require "auglambda";

functor AugLambda(
  structure Crash : CRASH
  structure LambdaTypes : LAMBDATYPES
  structure Pervasives : PERVASIVES
  structure DebuggerUtilities : DEBUGGER_UTILITIES

  sharing DebuggerUtilities.Options = DebuggerUtilities.Debugger_Types.Options
  sharing type LambdaTypes.Type = DebuggerUtilities.Debugger_Types.Type
  sharing type LambdaTypes.Primitive = Pervasives.pervasive
    ) : AUGLAMBDA =
struct
  structure LambdaTypes = LambdaTypes
  structure Ident = LambdaTypes.Ident
  structure Debugger_Types = DebuggerUtilities.Debugger_Types
  structure Options = Debugger_Types.Options

  (* We define a new datatype, isomorphic to LambdaTypes.LambdaExp, but annotated *)
  (* with size information -- this is the number of ML objects required by the expression *)
  (* ie. the number of items that will be required in a closure *)

  datatype Tag =
    VCC_TAG of string * int           (* value carrying constructor *)
  | IMM_TAG of string * int           (* constant constructor *)
  | SCON_TAG of Ident.SCon * int option   (* simple int, real, string ... *)
					(* The int option gives the size of a numeric type *)
  | EXP_TAG of sized_AugLambdaExp
  (* more complex tag, for dynamic switching *)

  and AugLambdaExp =
    VAR of LambdaTypes.LVar             (* variable lookup *)
  | FN of ((LambdaTypes.LVar list * LambdaTypes.LVar list) * {size:int, lexp:AugLambdaExp} * string * LambdaTypes.FunInfo)
    (* function definition *)
  | LET of ((LambdaTypes.LVar * LambdaTypes.VarInfo ref option * sized_AugLambdaExp) * sized_AugLambdaExp)
  | LETREC of
    ((LambdaTypes.LVar * LambdaTypes.VarInfo ref option) list *
     sized_AugLambdaExp list *
     sized_AugLambdaExp)
  | APP of (sized_AugLambdaExp *
	    (sized_AugLambdaExp list * sized_AugLambdaExp list) *
	    Debugger_Types.Backend_Annotation)
    (* function application *)
  | SCON of LambdaTypes.Ident.SCon * int option 
					(* int, real, string as strings *)
					(* The int option gives the size of a numeric type *)
  | MLVALUE of MLWorks.Internal.Value.ml_value (* immediate constants *)
  | INT of int                          (* int as int (for tags) *)
  | SWITCH of                           (* like a case statement *)
    (sized_AugLambdaExp *
     {num_vccs: int, num_imms: int} option *
     (Tag * sized_AugLambdaExp) list *
     sized_AugLambdaExp option)
  (* The second argument contains enough information about the type being
     matched for the code generator to choose an appropriate representation.
     The LVar is bound to the argument of a value carrying constructor.
  *)
  | STRUCT of sized_AugLambdaExp list
    (* structure definition *)
  | SELECT of {index : int, size : int} * sized_AugLambdaExp
    (* field selector *)
  | RAISE of sized_AugLambdaExp 
    (* Exceptions --- throw ... *)
  | HANDLE of (sized_AugLambdaExp * sized_AugLambdaExp)
    (*            ... and catch *)
  | BUILTIN of LambdaTypes.Primitive * LambdaTypes.Type
		      (* built-in functions -- These functions are
		       primitive to the abstract
		       machine. *)
  withtype sized_AugLambdaExp = {size:int, lexp:AugLambdaExp}


  fun count_gc_objects (options,
                        exp,generate_debug_info,mapping,setup_function) =
    let
      fun count_gc_objects' (LambdaTypes.VAR lv,_,mapping,_) = 
        ({size=0, lexp=VAR lv} : sized_AugLambdaExp ,mapping)
        | count_gc_objects'(LambdaTypes.LET((lv,info,lb), le),ty,mapping,name) =
	  let
	    val (lb' as {size,lexp},mapping') = count_gc_objects' (lb,ty,mapping,name)
	    val (le' as {size=size',lexp},mapping'') = count_gc_objects' (le,ty,mapping',name)
	  in
	    ({size=size+size', lexp=LET((lv,info,lb'),le')},mapping'')
	  end

        | count_gc_objects' (LambdaTypes.APP(LambdaTypes.BUILTIN prim, ([le],[]),annotation),ty,mapping,name) =
          let
            val (le as {size=size, ...},mapping') = 
              count_gc_objects' (le,ty,mapping,name)
	    val size = case prim of
	      Pervasives.LOAD_STRING => 0
	    | Pervasives.LOAD_VAR => 0
	    | Pervasives.LOAD_EXN => 0
	    | Pervasives.LOAD_STRUCT => 0
	    | Pervasives.LOAD_FUNCT => 0
	    | _ => size
          in
	    ({size=size, lexp=APP({size=0, lexp=BUILTIN(prim,
                         case annotation of
                          NONE => LambdaTypes.null_type_annotation
                        | SOME(annotation) => !annotation)},
                         ([le],[]),Debugger_Types.null_backend_annotation)},
	     mapping')
          end

        | count_gc_objects' (LambdaTypes.APP(le, ([le'],[]),ty'),ty,mapping,name) =
          let
            val (le as {size=size, ...},mapping') = 
              count_gc_objects' (le,ty,mapping,name)
            val (le' as {size=size', ...},mapping'') = 
              count_gc_objects' (le',ty,mapping',name)
            val annotation = 
              if generate_debug_info
                then 
                  (* Add in the recipe for this call *)
                  let
                    val this_ty =
                      case ty' of
                        NONE => LambdaTypes.null_type_annotation
                      | SOME ty' => !ty'
                  in
                    DebuggerUtilities.generate_recipe options (ty,this_ty,name)
                  end
              else Debugger_Types.null_backend_annotation
          in
            ({size=size+size', lexp=APP(le, ([le'],[]),annotation)},mapping'')
          end

        (* This should be combined with the above case *)
        | count_gc_objects' (LambdaTypes.APP(le,(lel,fpel),ty'),ty,mapping,name) =
          let
            val (le as {size=size, ...},mapping') = 
              count_gc_objects' (le,ty,mapping,name)

            fun countlist el =
              foldr
              (fn (form,(x,forms,mapping)) => 
               let
                 val (le as {size=size,lexp=lexp},mapping') = 
                   count_gc_objects'(form,ty,mapping,name)
               in
                 (x+size,le::forms,mapping')
               end)
              (0,[],mapping')
              el

            val (size',lel',mapping'') = countlist lel
            val (size'',fpel',mapping'') = countlist fpel
            val annotation = 
              (* Add in the recipe for this call *)
              if generate_debug_info
                then
                  let
                    val this_ty = 
                      case ty' of
                        NONE => LambdaTypes.null_type_annotation
                      | SOME(ty') => !ty'
                  in
                    DebuggerUtilities.generate_recipe options (ty,this_ty,name)
                  end
              else (Debugger_Types.null_backend_annotation)
          in
            ({size=size+size'+size'', lexp=APP(le,(lel',fpel'),annotation)},mapping'')
          end
        | count_gc_objects' (LambdaTypes.FN((lvl,fpvl), lexp, status, name,ty,funinfo),_,
                             debug_info,_) =
          let
            val (le as {size=size, ...},debug_info) = 
              count_gc_objects' (lexp,ty,debug_info,name)
            val debug_info =
              if DebuggerUtilities.is_nulltype ty orelse not generate_debug_info
                then debug_info
              else
                (* Add in the debug information for this call *)
                Debugger_Types.add_debug_info
                (debug_info,
                 name,
                 Debugger_Types.FUNINFO {ty = DebuggerUtilities.slim_down_a_type ty,
                                         is_leaf = false,
					 has_saved_arg = false,
                                         annotations = [],
                                         runtime_env = Debugger_Types.empty_runtime_env, 
                                         is_exn = false})
            (* If its a local function then there is no GC object for it *)
            val newsize = if LambdaTypes.isLocalFn funinfo then size else size+1
          in
            ({size=newsize, lexp=FN((lvl,fpvl), le, name,funinfo)},debug_info)
          end
        | count_gc_objects'(LambdaTypes.LETREC(lv_list, le_list, lexp),ty,mapping,name) =
          let
            val (le_list,mapping') =
              foldr
              (fn (form,(forms,mapping)) => 
               let
                 val (form',mapping') = 
                   count_gc_objects' (case form of 
                                        LambdaTypes.FN _ => form
                                      | _ => 
                                          Crash.impossible "Bad letrec form",
                                          ty,mapping,name)
               in
                 (form'::forms,mapping')
               end)
              ([],mapping)
              le_list
            val (lexp as {size=size, ...},mapping'') = count_gc_objects' (lexp,ty,mapping',name)
          in
            ({size=
              foldl
              (fn ({size=size, ...},x) => x+size)
              size
              le_list,
              lexp=LETREC(lv_list, le_list, lexp)},mapping'')
          end
        | count_gc_objects'(LambdaTypes.SCON (scon, opt), _,mapping,_) =
          ({size=case scon of
                   Ident.INT _ => 0
                 | Ident.CHAR _ => 0
                 | Ident.WORD _ => 0
                 | Ident.REAL _ => 1
                 | Ident.STRING _ => 1,
	   lexp=SCON (scon, opt)},mapping)
        | count_gc_objects'(LambdaTypes.MLVALUE value,_,mapping,_) =
          ({size= 1, lexp=MLVALUE value},mapping)
        | count_gc_objects'(LambdaTypes.INT i,_,mapping,_) = 
          ({size=0, lexp=INT i},mapping)
        | count_gc_objects'(LambdaTypes.SWITCH(le, info, tag_le_list, le_opt),
			    ty,mapping,name) =
          let
            fun transform_tag((tag, le),mapping) =
              let
                val (le,mapping') =
		  count_gc_objects' (le,ty,mapping,name)
                val (tag,mapping''') = case tag of
                  LambdaTypes.EXP_TAG lexp =>
                    let
                      val (lexp as {size=size, ...},mapping'') = 
                        count_gc_objects' (lexp,ty,mapping',name)
                    in
                      if size <> 0 then
                        Crash.impossible"EXP_TAG contains static gc"
                      else
                        (EXP_TAG lexp,mapping'')
                    end
                | LambdaTypes.IMM_TAG i => (IMM_TAG i,mapping')
                | LambdaTypes.VCC_TAG i => (VCC_TAG i,mapping')
                | LambdaTypes.SCON_TAG scon => (SCON_TAG scon,mapping')
              in
                ((tag, le),mapping''')
              end

            fun transform_opt (NONE,mapping) = 
              ((0, NONE),mapping)
              | transform_opt(SOME le,mapping) =
                let
                  val (le as {size=size, ...},mapping') = 
                    count_gc_objects' (le,ty,mapping,name)
                in
                  ((size, SOME le),mapping')
                end

            val (tag_le_list,mapping') =
              foldr(fn (form,(forms,mapping)) => 
                            let
                              val (a,mapping') = 
				transform_tag (form,mapping)
                            in
                              (a::forms,mapping')
                              end)
              ([],mapping)
              tag_le_list

            val ((size1, le_opt),mapping'') =
	      transform_opt (le_opt,mapping')

            val (le as {size=size, ...},mapping''') = 
              count_gc_objects' (le,ty,mapping'',name)

            val sizes =
              foldl
              (fn ((tag, {size=size, ...}),x) =>
               x + size +
               (case tag of
                  SCON_TAG(Ident.REAL _, _) => 1
                | SCON_TAG(Ident.STRING _, _) => 1
		| SCON_TAG(Ident.INT _, _) => 0
		| SCON_TAG(Ident.CHAR _, _) => 0
		| SCON_TAG(Ident.WORD _, _) => 0
                | _ => 0))
              (size1+size)
              tag_le_list
          in
            ({size=sizes, lexp=SWITCH(le, info, tag_le_list, le_opt)},
	     mapping''')
          end
        | count_gc_objects'(LambdaTypes.STRUCT (le_list,_),ty,mapping,name) =
          let
            val (size,le_list,mapping') = 
             foldr
             (fn (form,(x,forms,mapping)) => 
              let
                val (le as {size=size,lexp=lexp},mapping') = 
                  count_gc_objects'(form,ty,mapping,name)
              in
                (x+size,le::forms,mapping')
              end)
             (0,[],mapping)
             le_list
          in
            ({size=size, lexp=STRUCT le_list},mapping')
          end
        | count_gc_objects'(LambdaTypes.SELECT({index,size=lsize,...}, le),ty,mapping,name) =
          let
            val (le as {size=size, ...},mapping') = 
              count_gc_objects' (le,ty,mapping,name)
            val info = {index=index,size=lsize}
          in
            ({size=size, lexp=SELECT(info, le)},mapping')
          end
        | count_gc_objects'(LambdaTypes.RAISE (le),ty,mapping,name) =
          let
            val (le as {size=size, ...},mapping') = 
              count_gc_objects' (le,ty,mapping,name)
          in
            ({size=size, lexp=RAISE (le)},mapping')
          end
        | count_gc_objects'(LambdaTypes.HANDLE(le, le',annotation),ty,mapping,name) =
          let
            val (le as {size=size, ...},mapping') = count_gc_objects' (le,ty,mapping,name)
            val function = le'
            val (le' as {size=size', ...},mapping'') =
              count_gc_objects'(case function of
                                  LambdaTypes.FN (a,b,status,c,_,info) => 
                                    LambdaTypes.FN(a,b,status,c,DebuggerUtilities.handler_type,info)
				| x => x,
                                    ty,mapping',
                                    name)
          in
            ({size=size+size', lexp=HANDLE(le, le')},mapping'')
          end
        | count_gc_objects'(LambdaTypes.BUILTIN prim,ty,mapping,_) =
          ({size=0, lexp=BUILTIN(prim,ty)},mapping)

    in
      count_gc_objects' (exp,DebuggerUtilities.setup_function_type,
                         if generate_debug_info then
                           Debugger_Types.add_debug_info
                           (mapping,
                            setup_function,
                            Debugger_Types.FUNINFO {ty = DebuggerUtilities.setup_function_type,
                                                    is_leaf = false,
						    has_saved_arg = false,
                                                    annotations = [],
                                                    runtime_env = Debugger_Types.empty_runtime_env, 
                                                    is_exn = false})
                         else mapping,
                         setup_function)
    end

end
