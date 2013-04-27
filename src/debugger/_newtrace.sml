(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 *
 * (Low level) SML code that implements tracing and breakpointing.
 * Since it does both, "Trace" is arguably not a good name for the module,
 * but that is what it was called so we live with it.
 *
 * I assume that the file is called _newtrace.sml because it replaced
 * a _trace.sml - stephenb
 *
 * Revision Log
 * ------------
 *
 *  $Log: _newtrace.sml,v $
 *  Revision 1.45  1998/03/20 16:13:28  jont
 *  [Bug #30090]
 *  Remove MLWorks.IO in favour of print
 *
 * Revision 1.44  1997/09/18  14:38:48  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.43  1997/05/16  17:24:09  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.42  1997/05/02  17:00:47  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.41  1996/11/05  12:56:46  stephenb
 * [Bug #1441]
 * gather_recipes: remove the 4* stuff now that offsets are byte
 * offsets rather than word offsets.
 *
 * Revision 1.40  1996/10/31  14:27:34  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.39  1996/08/05  17:38:16  andreww
 * [Bug #1521]
 * Porpagating changes to typechecker/_types.sml
 *
 * Revision 1.38  1996/06/27  11:47:54  stephenb
 * Add some comments documenting the tracing code that Matthew wrote.
 * The code comment ratio is now moving in the right direction, but
 * there is still a lot of undocumented code here.
 *
 * Revision 1.37  1996/06/21  09:43:30  stephenb
 * Fix #1408.
 * Modified break_list and trace_list to they remove any existing intercepts
 * before installing the new ones.  This cures (in an inelegant way) the problem
 * of intercepts hanging around.
 *
 * Revision 1.36  1996/05/16  13:01:12  stephenb
 * Update wrt MLWorks.Debugger -> MLWorks.Internal.Debugger change.
 *
 * Revision 1.35  1996/05/01  10:02:38  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.34  1996/03/20  14:04:18  matthew
 * Changes for value polymorphism
 *
 * Revision 1.33  1996/03/18  12:26:29  stephenb
 * Fix bug #1148 -- quitting the debugger clears the breakpoints.
 * Fixed by adding some exception handlers to breakpoint_replacement
 * to ensure that the breakpoint is reinstalled even if an exception is thrown.
 *
 * Revision 1.32  1996/03/15  12:06:25  stephenb
 * Fix the long standing (i.e. since before I started working on the debugger)
 * bug that if you step in the debugger and keep stepping until you return
 * to the top level (i.e. the debugger is now out of the loop) all functions
 * still have step code enabled i.e. if you run anything it will immediately
 * call the debugger!
 *
 * Revision 1.31  1996/02/26  13:01:49  stephenb
 * Comment the recently changed step/break/next commands.
 * Also remove some redundant tests (famous last words!).
 *
 * Revision 1.30  1996/02/23  17:57:44  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.29  1996/02/22  14:15:38  jont
 * Replacing Map with NewMap
 *
 * Revision 1.28  1996/02/19  15:07:01  stephenb
 * Add "next" which makes it possible for the debugger to step over a
 * function call.  In order to add this, had to change the way stepping
 * and breakpointing is implemented.
 *
 * Revision 1.27  1995/12/27  13:27:33  jont
 * Removing Option in favour of MLWorks.Option
 *
 * Revision 1.26  1995/12/07  17:49:11  jont
 * Add more structure to the breakpoint table to allow
 * multiple skipping of breakpoints, and breakpoint hit counting
 *
 * Revision 1.25  1995/10/26  10:29:27  matthew
 * Adding untrace_all
 *
Revision 1.24  1995/10/24  15:12:19  daveb
Step function now skips setup functions.

Revision 1.23  1995/10/24  12:51:22  daveb
Removed get_stepping (it duplicated step_state).

Revision 1.22  1995/10/18  13:10:42  matthew
Adding type inference for returned values

Revision 1.21  1995/10/18  10:57:10  matthew
Merging trace_full and simple_trace functionality

Revision 1.20  1995/10/03  15:35:54  daveb
Added get_stepping.

Revision 1.19  1995/06/01  15:19:18  matthew
Adding trace_all function

Revision 1.18  1995/05/23  16:31:52  daveb
Split user_options into tool-specific and context-specific parts.

Revision 1.17  1995/05/11  16:13:59  matthew
Changing Scheme.generalises

Revision 1.16  1995/04/28  13:59:15  matthew
Changing uses of cast (again)

Revision 1.15  1995/04/25  14:23:14  matthew
Adding newline after trace output.

Revision 1.14  1995/04/21  14:24:14  matthew
Switching off debugger messages

Revision 1.13  1995/04/18  11:05:17  matthew
New step and breakpoint functionality

Revision 1.12  1995/03/08  10:59:57  matthew
Adding StackInterface structure

Revision 1.11  1995/03/01  16:22:22  matthew
Adding breakpoint function
Perhaps also working on type reconstruction

Revision 1.10  1994/06/23  11:43:19  nickh
Change bogus code test.

Revision 1.9  1994/06/09  15:49:29  nickh
New runtime directory structure.

Revision 1.8  1994/03/15  12:09:30  matthew
Added call to message_fn in untrace
;

Revision 1.7  1994/02/21  17:51:21  nosa
Boolean indicator for Monomorphic debugger decapsulation.

Revision 1.6  1993/12/09  17:12:36  matthew
 Added function replacement functions

Revision 1.5  1993/09/03  10:45:00  nosa
Instances in DEBRUIJNs for polymorphic debugger.

Revision 1.4  1993/08/19  11:39:21  matthew
Added message_fn parameter.
Report problems by calling message_fn rather than raising exceptions

Revision 1.3  1993/08/03  12:13:45  matthew
Changed format of tracing messages.

Revision 1.2  1993/06/02  14:12:54  matthew
Added untrace function

Revision 1.1  1993/05/07  16:11:30  matthew
Initial revision

 *
 *)

require "../basis/list";
require "../typechecker/types";
require "../typechecker/scheme";
require "../main/user_options";
require "../rts/gen/tags";
require "../interpreter/incremental";
require "../interpreter/shell_types";
require "../main/stack_interface";
require "debugger_utilities";
require "value_printer";

require "newtrace";

functor Trace (
  structure List : LIST
  structure Types : TYPES
  structure Scheme : SCHEME
  structure UserOptions : USER_OPTIONS
  structure Tags : TAGS
  structure Incremental : INCREMENTAL
  structure ShellTypes : SHELL_TYPES
  structure ValuePrinter : VALUE_PRINTER
  structure StackInterface : STACK_INTERFACE
  structure DebuggerUtilities : DEBUGGER_UTILITIES

  sharing ValuePrinter.Options = UserOptions.Options
  sharing Types.Datatypes = Scheme.Datatypes

  sharing type Incremental.Context = ShellTypes.Context
  sharing type UserOptions.Options.options = ShellTypes.Options.options
  sharing type Types.Options.options = UserOptions.Options.options
  sharing type UserOptions.user_tool_options = ShellTypes.user_options
  sharing type ValuePrinter.Type = Types.Datatypes.Type =
               DebuggerUtilities.Debugger_Types.Type
  sharing type ValuePrinter.DebugInformation =
               Incremental.InterMake.Compiler.DebugInformation =
               DebuggerUtilities.Debugger_Types.information
) : TRACE =
  struct
    structure Options = UserOptions.Options
    structure DebuggerTypes = DebuggerUtilities.Debugger_Types
    structure Datatypes = Types.Datatypes
    structure Value = MLWorks.Internal.Value
    structure Trace = MLWorks.Internal.Trace;
    structure Frame = Value.Frame
    structure Debugger = MLWorks.Internal.Debugger
    structure NewMap = Datatypes.NewMap

    type Type = Datatypes.Type
    type Context = Incremental.Context
    type UserOptions = UserOptions.user_tool_options

    fun print_entry (name,arg) = print (name ^ " " ^ arg ^ "\n")

    val do_debug = false
    fun debug s = if do_debug then print (s ^ "\n") else ()
    fun fdebug f = if do_debug then print (f() ^ "\n") else ()

    exception Value of string

    (* Functions from the runtime system *)
    local
      val env = MLWorks.Internal.Runtime.environment
    in
      (* apply_all applies an ML function to all code objects compiled with tracing on *)
      val apply_all : (Value.T -> unit) -> unit = env "trace ml apply all"
      val trace_code_intercept : Value.T * (Frame.frame -> unit) -> unit = env "trace code intercept"
      val trace_code_replace : Value.T * (Frame.frame -> unit) -> unit = env "trace code replace"
      val trace_set_code_loader_function : (Value.T -> unit) -> unit = env "trace set code loader function"
      val trace_unset_code_loader_function : (unit -> unit) -> unit = env "trace unset code loader function"
    end

    (* Hack about with a function string *)
    (* from ml_debugger *)
    fun get_name_and_location code_name =
      let
        fun aux1(#"[" ::l,acc) = (acc,l)
          | aux1(c::l,acc) = aux1(l,c::acc)
          | aux1([],acc) = (acc,[])
        fun aux2([#"]" ],acc) = acc
          | aux2(#"]" ::l,acc) = acc
          | aux2(c::l,acc) = aux2(l,c::acc)
          | aux2([],acc) = acc
        val (namechars,rest) = aux1(explode code_name,[])
        val locchars = aux2 (rest,[])
      in
        (implode (rev namechars),implode (rev locchars))
      end

    (* Simple function for removing the location information from a function name string *)
    fun strip_location s =
      let
        val len = size s
        fun strip n =
          if n = len then s
          else
            if MLWorks.String.ordof (s,n) = ord #"["
              then substring (* could raise Substring *) (s,0,n)
            else strip (n+1)
      in
        strip 0
      end

    fun get_code_string value =
      if
        Value.primary value = Tags.POINTER andalso
        #1 (Value.header value) = Tags.BACKPTR
        then
          Value.code_name value
      else
          raise Value "code_name: not a code item"

    fun get_code_name f =
      let
        val code_name = get_code_string f
        val (name,loc) = get_name_and_location code_name
      in
        name
      end

    (* What about META types? *)
    fun funarg (Datatypes.FUNTYPE (t,_)) = t
      | funarg _ = Datatypes.NULLTYPE

    fun funres (Datatypes.FUNTYPE (_,t)) = t
      | funres _ = Datatypes.NULLTYPE

    (* type reconstruction *)

    exception TypeReconstructionFailed of string

    fun assoc (a,[]) = NONE
      | assoc (a,(a',b)::rest) =
        if a = a' then SOME b
        else assoc (a,rest)

    fun infer_types (ty,[]) = ty
      | infer_types (ty,recipe::rest) =
        infer_types (DebuggerUtilities.apply_recipe (recipe,ty),rest)

    (* This scans down the stack and collects up recipes *)
    fun gather_recipes (frame,acc,debug_info) =
      let
        val (another,next,offset) = Frame.frame_next frame
      in
        if offset <> 0 (* It's an ML frame *)
          then
            let
              val frame_name = StackInterface.frame_name next
            in
              case DebuggerTypes.lookup_debug_info (debug_info,frame_name) of
                SOME (DebuggerTypes.FUNINFO {ty,annotations,...}) =>
                  let
                    val argty = funarg ty
                    val recipe =
                      case assoc (offset,annotations) of
                        SOME recipe => recipe
                      | _ => DebuggerTypes.NOP
                  in
                    if DebuggerUtilities.is_type_polymorphic argty
                      then
                        if another then gather_recipes (next,recipe::acc,debug_info)
                        else raise TypeReconstructionFailed "No more frames"
                    else
                      (argty,recipe::acc)
                  end
              | _ => gather_recipes (next,acc,debug_info)
            end
        else
            gather_recipes (next,acc,debug_info)
      end



    (* Return a reconstructed type *)
    fun reconstruct_type (frame,ty,debug_info) =
      if DebuggerUtilities.is_type_polymorphic ty
        then
          (infer_types (gather_recipes (frame,[],debug_info)))
          handle DebuggerUtilities.ApplyRecipe s =>
            (debug ("Recipe Application failed: " ^ s);
             ty)
               | TypeReconstructionFailed s =>
                   (debug ("Type Reconstruction Failed: " ^ s);
                    ty)
      else ty



    fun get_fun_types (f,debug_info) =
      let
        val name = get_code_string f
      in
        case DebuggerTypes.lookup_debug_info (debug_info,name)  of
          SOME (DebuggerTypes.FUNINFO {ty = Datatypes.FUNTYPE (dom,ran),...}) =>
            (dom,ran)
        | _ => (Datatypes.NULLTYPE,Datatypes.NULLTYPE)
      end



    (* This is kind of hacky, but if it doesn't work then nothing
     * disastrous happens.  Seems to be OK mind
     *)
    local
      open Datatypes
    in
      fun tyvars_of (ty,acc) =
        case ty of
          METATYVAR (ref (_,NULLTYPE,_),_,_) => ty :: acc
        | METATYVAR (ref (_,ty',_),_,_) => tyvars_of (ty',acc)
        | META_OVERLOADED (ref ty',_,_,_) => tyvars_of (ty',acc)
        | TYVAR _ => ty :: acc
        | METARECTYPE (ref (_,_,ty',_,_)) => tyvars_of (ty',acc)
        | RECTYPE labtys =>
          NewMap.fold (fn (acc, _, ty) => tyvars_of (ty,acc)) (acc,labtys)
        | FUNTYPE (ty1,ty2) => tyvars_of (ty2,tyvars_of (ty1,acc))
        | CONSTYPE (tylist,_) =>
          List.foldl tyvars_of acc tylist
        | DEBRUIJN _ => acc
        | NULLTYPE => acc
    end



    (* Need to replace any (meta)tyvars in the type by debruijns, so that
     * the Scheme functions will work.
     *)

    fun generalize (ty1,ty2) =
      let
        val ty = Datatypes.FUNTYPE (ty1,ty2)
        val tyvars = tyvars_of (ty,[])
      in
        case Scheme.make_scheme (tyvars,(ty,NONE)) of
          Datatypes.SCHEME (i,(Datatypes.FUNTYPE (ty1',ty2'),_)) => (ty1',ty2')
        | _ => (ty1,ty2)
      end



    (* Note that we insist on value polymorphism semantics here,
     * I don't think this matters much.
     * Just affects calls to Scheme.generalises* functions
     *)

    (* spec_type is an instantiation of gen_type *)
    (* try to instantiate ty in the same way *)
    fun instantiate_type (ty,gen_ty,spec_ty) =
      if not (DebuggerUtilities.is_type_polymorphic ty)
        then ty
      else
        (* the difficult bit *)
        let
(*
          val _ = output (std_out,
                          concat ["ty: ",Types.debug_print_type ty,
                                   "\ngen ty: ",Types.debug_print_type gen_ty,
                                   "\nspec ty: ",Types.debug_print_type spec_ty])
*)
          val (ty,gen_ty) = generalize (ty,gen_ty)
          val Options.OPTIONS{compat_options=Options.COMPATOPTIONS
                             {old_definition,...},...} =
            ShellTypes.get_current_options (!ShellTypes.shell_data_ref)
        in
          Scheme.apply_instantiation
            (ty, Scheme.generalises_map old_definition (gen_ty,spec_ty))
          handle Mismatch =>
            (debug ("Instantiation failed");
             ty)
        end



    (* As the name suggets, gets info on a frame.
     * The info is of the form :-
     *
     * (functionName:string, argumentValue:string, argumentType:Datatypes.Type)
     *
     * The functionName can be determined easily from the frame, the
     * argumentValue and argumentType require some type reconstruction.
     *)
    fun get_frame_info frame =
      let
        val shell_data = !ShellTypes.shell_data_ref
        val user_options = ShellTypes.get_user_options shell_data
        val options = ShellTypes.get_current_options shell_data
        val context = ShellTypes.get_current_context shell_data
        val name = StackInterface.frame_name frame
        val debug_info = Incremental.InterMake.current_debug_information ()
        val funinfo = DebuggerTypes.lookup_debug_info (debug_info,name)
        val (arg_string,ranty) =
          case funinfo of
            SOME (DebuggerTypes.FUNINFO {ty,...}) =>
              let
                val arg = StackInterface.frame_arg frame
                val arg_type = funarg ty
                val reconstructed_arg_type = reconstruct_type (frame,arg_type,debug_info)
                val final_type = Types.combine_types (reconstructed_arg_type,arg_type)
                  handle Types.CombineTypes =>
                    (fdebug (fn _ =>
                             concat ["Combine types fails for: ",
                                      name, "\n arg_type: ",
                                      Types.debug_print_type options arg_type,
                                      "\n reconstructed arg type: ",
                                      Types.debug_print_type options
                                      reconstructed_arg_type]);
                    arg_type)
                val ranty = instantiate_type (funres ty,arg_type,final_type)
                val print_options = UserOptions.new_print_options user_options
              in
                (ValuePrinter.stringify_value false (print_options,arg,final_type,debug_info),
                 ranty)
              end
          | _ => ("<Unknown arg>",Datatypes.NULLTYPE)
      in
        (strip_location name,arg_string,ranty)
      end




    (* Wacky tracing *)
    structure Test :
      sig
        val trace : Value.T * (('a -> 'b) * 'a * Frame.frame -> 'b) -> unit
        val replace : Value.T * ('c -> 'd) -> unit
      end =

      struct
        fun trace (cv, new) =
          let
            fun untraced_once f' a =
              (trace_code_intercept (cv, fn _ => trace (cv, new));
               f' a)

            val replacement =
              (fn frame =>
               StackInterface.set_frame_return_value
               (frame,
                Value.cast (new (untraced_once (Value.cast (StackInterface.frame_closure frame)),
                                 Value.cast (StackInterface.frame_arg frame),
                                 frame))))
          in
            trace_code_replace (cv, replacement)
          end

        fun replace (cv, new) =
          let
            val replacement =
              (fn frame =>
               StackInterface.set_frame_return_value
               (frame,
                Value.cast (new (Value.cast (StackInterface.frame_arg frame)))))
          in
            trace_code_replace (cv, replacement)
          end

      end



    (* Indentation *)
    val indent_level = ref 0

    fun outspaces 0 = ()
      | outspaces n = (print"  ";outspaces(n-1))



    (* "always" and "never" are used the trace_full_internal as the default
     * values for the tracing and breakpointing.  "always" is just a function
     * that always returns true, and "never" is one which always returns
     * false.  I've no idea why their type, though identical, is defined
     * twice - stephenb
     *)
    val always = ((Value.cast (fn _ => true)) : Value.T,
                  Datatypes.FUNTYPE (Datatypes.DEBRUIJN (0,false,false,
                                                         NONE),
                                     Types.bool_type))

    val never = ((Value.cast (fn _ => false)) : Value.T,
                  Datatypes.FUNTYPE (Datatypes.DEBRUIJN (0,false,false,NONE),
                                     Types.bool_type))



    (* Error is used to abort out of a trace_full_internal in the case
     * that any errors are detected.  Since all that is done with the
     * exception is to catch it and ignore it, an alternative would be
     * to write the body of trace_full_internal in a more functional
     * style - stephenb
     *)
    exception Error



    fun generalises (ty1,ty2) =
      let val Options.OPTIONS{compat_options=
                              Options.COMPATOPTIONS{old_definition,...},...}
        = ShellTypes.get_current_options (!ShellTypes.shell_data_ref)
      in
      Scheme.generalises old_definition (ty1,ty2)
                   handle Scheme.Mismatch => false
      end

    fun type_eq (ty1,ty2) = Types.type_eq (ty1,ty2,true,true)




    (* trace_full_internal implements conditional tracing and breakpointing.
     * It patches "fun_val" such that a) it displays a trace message whenever
     * "test_val" applied to the arguments returns true and b) breakpoints
     * whenever "break_val" applied to the arguments returns true.
     *
     * For example, using the latest shell interface to this function, then
     * assuming you've defined the ubiquitous factorial function fact you
     * could type :-
     *
     *   Shell.Trace.traceFull ("fact", fn _ => true, fn _ => false);
     *
     * and have it unconditionally trace the factorial function and not
     * breakpoint at all.  Alternately, if you are only interested in
     * tracing the function when the argument is less than 3, you could do
     *
     *   Shell.Trace.traceFull ("fact", fn n => n < 3, fn _ => false);
     *
     * The "entry_only" argument is a bit of a mystery, presumably it
     * controls whether the tracing/breakpointing is only attempted at
     * function entry only.  In the only current use of trace_full_internal
     * it is set to false.
     *
     * It isn't clear to me at the moment how this interacts with the
     * other tracing/breakpointing routines that have been updated
     * to cope with the introduction of the "next" command in the debugger.
     * My guess is that the interaction is not a good one - stephenb.
     *)

    fun trace_full_internal entry_only ((test_val,test_ty), (break_val,break_ty)) fun_val =
      let
        fun message_fn s = print(s ^ "\n")
        val shell_data = !ShellTypes.shell_data_ref
        val user_options = ShellTypes.get_user_options shell_data
        val options = ShellTypes.get_current_options shell_data
        fun do_error s = (message_fn s;raise Error)
      in
        if not (Types.isFunType test_ty)
          then do_error "Test function doesn't have function type"
        else ();
        if not (Types.isFunType break_ty)
          then do_error "Break function doesn't have function type"
        else ();
        let
          fun string_value (value,ty) =
            let
              val print_options = UserOptions.new_print_options user_options
              val debug_info = Incremental.InterMake.current_debug_information ()
            in
              ValuePrinter.stringify_value false (print_options,value,ty,debug_info)
            end
          val debug_info = Incremental.InterMake.current_debug_information ()
          val (fun_dom,_) = get_fun_types (fun_val,debug_info)
          val (test_dom,test_ran) = Types.argres test_ty
          val (break_dom,break_ran) = Types.argres break_ty
          val fun_name = strip_location (get_code_name fun_val)
          val _ =
            (* Tedious correctness checking *)
            (if generalises (test_dom,fun_dom)
               then ()
             else
               do_error
               (concat [fun_name ^ ": Test function domain not compatible with traced function domain:",
                        "\n  test domain: ", Types.debug_print_type options test_dom,
                        "\n  function domain: ", Types.debug_print_type
                                               options fun_dom, "\n"]);
             if type_eq (test_ran,Types.bool_type)
               then ()
             else
               do_error
               (concat [fun_name ^ ": Test function range not boolean",
                        "\n  test range: ", Types.debug_print_type options
                                test_ran, "\n"]);
             if generalises (break_dom,fun_dom)
               then ()
             else
               do_error
               (concat [fun_name ^ ": Break function domain not compatible with traced function domain:",
                         "\n  break domain: ", Types.debug_print_type
                                options break_dom,
                         "\n  function domain: ", Types.debug_print_type
                         options fun_dom, "\n"]);
             if type_eq (break_ran,Types.bool_type)
               then ()
             else
               do_error
               (concat [fun_name ^ ": Break function range not boolean:",
                         "\n  break range: ", Types.debug_print_type options break_ran,"\n"]))
        in
          Test.trace
          ((Value.cast fun_val),
           fn (f,a,frame) =>
           let
             (* val entry_only = true *)
             val do_output = ((Value.cast test_val) a) : bool
             val do_break = ((Value.cast break_val) a) : bool
           in
             if do_output
               then
                 if entry_only then
                   let
                     val (name,arg,_) = get_frame_info frame

                     val _ = print_entry (name,arg)
                     val _ =
                       if do_break
                         then
                           Debugger.break ("Function entry: " ^ name ^ " " ^ arg)
                       else ()
                   in
                     f a
                   end
                 else
                   let
                     val (name,arg,res_ty) = get_frame_info frame
                     val level = !indent_level
                     val _ = indent_level := (!indent_level) + 1
                     val _ = outspaces level
                     val _ = print_entry (name,arg)
                     val _ =
                       if do_break
                         then
                           Debugger.break ("Function entry: " ^ name ^ " " ^ arg)
                       else ()
                     val result = f a handle exn => (indent_level := level;raise exn)
                   in
                     indent_level := level;
                     outspaces level;
                     print (name ^ " returns " ^ string_value (result,res_ty) ^ "\n");
                     result
                   end
             else
               (if do_break
                  then
                    let
                      val (name,arg,_) = get_frame_info frame
                    in
                      Debugger.break ("Function entry: " ^ name ^ " " ^ arg)
                    end
                else ();
                  f a)
           end)
          handle Trace.Trace s =>
            message_fn ("Cannot trace " ^ fun_name ^ ": " ^ s)
        end
      end handle Error => ()



    (* Association lists of the functions that currently have breakpoints
     * set on them and/or which are being traced.  The value of the
     * association appears to a be a pair of function/type pairs where
     * the first controls whether tracing messages are output and the
     * second controls whether the function breakpoints.
     *)
    val traced_functions : (string * ((Value.T * Type) * (Value.T * Type))) list ref = ref []
    val broken_functions : (string * ((Value.T * Type) * (Value.T * Type))) list ref = ref []

    fun remove' (s,[],acc) = rev acc
      | remove' (s,(a,b)::c,acc) =
      if s = a then (rev acc) @ c
      else remove' (s,c,(a,b)::acc)
    fun remove l s = l := remove' (s,!l,[])

    val remove_breakpoint = remove broken_functions
    val remove_traced = remove traced_functions

    fun trim (s,n) =
      if size s > n then substring (* could raise Substring *) (s,0,n) else s

    fun trace_function frame =
      let
	val (name,arg_string,_) = get_frame_info frame
      in
	print_entry (name, arg_string)
      end

    fun break_function frame =
      let
	val (name,arg_string,_) = get_frame_info frame
      in
	Debugger.break ("Entering: " ^ name ^ " " ^ arg_string)
      end

    fun assoc (name,[]) = NONE
      | assoc (name,(s,b) :: rest) =
      if size name >=  size s andalso substring (* could raise Substring *) (name,0,size s) = s
	then SOME b
      else assoc (name,rest)

    fun traceit code =
      let
	val name = Value.code_name code
      in
	case assoc (name,!traced_functions) of
	  SOME (f,g) =>
	    trace_full_internal false (f,g) code
	| _ => ()
      end

    (* frame_message is purely for the purposes of debugging the
     * debugger.  Sprinkle calls to this liberally around the
     * breakpoint, step and next code and all will become clear.
     *)
    fun frame_message (frame, message) =
      let val (name, arg_string, _) = get_frame_info frame in
	print( message);
	print( name);
	print( " ");
	print( arg_string);
	print( "\n")
      end

    datatype Stepping = OFF | LOGICALLY_ON | ON
    (*
     * The ON and OFF cases should be fairly obvious -- they indicate
     * whether all the code has been interecepted to do stepping (ON)
     * or not (OFF).
     *
     * The LOGICALLY_ON case is an ugly hack.  It is here as an artifact
     * of the way the tracer indicates to the debugger that it has
     * been called due to a step action -- it is effectively done via a
     * shared variable (ugh!).  This third case is used to fool the
     * debugger into thinking that stepping is enabled, even though
     * the code is not intercepted.
     *)

    val stepping_status = ref OFF

    (* The number of functions to step over before entering the debugger.
     * 0 means stop at the next function.
     *)
    val step_count = ref 0

    val intercepted_function = ref NONE

    (* Some sort of table of functions which have breakpoints set.
     * Presumably the domain of this should match that of broken_functions
     * and so they could be merged into one in the future? - stephenb
     *)
    val breakpoint_table =
      ref(NewMap.empty' ((op<):string*string->bool)) : (string, {hits: int, max: int, name: string}) NewMap.map ref

    fun is_a_break s = NewMap.tryApply'(!breakpoint_table, s)

    fun update_break(arg as {name, ...}) =
      breakpoint_table := NewMap.define'(!breakpoint_table, (name, arg))

    fun add_break{hits, max, name} =
      breakpoint_table :=
      NewMap.define'(!breakpoint_table,
		     (name, {hits=hits, max=max, name=name}))

    fun remove_break name =
      breakpoint_table := NewMap.undefine(!breakpoint_table, name)

    (* Note that this only installs the breakpoint if it is in the
     * list of breakpointed functions.  This suits the places it is
     * used since they either make sure the name is in the list or
     * make use of the fact that the breakpoint won't be added if it
     * is not.
     *)
    fun install_breakpoint (name, code) =
      case assoc (name,!broken_functions) of
	SOME _ =>
	  trace_code_replace (code, breakpoint_replacement)
      | NONE => ()

    (* This is is what is stuffed in the replacement slot of a function
     * so that the debugger is called when the function is hit.
     *
     * A replacement is used rather than a simple intercept so that
     * the "next" implementation can get in when the debugger is run
     * and alter the replacement/intercept so that this takes effect
     * after the debugger is exited and the function is restarted.
     *)
    and breakpoint_replacement frame =
      let
	val (name, arg_string, _) = get_frame_info frame
	val f = Value.cast (StackInterface.frame_closure frame)
	val a = Value.cast (StackInterface.frame_arg frame)
	val c = StackInterface.frame_code frame
      in
	(* nop out the intercept to avoid an infinite loop.  *)
	MLWorks.Internal.Trace.restore f;
	intercepted_function := SOME name;
	(Debugger.break ("Entering: " ^ name ^ " " ^ arg_string)
	 handle exn =>
	   (intercepted_function := NONE;
            install_breakpoint (name, c);
            raise exn));
	intercepted_function := NONE;
	(StackInterface.set_frame_return_value (frame, Value.cast (f a))
	 handle exn => (install_breakpoint (name, c);  raise exn));
	install_breakpoint (name, c)
      end

    and breakit code =
      let
	val name = Value.code_name code
      in
	install_breakpoint (name, code)
      end

    and restore_intercepts () =
      let
	fun restore code = (traceit code; breakit code)
      in
	Trace.restore_all ();
	step_count := 0;
	stepping_status := OFF;
	trace_set_code_loader_function restore;
	apply_all restore
      end

    fun restore_intercepts_if_not_stepping () =
      case !stepping_status of
	OFF => restore_intercepts ()
      | _   => ()

    fun reinstall function frame =
      let
	val code = StackInterface.frame_code frame
      in
	trace_code_replace (code, function)
      end

    (* This is what is stuffed in the intercept/replacement slot when
     * single stepping.
     *
     * A replacement is used rather than a simple intercept so that
     * the "next" implementation can get in when the debugger is run
     * and alter the replacement/intercept so that this takes effect
     * after the debugger is exited and the function is restarted.
     *)
    fun step_always_replacement frame =
      let
	val (name, arg_string, _) = get_frame_info frame
	val f = Value.cast (StackInterface.frame_closure frame)
	val a = Value.cast (StackInterface.frame_arg frame)
	val c = StackInterface.frame_code frame
      in
	restore_intercepts ();
	(* make sure that if there was a breakpoint/trace on the function
	 * restored by restore_intercepts, that it is nopped out ... *)
	MLWorks.Internal.Trace.restore f;
	(if !step_count > 0 then
	   step_count := !step_count - 1
	 else
	   (intercepted_function := SOME name;
	    stepping_status := LOGICALLY_ON;
	    Debugger.break ("Entering: " ^ name ^ " " ^ arg_string);
	    intercepted_function := NONE));
	   StackInterface.set_frame_return_value (frame, Value.cast (f a))
      end

    (* This is what is stuffed in an intercept/replacement slot after
     * "next" has been called to guarantee that debugger is called
     * on the first function after the one being stepped over.
     *)
    fun step_once_replacement frame =
      let
	val (name, arg_string, _) = get_frame_info frame
	val f = Value.cast (StackInterface.frame_closure frame)
	val a = Value.cast (StackInterface.frame_arg frame)
	val c = StackInterface.frame_code frame
      in
	restore_intercepts ();
	(* make sure that if there was a breakpoint/trace on the function
	 * restored by restore_intercepts, that it is nopped out ... *)
	MLWorks.Internal.Trace.restore f;
	intercepted_function := SOME name;
	stepping_status := LOGICALLY_ON;
	Debugger.break ("Entering: " ^ name ^ " " ^ arg_string);
	intercepted_function := NONE;
	StackInterface.set_frame_return_value (frame, Value.cast (f a))
      end

    (* Replace/intercept "code" with a "step" function.
     * If "code" is a setup function, then this is a nop since they
     * shouldn't be stepped.  If "code" is not currently being intercepted,
     * then it is replaced with the step function.  If "code" is currently
     * intercepted, then the interception is replaced by another
     * intercept which when run reinstalls the "step" function.
     *)
    fun replace_with step code =
      let
	val full_code_name = Value.code_name code
	val function_name = strip_location full_code_name
      in
	if function_name = "<Setup>" then
	  ()
	else
	  case !intercepted_function of
	    NONE =>
	      trace_code_replace (code, step)
	  | SOME name =>
	      if name = function_name
                then trace_code_intercept (code, reinstall step)
	      else trace_code_replace (code, step)
      end

    val make_code_step_always = replace_with step_always_replacement

    val make_code_step_once = replace_with step_once_replacement

    fun set_stepping b =
      if b then
	case !stepping_status of
	  ON => ()
	| _ =>
	    (apply_all make_code_step_always;
	     trace_set_code_loader_function make_code_step_always;
	     stepping_status := ON)
      else
	case !stepping_status of
	  OFF =>          ()
	| LOGICALLY_ON => stepping_status := OFF
	| ON =>           restore_intercepts ()

    fun make_all_code_step_once () =
      (apply_all make_code_step_once;
       stepping_status := ON)

    fun stepping () =
      case !stepping_status of
	OFF => false
      | _   => true

    fun set_step_count n =
        if n > 0
        then step_count := n-1
        else step_count := 0

    (* What the following does is reasonably clear, what isn't is
     * why it is needed.  I can only find one use of it in
     * _ml_debugger but I haven't investigated to see what use is made
     * of it - stephenb.
     *)
    fun step_through f a =
      let
	val _ = set_stepping true
	val result = f a handle exn => (set_stepping false; raise exn)
      in
	set_stepping false;
	result
      end

    fun tracealways code = trace_code_intercept (code,trace_function)

    (* Trace interface functions *)

    (* Note that we only change the intercept status of code if we are
     * not stepping.  Might be better to have separate functions for
     * setting the name refs and actually updating the relevant code objects.
     * Should ensure traced and broken functions are kept consistent with
     * each other
     *)

    fun update (name,data,list,acc) =
      case list of
	[] => (name,data)::acc
      | ((a,d)::rest) =>
	  if a = name then rev acc @ ((a,data)::rest)
	  else update (name,data,rest,(a,d)::acc)

    fun trace name =
      let
	fun restore code = (traceit code; breakit code)
      in
	traced_functions := update (name,(always,never),!traced_functions,[]);
	remove_breakpoint name;
	if stepping () then
	  ()
	else
	  (trace_set_code_loader_function restore;
	   apply_all traceit)
      end

    fun trace_full (name,f,g) =
      let
	fun restore code = (traceit code; breakit code)
      in
	traced_functions := update (name,(f,g),!traced_functions,[]);
	remove_breakpoint name;
	if stepping () then
	  ()
	else
	  (trace_set_code_loader_function restore;
	   apply_all traceit)
      end

    (* Set a breakpoint on the function with the given name. *)

    fun break name =
      let
	fun restore code = (traceit code; breakit code)
      in
	broken_functions := update (name,(always,never),!broken_functions,[]);
	remove_traced name;
	trace_set_code_loader_function restore;
	apply_all breakit
      end

    val break = fn(arg as {hits, max, name}) =>
      (break name;
       add_break arg)

    (* Replace all the existing traced functions with those named in the
     * argument list.  IMHO this isn't a particularly good interface,
     * but it is what the GUI debugger currently expects.
     *
     * If the user is currently stepping, then you don't want to physically
     * overwrite the existing intercepts with trace intercepts,
     * so in this case all that it is done is to construct correct
     * the correct trace list and table so that the traced functions
     * will be restored when stepping is over.
     *
     * If the user isn't currently stepping, then the traced functions can
     * be updated straight away.  The method used to do this is not
     * particularly efficient or elegant, but since the whole debugger
     * will hopefully be rewritten soon I'm not spending much time on
     * it now - stephenb
     *)
    local
      fun addTrace (name, tfl) = (name, (always,never))::tfl
    in
      fun trace_list names =
	if stepping () then
	  let
	    val tfl = List.foldl addTrace [] names
	  in
	    traced_functions := tfl
	  end
	else
	  (traced_functions := [];
	   restore_intercepts ();
	   List.app trace names)
    end

    (* Replace all the existing breakpoints with those named in the
     * argument list.  IMHO this isn't a particularly good interface,
     * but it is what the GUI debugger currently expects.
     *
     * If the user is currently stepping, then you don't want to physically
     * overwrite the existing intercepts with breakpoint intercepts,
     * so in this case all that it is done is to construct correct
     * the correct breakpoint list and table so that the breakpoints
     * will be restored when stepping is over.
     *
     * If the user isn't currently stepping, then the breakpoints can
     * be updated straight away.  The method used to do this is not
     * particularly efficient or elegant, but since the whole debugger
     * will hopefully be rewritten soon I'm not spending much time on
     * it now - stephenb
     *)
    local
      val init = ([], NewMap.empty' ((op<):string*string->bool))

      fun addBreakpoint (bp as {hits, max, name}, (bpl, bpt)) =
	((name, (always,never))::bpl, NewMap.define (bpt, name, bp))

    in
      fun break_list name_hits_list =
	if stepping () then
	  let
	    val (bpl, bpt) = List.foldl addBreakpoint init name_hits_list
	  in
	    broken_functions := bpl;
	    breakpoint_table := bpt
	  end
	else
	  (broken_functions := [];
	   breakpoint_table := NewMap.empty' ((op<):string*string->bool);
	   restore_intercepts ();
	   List.app break name_hits_list)
    end

    fun untrace name =
      (remove_traced name;
       restore_intercepts_if_not_stepping ())

    fun unbreak name =
      (remove_breakpoint name;
       remove_break name;
       restore_intercepts_if_not_stepping ())

    fun untrace_all () =
      (traced_functions := [];
       restore_intercepts_if_not_stepping ())

    fun unbreak_all () =
      (broken_functions := [];
       breakpoint_table :=
       NewMap.empty' ((op<):string*string->bool);
       restore_intercepts_if_not_stepping ())

    fun breakpoints () =
      NewMap.range_ordered(!breakpoint_table)

    fun traces () = map #1 (!traced_functions)

    fun set_trace_all b =
      if b
        then apply_all tracealways
      else restore_intercepts ()

    (* "next" implements something that is a mixture of "next" and
     * "finish" in gdb.  The idea is that given a frame which has
     * just been intercepted (due to either step or breakpoint),
     * step over all (child) calls in the body of the code associated with
     * the frame and stop at the start of next (sibling) call.
     *
     * This would be relatively simple to do by inserting breakpoint
     * after the call instruction.  However, the approach taken here
     * is to use the existing intercept mechanism and use a
     * technique based on the way tracing is implemented i.e. the
     * flow of control is contorted.
     *)
    fun next frame =
      let
	val step_status_before_next_called = !stepping_status

	fun replacement frame =
	  let
	    val (name, arg_string, _) = get_frame_info frame
	    val f = Value.cast (StackInterface.frame_closure frame)
	    val a = Value.cast (StackInterface.frame_arg frame)
	    val c = StackInterface.frame_code frame
	    val _ = MLWorks.Internal.Trace.restore f
	  in
	    StackInterface.set_frame_return_value (frame, Value.cast (f a));
	    case step_status_before_next_called of
	      ON => set_stepping true
	    | _ =>  make_all_code_step_once ()
	  end

      in
	set_stepping false;
	trace_code_replace ((StackInterface.frame_code frame), replacement)
        handle Trace.Trace s =>
          (print( "Cannot step over ");
           print( strip_location (StackInterface.frame_name frame));
           print( ": ");
           print( s);
           print( "\n"))
      end

    (* Select from an object, with some checking for error cases *)
    (* A header of zero is possible if we are in a shared closure *)
    fun select field =
      if field < 0 then
        raise Value "select: negative field"
      else
        fn value =>
        let
          val primary = Value.primary value
        in
          if primary = Tags.PAIRPTR
            then
              if field >= 2
                then
                  raise Value "select: field >= 2 in pair"
              else
                Value.sub (value, field)
              else if primary = Tags.POINTER
                     then
                       let
                         val (secondary, length) = Value.header value
                       in
                         if (secondary = Tags.INTEGER0 andalso field=0)
                           orelse (secondary = Tags.INTEGER1 andalso field=0)
                           then
                             Value.sub (value, 1)
                         else
                           if secondary = Tags.RECORD then
                             if field >= length then
                               raise Value "select: field >= length in record"
                             else
                               Value.sub (value, field+1)
                           else
                             raise Value "select: invalid secondary"
                       end
                   else
                     raise Value "select: invalid primary"
        end

    fun get_function_string f =
      let
        val f : Value.T = Value.cast f
        val value = select 0 f
      in
        if
          Value.primary value = Tags.POINTER andalso
          #1 (Value.header value) = Tags.BACKPTR
          then
            Value.code_name value
        else
          raise Value "code_name: not a code item"
      end

    fun get_function_name f =
      let
        val code_name = get_function_string f
        val (name,loc) = get_name_and_location code_name
      in
        name
      end

  end
