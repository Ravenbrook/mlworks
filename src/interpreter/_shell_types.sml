(* Types for passing to the shell and listener creation functions.
 *
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
 *
 * $Log: _shell_types.sml,v $
 * Revision 1.40  1996/02/05 17:30:52  daveb
 * UserContext no longer includes a user_tool_options type.
 *
 *  Revision 1.39  1995/10/18  14:22:46  nickb
 *  Add profiler.
 *
 *  Revision 1.38  1995/05/29  16:37:53  daveb
 *  Separated user options into tool-specific and context-specific parts.
 *
 *  Revision 1.37  1995/04/28  10:38:46  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.36  1995/04/19  10:44:24  daveb
 *  Added set_context_name.
 *
 *  Revision 1.35  1995/03/31  17:44:39  daveb
 *  Added history number to each history item.
 *
 *  Revision 1.34  1995/03/16  19:20:07  daveb
 *  Merged get_context_name and string_context_name.
 *  
 *  Revision 1.33  1995/03/15  15:28:45  daveb
 *  Changed ShellData to hold a single user_context instead of a stack.
 *  
 *  Revision 1.32  1995/03/10  15:14:50  daveb
 *  Added a current selection to the user_context type, and functions
 *  to set and get this, and a registry for automatic update of a tool's
 *   current selection.
 *  
 *  Revision 1.31  1995/03/06  18:23:56  daveb
 *  Added context to history item type.  Added process_result function.
 *  
 *  Revision 1.30  1995/03/01  10:56:08  matthew
 *  Removing ValuePrinter from parameter
 *  
 *  Revision 1.29  1995/01/13  12:10:32  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *  
 *  Revision 1.28  1994/08/01  09:51:46  daveb
 *  Added get_current_preferences.
 *  
 *  Revision 1.27  1994/07/19  09:02:53  daveb
 *  Added register of update functions to user contexts.
 *  
 *  Revision 1.26  1994/07/14  15:35:41  daveb
 *  mk_xinterface_fn now has the type Podium_.ListenerArgs -> bool -> unit.
 *  
 *  Revision 1.25  1994/06/30  14:39:53  daveb
 *  Made source_map type concrete.
 *  Added save file name to user contexts.
 *  
 *  Revision 1.24  1994/06/21  12:26:37  daveb
 *  Replaced ContextRefs with user_contexts.  These store info about the
 *  evaluations done in the current user context, as well as the aggregate
 *  context.
 *  
 *  Revision 1.23  1994/02/23  20:19:20  daveb
 *  Changed naming scheme for contexts.
 *  
 *  Revision 1.22  1994/02/01  17:20:25  daveb
 *  Changed substructure of InterMake.
 *  
 *  Revision 1.21  1994/01/28  16:23:12  matthew
 *  Better locations in error messages
 *  
 *  Revision 1.20  1993/11/25  14:19:09  matthew
 *  Moved exception DebuggerTrapped from Shell for easier use elsewhere.
 *  
 *  Revision 1.19  1993/11/09  15:30:55  jont
 *  shell_data_ref initial value commented as only to initialise the ref
 *  
 *  Revision 1.18  1993/09/02  16:00:31  daveb
 *  Fixed non-exhaustive value binding.
 *  
 *  Revision 1.17  1993/06/16  13:23:56  matthew
 *  Changed context string to eg. MLWorks-1 from MLWorks%1
 *  
 *  Revision 1.16  1993/06/03  17:52:59  daveb
 *  Removed the context field from the prompter.
 *  
 *  Revision 1.15  1993/05/18  15:25:02  jont
 *  Removed integer parameter
 *  
 *  Revision 1.14  1993/05/11  09:55:54  daveb
 *  Added code to create, store and retreive an initial contextref.
 *  
 *  Revision 1.13  1993/05/10  13:42:02  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *  
 *  Revision 1.12  1993/05/06  14:52:00  matthew
 *  Simplified.  Removed ShellState type, removed printer_descriptor and print_method
 *  table fields.
 *  
 *  Revision 1.11  1993/05/04  15:33:49  matthew
 *  Added ContextRef type.
 *  
 *  Revision 1.10  1993/04/06  16:09:03  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.9  1993/04/02  14:33:11  matthew
 *  Signature changes
 *  
 *  Revision 1.8  1993/03/29  16:59:44  matthew
 *  Added ShellState type
 *  Added shell_data_ref and with_shell_data
 *  
 *  Revision 1.7  1993/03/26  14:02:28  matthew
 *  Changed context_ref in ShellData to a list of context refs
 *  
 *  Revision 1.6  1993/03/19  19:34:20  matthew
 *  Added copy_listener_args
 *  
 *  Revision 1.5  1993/03/18  18:05:59  matthew
 *  Added output_fn field to shell_data
 *  
 *  Revision 1.4  1993/03/15  16:27:40  matthew
 *  Simplified types
 *  
 *  Revision 1.3  1993/03/11  10:54:59  matthew
 *  Options changes
 *  
 *  Revision 1.2  1993/03/09  15:25:25  matthew
 *  Added ShellData type and access functions
 *  
 *  Revision 1.1  1993/03/02  18:30:07  daveb
 *  Initial revision
 *  
 *)

require "user_context";
require "../main/user_options";
require "../main/preferences";
require "shell_types";

functor ShellTypes (
   structure UserContext: USER_CONTEXT
   structure UserOptions: USER_OPTIONS
   structure Preferences: PREFERENCES

   sharing UserOptions.Options = UserContext.Options

   sharing type UserOptions.user_context_options =
		UserContext.user_context_options
): SHELL_TYPES =
struct
  structure Options = UserOptions.Options

  type user_options = UserOptions.user_tool_options
  type user_preferences = Preferences.user_preferences
  type user_context = UserContext.user_context
  type Context = UserContext.Context
  type preferences = Preferences.preferences

  exception DebuggerTrapped

  datatype ListenerArgs = 
    LISTENER_ARGS of
    {user_context : user_context,
     user_options : user_options,
     user_preferences : user_preferences,
     prompter :
       {line : int, subline : int, name : string, topdec : int} -> string,
     mk_xinterface_fn : ListenerArgs -> bool -> unit}

  fun new_options (user_options, user_context) = 
    UserOptions.new_options
      (user_options, UserContext.get_user_options user_context)

  (* this is the data used by each shell *)
  datatype ShellData =
    SHELL_DATA of
    {get_user_context : unit -> user_context,
     user_options : user_options,
     user_preferences : user_preferences,
     prompter :
       {line : int, subline : int, name : string, topdec : int} -> string,
     debugger :
       (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T) ->
       (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T),
     profiler : MLWorks.Profile.profile -> unit,
     exit_fn : int -> unit,
     x_running : bool,
     mk_xinterface_fn : ListenerArgs -> bool -> unit,
     mk_tty_listener : ListenerArgs -> int}

  fun get_listener_args (SHELL_DATA{get_user_context,
                                    user_options,
                                    user_preferences,
                                    prompter,
                                    mk_xinterface_fn,
                                    ...}) =
    LISTENER_ARGS
      {user_context = get_user_context (),
       user_options = UserOptions.copy_user_tool_options user_options,
       user_preferences = user_preferences,
       prompter = prompter,
       mk_xinterface_fn = mk_xinterface_fn}

  fun get_current_options (SHELL_DATA{user_options, get_user_context, ...}) = 
    UserOptions.new_options
      (user_options, UserContext.get_user_options (get_user_context ()))

  fun get_current_preferences (SHELL_DATA{user_preferences,...}) = 
    Preferences.new_preferences user_preferences

  fun get_user_options (SHELL_DATA{user_options,...}) = 
    user_options

  fun get_user_preferences (SHELL_DATA{user_preferences,...}) = 
    user_preferences

  fun get_user_context
	(SHELL_DATA{get_user_context, ...}) =
    get_user_context ()

  fun get_current_context shell_data =
    UserContext.get_context (get_user_context shell_data)

  fun get_current_prompter (SHELL_DATA{prompter,...}) = prompter

  fun get_current_profiler (SHELL_DATA{profiler,...}) = profiler

  fun get_print_options (Options.OPTIONS{print_options,...}) = print_options

  fun get_current_print_options shell_data =
    get_print_options(get_current_options shell_data)

  exception BadShellData of string

  val shell_data_ref =
    (* This is a dummy value solely for initialising the reference *)
    ref
      (SHELL_DATA
         {get_user_context = fn () => UserContext.dummy_context,
          user_options =
            UserOptions.make_user_tool_options Options.default_options,
	  user_preferences =
	    Preferences.make_user_preferences Preferences.default_preferences,
          prompter = fn _ => raise BadShellData "prompter",
          debugger = fn _ => raise BadShellData "debugger",
	  profiler = fn _ => raise BadShellData "profiler",
	  exit_fn = fn _ => raise BadShellData "exit",
          x_running = false,
          mk_xinterface_fn = fn _ => raise BadShellData "xinterface",
          mk_tty_listener = fn _ => raise BadShellData "tty listener"})

  fun with_shell_data shell_data f =
    let
      val old_data = !shell_data_ref
      val _ = shell_data_ref := shell_data
      val result = f () handle exn => (shell_data_ref := old_data; raise exn)
    in
      shell_data_ref := old_data;
      result
    end

  val toplevel_name_ref = ref []

  fun get_current_toplevel_name () =
    case !toplevel_name_ref of
      (n::_) => n
    | _ => "Top Level"

  fun with_toplevel_name name f =
    let
      val previous = !toplevel_name_ref
      val _ = toplevel_name_ref := name :: !toplevel_name_ref;
      val result = (f ()) handle exn => (toplevel_name_ref := previous;raise exn)
    in
      toplevel_name_ref := previous;
      result
    end

end;
