(*
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This is the file that starts the interpreter.  It is the last file
 *  loaded into the runtime system in order to create an interpreter image.
 *
 *  Notes
 *  -----
 *  It is a good idea to have your own copy of this file if you are
 *  developing, as you will be able to flip various switches without much
 *  recompilation.
 *
 *  Revision Log
 *  ------------
 *  $Log: interpreter.sml,v $
 *  Revision 1.61  1999/05/13 13:51:02  daveb
 *  [Bug #190553]
 *  Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.60  1999/02/02  16:00:27  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.59  1998/07/07  13:46:16  jont
 * [Bug #20122]
 * Move pervasive signatures into __pervasive_library.sml
 *
 * Revision 1.58  1998/05/26  13:56:24  mitchell
 * [Bug #30413]
 * Use abstract exit status
 *
 * Revision 1.57  1997/05/19  10:49:09  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.56  1996/12/18  17:17:01  andreww
 * [Bug #1818]
 * increasing pervasive module count by one, to account for new
 * floatarray signature.
 *
 * Revision 1.55  1996/10/30  15:29:33  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.54  1996/07/03  11:58:39  andreww
 * Altering MLWorks.Internal.Runtime.modules to include some of the
 * changes to the pervasive library (i.e., to be able to see MLWorks.General).
 *
 * Revision 1.53  1996/05/30  15:44:41  jont
 * interrupt has moved into MLWorks
 *
 * Revision 1.52  1996/05/30  13:20:05  daveb
 * The Interrupt exception is no longer at top level.
 *
 * Revision 1.51  1996/05/16  13:07:53  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.50  1996/05/08  13:29:54  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.49  1996/05/01  10:31:54  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.48  1996/04/17  14:51:58  stephenb
 * Replace any use of MLWorks.exit by Exit.exit
 *
 * Revision 1.47  1996/04/04  10:17:12  stephenb
 * Change the messages in the debugger calls so that they are the same
 * as those used by the gui version (see ./xinterpreter.sml).
 *
 * Revision 1.46  1996/01/16  12:19:02  nickb
 * Change to StorageManager interface.
 *
 *  Revision 1.45  1996/01/15  14:04:11  stephenb
 *  Fix the error I introduced in the previous fix!
 *
 *  Revision 1.44  1996/01/12  12:09:27  stephenb
 *  Ensure that handle_fatal_signal resets the fatal (signal) handler status
 *  before it returns.
 *
 *  Revision 1.43  1996/01/08  16:28:06  nickb
 *  Debugger SIGNAL changed to INTERRUPT
 *
 *  Revision 1.42  1995/07/12  13:24:41  jont
 *  Add parameter to make_shell_structure to indicate image type (ie tty or motif)
 *
 *  Revision 1.41  1995/06/15  13:24:30  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.40  1995/06/14  13:06:10  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.39  1995/06/02  15:01:53  nickb
 *  Add fatal signal handling.
 *
 *  Revision 1.38  1995/05/26  16:38:04  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.37  1995/05/11  10:42:59  matthew
 *  Setting pervasive generalise function moved elsewhere
 *
 *  Revision 1.36  1995/05/02  15:24:40  matthew
 *  Remove script argument to ml_debugger
 *  Change use of cast (again)
 *
 *  Revision 1.35  1995/05/01  11:13:12  daveb
 *  Moved the user context stuff into a separate file from shelltypes.sml.
 *
 *  Revision 1.34  1995/04/06  09:30:22  matthew
 *  Removing Mod_rules.print_times
 *
 *  Revision 1.33  1995/03/01  11:54:48  matthew
 *  Removing use of frame_call
 *  in break function
 *
 *  Revision 1.32  1995/01/27  10:23:57  daveb
 *  Removed reference to ShellTypes.Option.
 *
 *  Revision 1.31  1994/12/07  11:32:18  matthew
 *  Changing uses of cast
 *
 *  Revision 1.30  1994/08/01  12:39:17  daveb
 *  Separated preferences from options.
 *
 *  Revision 1.29  1994/07/18  09:35:25  daveb
 *  Type of mk_xinterface_fn in ShellTypes.ListenerArgs has changed.
 *
 *  Revision 1.28  1994/07/08  10:16:14  nickh
 *  Change interrupt handling.
 *
 *  Revision 1.27  1994/06/22  09:48:28  daveb
 *  Repaced context refs with user_contexts.
 *
 *  Revision 1.26  1994/03/01  15:34:14  nosa
 *  Pass debugger scripts to ml_debugger.
 *
 *  Revision 1.25  1994/03/01  15:10:49  nosa
 *  Pass debugger scripts to ml_debugger.
 *
 *  Revision 1.24  1993/11/09  15:49:00  jont
 *  Changed initial value of user_options to have interrupt_tight_loops on
 *  by default
 *
 *  Revision 1.23  1993/06/03  17:55:52  daveb
 *  Removed the context field from the prompter.
 *
 *  Revision 1.22  1993/05/18  15:21:57  jont
 *  Removed integer parameter
 *
 *  Revision 1.21  1993/05/11  09:50:12  daveb
 *  Interface to contextrefs has changed.
 *
 *  Revision 1.20  1993/05/10  16:27:01  daveb
 *  Changed type of ml_debugger.
 *
 *  Revision 1.19  1993/05/10  14:21:35  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.18  1993/05/10  12:03:29  matthew
 *  Added interrupt handler
 *
 *  Revision 1.17  1993/05/06  15:32:33  matthew
 *  ShellTypes simplification
 *
 *  Revision 1.16  1993/05/04  17:23:11  matthew
 *  Changed context ref handling
 *
 *  Revision 1.15  1993/04/26  12:11:32  matthew
 *  Removed ML_Debugger.BASE_FRAME
 *
 *  Revision 1.14  1993/04/13  16:16:16  matthew
 *  Changes to pervasive dyamics
 *  Changes to pervasive break functions
 *
 *  Revision 1.13  1993/04/06  16:10:24  jont
 *  Moved user_options and version from interpreter to main
 *
 *  Revision 1.12  1993/04/02  19:03:01  daveb
 *  Changed to reflect Matthew's signature changes.
 *
 *  Revision 1.11  1993/03/30  15:55:36  matthew
 *  Set initial context properly.
 *
 *  Revision 1.10  1993/03/30  12:59:25  matthew
 *  Added pervasive break function
 *  Prompter changess
 *
 *  Revision 1.9  1993/03/15  16:52:08  matthew
 *  Simplified ShellTypes types
 *
 *  Revision 1.8  1993/03/11  14:49:51  matthew
 *  Signature revisions
 *
 *  Revision 1.7  1993/03/08  14:53:40  matthew
 *  Options & Info changes
 *  Changes for ShellData type
 *
 *  Revision 1.6  1993/03/01  17:51:28  daveb
 *  Revised to use new TTY listener.  This version doesn't load the X interface.
 *  See xinterpreter.sml.
 *
 *  Revision 1.5  1992/12/08  15:15:59  clive
 *  Don't override error_notify in the value_printer
 *
 *  Revision 1.4  1992/12/04  15:32:00  richard
 *  Commented out diagnostic settings in preparation for release.
 *
 *  Revision 1.3  1992/11/12  16:49:40  richard
 *  Added instruction to delete the loaded modules from the runtime
 *  system's root and so free the setup procedures and unwanted stuff.
 *
 *  Revision 1.2  1992/11/07  15:13:17  richard
 *  Changes to the pervasives.
 *
 *  Revision 1.1  1992/10/15  07:16:05  richard
 *  Initial revision
 *
 *)

require "../main/__toplevel";
require "../debugger/__ml_debugger";
require "__shell_structure";
require "__tty_listener";
require "__shell_types";
require "__user_context";
require "__incremental";
require "__os";
require "../main/__user_options";
require "../main/__preferences";

(* This is getting too big *)

local
structure UserContext = UserContext_
structure ShellTypes = ShellTypes_
structure Info = TopLevel_.Info
structure Options = TopLevel_.Options
structure Incremental = Incremental_
structure Ml_Debugger = Ml_Debugger_

in

val x_message = "This version of MLWorks was compiled without the X interface\n"

fun default_prompter {name, topdec, line, subline} =
  concat [name, if subline > 0 then ">> " else "> "]

  fun handle_fatal_signal shell_data_ref s = 
    let
      val shell_data as ShellTypes.SHELL_DATA{prompter,
                                              mk_xinterface_fn,
                                              ...} = !shell_data_ref
      val c = ShellTypes.get_current_context shell_data
    in
      Ml_Debugger.ml_debugger 
        (Ml_Debugger.get_debugger_type (),
         ShellTypes.get_current_options shell_data,
         ShellTypes.get_current_preferences shell_data)
        (Ml_Debugger.get_start_frame(),
         Ml_Debugger.FATAL_SIGNAL s,
         Ml_Debugger.POSSIBLE ("Return to top level",
			       Ml_Debugger.FUN
			        (fn _ =>
				 (MLWorks.Threads.Internal.reset_fatal_status();
				  raise MLWorks.Interrupt))),
         Ml_Debugger.NOT_POSSIBLE)
    end

  fun interrupt_function shell_data_ref s = 
    let
      val shell_data as ShellTypes.SHELL_DATA{prompter,
                                              mk_xinterface_fn,
                                              ...} = !shell_data_ref
      val c = ShellTypes.get_current_context shell_data
    in
      Ml_Debugger.ml_debugger 
        (Ml_Debugger.get_debugger_type (),
         ShellTypes.get_current_options shell_data,
         ShellTypes.get_current_preferences shell_data)
        (Ml_Debugger.get_start_frame(),
         Ml_Debugger.INTERRUPT,
         Ml_Debugger.POSSIBLE ("Return to top level",
                               Ml_Debugger.DO_RAISE MLWorks.Interrupt),
         Ml_Debugger.POSSIBLE ("Continue interrupted code",
                               Ml_Debugger.NORMAL_RETURN))
    end

  fun double_stack_limit () = 
    let val m = MLWorks.Internal.Runtime.Memory.max_stack_blocks
    in m := (!m * 2)
    end

  fun stack_overflow_function shell_data_ref s = 
    let
      val shell_data as ShellTypes.SHELL_DATA{prompter,
                                              mk_xinterface_fn,
                                              ...} = !shell_data_ref
    in
      Ml_Debugger.ml_debugger 
        (Ml_Debugger.get_debugger_type (),
         ShellTypes.get_current_options shell_data,
         ShellTypes.get_current_preferences shell_data)
        (Ml_Debugger.get_start_frame(),
         Ml_Debugger.STACK_OVERFLOW,
         Ml_Debugger.POSSIBLE
	   ("Return to top level", Ml_Debugger.DO_RAISE MLWorks.Interrupt),
         Ml_Debugger.POSSIBLE
	   ("Continue with extended stack",
            Ml_Debugger.FUN double_stack_limit))
    end

  val _ =
    MLWorks.Internal.Runtime.Event.stack_overflow_handler
    (stack_overflow_function ShellTypes.shell_data_ref)

  val _ =
    MLWorks.Internal.Runtime.Event.interrupt_handler
    (interrupt_function ShellTypes.shell_data_ref)

  val _ =
    MLWorks.Threads.Internal.set_handler
    (handle_fatal_signal ShellTypes.shell_data_ref)

  fun break_function (shell_data_ref) s =
    let
      val shell_data as ShellTypes.SHELL_DATA{prompter,
                                              mk_xinterface_fn,
                                              ...} = !shell_data_ref
    in
      Ml_Debugger.ml_debugger 
        (Ml_Debugger.get_debugger_type (),
         ShellTypes.get_current_options shell_data,
         ShellTypes.get_current_preferences shell_data)
        (Ml_Debugger.get_start_frame(),
         Ml_Debugger.BREAK s,
         Ml_Debugger.POSSIBLE ("Return to top level",
                               Ml_Debugger.DO_RAISE MLWorks.Interrupt),
         Ml_Debugger.POSSIBLE ("Continue interrupted code",
                               Ml_Debugger.NORMAL_RETURN)) 
    end
  
  val _ = MLWorks.Internal.Debugger.break_hook := break_function (ShellTypes.shell_data_ref)

  exception NoDebugger

  val initial_context =
    ShellStructure_.make_shell_structure true
      (ShellTypes.shell_data_ref, Incremental.initial)

  val user_context_options =
    UserOptions_.make_user_context_options Options.default_options

  val _ =
    case user_context_options
    of UserOptions_.USER_CONTEXT_OPTIONS
         {1={generate_interruptable_code, ...}, ...} =>
      generate_interruptable_code := true
      (* want this on for the interpreter *)

  fun main arguments =
    let
    in
      TTYListener_.listener
      (ShellTypes.LISTENER_ARGS
       {user_context =
	  UserContext.makeInitialUserContext
	    (initial_context, "MLWorks", user_context_options),
        user_options =
          UserOptions_.make_user_tool_options Options.default_options,
	user_preferences =
	  Preferences_.make_user_preferences Preferences_.default_preferences,
        prompter=default_prompter,
        mk_xinterface_fn = fn _ =>  fn _ => (print x_message; ())})
    end
end;

  (* MLWorks.Internal.Runtime.modules is a list of the modules that have
     been loaded in the building of this image.  Since we have now created
     the user's image, we don't need most of this list any more.  The only
     entries we need are the pervasives, for loading object files.  These
     are the last 2 entries on the list.
     
     This is not robust code.  It would be better if a module read from 
     an object file could be loaded using a similar mechanism to loading
     the result of compiling a source file. *)

  val _ = MLWorks.Internal.Runtime.modules :=
    (case rev(!MLWorks.Internal.Runtime.modules) of
       x :: y :: _ => [y, x]
     | _ => !MLWorks.Internal.Runtime.modules (* Impossible case *))

(* previously: MLWorks.Internal.Runtime.modules := []; *)

val _ = case main (MLWorks.arguments ()) of
          0 => OS.Process.exit (OS.Process.success)
        | _ => OS.Process.exit (OS.Process.failure);


