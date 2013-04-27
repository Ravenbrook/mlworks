(*  ==== COMPILER SHELL ====
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
 *  Implementation 
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: _shell.sml,v $
 *  Revision 1.134  1998/02/19 19:36:21  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 * Revision 1.133  1998/01/26  18:47:52  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.132.2.2  1997/11/26  13:07:48  daveb
 * [Bug #30071]
 *
 * Revision 1.132.2.1  1997/09/11  20:54:54  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.132  1997/07/31  12:43:33  johnh
 * [Bug #50019]
 * Modify process_result to take a UserContext.source_reference type for src.
 *
 * Revision 1.131  1997/05/19  10:46:42  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.130  1997/03/25  11:55:45  andreww
 * [Bug #1989]
 * removing Internal.Value.exn_name_string.
 *
 * Revision 1.129  1997/03/19  12:27:33  matthew
 * Adding level to do_actions
 *
 * Revision 1.128  1996/10/31  13:39:44  io
 * [Bug #1717]
 * fix an incorrect translation
 *
 * Revision 1.127  1996/10/30  12:56:56  io
 * moving String from toplevel
 *
 * Revision 1.126  1996/08/07  11:03:49  daveb
 * Added \r to the list of trivial characters.
 *
 * Revision 1.125  1996/07/30  09:44:57  daveb
 * [Bug #1299]
 * Added handlers to update end_pos and topdecs after a DebuggerTrapped or
 * Interrupt exception.  Also ignored trivial remaining lines, so that the
 * listener doesn't print unnecessary newlines.
 *
 * Revision 1.124  1996/05/30  13:16:33  daveb
 * The Interrupt exception is no longer at top level.
 *
 * Revision 1.123  1996/05/08  12:50:59  daveb
 * Moved code that updates the end_position and topdecs references so that
 * the ActionQueue is cleared first.  Thus errors that arise from the action
 * queue are handled in the same way as those that occur during compilation.
 *
 * Revision 1.121  1996/05/02  17:28:25  daveb
 * Removed ActionQueue.Handler exception.
 *
 * Revision 1.120  1996/05/01  10:28:08  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.119  1996/04/09  18:40:25  daveb
 * UserContext.process_result now takes a preferences argument (and a record
 * instead of a tuple).
 *
 * Revision 1.118  1996/02/05  17:41:31  daveb
 * UserContext no longer includes a user_tool_options type.
 *
 *  Revision 1.117  1996/01/24  12:09:41  daveb
 *  Fixed bug in handling of trivial lines.
 *
 *  Revision 1.116  1996/01/22  14:07:38  daveb
 *  Added INTERRUPT, EMPTY, and DEBUGGER_TRAPPED constructors to Result
 *  datatype, so that listeners can perform appropriate cleanup actions.
 *
 *  Revision 1.115  1996/01/18  14:16:34  daveb
 *  Added Result datatype.  Made the do_line function take Info.options.
 *
 *  Revision 1.114  1996/01/17  12:15:08  daveb
 *  Changes to support the new gui listener behaviour.
 *  The do_line function now takes and returns an explicit ShellState value,
 *  instead of this information being stored internally.  It also returns
 *  a list of the sources of each topdec, instead of offsets into the source
 *  string, and an extra string for any remaining source.  It uses the new
 *  Location.extract function to extract these source strings.
 *
 *  Revision 1.113  1995/09/08  15:29:33  matthew
 *  Changing error wrapping.
 *
 *  Revision 1.112  1995/07/19  12:08:51  matthew
 *  Changing parser error reporting.
 *
 *  Revision 1.111  1995/07/13  12:19:26  matthew
 *  Moving identifier type to Ident
 *
 *  Revision 1.110  1995/06/05  14:13:33  daveb
 *  UserContext.process_result now takes a user_options argument.
 *
 *  Revision 1.109  1995/05/26  11:40:03  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.108  1995/04/28  12:00:07  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.107  1995/04/25  12:45:55  daveb
 *  Added current_source ref, so that do_lines can synthesize the full
 *  source of the current topdec.
 *
 *  Revision 1.106  1995/03/16  17:43:30  daveb
 *  Removed context_name function, as is no longer used.
 *
 *  Revision 1.105  1995/03/15  14:19:27  daveb
 *  Type of ShellTypes.ShellData has changed.
 *  Also, prompt_function now takes the context name string as an argument.
 *
 *  Revision 1.104  1995/03/06  12:22:21  daveb
 *  Replaced user context manipulation with a call to ShellTypes.process_result.
 *
 *  Revision 1.103  1995/03/02  12:13:58  matthew
 *  Changes to Lexer structure
 *
 *  Revision 1.102  1995/02/20  14:47:40  daveb
 *  do_actions now takes an output function argument.
 *
 *  Revision 1.101  1995/01/13  15:00:03  daveb
 *  Removed obsolete sharing constraint.
 *
 *  Revision 1.100  1994/08/09  12:53:13  daveb
 *  Changed type of InterPrint.strings.  Renamed source_result to result.
 *
 *  Revision 1.99  1994/07/28  14:44:28  daveb
 *  Changed print_options identifier to options, for clarity.
 *
 *  Revision 1.98  1994/06/23  10:06:31  jont
 *  Update debugger information production
 *
 *  Revision 1.97  1994/06/22  10:50:00  daveb
 *  Removed extraneous newline from printed results.
 *
 *  Revision 1.96  1994/06/21  15:04:39  daveb
 *  Changes to support per-user_context information.
 *
 *  Revision 1.95  1994/05/06  15:52:21  jont
 *  Add incremental parser basis to stuff passed to interprint
 *
 *  Revision 1.94  1994/03/17  10:17:26  matthew
 *  Commented out catchall handler.
 *
 *  Revision 1.93  1994/03/15  10:18:29  matthew
 *  Added Exit exception and handler
 *
 *  Revision 1.92  1994/02/23  17:38:21  matthew
 *  Added catchall exception handler
 *
 *  Revision 1.91  1994/02/02  10:45:51  daveb
 *  Rejigged substructures.
 *
 *  Revision 1.90  1993/11/25  14:19:25  matthew
 *  Moved exception DebuggerTrapped into ShellTypes for easier use elsewhere.
 *
 *  Revision 1.89  1993/09/23  16:37:48  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.88  1993/09/23  14:13:09  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.87  1993/09/16  15:49:39  nosa
 *  Pass options to InterPrint.definitions instead of print_options.
 *
 *  Revision 1.86.1.3  1993/09/23  16:12:23  daveb
 *  No longer resets prompt when a topdec ends in the middle of a line.
 *
 *  Revision 1.86.1.2  1993/09/23  14:07:46  daveb
 *  Minor fix to handling of blank lines & subline count.
 *
 *  Revision 1.86.1.1  1993/08/10  13:23:01  jont
 *  Fork for bug fixing
 *
 *  Revision 1.86  1993/08/10  13:23:01  matthew
 *  Added stream_name parameter to be used as name of input token stream
 *  Changed line count to be the subline number
 *
 *  Revision 1.85  1993/07/29  11:17:31  matthew
 *  Removed error_info parameter from InterPrint.definitions
 *
 *  Revision 1.84  1993/06/03  17:53:27  daveb
 *  Removed the prompter_args value.  Now uses the name of the current
 *  ContextRef for the prompt.
 *
 *  Revision 1.83  1993/06/01  11:29:56  matthew
 *  Added handler for ActionQueue.Handled around ActionQueue.do_actions
 *
 *  Revision 1.82  1993/05/27  11:28:55  matthew
 *  Changes to error handling
 *
 *  Revision 1.81  1993/05/12  15:45:56  matthew
 *  Changes to ActionQueue
 *
 *  Revision 1.80  1993/05/10  10:40:38  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.79  1993/05/06  15:04:00  matthew
 *  Removed printer descriptors
 *  Changes to ActionQueue interface
 *
 *  Revision 1.78  1993/04/20  12:25:54  matthew
 *  Added unit parameter to two calls to reset_parsing_state
 *
 *  Revision 1.77  1993/04/15  11:18:55  daveb
 *  Replaced a call to output_fn with a call to Info.error', and
 *  moved it so that the resulatant raise of Info.Stop will be
 *  handled correctly.
 *
 *  Revision 1.76  1993/04/06  17:49:50  daveb
 *  The shell's do_line function now returns the positions of any topdecs
 *  that end in the current line, and whether the current topdec is still valid.
 *
 *  Revision 1.75  1993/04/06  16:24:51  jont
 *  Moved user_options and version from interpreter to main
 *
 *  Revision 1.74  1993/04/02  14:50:00  matthew
 *  Signature changes
 *
 *  Revision 1.73  1993/04/01  12:07:01  daveb
 *  Interprets empty lines as end-of-file.  Knows enough about lexer state to
 *  set prompt appropriately.  Passes empty lines to parser when appropriate.
 *
 *  Revision 1.72  1993/03/29  17:10:08  matthew
 *  Prompt changes
 *  Used with_shell_data
 *  Removed call to make_shell_structure (this is done only once now)
 *
 *  Revision 1.71  1993/03/25  10:19:17  daveb
 *  ActionQueue.do_actions now takes a single ShellData argument.
 *
 *  Revision 1.70  1993/03/24  14:22:14  matthew
 *  reset prompt before executing topdec
 *
 *  Revision 1.69  1993/03/19  12:19:09  matthew
 *  Error wrap of call to incremental parser.  Restructuring of the command loop
 *
 *  Revision 1.68  1993/03/17  12:09:06  matthew
 *  Changed to allow error wrapping of incremental parsing.
 *  Loop function simplified.
 *  Pass new parser basis to Incremental.add_source
 *  Fixed line numbering of blank lines.
 *
 *  Revision 1.67  1993/03/15  16:38:41  matthew
 *  Changed ShellData type to include all shell information
 *
 *  Revision 1.66  1993/03/12  11:21:12  matthew
 *  Fixed problem with prompts
 *  do_line now takes an output function
 *
 *  Revision 1.65  1993/03/09  15:51:47  matthew
 *  Options & Info changes
 *
 *  Revision 1.64  1993/03/02  18:49:09  daveb
 *  Completely revised.  Much stuff moved to _action_queue, _shell_structure,
 *  _user_options and _tty_listener.  The shell now provides a core service
 *  to both TTY-based and X-based listeners.
 *
 *  Revision 1.61  1993/02/09  12:34:23  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.60  1993/02/08  10:42:02  matthew
 *  Changes of sharing relations and new structure representation
 *
 *  Revision 1.59  1993/01/28  16:52:09  jont
 *  Modified to allow user control of listing options
 *
 *  Revision 1.58  1993/01/07  16:38:25  matthew
 *  Modified empty_action_queue so errors are only handled once at the
 *  outermost call.
 *  This stops compilation continuing after an error.
 *
 *  Revision 1.57  1993/01/05  11:58:34  jont
 *  Modified to deal with new code printing options
 *
 *  Revision 1.56  1992/12/23  17:48:19  daveb
 *  "use" can now read a file that doesn't have a ".sml" extension.
 *
 *  Revision 1.55  1992/12/21  13:09:30  matthew
 *  Changed listener window syntax error message.
 *  Added proper line numbering for listener shell
 *
 *  Revision 1.54  1992/12/18  16:49:28  daveb
 *  Ensured that user options are passed from the TTY shell to the listener shell
 *
 *  Revision 1.53  1992/12/18  13:25:21  matthew
 *  Added xinterface_flag to make_shell_structure -- if true, xinterface is running.
 *  Rebound streams when saving image from listener window.
 *  Fix of Clive to interrupt handling in listener.
 *
 *  Revision 1.52  1992/12/18  10:41:33  clive
 *  We also pass the current module forward for the source_displayer
 *
 *  Revision 1.51  1992/12/17  12:47:37  clive
 *  Changed debug info to have only module name - needed to pass module table through to window stuff
 *
 *  Revision 1.50  1992/12/16  18:25:21  matthew
 *  Fixed secondary prompts.
 *  Changed some messages
 *
 *  Revision 1.49  1992/12/16  17:50:56  clive
 *  Fixed bug in 'make' from 'source' option in listener with no file selected
 *
 *  Revision 1.48  1992/12/16  16:39:14  clive
 *  Tried to give an error message if make called on an invalid filename
 *
 *  Revision 1.47  1992/12/16  13:31:19  clive
 *  Changes to the debugger for a limited backtrace
 *
 *  Revision 1.46  1992/12/10  15:54:23  clive
 *  Stopped recompile errors entring the debugger
 *  Changed the debugger to propagate Interrupt if told to 'q' during ^C action
 *
 *  Revision 1.45  1992/12/09  18:07:17  clive
 *  Message from use if the file is not found
 *
 *  Revision 1.44  1992/12/09  12:36:37  clive
 *  Added passing of the module_table to the source_viewer
 *
 *  Revision 1.43  1992/12/09  12:27:35  matthew
 *  Various bug fixes.
 *  Made action queue global -- experimental
 *
 *  Revision 1.42  1992/12/08  21:00:42  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.41  1992/12/08  16:59:15  daveb
 *  Fixed clear_debug_info - we can't set the current_context with a
 *  user-visible function, because it gets reset later.  So we have to use
 *  the action queue.
 *
 *  Revision 1.40  1992/12/08  16:37:20  daveb
 *  Made changed options apply immediately after evaluation.
 *  Changed the user-visible field optimise_self_calls to
 *  optimise_self_tail_calls.
 *
 *  Revision 1.39  1992/12/08  13:42:25  daveb
 *  Ensured that options are pased to compile, recompile and make.
 *
 *  Revision 1.38  1992/12/04  15:28:55  clive
 *  Added a correct handler around make to preserve context on partial make
 *
 *  Revision 1.37  1992/12/04  11:48:59  daveb
 *  Fixed exit from listener.
 *  Fixed calculation of subline in listener prompt.
 *
 *  Revision 1.36  1992/12/03  22:28:04  daveb
 *  Moved xinterface and save into Shell structure.
 *  Attempted to fix exit from listener shells.
 *  Propagated options into shells.
 *  Removed the shell function (it was causing a lot of trouble).
 *  Added remake function (clive).
 *  Improved error reporting.
 *  Removed a sharing constraint.
 *  Minor tidying up.
 *
 *  Revision 1.35  1992/12/02  18:06:36  daveb
 *  Deleted several pieces of commented-out code.
 *
 *  Revision 1.34  1992/12/02  15:29:35  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *  Many settable options now plumbed in.
 *  Exit function pu into shell structure.
 *  Some minor tidying up.
 *
 *  Revision 1.33  1992/12/01  16:17:55  clive
 *  Added a forced garbage collection before a save
 *
 *  Revision 1.32  1992/12/01  15:03:30  matthew
 *  Changed stream handling.
 *
 *  Revision 1.31  1992/12/01  10:55:39  clive
 *  Debugger now takes the print options
 *
 *  Revision 1.30  1992/11/28  16:05:44  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.29  1992/11/26  18:46:16  matthew
 *  Flush output when starting shell.
 *
 *  Revision 1.28  1992/11/26  17:29:41  clive
 *  Added some of the functions in the Debug structure
 *
 *  Revision 1.27  1992/11/26  16:41:04  matthew
 *  Integrated clm stuff.  Tidied some things up.  Used streams more.
 *
 *  Revision 1.26  1992/11/25  17:32:57  daveb
 *  Put the substructures in the structures.
 *
 *  Revision 1.25  1992/11/24  12:03:04  clive
 *  The debugger now takes messages to go with the 'q' and 'c' options
 *
 *  Revision 1.24  1992/11/24  10:59:16  daveb
 *  More changes to the user visible structures.  These aren't plumbed in
 *  to the rest of the compiler yet.
 *
 *  Revision 1.23  1992/11/20  16:54:11  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.22  1992/11/19  19:45:20  matthew
 *  Added recompile and compile, and some info bug fixes.
 *
 *  Revision 1.21  1992/11/18  17:40:14  clive
 *  Added completion of name by adding .sml to used files
 *  Added an error message if a use or make fails
 *
 *  Revision 1.20  1992/11/18  15:06:46  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.19  1992/11/12  17:32:14  clive
 *  Added tracing
 *
 *  Revision 1.18  1992/11/12  11:32:00  daveb
 *  Added show structure, moved Print structure out of Shell.
 *
 *  Revision 1.17  1992/11/11  16:14:47  daveb
 *  Added print controls to user-visible values in shell().
 *
 *)

require "../utils/lists";
require "../utils/crash";
require "../parser/parser";
require "shell_types";
require "user_context";
require "incremental";
require "shell";

functor Shell (
  structure Crash : CRASH
  structure Lists : LISTS
  structure Parser : PARSER
  structure ShellTypes: SHELL_TYPES
  structure UserContext: USER_CONTEXT
  structure Incremental: INCREMENTAL

  sharing Parser.Lexer.Info = Incremental.InterMake.Compiler.Info
  sharing Incremental.InterMake.Compiler.Absyn = Parser.Absyn
  sharing ShellTypes.Options = UserContext.Options =
	  Incremental.InterMake.Compiler.Options

  sharing type Incremental.InterMake.Compiler.ParserBasis = Parser.ParserBasis
  sharing type Incremental.Result = UserContext.Result
  sharing type Parser.Lexer.Options = ShellTypes.Options.options
  sharing type ShellTypes.Context = Incremental.Context
  sharing type ShellTypes.user_context = UserContext.user_context
  sharing type UserContext.identifier =
	       Parser.Absyn.Ident.Identifier
  sharing type ShellTypes.preferences = UserContext.preferences
): SHELL =
struct
  structure Compiler = Incremental.InterMake.Compiler
  structure Parser = Parser
  structure Lexer  = Parser.Lexer
  structure Info = Compiler.Info
  structure Options = ShellTypes.Options
  structure Absyn = Parser.Absyn

  type ShellData = ShellTypes.ShellData
  type Context = Incremental.Context

  exception Exit of int

  datatype ShellState =
    SHELL_STATE of
      {parser_state: Parser.ParserState,
       lexer_state: Lexer.Token.LexerState,
       source: string,
       line_count: int}

  datatype Result =
    OK of ShellState
  | ERROR of Info.error * Info.error list
  | INTERRUPT
  | DEBUGGER_TRAPPED
  | TRIVIAL

  val initial_state =
    SHELL_STATE
      {parser_state = Parser.initial_parser_state,
       lexer_state = Lexer.Token.PLAIN_STATE,
       source = "",
       line_count = 1}


  (* shell returns two functions.  The first takes one line of input,
     parses it relative to a state stored from earlier lines, and evaluates
     any topdecs found.  The second takes a string and converts
     it into a prompt string. *)
  fun shell (shell_data,stream_name,flush_stream) =
    let
      val ShellTypes.SHELL_DATA{debugger,
                                exit_fn,
                                ...} = shell_data

      val output_fn = print
        
      fun do_prompt (s, SHELL_STATE {line_count, ...}) =
        ShellTypes.get_current_prompter
	  shell_data
          {line = ~1,
           subline = line_count - 1,
	   name = s,
           topdec =
	     Incremental.topdec (ShellTypes.get_current_context shell_data)}

      (* need to record the context in which the current topdec is parsed *)
      val current_context = ref (ShellTypes.get_current_context shell_data)

      (* and the incremental parser basis *)
      fun get_current_pB () = Incremental.parser_basis (!current_context)

      val current_pB = ref (get_current_pB ())

      fun do_line error_info (line, state) =
        ShellTypes.with_shell_data
        shell_data
        (fn () =>
         let
	   (* A null string signals EOF *)
	   val real_eof = size line = 0

	   val SHELL_STATE
		 {parser_state = parser_start_state,
		  lexer_state = lexer_start_state,
		  source = old_source,
		  line_count} =
	     state

	   val full_source = old_source ^ line

           (* when one or more topdecs end on the line being parsed, topdecs
	      stores the source of each of the topdecs, and end_position
	      records the position where the remaining text begins, for later
	      extraction. *)
           val end_position = ref 0;
           val topdecs = ref [];

           (* need to wrap the parser so that we stop on errors *)
           fun error_wrap f a =
	     Info.wrap
               error_info
               (Info.FATAL, Info.RECOVERABLE,
	        Info.FAULT, Info.Location.FILE stream_name)
               f
               a

	  fun check_eof () =
	    if real_eof then
	      exit_fn 0
            else
	      ()

	  fun all_chars p str =
	    let
	      fun scan i = 
		if i < 0 then
		  true
		else
		  p (MLWorks.String.ordof (str, i)) andalso (scan (i-1))
	    in
	      scan (size str -1)
	    end
	    
	  val trivial =
	    all_chars 
              (fn c => (c = ord #" " orelse c = ord #"\n" orelse
                        c = ord #"\t" orelse c = ord #"\r" orelse
			c = ord #"\012"))

	  (* trivial' is similar to trivial, but also ignores semi-colons.
	     This is used to ignore empty topdecs.  *)
          val trivial' =
	    all_chars
	      (fn c => (c = ord #" " orelse c = ord #"\n" orelse
                        c = ord #"\t" orelse c = ord #"\r" orelse
			c = ord #"\012" orelse c = ord #";"))
        in
	  if line_count = 1 andalso size line > 0
	     andalso trivial' line then
	     (* Blank lines are ignored if we haven't parsed anything yet *)
	    ([], "", TRIVIAL)
	  else if lexer_start_state = Lexer.Token.PLAIN_STATE
                  andalso size line > 0 andalso trivial line then
	    ([],
	     full_source,
	     OK (SHELL_STATE
		   {lexer_state = lexer_start_state,
		    parser_state = parser_start_state,
		    source = full_source,
		    line_count = line_count + 1}))
          else
            let
              val input_function =
                let val buff = ref line
                in
                  fn _ => (let val out = !buff in buff := ""; out end)
                end
              
              val token_stream = Lexer.mkLineTokenStream (input_function,
                                                          stream_name,
                                                          line_count,
							  real_eof)
              exception STOP of ShellState
              
	      (* get_topdec parses the token_stream.  If it finds a topdec
		 it returns that topdec; otherwise it raises an exception. *)
              fun get_topdec error_info (lexer_state, parser_state) =
                (let 
                  val (pB,new_ps,new_ls) =
                    Parser.parse_incrementally
                      error_info
                      (ShellTypes.get_current_options shell_data,
                       token_stream,
                       !current_pB,
                       parser_state,
                       lexer_state)
                in
                  (* we are part way through parsing a topdec, so store state *)
                  current_pB := pB;
		  (* Return the full source in the state, as the lexer_state
		     includes position information relative to everything
		     read so far. *)
                  raise STOP
		          (SHELL_STATE
		             {parser_state = new_ps,
                              lexer_state = new_ls,
		              source = full_source,
		              line_count = line_count + 1})
                end
                handle
                  Parser.FoundTopDec (topdec,newpB,loc) =>
                    (topdec,newpB,loc)
                | Parser.SyntaxError (message,location) =>
                    Info.error' error_info (Info.FATAL, location, message))

              fun reset_parsing_state () =
                (current_context := ShellTypes.get_current_context (shell_data);
                 current_pB := get_current_pB ())
                
	      (* The loop function parses as many topdecs as possible from
		 the tokenstream. *)
              fun loop (lexer_state, parser_state) =
                let
                  val _ =
                    if Parser.is_initial_state parser_state
		       andalso lexer_state = Lexer.Token.PLAIN_STATE then
                      reset_parsing_state ()
                    else
                      ()
                        
                  val parsing_context = !current_context

		  (* If get_topdec reaches the end of the input, it raises
		     STOP. *)
                  val (topdec, new_pB, loc2) = 
                    error_wrap get_topdec (lexer_state, parser_state)
                    handle exn as Info.Stop _ =>
                      (ignore(flush_stream ());
                       raise exn)

		  val loc1 =
		    case topdec of
		      Absyn.STRDECtopdec (_, l) => l
		    | Absyn.REQUIREtopdec (_, l) => l
		    | Absyn.FUNCTORtopdec (_, l) => l
		    | Absyn.SIGNATUREtopdec (_, l) => l

		  (* loc1 is the location of the topdec itself; loc2 is
		     the location of the semicolon. *)
		  val loc = Info.Location.combine (loc1, loc2);

		  val (s_pos, e_pos) =
		    Info.Location.extract (loc, full_source)
		    handle
		      Info.Location.InvalidLocation => (0, 1)

		  val new_source =
		    substring (* could raise Substring *) (full_source, s_pos, e_pos - s_pos)
		    handle Subscript => full_source (* tied to substring above *)

                  (*compile the source in the parsing context *)
                  val result =
                    (Incremental.compile_source
                     error_info
                     (Incremental.OPTIONS
                      {options = ShellTypes.get_current_options shell_data,
                       debugger=debugger},
                      parsing_context,
                      Compiler.TOPDEC (stream_name,topdec,new_pB))
                     handle
                     exn as ShellTypes.DebuggerTrapped =>
                       (end_position := e_pos;
                        topdecs := new_source :: !topdecs;
                        raise exn)
                   | exn as MLWorks.Interrupt =>
                       (end_position := e_pos;
                        topdecs := new_source :: !topdecs;
                        raise exn))

                in
		  UserContext.process_result
		    {src = UserContext.STRING new_source,
		     result = result,
		     user_context = ShellTypes.get_user_context shell_data,
		     options = ShellTypes.get_current_options shell_data,
		     preferences =
		       ShellTypes.get_current_preferences shell_data,
		     output_fn = output_fn};

		  (* Don't update these references until after the topdec
		     has been successfully compiled. *)
		  end_position := e_pos;
		  topdecs := new_source :: !topdecs;

		  (* The following lines check whether there is anything
		     else to parse on this line.  If not, the initial state
		     is returned, without incrementing the line_count. *)
                  reset_parsing_state();
                  if Lexer.eof token_stream then
		    (* This is the end of the line.  NOT usually the real end
		       of file.  That only happens when (size line = 0). *)
                    raise STOP initial_state
                  else
		    ();
                  loop
		    (Lexer.Token.PLAIN_STATE, Parser.initial_parser_state)
                end
            in
              loop (lexer_start_state, parser_start_state)
              handle exn =>
		let
		  val current_source =
		    let
		      val i = !end_position

		      val remainder =
		        substring (line, i, size line - i)
		        handle
			  Subscript => line (* tied to substring above *)
		    in
		      if trivial remainder then
			""
		      else
			remainder
		    end
		in
		  case exn of 
                    STOP
		      (state as SHELL_STATE
		         {parser_state, lexer_state, source, line_count}) =>
		      (check_eof ();
		       if lexer_state = Lexer.Token.PLAIN_STATE andalso
		          Parser.is_initial_state parser_state then
                         (rev (!topdecs), "", OK initial_state)
		       else
		         (rev (!topdecs), current_source, OK state))
                  | Info.Stop (error, error_list) =>
		      (reset_parsing_state();
		       (rev (!topdecs),
			current_source,
			ERROR (error, error_list)))
		      (* I'm not sure how to handle EOF in this case *)
                  | ShellTypes.DebuggerTrapped =>
                      (check_eof ();
		       reset_parsing_state();
		       (rev (!topdecs), current_source, DEBUGGER_TRAPPED))
                  | MLWorks.Interrupt =>
                      (check_eof ();
		       reset_parsing_state();
		       (rev (!topdecs), current_source, INTERRUPT))
                  | exn as Exit _ => raise exn
		  | exn => raise exn
    (*
                  | exn =>
                      (* Can't use regular error reporting mechanism here *)
                      (* This should print a stack backtrace also *)
                      (print("Compiler Error: Unexpected exception " ^ 
                              (MLWorks.Internal.Value.exn_name exn) ^
                              "\n");
                       check_eof ();
		       reset_parsing_state();
		       (rev (!topdecs), false, current_source, initial_state))
    *)
		end
    
            end
        end)
    in
      (do_line, do_prompt)
    end (* of shell *)
  
  end
