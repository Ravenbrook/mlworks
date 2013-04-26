(* Types for passing to the shell and listener creation functions.
 *
 * Copyright (C) 1993 Harlequin Ltd.
 *
 * $Log: shell_types.sml,v $
 * Revision 1.32  1995/10/18 14:10:20  nickb
 * Add profiler.
 *
 *  Revision 1.31  1995/05/29  16:31:58  daveb
 *  Added user_preferences field to SHELL_DATA.
 *
 *  Revision 1.30  1995/04/28  10:38:01  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.29  1995/04/18  14:19:02  daveb
 *  Added set_context_name.
 *  
 *  Revision 1.28  1995/03/31  15:29:02  daveb
 *  Added history number to each history item.
 *  
 *  Revision 1.27  1995/03/16  18:43:43  daveb
 *  Merged get_context_name and string_context_name.
 *  
 *  Revision 1.26  1995/03/15  15:22:31  daveb
 *  Changed ShellData to hold a single user_context instead of a stack.
 *  
 *  Revision 1.25  1995/03/10  14:51:18  daveb
 *  Added a current selection to the user_context type, and functions
 *  to set and get this, and a registry for automatic update of a tool's
 *  current selection.
 *  
 *  Revision 1.24  1995/03/02  14:39:48  daveb
 *  Added context to history item type.  Added process_result function.
 *  
 *  Revision 1.23  1995/01/13  12:14:49  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *  
 *  Revision 1.22  1994/07/29  15:54:22  daveb
 *  Added get_current_preferences.
 *  
 *  Revision 1.21  1994/07/18  16:58:34  daveb
 *  Added register of update functions to user contexts.
 *  
 *  Revision 1.20  1994/07/14  15:35:28  daveb
 *  mk_xinterface_fn now has the type Podium_.ListenerArgs -> bool -> unit.
 *  
 *  Revision 1.19  1994/06/30  14:37:28  daveb
 *  Made source_map a concrete type, added [sg]et_saved_file_name.
 *  
 *  Revision 1.18  1994/06/21  12:26:55  daveb
 *  Replaced ContextRefs with user_contexts.  These store info about the
 *  evaluations done in the current user context, as well as the aggregate
 *  context.
 * 
 *  Revision 1.17  1994/02/23  19:51:50  daveb
 *  Removing getContextId.
 *  
 *  Revision 1.16  1994/01/28  16:27:35  matthew
 *  Improvements to error locations
 *  
 *  Revision 1.15  1993/11/25  14:18:37  matthew
 *  Moved exception DebuggerTrapped from Shell for easier use elsewhere.
 *  
 *  Revision 1.14  1993/06/03  17:54:23  daveb
 *  Removed the context field from the prompter.
 *  
 *  Revision 1.13  1993/05/10  16:59:08  daveb
 *  Added code to create, store and retreive an initial contextref.
 *  
 *  Revision 1.12  1993/05/10  10:30:47  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *  
 *  Revision 1.11  1993/05/06  14:38:30  matthew
 *  Simplified.
 *  
 *  Revision 1.10  1993/05/04  15:29:29  matthew
 *  Changed context ref handling
 *  
 *  Revision 1.9  1993/04/02  14:34:36  matthew
 *  Signature changes
 *  
 *  Revision 1.8  1993/03/30  11:13:31  matthew
 *  Added ShellState
 *  Changed prompter function
 *  Added shell_data_ref and with_shell_state
 *  
 *  Revision 1.7  1993/03/26  14:40:37  matthew
 *  Added break function field
 *  changed context ref in ShellData to a list of context refs
 *  
 *  Revision 1.6  1993/03/19  15:50:45  matthew
 *  Added copy_listener_args
 *  
 *  Revision 1.5  1993/03/18  18:05:39  matthew
 *  Added output_fn field to shell_data
 *  
 *  Revision 1.4  1993/03/15  16:20:56  matthew
 *  Simplified types
 *  
 *  Revision 1.3  1993/03/10  13:25:27  matthew
 *  Simplified debugger interface
 *  
 *  Revision 1.2  1993/03/09  15:23:50  matthew
 *  Options & Info changes
 *  Added ShellData type
 *  
 *  Revision 1.1  1993/03/02  18:29:53  daveb
 *  Initial revision
 *  
 *
 *)

require "../main/options";

signature SHELL_TYPES =
sig
  structure Options : OPTIONS

  type preferences
  type user_preferences
  type user_options
  type Context
     
  type user_context

  datatype ListenerArgs = 
    LISTENER_ARGS of
     {user_context: user_context,
      user_options : user_options,
      user_preferences : user_preferences,
      prompter :
        {line : int, subline : int, name : string, topdec : int} -> string,
      mk_xinterface_fn : ListenerArgs -> bool -> unit}

  val new_options: user_options * user_context -> Options.options

  (* this is the data used by each shell *)
  datatype ShellData =
    SHELL_DATA of
      {get_user_context: unit -> user_context,
       user_options : user_options,
       user_preferences: user_preferences,
       prompter :
         {line : int, subline : int, name : string, topdec : int} -> string,
       debugger :
         (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T) ->
         (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T),
       profiler : MLWorks.Profile.profile -> unit,
       exit_fn : int -> unit,
       x_running : bool,
       mk_xinterface_fn : ListenerArgs -> bool -> unit,
       (* This is used for restarting a saved image *)
       mk_tty_listener : ListenerArgs -> int}

  val get_user_options : ShellData -> user_options
  val get_user_preferences : ShellData -> user_preferences
  val get_current_context : ShellData -> Context
  val get_user_context : ShellData -> user_context

  val get_current_options : ShellData -> Options.options
  val get_current_preferences : ShellData -> preferences
  val get_current_prompter :
    ShellData -> ({line : int, subline : int, name : string, topdec : int}
		  -> string)
  val get_current_profiler : ShellData -> (MLWorks.Profile.profile -> unit)

  val get_current_print_options : ShellData -> Options.print_options
  val get_listener_args : ShellData -> ListenerArgs

  val shell_data_ref : ShellData ref

  val with_shell_data : ShellData -> (unit -> 'a) -> 'a

  val with_toplevel_name : string -> (unit -> 'a) -> 'a
  val get_current_toplevel_name : unit -> string

  exception DebuggerTrapped

end;
