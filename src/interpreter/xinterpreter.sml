(*  ==== RUN THE INTERPRETER ====
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
 *  $Log: xinterpreter.sml,v $
 *  Revision 1.64  1999/05/13 13:55:56  daveb
 *  [Bug #190553]
 *  Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.63  1998/07/07  13:44:48  jont
 * [Bug #20122]
 * Move pervasive signatures into __pervasive_library.sml
 *
 * Revision 1.62  1998/05/26  13:56:24  mitchell
 * [Bug #30413]
 * Use abstract exit status
 *
 * Revision 1.61  1997/06/16  09:22:08  johnh
 * [Bug #30174]
 * Making podium platform specific.
 *
 * Revision 1.60  1997/01/08  11:43:26  andreww
 * [Bug #1818]
 * increasing pervasive module count by one, to account for new
 * floatarray signature.
 *
 * Revision 1.59  1996/10/09  16:14:21  io
 * moving String from toplevel
 *
 * Revision 1.58  1996/07/01  15:20:47  andreww
 * expanding the pervasive library to include two more runtime modules.
 *
 * Revision 1.57  1996/05/30  13:20:19  daveb
 * The Interrupt exception is no longer at top level.
 *
 * Revision 1.56  1996/05/16  13:08:07  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.55  1996/05/08  13:30:06  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.54  1996/05/01  11:27:21  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.53  1996/04/17  14:08:21  stephenb
 * Replace any use of MLWorks.exit by Exit.exit
 *
 * Revision 1.52  1996/03/19  15:26:03  daveb
 * Reinstated the code to keep the pervasive modules in the runtime modules
 * list.  This is needed for loading object files into the interpreter.
 *
 * Revision 1.51  1996/03/15  10:49:26  daveb
 * Added comment to show where to call Incremental.preload.
 *
 * Revision 1.50  1996/03/11  10:05:43  daveb
 * Runtime.modules list is now set to nil after loading.  The pervasives
 * are held on to by Incremental.project.
 *
 *  Revision 1.49  1996/01/16  12:19:42  nickb
 *  Change to StorageManager interface.
 *
 *  Revision 1.48  1996/01/12  11:52:43  stephenb
 *  handle_fatal_signal: reset fatal (signal) handler status when quitting.
 *
 *  Revision 1.47  1996/01/08  16:28:16  nickb
 *  Debugger SIGNAL changed to INTERRUPT
 *
 *  Revision 1.46  1995/09/12  12:38:59  matthew
 *  Improving messages
 *
 *  Revision 1.45  1995/07/26  14:59:41  matthew
 *  GUI directory restructuring
 *
 *  Revision 1.44  1995/07/13  10:32:36  matthew
 *  Changes to Ml_Debugger signature
 *
 *  Revision 1.43  1995/07/12  13:25:07  jont
 *  Add parameter to make_shell_structure to indicate image type (ie tty or motif)
 *
 *  Revision 1.42  1995/06/15  13:24:03  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.41  1995/06/14  13:57:00  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.40  1995/06/02  14:11:26  nickb
 *  Add fatal signal handling.
 *
 *  Revision 1.39  1995/05/30  17:44:34  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.38  1995/05/11  10:43:10  matthew
 *  Setting pervasive generalise function moved elsewhere
 *
 *  Revision 1.37  1995/05/02  15:24:15  matthew
 *  Remove script argument to ml_debugger
 *  Change use of cast (again)
 *
 *  Revision 1.36  1995/04/28  14:05:02  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.35  1995/04/06  09:30:41  matthew
 *  Removing Mod_rules.print_times
 *
 *  Revision 1.34  1995/01/17  16:45:46  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *
 *  Revision 1.33  1994/12/07  11:33:08  matthew
 *  Changing uses of cast
 *
 *  Revision 1.32  1994/08/11  13:27:06  matthew
 *  Interrupt handler raises wrong exception
 *
 *  Revision 1.31  1994/08/01  12:34:45  daveb
 *  Separated preferences from options.
 *
 *  Revision 1.30  1994/07/28  11:50:41  daveb
 *  Added comment about argument handling.
 *
 *  Revision 1.29  1994/07/08  10:15:51  nickh
 *  Change interrupt and stack overflow handling.
 *
 *  Revision 1.28  1994/06/20  13:12:40  daveb
 *  Replaced context_ref with user_contexts.
 *
 *  Revision 1.27  1994/03/21  18:03:21  matthew
 *  Stopped raising Interrupt on return from debugger.
 *
 *  Revision 1.26  1994/02/24  00:02:29  nosa
 *  Debugger scripts for tracing tool using debugger.
 *
 *  Revision 1.25  1994/02/02  11:11:19  daveb
 *  Minor changes in substructures.
 *
 *  Revision 1.24  1994/01/19  10:17:42  matthew
 *  Changed implementation of last function to avoid gc problem
 *
 *  Revision 1.24  1994/01/19  10:17:42  matthew
 *  Changed implementation of last function to avoid gc problem
 *
 *  Revision 1.23  1994/01/06  13:07:43  matthew
 *  Preserve pervasive modules.
 *
 *  Revision 1.22  1993/11/09  15:33:09  jont
 *  Changed initial value of user_options to have interrupt_tight_loops on
 *  by default
 *
 *  Revision 1.21  1993/10/12  16:30:35  matthew
 *  Merging bug fixes
 *
 *  Revision 1.20.1.2  1993/10/12  16:26:42  matthew
 *  Uncommented stack overflow handler
 *  Uses STACK_OVERFLOW mode in the debuggert
 *
 *  Revision 1.20.1.1  1993/06/16  11:55:38  jont
 *  Fork for bug fixing
 *
 *  Revision 1.20  1993/06/16  11:55:38  matthew
 *  Commented out SIGUSR1 handling for the moment
 *
 *  Revision 1.19  1993/06/11  14:06:24  matthew
 *  Added stack overflow function and SIGUSER1 handler
 *  l
 *
 *  Revision 1.18  1993/06/03  17:55:05  daveb
 *  Removed the context field from the prompter.
 *
 *  Revision 1.17  1993/05/18  15:22:44  jont
 *  Removed integer parameter
 *
 *  Revision 1.16  1993/05/10  17:08:09  daveb
 *  Interface to contextrefs has changed.
 *
 *  Revision 1.15  1993/05/10  16:21:18  daveb
 *  Changed type of ml_debugger.
 *
 *  Revision 1.14  1993/05/10  14:34:51  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *  
 *  Revision 1.13  1993/05/10  09:42:08  matthew
 *  Added interrupt handler
 *  
 *  Revision 1.12  1993/05/07  15:34:00  matthew
 *  Break function uses global start_frames and debugger type
 *  
 *  Revision 1.11  1993/05/06  14:27:06  matthew
 *  ShellTypes changes
 *  
 *  Revision 1.10  1993/05/04  16:47:34  matthew
 *  Changed context ref handling
 *  
 *  Revision 1.9  1993/04/26  12:11:47  matthew
 *  Removed ML_Debugger.BASE_FRAME
 *  
 *  Revision 1.8  1993/04/08  08:39:43  matthew
 *  Added MLWorks.Debugger structure
 *  Set up generalise function in pervasives
 *  
 *  Revision 1.7  1993/04/06  16:31:45  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.6  1993/04/02  15:32:46  matthew
 *  Signature changes
 *  
 *  Revision 1.5  1993/03/30  12:56:42  matthew
 *  Added pervasive break function
 *  Sorted out a bit
 *  
 *  Revision 1.4  1993/03/15  17:36:03  matthew
 *  Simplified ShellTypes types
 *  
 *  Revision 1.3  1993/03/11  14:50:03  matthew
 *  Signature revisions
 *  
 *  Revision 1.2  1993/03/08  15:48:10  matthew
 *  Options & Info changes
 *  Changes for ShellData type
 *  
 *  Revision 1.1  1993/03/02  19:45:11  daveb
 *  Initial revision
 *  
 *)

require "../main/__toplevel";
require "../main/__info";
require "../debugger/__ml_debugger";
require "__shell_types";
require "__user_context";
require "../main/__user_options";
require "../main/__preferences";
require "__tty_listener";
require "__shell_structure";
require "__incremental";
require "__os";
require "../winsys/__podium";

(* require "__intermake"; InterMake_.Diagnostic.set 1; *)
(* require "../main/__compiler"; Compiler_.Diagnostic.set 2; *)

local

  structure Options = TopLevel_.Options
  structure UserContext = UserContext_
  structure ShellTypes = ShellTypes_
  structure Ml_Debugger = Ml_Debugger_
  structure Incremental = Incremental_
  structure Info = Info_

  (* This is getting too big *)

  fun default_prompter {name, topdec, line, subline} =
    concat [name, if subline > 0 then ">> " else "> "]

  exception NoDebugger

  val initial_context =
    ShellStructure_.make_shell_structure false
    (ShellTypes.shell_data_ref, Incremental.initial)

  (* Set up preloaded modules here. *)
  (*
  val _ = Incremental.preload (Incremental.initial, "utils.__lists")
  *)

  val user_context_options =
    UserOptions_.make_user_context_options Options.default_options 

  val user_preferences =
    Preferences_.make_user_preferences Preferences_.default_preferences

  val _ =
    case user_context_options
    of UserOptions_.USER_CONTEXT_OPTIONS
         {1={generate_interruptable_code, ...}, ...} =>
      generate_interruptable_code := true;
      (* want this on for the interpreter *)

  val _ = UserContext.makeInitialUserContext
	    (initial_context, "Initial", user_context_options)

(* Argument handling is actually done is the Shell.save function in
   interpreter/_shell_structure.sml.  The reason for this is that 
   main is run when building the motif.img, in the images Makefile.
   The Makefile pipes "Shell.save ..." into the interpreter, and it
   saves an image.  It is this image that the user runs, and that has
   to handle the user's arguments.
   
   An alternative approach would be to call MLWorks.save here.  Unfortunately
   this increases the size of the saved image.  I don't know why.  *)

  fun main arguments =
    TTYListener_.listener
      (ShellTypes_.LISTENER_ARGS
         {user_context = UserContext.getNewInitialContext(),
          user_options =
	    UserOptions_.make_user_tool_options Options.default_options,
          user_preferences = user_preferences,
          prompter=default_prompter,
          mk_xinterface_fn = Podium_.start_x_interface})
in

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

  fun handle_fatal_signal shell_data_ref s =
    let
      val shell_data as ShellTypes.SHELL_DATA{prompter,
                                              mk_xinterface_fn,
                                              ...} = !shell_data_ref
      val context = ShellTypes.get_current_context shell_data
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
      val context = ShellTypes.get_current_context shell_data
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
      val context = ShellTypes.get_current_context shell_data
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
      val context = ShellTypes.get_current_context shell_data
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
  
  val _ = MLWorks.Internal.Debugger.break_hook :=
	    break_function (ShellTypes.shell_data_ref)

  val _ = case main (MLWorks.arguments ()) of
            0 => OS.Process.exit (OS.Process.success)
          | _ => OS.Process.exit (OS.Process.failure);
end
