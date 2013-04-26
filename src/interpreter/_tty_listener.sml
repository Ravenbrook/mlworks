(*  TTY Listener.
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Log: _tty_listener.sml,v $
 *  Revision 1.63  1998/02/18 17:03:57  jont
 *  [Bug #70070]
 *  Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.62  1998/01/26  18:52:18  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.61.2.2  1997/11/26  13:13:39  daveb
 * [Bug #30071]
 *
 * Revision 1.61.2.1  1997/09/11  20:54:37  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.61  1997/06/17  14:37:32  daveb
 * [Bug #30090]
 * Added handler for IO.Io around TextIO.inputLine, so that the gui.img
 * builds correctly on Windows.
 *
 * Revision 1.60  1997/06/13  09:10:21  matthew
 * Removing uses of MLWorks.IO
 *
 * Revision 1.59  1997/03/25  11:56:05  andreww
 * [Bug #1989]
 * removing Internal.Value.exn_name_string.
 *
 * Revision 1.58  1997/03/17  14:31:04  matthew
 * Remove ShellData from ActionQueue
 *
 * Revision 1.57  1996/05/30  13:19:00  daveb
 * The Interrupt exception is no longer at top level.
 *
 * Revision 1.56  1996/05/24  12:45:59  matthew
 * Improving SYSTEM ERROR behaviour
 *
 * Revision 1.55  1996/05/16  13:07:37  stephenb
 * Update wrt MLWorks.Debugger -> MLWorks.Internal.Debugger change.
 *
 * Revision 1.54  1996/05/01  10:30:27  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.53  1996/03/15  12:39:09  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.52  1996/01/22  14:04:04  daveb
 * Minor change to catch extra cases of Shell.Result datatype.
 *
 *  Revision 1.51  1996/01/18  11:24:45  daveb
 *  Changed Shell interface.
 *
 *  Revision 1.50  1996/01/16  11:24:40  daveb
 *  The Shell structure now uses a ShellState type.
 *
 *  Revision 1.49  1995/10/18  13:54:37  nickb
 *  Add dummy profiler entry to the shell_data created here.
 *
 *  Revision 1.48  1995/09/08  15:15:57  matthew
 *  Adding flush_stream function to Shell.shell
 *
 *  Revision 1.47  1995/07/12  14:24:02  matthew
 *  Removed Incremental from Ml_Debugger
 *
 *  Revision 1.46  1995/06/15  13:08:20  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.45  1995/06/14  13:01:39  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.44  1995/05/29  16:40:58  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *  Moved user_preferences into Preferences.
 *
 *  Revision 1.43  1995/05/02  15:17:10  matthew
 *  Remove script argument to ml_debugger
 *  Change use of cast (again)
 *
 *  Revision 1.42  1995/04/28  12:18:21  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.41  1995/03/15  15:37:45  daveb
 *  Type of shell_date has changed.  Prompt function now takes the
 *  context name as a string, so in the TTY listener I just use "MLWorks".
 *
 *  Revision 1.40  1995/02/23  17:22:42  matthew
 *  Adding break on SYSTEM ERROR.  This is mainly for debugging purposes.
 *
 *  Revision 1.39  1995/01/13  15:04:35  daveb
 *  Removed obsolete sharing condition.
 *
 *  Revision 1.38  1994/12/08  17:29:48  jont
 *  Move OS specific stuff into a system link directory
 *
 *  Revision 1.37  1994/08/10  14:45:18  daveb
 *  Moved read_dot_mlworks to _actionqueue.
 *
 *  Revision 1.36  1994/08/01  09:36:50  daveb
 *  Separated preferences from options.
 *
 *  Revision 1.35  1994/06/21  15:06:56  daveb
 *  Replaced context_ref with user_contexts.
 *  The ActionQueue.Error exception no longer includes a context.
 *
 *  Revision 1.34  1994/04/07  12:15:38  daveb
 *  Added case for DebuggerTrapped.
 *
 *  Revision 1.33  1994/03/21  17:14:55  matthew
 *  Added catchall handler around interpreter loop
 *
 *  Revision 1.32  1994/03/11  17:04:51  matthew
 *  Replace Exit by Shell.Exit
 *
 *  Revision 1.31  1994/02/24  01:19:11  nosa
 *  Debugger scripts for tracing tool using debugger.
 *
 *  Revision 1.30  1994/02/02  10:54:03  daveb
 *  Minor changes to sharing constraints.
 *
 *  Revision 1.29  1994/01/28  16:27:01  matthew
 *  Improvements to error locations
 *
 *  Revision 1.28  1993/12/22  10:52:02  daveb
 *  Changed quit message for debugger, since it no longer raises Interrupt.
 *
 *  Revision 1.27  1993/11/25  14:21:02  matthew
 *  Moved exception DebuggerTrapped from Shell to ShellTypes
 *
 *  Revision 1.26  1993/11/22  17:49:23  daveb
 *  Ml_Debugger.with_start_frame no longer needs a frame argument, removing
 *  the need for the call to MLWorks.Internal.Value.frame_call.
 *
 *  Revision 1.25  1993/10/08  16:21:47  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.24.1.2  1993/10/08  14:53:05  matthew
 *  Use with_base_frame in debugger function
 *  Stream name now "<TTY listener>"
 *
 *  Revision 1.24.1.1  1993/08/10  12:21:29  jont
 *  Fork for bug fixing
 *
 *  Revision 1.24  1993/08/10  12:21:29  matthew
 *  Added stream_name parameter to Shell.shell
 *
 *  Revision 1.23  1993/05/26  12:54:53  matthew
 *  Changes to error handling
 *
 *  Revision 1.22  1993/05/20  09:32:16  matthew
 *  Pass over non-existent .mlworks in silence.
 *
 *  Revision 1.21  1993/05/12  15:45:15  matthew
 *  Changes to ActionQueue
 *
 *  Revision 1.20  1993/05/11  13:48:26  matthew
 *  Changes to use
 *
 *  Revision 1.19  1993/05/10  15:57:35  daveb
 *  Changed type of ml_debugger.
 *
 *  Revision 1.18  1993/05/10  14:02:20  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.17  1993/05/10  09:37:06  matthew
 *  Removed interrupt handler
 *
 *  Revision 1.16  1993/05/06  17:43:15  matthew
 *  Wrap reading .mlworks with a with_shell_data
 *
 *  Revision 1.15  1993/05/06  15:27:24  matthew
 *  Changed interface to ActionQueue.do_actions
 *  ShellTypes simplification
 *
 *  Revision 1.14  1993/05/04  15:20:23  matthew
 *  Changed context ref handling
 *
 *  Revision 1.13  1993/04/30  10:30:17  matthew
 *  Added Interrupt handler around loop
 *
 *  Revision 1.12  1993/04/26  12:10:44  matthew
 *  Removed ML_Debugger.BASE_FRAME
 *
 *  Revision 1.11  1993/04/20  15:55:03  richard
 *  Commented out old tracing code.
 *
 *  Revision 1.10  1993/04/06  16:09:28  jont
 *  Moved user_options and version from interpreter to main
 *
 *  Revision 1.9  1993/04/02  14:59:18  matthew
 *  Signature changes
 *
 *  Revision 1.8  1993/04/01  12:44:18  daveb
 *  Passes empty lines to shell, which handles end of file appropriately.
 *  Added call to clear_eof after printing a prompt, so that user input
 *  terinated by an EOF doesn't affect compiler input.
 *
 *  Revision 1.7  1993/03/30  12:24:22  matthew
 *  Added read_dot_mlworks function
 *  Added initial_listener function that reads .mlworks file
 *
 *  Revision 1.6  1993/03/26  14:04:37  matthew
 *  Moved break function in from _shell_structure
 *
 *  Revision 1.5  1993/03/18  18:09:57  matthew
 *  Added output_fn field to shell_data
 *
 *  Revision 1.4  1993/03/15  16:44:22  matthew
 *  Simplified ShellTypes types
 *
 *  Revision 1.3  1993/03/12  14:24:59  matthew
 *  Removed prompt stuff, use prompt function from shell
 *  Simpilified debugger interface
 *  Signature revisions
 *
 *  Revision 1.2  1993/03/09  15:29:45  matthew
 *  Options & Info changes
 *  Changes for ShellData type
 *  
 *  Revision 1.1  1993/03/02  18:59:33  daveb
 *  Initial revision
 *
 *)

require "../debugger/ml_debugger";
require "shell_types";
require "user_context";
require "../main/user_options";
require "../main/preferences";
require "shell";
require "tty_listener";

require "../basis/__text_io";
require "../basis/__io";

functor TTYListener (
  structure Ml_Debugger : ML_DEBUGGER
  structure ShellTypes: SHELL_TYPES
  structure UserContext: USER_CONTEXT
  structure UserOptions: USER_OPTIONS
  structure Preferences: PREFERENCES
  structure Shell: SHELL

  sharing UserOptions.Options = Ml_Debugger.ValuePrinter.Options =
	  ShellTypes.Options

  sharing type ShellTypes.user_options =
	       UserOptions.user_tool_options

  sharing type Shell.ShellData = ShellTypes.ShellData
  sharing type Shell.Context = ShellTypes.Context = UserContext.Context
  sharing type ShellTypes.user_context = UserContext.user_context
  sharing type UserContext.user_context_options =
	       UserOptions.user_context_options
  sharing type Ml_Debugger.preferences = Preferences.preferences = ShellTypes.preferences
  sharing type ShellTypes.user_preferences = Preferences.user_preferences
): TTY_LISTENER =
struct
  structure Info = Shell.Info

  type ListenerArgs = ShellTypes.ListenerArgs

  fun listener_aux (ShellTypes.LISTENER_ARGS
                    {user_context,
                     prompter,
                     user_options,
                     user_preferences,
                     mk_xinterface_fn},
                    initial_shell_p) = 
    let
      fun output_fn s = TextIO.print s
        
      val exit_fn : int -> unit = (fn n => raise Shell.Exit n)
        
      fun debugger_function f x =
        let
          val call_debugger =
            Ml_Debugger.ml_debugger 
              (Ml_Debugger.TERMINAL,
               ShellTypes.new_options (user_options, user_context),
               Preferences.new_preferences user_preferences)
        in
	    Ml_Debugger.with_start_frame
             (fn base_frame =>
	      ((f x)
	       handle
		 exn as ShellTypes.DebuggerTrapped => raise exn
	       | exn as Shell.Exit _ => raise exn
	       | exn as MLWorks.Interrupt => raise exn
	       | exn as Info.Stop _ => raise exn
	       | exn => 
		   (call_debugger 
		      (base_frame,
		       Ml_Debugger.EXCEPTION exn,
		       Ml_Debugger.POSSIBLE
			 ("quit (return to listener)",
                          Ml_Debugger.DO_RAISE ShellTypes.DebuggerTrapped),
		       Ml_Debugger.NOT_POSSIBLE);
		    raise ShellTypes.DebuggerTrapped)))
        end

      fun profiler p = 
        TextIO.output (TextIO.stdErr, "Graphical profiler not available in TTY Listener\n")

      val shell_data = 
        ShellTypes.SHELL_DATA
         {get_user_context = fn () => user_context,
          user_options = user_options,
          user_preferences = user_preferences,
          debugger = debugger_function,
	  profiler = profiler,
          prompter = prompter,
          exit_fn = exit_fn,
          x_running = false,		(* X isn't running yet. *)
          mk_xinterface_fn = mk_xinterface_fn,
          mk_tty_listener = initial_listener}

      val title = "<TTY listener>"

      (* This should discard unprocessed input on std_in *)
      fun flush_stream () = ()

      val (handler, do_prompt) = Shell.shell (shell_data,title,flush_stream)

      fun debugger_function exn = 
        let
          val shell_data as ShellTypes.SHELL_DATA{prompter,
                                                  mk_xinterface_fn,
                                                  ...} = !ShellTypes.shell_data_ref
          val context = ShellTypes.get_current_context shell_data
        in
          Ml_Debugger.ml_debugger 
          (Ml_Debugger.get_debugger_type (),
           ShellTypes.get_current_options shell_data,
           ShellTypes.get_current_preferences shell_data)
          (Ml_Debugger.get_start_frame(),
           Ml_Debugger.EXCEPTION exn,
           Ml_Debugger.POSSIBLE ("Return to top level",
                                 Ml_Debugger.NORMAL_RETURN),
           Ml_Debugger.NOT_POSSIBLE)
        end
  
      fun loop state =
        let
	  val _ = output_fn(do_prompt ("MLWorks", state))
	  (* val _ = MLWorks.IO.clear_eof MLWorks.IO.std_in *)
          val line = TextIO.inputLine TextIO.stdIn
		     handle IO.Io _ => ""
          val new_state =
	    (case #3 (ShellTypes.with_toplevel_name title
	    	       (fn () =>
			  handler
			    (Info.make_default_options ())
			    (line, state)))
	     of Shell.OK s => s
	     |  _ => Shell.initial_state)
            handle 
              MLWorks.Interrupt => Shell.initial_state
            | ShellTypes.DebuggerTrapped => Shell.initial_state
            | exn as Shell.Exit _ => raise exn
            | exn => (debugger_function exn;
                      Shell.initial_state)
	in
          loop new_state
        end
    in
      loop Shell.initial_state
      handle Shell.Exit n => n
    end (* of listener_aux *)

  and listener args = listener_aux (args,false)
  and initial_listener args = listener_aux (args,true)

end
