(* Listener using Capi interface *)
(*
 *
 *  $Log: _listener.sml,v $
 *  Revision 1.112  1999/05/12 11:11:23  daveb
 *  [Bug #190554]
 *  Type of Timer.checkCPUTimer has changed.
 *
 * Revision 1.111  1998/06/01  14:22:24  johnh
 * [Bug #30369]
 * Change type of Capi.open_file_dialog.
 *
 * Revision 1.110  1998/03/31  15:31:34  johnh
 * [Bug #30346]
 * Call Capi.getNextWindowPos().
 *
 * Revision 1.109  1998/03/26  15:51:38  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.108  1998/03/26  12:05:56  johnh
 * [Bug #50035]
 * Allow keyboard accelerators to be platform specific.
 *
 * Revision 1.107  1998/02/19  20:15:53  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.106  1998/02/18  17:02:17  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.105  1998/02/13  15:56:48  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.104  1998/01/27  14:06:16  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.103  1997/11/09  09:27:53  jont
 * [Bug #30089]
 * Remove use of MLWorks.Time.Elapsed in favour of basis timer
 *
 * Revision 1.102  1997/10/16  11:23:46  johnh
 * [Bug #30284]
 * Call SaveImage.add_with_fn to add a wrapper function which resets the reference
 * storing the listener_tool widget for the duration of the image save call.
 *
 * Revision 1.101  1997/10/09  14:46:05  johnh
 * [Bug #30193]
 * Reogranise the System Messages implementation.
 *
 * Revision 1.100  1997/10/06  10:59:02  johnh
 * [Bug #30137]
 * Create system messages window.
 *
 * Revision 1.99.2.5  1997/12/02  11:48:12  johnh
 * [Bug #30071]
 * Remove old commands from the File menu.
 *
 * Revision 1.99.2.4  1997/11/26  13:13:35  daveb
 * [Bug #30071]
 * The Shell.Error exception is no longer needed.
 *
 * Revision 1.99.2.3  1997/11/20  17:09:32  johnh
 * [Bug #30071]
 * Generalise open_file_dialog to take any masks.
 *
 * Revision 1.99.2.1  1997/09/11  20:52:29  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.99  1997/07/23  14:21:03  johnh
 * [Bug #30182]
 * Add delete handler.
 *
 * Revision 1.98  1997/06/18  08:39:40  johnh
 * [Bug #30181]
 * Tidy interrupt button code.
 *
 * Revision 1.96  1997/06/17  14:59:43  johnh
 * [Bug #30174]
 * Replace podium with Listener on Motif and create Listener on startup for Windows.
 *
 * Revision 1.95  1997/06/12  15:04:02  johnh
 * [Bug #30175]
 * Combine tools and windows menus.
 *
 * Revision 1.94  1997/06/10  14:30:54  johnh
 * [Bug #30075]
 * Allowing only one instance of tools.
 *
 * Revision 1.93  1997/06/09  15:59:42  johnh
 * [Bug #02030]
 * Fixing Usage->EditError functionality and remove the menu item for now.
 *
 * Revision 1.92  1997/05/21  15:26:59  matthew
 * [Bug #20057]
 * Add sofar string to key_function function in completion menu
 *
 * Revision 1.91  1997/05/16  15:49:17  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.90  1997/04/15  09:24:54  jont
 * [Bug #2049]
 * Make sure file location is used in error browser title where appropriate
 *
 * Revision 1.89  1997/03/21  14:40:05  matthew
 * Adding missing call to buttons_update_fun after setting evaluating.
 *
 * Revision 1.88  1997/03/21  11:33:56  matthew
 * Adding handler for Shell.Error
 *
 * Revision 1.87  1997/03/20  14:41:57  johnh
 * [Bug #1986]
 * Replacing completions rather than inserting to avoid raising
 * subscript exceptions on Motif and handle completions correctly
 * on Win32.
 *
 * Revision 1.86  1997/03/17  14:34:27  andreww
 * [Bug #1977]
 * Multi-line editing on Listener no longer works!
 *
 * Revision 1.85  1997/03/12  15:25:56  andreww
 * [Bug #1667]
 * adding mutual exclusion primitives for the listener.
 *
 * Revision 1.84  1996/11/21  15:00:14  jont
 * [Bug #1799]
 * Make more calls to Capi.Text.check_insertion
 * Use truncated string from check_insertion where necessary
 *
 * Revision 1.83  1996/11/06  11:16:15  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.82  1996/11/01  15:09:49  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.81  1996/10/31  10:17:50  johnh
 * Add interrupt button on Windows.
 *
 * Revision 1.80  1996/10/22  12:26:03  io
 * [Bug #1614]
 * remove use of Substring
 *
 * Revision 1.79  1996/10/21  15:22:30  jont
 * Remove references to basis.toplevel
 *
 * Revision 1.78  1996/08/07  12:25:23  daveb
 * [Bug #1517]
 * Bound abandon to Ctrl-G.
 *
 * Revision 1.77  1996/08/06  16:32:39  daveb
 * [Bug #1517]
 * Added functions for moving forward or backward by a character or line.
 *
 * Revision 1.76  1996/07/30  13:32:49  daveb
 * [Bug #1507]
 * Replaced existing handlers for Shell.Exit with a single one in do_evaluate.
 *
 * Revision 1.75  1996/07/30  09:05:37  daveb
 * [Bug #1299]
 * Preserved remaining source after a runtime error.
 *
 * Revision 1.74  1996/07/29  09:40:02  daveb
 * [Bug #1478]
 * Disabled Close menu item during evaluations.
 *
 * Revision 1.73  1996/07/15  13:33:32  andreww
 * propagating changes made to the GUI standard IO redirection mechanism
 * (see __pervasive_library.sml for the StandardIO structure)
 *
 * Revision 1.72  1996/07/03  13:17:44  andreww
 * Redirecting standard IO through GuiStandardIO in pervasive library.
 *
 * Revision 1.71  1996/06/25  09:53:52  daveb
 * Made button buttons have different names from menu buttons, so that
 * Windows can distinguish between them, and so let us put mnemonics on
 * the menu items but not the buttons.
 *
 * Revision 1.70  1996/06/21  11:06:19  stephenb
 * Fix #1429 - change the Load Objects dialog to use .mo instead of .sml
 *
 * Revision 1.69  1996/06/19  14:35:55  daveb
 * Bug 1356: Made file_action call MLWorks.String.ml_string, so that backslashes
 * are correctly escaped.
 *
 * Revision 1.68  1996/06/18  16:03:42  daveb
 * Added Step button.
 *
 * Revision 1.67  1996/06/17  16:36:27  nickb
 * Add profiler button and rearrange buttons.
 *
 * Revision 1.66  1996/05/31  16:11:22  daveb
 * Bug 1074: Capi.list_select now takes a function to be called on any key
 * press handled by the list widget itself.  In the listener, this pops the
 * completions widget down as if the key had been typed at the listener.
 *
 * Revision 1.65  1996/05/30  14:28:41  daveb
 * The Interrupt exception is no longer at top level.
 *
 * Revision 1.64  1996/05/29  16:48:57  daveb
 * Fixed bug with clear_all.  The prompt_pos needs to be set before the
 * contents of the text widget, or else the modification is disallowed by
 * the modication_ok function.
 *
 * Revision 1.63  1996/05/29  16:06:34  daveb
 * DebuggerWindow.make_debugger_window now returns a clean-up function to call
 * at the end of each evaluation.
 *
 * Revision 1.62  1996/05/24  15:48:34  daveb
 * The extension passed to open_file_dialog does not need a preceding * .
 *
 * Revision 1.61  1996/05/24  15:33:16  daveb
 * Removed Path menu.
 *
 * Revision 1.60  1996/05/24  13:35:36  daveb
 * Type of GuiUtils.view_option has changed.
 *
 * Revision 1.59  1996/05/24  11:09:08  daveb
 * Added "Abandon" command.
 *
 * Revision 1.58  1996/05/24  10:44:39  daveb
 * Moved Find to the Edit menu.
 *
 * Revision 1.57  1996/05/22  16:00:42  daveb
 * Added Preferences and Paths menus.
 *
 * Revision 1.56  1996/05/15  11:43:24  daveb
 * Improved behaviour of error browser when the evaluation has written some
 * output to the text widget.
 *
 * Revision 1.55  1996/05/14  16:15:25  daveb
 * Added File menu.
 *
 * Revision 1.54  1996/05/14  13:43:46  matthew
 * Handle Shell.Exit in error browser redo function
 *
 * Revision 1.53  1996/05/10  14:46:58  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.52  1996/05/09  15:42:41  daveb
 * Made copying of lines detect our current prompt better.
 *
 * Revision 1.51  1996/05/09  13:30:16  daveb
 * Evaluation of lines copied from before the prompt was broken: the copied
 * line is now appended to any existing input.
 * The buttons are disabled while the listener is reading from std_in.
 *
 * Revision 1.50  1996/05/08  14:33:35  daveb
 * The error browser now returns a quit function.  Use this to make the
 * evaluate command kill any existing error browser.
 *
 * Revision 1.49  1996/05/01  11:15:54  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.48  1996/04/30  10:07:41  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.47  1996/03/15  12:36:22  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.46  1996/03/14  12:21:06  matthew
 * Adjust prompt_pos on clearing input.
 *
 * Revision 1.45  1996/02/23  11:43:31  daveb
 * Added Clear All button.
 *
 * Revision 1.44  1996/02/23  11:26:27  daveb
 * Ensured erroneous input is added to the history if not corrected with the
 * Error Browser interface.
 *
 * Revision 1.43  1996/02/22  17:28:41  daveb
 * ErrorBrowser.create now takes a close_action field.
 *
 * Revision 1.42  1996/02/19  13:52:13  matthew
 * Fiddling with edit menu operations
 *
 * Revision 1.41  1996/02/08  11:31:49  daveb
 * Removed sensitivity field from argument to view_options.
 *
 * Revision 1.40  1996/01/25  17:26:56  matthew
 * Changing yank behaviour
 *
 * Revision 1.39  1996/01/25  14:45:29  daveb
 * Minor change to error browser interface.
 *
 * Revision 1.38  1996/01/25  12:31:30  daveb
 * Changed behaviour of Return before the end of buffer.
 *
 * Revision 1.37  1996/01/23  16:25:34  daveb
 * Corrected behaviour of clear.
 *
 * Revision 1.36  1996/01/23  15:24:52  daveb
 * Minor reorganisation of menus.
 *
 * Revision 1.35  1996/01/22  14:40:11  daveb
 * Now handles exceptions and trivial lines.
 *
 * Revision 1.34  1996/01/22  13:55:32  daveb
 * Added get_input_from_stdin function, since get_input_to_evaluate now
 * reads input from prompt_pos instead of write_pos.
 *
 * Revision 1.33  1996/01/22  10:18:37  daveb
 * Added buttons.  This involved adding the time-handler functionality, and
 * moving the history mechanism to gui_utils.  The latter change was needed
 * because the add_history function needs to know about indices (it was in
 * shell_utils, but gui_utils is more appropriate).
 *
 * Revision 1.32  1996/01/19  15:08:26  matthew
 * Changing inspector interface.
 *
 * Revision 1.31  1996/01/18  17:01:37  daveb
 * Added key binding for ^O to insert newline.  Removed yank_current_line
 * because it was never used.
 *
 * Revision 1.30  1996/01/18  15:58:18  daveb
 * The previous change caused crashes with empty lines.  Fixed it.
 *
 * Revision 1.29  1996/01/18  14:23:23  daveb
 * Added support for error browsing.
 *
 * Revision 1.28  1996/01/18  10:40:18  matthew
 * Reordering top level menus.
 *
 * Revision 1.27  1996/01/17  14:43:31  daveb
 * Added newline to end of input - otherwise a null line is treated as an EOF!
 *
 * Revision 1.26  1996/01/17  12:14:28  daveb
 * Now parses everything since the main prompt, so allowing multi-line editing.
 * Uses the revised shell interface (see interpreter/shell).
 *
 * Revision 1.25  1996/01/16  15:43:24  matthew
 * Changing uses of full_menus
 *
 * Revision 1.24  1996/01/16  13:29:35  matthew
 * Fixing problem with previous change for Windows.
 *
 * Revision 1.23  1996/01/12  16:30:35  matthew
 * Adding insertion checks for the benefit of Windows
 *
 * Revision 1.22  1996/01/09  14:03:41  matthew
 * Moved list_select to capi
 *
 * Revision 1.21  1996/01/09  12:03:00  matthew
 * Fixing problem with typing return before prompt.  This doesn't actually
 * insert anything, so should be allowed.
 *
 * Revision 1.20  1996/01/09  11:32:58  matthew
 * Adding checks on modifications before prompt.
 *
 * Revision 1.19  1995/12/07  14:34:19  matthew
 * Changing interface to edit_menu
 *
 * Revision 1.18  1995/11/22  12:30:13  matthew
 * Adding call to transfer_focus
 *
 * Revision 1.17  1995/11/17  11:24:01  matthew
 * Trying to fix completion for windows.
 *
 * Revision 1.16  1995/11/15  16:59:43  matthew
 * Adding window menu
 *
 * Revision 1.15  1995/11/13  17:10:51  matthew
 * Simplifying capi interface.
 *
 * Revision 1.14  1995/10/26  15:11:20  daveb
 * Now creates a new list widget each time that completion is asked for, so that
 * it pops up with the correct size under TWM.
 *
 * Revision 1.13  1995/10/25  12:27:53  nickb
 * Make profile tool a child of the application shell.
 *
 * Revision 1.12  1995/10/20  11:20:45  daveb
 * Renamed ShellUtils.edit_string to ShellUtils.edit_source
 * (and ShellUtils.edit_source to ShellUtils.edit_location).
 *
 * Revision 1.11  1995/10/18  13:48:05  nickb
 * Add profiler to the shelldata made here.
 *
 * Revision 1.10  1995/10/09  11:43:33  daveb
 * The search_opt field of the context menu now takes a boolean component which
 * controls whether users are given the option of which contexts to search.
 * In input tools this should be true, in the context browser it should be false.
 *
 * Revision 1.9  1995/10/05  12:50:03  daveb
 * Moved breakpoints_menu to podium.
 * Combined search menu with (slimline) context menu.
 *
 * Revision 1.8  1995/09/11  15:01:26  matthew
 * Changing top level window initialization
 *
 * Revision 1.7  1995/09/08  15:28:32  matthew
 * Adding flush_stream function to Shell.shell
 *
 * Revision 1.6  1995/08/30  13:23:43  matthew
 * Renaming layout constructors
 *
 * Revision 1.5  1995/08/25  13:27:26  matthew
 * Removing some diagnostic
 *
 * Revision 1.4  1995/08/25  11:22:14  matthew
 * Abstracting text functionality
 *
 * Revision 1.3  1995/08/10  12:16:16  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:57:59  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:35:20  matthew
 * new unit
 * New unit
 *
 *  Revision 1.103  1995/07/19  13:10:03  matthew
 *  Adding "external listener" features
 *
 *  Revision 1.102  1995/07/17  11:48:21  matthew
 *  Abstraction of text functionality
 *
 *  Revision 1.101  1995/07/14  17:24:01  io
 *  add searching capability
 *
 *  Revision 1.100  1995/07/07  15:31:47  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.99  1995/07/04  17:17:16  daveb
 *  Replaced ad-hoc handling of CTRL-D (which has stopped working)
 *  with an explicit function.
 *
 *  Revision 1.98  1995/07/04  10:41:19  matthew
 *  Stuff
 *
 *  Revision 1.97  1995/06/15  13:01:10  daveb
 *  Hid details of WINDOWING type in ml_debugger.
 *
 *  Revision 1.96  1995/06/14  13:22:54  daveb
 *  Type of Ml_Debugger.ml_debugger has changed.
 *
 *  Revision 1.95  1995/06/08  14:44:40  daveb
 *  Removed expansion of tabs.
 *
 *  Revision 1.94  1995/06/05  13:23:44  daveb
 *  Changed sensitivity argument of view_options to NO_SENSE_SELECTION,
 *  because the shell functions now set the current selection.
 *
 *  Revision 1.93  1995/06/01  10:32:23  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.92  1995/05/23  14:15:44  matthew
 *  Changing interface to list_select.
 *
 *  Revision 1.91  1995/05/23  09:26:52  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.90  1995/05/16  09:52:33  matthew
 *  Adding escape key functionality
 *
 *  Revision 1.89  1995/05/04  09:41:00  matthew
 *  Removed script from ml_debugger
 *
 *  Revision 1.88  1995/04/28  15:03:04  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.87  1995/04/19  10:57:52  daveb
 *  Changes to context_menu.
 *
 *  Revision 1.86  1995/04/13  17:45:13  daveb
 *  Xm.doInput is back to taking unit.
 *
 *  Revision 1.85  1995/04/06  15:37:17  daveb
 *  Type of Xm.doInput has changed.
 *
 *  Revision 1.84  1995/03/17  12:29:42  daveb
 *  Merged ShellTypes.get_context_name and ShellTypes.string_context_name.
 *
 *  Revision 1.83  1995/03/16  11:50:43  daveb
 *  Removed context_function from register when closing the window.
 *
 *  Revision 1.82  1995/03/15  17:42:01  daveb
 *  Changed to share current context with other tools..
 *
 *  Revision 1.81  1995/03/10  15:34:41  daveb
 *  MotifUtils.options_menu takes an extra argument.
 *
 *  Revision 1.80  1995/01/13  15:48:40  daveb
 *  Removed obsolete sharing constraint.
 *
 *  Revision 1.79  1994/09/21  16:37:13  brianm
 *  Adding value menu ...
 *
 *  Revision 1.78  1994/08/01  10:50:40  daveb
 *  Moved preferences to separate structure.
 *
 *  Revision 1.77  1994/07/27  14:05:13  daveb
 *  Cut-down menus for novices.
 *
 *  Revision 1.76  1994/07/12  15:51:20  daveb
 *  ToolData.works_menu takes different arguments.
 *
 *  Revision 1.75  1994/06/23  10:06:01  matthew
 *  Changed behaviour of Ctrl-E to go to end of input.
 *
 *  Revision 1.74  1994/06/20  17:13:57  daveb
 *  Changed context refs to user_contexts.  Filter out constant user_contexts
 *  from the selection menu.
 *
 *  Revision 1.72  1994/04/06  12:53:03  daveb
 *  Added breakpoints menu.
 *
 *  Revision 1.71  1994/03/15  11:29:14  matthew
 *  Changed Exit exn to Shell.Exit
 *  Cleaned up history mechanism so erroneous input is also recorded
 *
 *  Revision 1.70  1994/03/11  15:35:13  matthew
 *  Fixing bug with calling debugger
 *
 *  Revision 1.69  1994/02/17  15:07:38  matthew
 *  Fixed C-d
 *
 *  Revision 1.68  1994/02/02  11:57:21  daveb
 *  ActionQueue no longer has Incremental as a substructure.
 *
 *  Revision 1.67  1994/01/28  18:06:34  matthew
 *  Fixing locations in errors
 *
 *  Revision 1.66  1994/01/28  10:35:19  matthew
 *  Added support for C-a going to just after the prompt
 *
 *  Revision 1.65  1993/12/22  10:52:25  daveb
 *  Changed quit message for debugger, since it no longer raises Interrupt.
 *
 *  Revision 1.64  1993/12/01  16:37:28  matthew
 *  Added with_input_disabled to prevent commands being processed while in the debugger.
 *  A better solution should be possible.
 *
 *  Revision 1.63  1993/11/26  12:25:24  matthew
 *  Improvements to calling debugger.
 *
 *  Revision 1.62  1993/11/22  17:49:31  daveb
 *  Ml_Debugger.with_start_frame no longer needs a frame argument, removing
 *  the need for the call to MLWorks.Internal.Value.frame_call.
 *
 *  Revision 1.61  1993/11/18  12:19:09  nickh
 *  Change to instream arguments.
 *
 *  Revision 1.60  1993/10/22  17:02:58  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.59  1993/10/08  16:39:22  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.58  1993/09/13  09:16:08  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.57.1.4  1993/10/22  15:19:33  daveb
 *  Changed ToolData.works_menu to take a (unit -> bool) function that
 *  controls whether the Close menu option is enabled.
 *  Changed modify_verify to check for EOF, and changed input functions
 *  to deal with EOF.
 *
 *  Revision 1.57.1.3  1993/10/08  15:07:33  matthew
 *  Added destroy Callback to eg. quit from editor windows
 *  Uses history menu utilities
 *
 *  Revision 1.57.1.2  1993/09/10  11:14:01  daveb
 *  Added name parameter to MotifUtils.list_select.
 *
 *  Revision 1.57.1.1  1993/08/31  15:26:36  jont
 *  Fork for bug fixing
 *
 *  Revision 1.57  1993/08/31  15:26:36  matthew
 *  Force a new prompt when changing contexts.
 *
 *  Revision 1.56  1993/08/25  15:03:54  matthew
 *  Return quit function from ShellUtils.edit_string
 *
 *  Revision 1.55  1993/08/24  16:40:39  matthew
 *  >Improved editing error handling
 *
 *  Revision 1.54  1993/08/11  11:25:37  matthew
 *  Changes to user options
 *  Removed preferences menu
 *  Options update
 *
 *  Revision 1.53  1993/08/10  15:20:42  nosa
 *  tooldata passed to make_debugger_window for inspector invocation
 *  in debugger-window.
 *
 *  Revision 1.52  1993/08/10  12:22:27  matthew
 *  Get maximum history length from options
 *  Beep when no completion found
 *  Longest common prefix completion
 *  Pass stream name to Shell.shell
 *
 *  Revision 1.51  1993/08/03  11:59:41  matthew
 *  Added error editing operation
 *
 *  Revision 1.50  1993/06/02  13:07:17  daveb
 *  Removed value menu for the time being, since there's nothing on it.
 *
 *  Revision 1.49  1993/05/28  16:15:37  matthew
 *  Added tty_ok value to WINDOWING
 *
 *  Revision 1.48  1993/05/28  10:10:04  matthew
 *  Added completion
 *  Changed getline function
 *
 *  Revision 1.47  1993/05/21  16:34:44  matthew
 *  Added some very preliminary stuff for completion.
 *
 *  Revision 1.46  1993/05/18  17:29:35  jont
 *  Removed integer parameter
 *
 *  Revision 1.45  1993/05/13  14:20:58  daveb
 *  All tools now set their own titles and pass them to their options menus.
 *
 *  Revision 1.44  1993/05/11  13:34:08  daveb
 *  History no longer allows duplicate entries, nor very short entries,
 *  and is limited in length.
 *
 *  Revision 1.43  1993/05/11  12:46:14  daveb
 *  Added code to check state of meta keys.
 *
 *  Revision 1.42  1993/05/11  12:10:30  daveb
 *  Replaced creation of outstream with MotifUtils.make_outstream.
 *  Revised handling of contexts.
 *
 *  Revision 1.41  1993/05/10  16:07:42  daveb
 *  Changed type of ml_debugger.
 *
 *  Revision 1.40  1993/05/10  14:29:28  daveb
 *   Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.39  1993/05/10  11:49:39  matthew
 *  Added interrupt handler around debugger
 *  Added Ctrl-U handler and delete_current_line
 *
 *  Revision 1.38  1993/05/07  17:22:42  matthew
 *  Debugger changes
 *
 *  Revision 1.37  1993/05/06  15:11:20  matthew
 *  Simplified state_stack (now context_stack)
 *  ShellTypes revision
 *
 *  Revision 1.36  1993/05/06  11:21:52  daveb
 *  Removed inspector from values menu (It's now in the works menu).
 *  Removed old debugger code.
 *
 *  Revision 1.35  1993/05/05  12:11:04  daveb
 *  Added tools argument to works_menu(),
 *  removed exitApplication from TOOLDATA (works_menu now accesses it directly).
 *
 *  Revision 1.34  1993/05/04  16:24:34  matthew
 *  Added context selection
 *  Changed context ref handling
 *
 *  Revision 1.33  1993/05/04  12:27:20  matthew
 *  Added quit to windowing debugger.
 *  ,
 *
 *  Revision 1.32  1993/04/30  14:44:35  daveb
 *  Reorganised menus.
 *
 *  Revision 1.31  1993/04/27  15:12:43  daveb
 *  Moved options menu code to _GUI_UTILS.
 *
 *  Revision 1.30  1993/04/26  12:40:10  matthew
 *  Indentation change & removed old tracing code
 *  Removed ML_Debugger.BASE_FRAME
 *
 *  Revision 1.29  1993/04/23  15:15:05  matthew
 *  Use Xm.Text.Replace function for replacing topdecs
 *  ModifyVerify takes note of modifications before the prompt
 *  Added yank current line
 *  Changed key bindings
 *
 *  Revision 1.28  1993/04/22  13:10:16  richard
 *  The editor interface is now implemented directly through
 *  Unix system calls, and is not part of the pervasive library
 *  or the runtime system.
 *
 *  Revision 1.27  1993/04/21  14:49:46  daveb
 *  Added browse context menu item.
 *
 *  Revision 1.26  1993/04/21  13:46:57  richard
 *  Commented out old tracing stuff..
 *
 *  Revision 1.25  1993/04/20  16:10:57  matthew
 *  Added debug function do_debug control variable
 *  Removed call to strip_prompt from getline
 *  Rewrite of do_return to handle input properly
 *
 *  Revision 1.24  1993/04/16  17:35:40  daveb
 *  Added history menu.
 *
 *  Revision 1.23  1993/04/16  17:13:49  matthew
 *  *** empty log message ***
 *
 *  Revision 1.22  1993/04/15  16:06:42  matthew
 *  Changed "text" widget name to "textIO";
 *
 *  Revision 1.21  1993/04/14  11:17:11  daveb
 *  Fixed the history mechanism.
 *
 *  Revision 1.20  1993/04/13  09:54:12  matthew
 *  Changed interface to file selection
 *
 *  Revision 1.19  1993/04/08  12:11:31  jont
 *  Added editor options menu and Editor menu
 *
 *  Revision 1.18  1993/04/08  08:36:11  daveb
 *  Fixed input to work with recent changes.  Added working lookahead.
 *  Reinstated change to location of user_options, which I accidentally erased
 *  in the previous revision.
 *
 *  Revision 1.17  1993/04/07  13:40:06  daveb
 *  Added a first stab at a history mechanism.  Buggy.  Lots of support work
 *  needed to get this far, so from here on it's plain sailing
 *
 *  Revision 1.16  1993/04/06  10:10:39  jont
 *  Moved user_options and version from interpreter to main
 *  Added menu stuff for compatibility options
 *
 *  Revision 1.15  1993/04/05  10:55:13  matthew
 *  Changed ordof and MLWorks.String.ordof to MLWorks.String.ordof
 *  Changed interface to inspector tool
 *
 *  Revision 1.14  1993/04/02  15:15:30  matthew
 *  Structure changes
 *  Added File Selection tool
 *
 *  Revision 1.13  1993/03/31  13:52:25  matthew
 *  Added Options menus
 *
 *  Revision 1.12  1993/03/30  11:39:23  matthew
 *  Added state stack and push and pop operations thereon
 *
 *  Revision 1.10  1993/03/24  10:14:03  matthew
 *  Menu modifications
 *  Most of this is test code.
 *
 *  Revision 1.9  1993/03/18  18:08:55  matthew
 *  Added create_new_listener function
 *  Added output_fn field to shell_data
 *
 *  Revision 1.8  1993/03/18  09:56:56  matthew
 *  Add newline when using earlier line
 *
 *  Revision 1.7  1993/03/17  16:18:38  matthew
 *  Used Menus utilities to make menubar menus
 *
 *  Revision 1.6  1993/03/15  17:13:35  matthew
 *  Simplified ShellTypes types
 *
 *  Revision 1.5  1993/03/15  14:34:51  daveb
 *  Fixed problems with prompt and resizing.
 *
 *  Revision 1.4  1993/03/12  11:42:44  matthew
 *  Changed interface to shell.
 *  Haven't tested this
 *
 *  Revision 1.3  1993/03/09  15:57:55  matthew
 *  Options & Info changes
 *  Changes for ShellData type
 *
 *  Revision 1.2  1993/03/04  16:40:19  daveb
 *  Replaced mainWindow/text combination with rowColumn/scrolledText.
 *  Scrolling now works properly.
 *
 *  Revision 1.1  1993/03/02  19:18:28  daveb
 *  Initial revision
 *
 *
 *  Copyright (c) 1993 Harlequin Ltd.
 *
 *)

(* Basis *)
require "^.basis.__int";
require "^.basis.__string";
require "^.basis.__timer";
require "^.basis.__text_io";
require "^.system.__time";

(* Utilities *)
require "^.utils.lists";
require "^.utils.crash";
require "^.utils.mutex";
require "^.utils.__terminal";

(* GUI stuff *)
require "capi";
require "menus";
require "gui_utils";
require "tooldata";
require "debugger_window";
require "inspector_tool";
require "profile_tool";
require "error_browser";

(* Environment *)
require "^.main.preferences";
require "^.main.user_options";

(* Compiler *)
require "^.interpreter.shell";
require "^.interpreter.shell_utils";
require "^.interpreter.tty_listener";
require "^.interpreter.save_image";
require "^.debugger.ml_debugger";
require "^.debugger.newtrace";

require "listener";

(* WARNING: Don't use std_out for error tracing when debugging this file.
 Usually you should use MLWorks.IO.terminal_out instead. *)

functor Listener (
  structure Lists: LISTS
  structure Crash : CRASH
  structure Capi: CAPI

  structure Preferences : PREFERENCES
  structure UserOptions : USER_OPTIONS

  structure Shell: SHELL
  structure ShellUtils : SHELL_UTILS
  structure TTYListener : TTY_LISTENER
  structure Ml_Debugger: ML_DEBUGGER
  structure Trace : TRACE
  structure ToolData : TOOL_DATA
  structure GuiUtils : GUI_UTILS
  structure Menus : MENUS
  structure DebuggerWindow : DEBUGGERWINDOW
  structure InspectorTool : INSPECTORTOOL
  structure ProfileTool : PROFILE_TOOL
  structure ErrorBrowser: ERROR_BROWSER
  structure Mutex : MUTEX
  structure SaveImage : SAVE_IMAGE
  
  sharing UserOptions.Options = Ml_Debugger.ValuePrinter.Options =
          ShellUtils.Options = ToolData.ShellTypes.Options
  sharing Shell.Info = ShellUtils.Info

  sharing type ToolData.ShellTypes.user_options = UserOptions.user_tool_options =
               GuiUtils.user_tool_options = ShellUtils.UserOptions
  sharing type GuiUtils.user_context_options =
               ToolData.UserContext.user_context_options
  sharing type GuiUtils.user_context = ToolData.ShellTypes.user_context
  sharing type Shell.Context = ShellUtils.Context = ToolData.ShellTypes.Context
  sharing type Shell.ShellData = ToolData.ShellTypes.ShellData
  sharing type Menus.Widget = DebuggerWindow.Widget = ToolData.Widget = GuiUtils.Widget = 
               Capi.Widget = ProfileTool.Widget = ErrorBrowser.Widget = InspectorTool.Widget
  sharing type TTYListener.ListenerArgs = ToolData.ShellTypes.ListenerArgs
  sharing type ErrorBrowser.location = ShellUtils.Info.Location.T
  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec
  sharing type ToolData.ToolData = DebuggerWindow.ToolData = 
               InspectorTool.ToolData = ProfileTool.ToolData = ErrorBrowser.ToolData
  sharing type Preferences.preferences = ToolData.ShellTypes.preferences =
               Ml_Debugger.preferences = ShellUtils.preferences
  sharing type ShellUtils.user_context = GuiUtils.user_context = 
               ProfileTool.user_context = ErrorBrowser.user_context
  sharing type ShellUtils.Type = GuiUtils.Type = InspectorTool.Type
  sharing type Preferences.user_preferences = ShellUtils.user_preferences =
               ToolData.ShellTypes.user_preferences = GuiUtils.user_preferences =
               ProfileTool.user_preferences
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
  sharing type Ml_Debugger.debugger_window = DebuggerWindow.debugger_window
  sharing type ErrorBrowser.error = Shell.Info.error
): LISTENER =

  struct
    structure Info = ShellUtils.Info
    structure Location = Info.Location
    structure Options = ShellUtils.Options
    structure ShellTypes = ToolData.ShellTypes
    structure UserContext = ToolData.UserContext
      
    type ToolData = ToolData.ToolData

    val do_debug = false
    fun debug s = if do_debug then Terminal.output(s ^ "\n") else ()
    fun fdebug f = if do_debug then Terminal.output(f() ^ "\n") else ()
    fun ddebug s = Terminal.output(s ^ "\n")

    fun make_debugger_function (debugger_type,user_options,user_preferences,local_context) f x =
      Ml_Debugger.with_start_frame
      (fn base_frame =>
       (f x)
       handle
       exn as ShellTypes.DebuggerTrapped => raise exn
     |  exn as Shell.Exit _ => raise exn
     |  exn as MLWorks.Interrupt => raise exn
     |  exn as Info.Stop _ => raise exn
     |  exn as Capi.SubLoopTerminated => raise exn
     |  exn =>
	  (Ml_Debugger.ml_debugger
	   (debugger_type,
	    ShellTypes.new_options
	    (user_options,
	     GuiUtils.get_user_context (!local_context)),
	    Preferences.new_preferences user_preferences)
	   (base_frame,
	    Ml_Debugger.EXCEPTION exn,
	    Ml_Debugger.POSSIBLE
	    ("quit (return to listener)",
	     Ml_Debugger.DO_RAISE ShellTypes.DebuggerTrapped),
	    Ml_Debugger.NOT_POSSIBLE);
	   raise ShellTypes.DebuggerTrapped))
      
    (* Some dull utilities *)
      
    val prompt = "MLWorks>"
    val prompt_len = size prompt
      
    fun strip_prompt (s:string):string =
      if String.isPrefix prompt s then
	String.extract (s, prompt_len, NONE)
      else
	s
	
    exception NoLocation
    fun get_location line =
      let
	val sz = size line
	fun aux index =
	  if index < sz
	    then
	      if String.sub (line,index) = #":" then
		index+1
	      else
		aux (index+1)
	  else
	    raise NoLocation
	(* skip up to second ":" *)
	val result = SOME (substring (line,0,(aux (aux 0))-1))
	handle NoLocation => NONE
      in
	result
      end
    
      (*
       * the mutex is used to control access to all the I/O fns
       * so that position information isn't corrupted between
       * thread switches.
       *
       * See <URI:spring://ML_Notebook/Design/GUI/Mutexes>.
       *
       * inputBuffer is used to store input when concurrent output
       * interleaves with multi-line input.  anyOutput records
       * whether any concurrent output has been printed during the
       * current multi-line input, and anyRecentOutput records
       * whether or not any output occurred since the last line.
       *
       * see <URI:spring://ML_Notebook/Design/GUI/Mutexes#
       *                                   input-over-several-lines>
       *)
    val inputBuffer = ref ""
    val anyOutput = ref false
    val anyRecentOutput = ref false

    local
      val mutex = Mutex.newBinaryMutex false
      val claimant = ref NONE
      val numClaims = ref 0
    in
      fun claimWindow () =
        let
          val me = MLWorks.Threads.Internal.id()
          val notClaimed = case !claimant
                             of (SOME id) => id<>me
                              | NONE => true
        in
          if notClaimed then (Mutex.wait [mutex]; 
                              claimant:=(SOME me);
                              numClaims:=1)
          else numClaims:=(!numClaims+1)
        end

      fun releaseWindow () =
        (numClaims:= !numClaims-1;
         if !numClaims=0 then (claimant:=NONE;
                               Mutex.signal [mutex])
         else ())

      fun lockWindow f a =
             (claimWindow ();              
             (f a)
              before (releaseWindow())
             )
             handle e => (releaseWindow(); raise e)
    end



    (* TEXT UTILITIES *)
      
    (* Most change functions should check that the change is allowable -- only motif *)
    (* will do this automatically *)
      
    fun get_current_line text =
       let
         val pos = Capi.Text.get_insertion_position text
       in
         Capi.Text.get_line (text, pos)
       end
    
    fun get_current_subline (text,start_pos) =
      let
	val (line,ix) = Capi.Text.get_line_and_index (text,start_pos)
	val line2 = strip_prompt line
	val ix2 = ix - (size line - size line2)
      in
	if ix2 > 0 then substring (* could raise Substring *) (line2,0,ix2) else ""
      end
    
    val (input_flag,input_string) = (ref false,ref "")
      
    val text_size = Capi.Text.text_size

    fun replace_current_input ((text,prompt_pos,write_pos),line) =
      if !input_flag then
	()
      else
	let
	  val length = Capi.Text.get_last_position text
	  val line = Capi.Text.check_insertion(text, line, !prompt_pos, [write_pos,prompt_pos])
	in
	  (* Capi.Text.replace doesn't always work properly for X, but
	   setting the whole string causes ridiculous amounts of flicker. *)
	  Capi.Text.replace (text,!prompt_pos,length,line);
	  Capi.Text.set_insertion_position
	  (text, !prompt_pos + text_size line)
	end
      
    fun start_of_line (text,prompt_pos,write_pos) () =
      let
	val ppos = !prompt_pos
	val pos = Capi.Text.get_insertion_position text
	val new_pos =
	  if pos < ppos
	    then Capi.Text.current_line (text,pos)
	  else ppos
      in
	Capi.Text.set_insertion_position (text,new_pos)
      end
    
    fun end_of_line (text,prompt_pos,write_pos) () =
      let
	val ppos = !prompt_pos
	val pos = Capi.Text.get_insertion_position text
	val new_pos =
	  if pos < ppos
	    then Capi.Text.end_line (text,pos)
	  else Capi.Text.get_last_position text
      in
	Capi.Text.set_insertion_position (text,new_pos)
      end
    
    fun forward_char (text,prompt_pos,write_pos) () =
      let
	val pos = Capi.Text.get_insertion_position text
	val last_pos = Capi.Text.get_last_position text
	val end_line = Capi.Text.end_line (text, pos)
	  
	val new_pos =
	  if pos = last_pos orelse pos = last_pos - 1 then
	    last_pos
	  else if pos = end_line - 1 then
	    (* This case handles Windows \r\n. *)
	    pos + size Capi.terminator
	       else
		 pos + 1
      in
	Capi.Text.set_insertion_position (text, new_pos)
      end
    
    fun backward_char (text,prompt_pos,write_pos) () =
      let
	val pos = Capi.Text.get_insertion_position text
	val end_line = Capi.Text.end_line (text, pos)
	val last_pos = Capi.Text.get_last_position text
	val term_size = size Capi.terminator
	  
	val new_pos =
	  if pos = 0 then
	    0
	  else if pos = last_pos then
	    if Capi.Text.substring (text, last_pos - term_size, term_size) =
	      Capi.terminator then
	      pos - term_size
	    else
	      pos - 1
	       else if pos = end_line then
		 (* This case handles Windows \r\n. *)
		 pos - term_size
		    else
		      pos - 1
      in
	Capi.Text.set_insertion_position (text, new_pos)
      end
    
    fun previous_line (text,prompt_pos,write_pos) () =
      let
	val pos = Capi.Text.get_insertion_position text
	val start_line = Capi.Text.current_line (text, pos)
	val end_line = Capi.Text.end_line (text, pos)
	  
	val column =
	  if pos = start_line then
	    0
	  else if pos = end_line then
	    (* This case handles Windows \r\n. *)
	    pos - start_line - (size Capi.terminator - 1)
	       else
		 pos - start_line
		 
	val prev_line =
	  if start_line = 0 then
	    0
	  else
	    Capi.Text.current_line (text, start_line - 1)
	    
	val length_prev_line = start_line - prev_line
	  
	(* If this is the first line, leave the insertion position
	 as it is.  This is Windows semantics, not Motif. *)
	val new_pos =
	  if start_line = 0 then
	    pos
	  else if column > length_prev_line then
	    start_line - 1
	       else
		 prev_line + column
      in
	Capi.Text.set_insertion_position (text, new_pos)
      end
    
    fun next_line (text,prompt_pos,write_pos) () =
      let
	val pos = Capi.Text.get_insertion_position text
	val start_line = Capi.Text.current_line (text, pos)
	val end_line = Capi.Text.end_line (text, pos)
	  
	val column =
	  if pos = end_line then
	    (* This case handles Windows \r\n. *)
	    pos - start_line - (size Capi.terminator - 1)
	  else
	    pos - start_line
	    
	val last_pos = Capi.Text.get_last_position text
	  
	val end_next_line =
	  if last_pos = end_line then
	    last_pos
	  else
	    Capi.Text.end_line (text, end_line + 1)
	    
	val length_next_line = end_next_line - end_line
	  
	(* If this is the last line, leave the insertion position
	 as it is.  This is Windows semantics, not Motif. *)
	val new_pos =
	  if last_pos = end_line then
	    pos
	  else if column >= length_next_line then
	    end_next_line
	       else
		 end_line + column + 1
      in
	Capi.Text.set_insertion_position (text, new_pos)
      end
    



    (* get_current_input gets the text between the start_position
       and the end of the buffer.  When the input is for evaluation,
       start_pos should be !prompt_pos.  When the input is to be
       passed to std_in, start_pos should be !write_pos.
     *)
    fun get_current_input (text, start_pos, write_pos) =
      let
	val last_pos = Capi.Text.get_last_position text

	val input =
	  Capi.Text.substring (text, start_pos, last_pos - start_pos)
      in
	if size input = 0 orelse
	  String.sub (input, size input - 1) <> #"\n" then
	  (debug ("Inserting return at " ^ Int.toString last_pos);
	   (* This is always after the prompt *)
	   Capi.Text.insert (text, last_pos, "\n");
	   write_pos := last_pos + text_size "\n";
	   Capi.Text.set_insertion_position
	   (text, last_pos + text_size "\n");
	   input ^ "\n")
	else
	  (write_pos := last_pos;
	   input)
      end
    



    (* get_input_line gets input to evaluate or to pass to stdin, as
     appropriate.  In the former case, start_pos should be !prompt_pos;
         in the latter case, start_pos should be !write_pos.
       *)
    fun get_input_line (text, start_pos, write_pos) =
       let
         val last_pos = Capi.Text.get_last_position text
         val current_pos = Capi.Text.get_insertion_position text
       in
         if current_pos < start_pos then
           let
             val line =
               strip_prompt (Capi.Text.get_line (text, current_pos)) ^ "\n"
           in
             (* last_pos always after the prompt *)
             Capi.Text.insert(text, last_pos, line);
             write_pos := last_pos + text_size line;
             Capi.Text.set_insertion_position
             (text, last_pos + text_size line);
             line
           end
         else (* current_pos >= start_pos *)
           get_current_input (text, start_pos, write_pos)
       end
    
    (* END TEXT UTILITIES *)
  
    val listener_tool = ref NONE
    val sizeRef = ref NONE
    val posRef = ref NONE

    (*
     * create_listener: the podiumExists boolean here indicates whether MLWorks 
     * has a podium (true on Windows, false on Unix), so that we know whether 
     * to create an interrupt button on the Listener.
     *)    
    fun create_listener podiumExists
      (tooldata as ToolData.TOOLDATA
       {args,appdata,current_context,motif_context,tools}) =
      let
	val ShellTypes.LISTENER_ARGS {user_options,
				      user_preferences,
				      prompter,
				      mk_xinterface_fn,
				      ...} = args
	  
	val ToolData.APPLICATIONDATA {applicationShell,...} = appdata
	  
	val full_menus =
	  case user_preferences
	    of Preferences.USER_PREFERENCES ({full_menus, ...}, _) =>
	      !full_menus
	      
	val title = "Listener"
	
	val location_title = "<"^title^">"
	  
	(*** Make the windows ***)
	val (shell,mainWindow,menuBar,contextLabel) = 
	  if podiumExists then 
	    Capi.make_main_window 
	       {name = "listener",
		title = title,
		parent = applicationShell,
		contextLabel = full_menus, 
		winMenu = false,
		pos = getOpt(!posRef, Capi.getNextWindowPos())}
	  else 
	    let 
	      val (mainWindow, menuBar, contextLabel) = 
		Capi.make_main_subwindows (applicationShell, full_menus)
	    in
	      Capi.reveal mainWindow;
	      (applicationShell, mainWindow, menuBar, contextLabel)
	    end

	val buttonPane =
	  Capi.make_managed_widget ("buttonPane", Capi.RowColumn, mainWindow, []);
	  
	(*** IO Functions ***)
	  
	fun beep () = Capi.beep shell
	fun message_fun s = Capi.send_message (shell,s)
	  
	val local_context = ref motif_context
	  
	(*** Debugger Functions ***)
	  
	(* This creates the debugger window when the listener is being created *)
	(* Strange things happen if done at debugger entry time *)
	val (run_debugger, clean_debugger) =
	  DebuggerWindow.make_debugger_window
	  (shell, title ^ " Debugger", tooldata)
	  
	val debugger_type =
	  Ml_Debugger.WINDOWING
	  (run_debugger,
	   print,
	   true)
	  
	val debugger_function =
	  make_debugger_function
	  (debugger_type,user_options,user_preferences,local_context)
	  
	fun get_current_user_context () =
	  GuiUtils.get_user_context (!local_context)
	  
	fun get_user_context_options () =
	  ToolData.UserContext.get_user_options (get_current_user_context ())

	(* Options and contexts *)
	fun get_user_options () = user_options

	(* Note that val shell_data depends on val profiler which depends on 
	 * mk_tooldata which depends on mk_listener_args below *)
	fun mk_listener_args () =     
	  ShellTypes.LISTENER_ARGS
          {user_context = GuiUtils.get_user_context (!local_context),
           user_options = UserOptions.copy_user_tool_options user_options,
           user_preferences = user_preferences,
           prompter = prompter,
           mk_xinterface_fn = mk_xinterface_fn}


	fun mk_tooldata () = 
	  ToolData.TOOLDATA {args = mk_listener_args(),
			     appdata = appdata,
			     current_context = current_context,
			     motif_context = !local_context,
			     tools = tools}

	(* Profiler functions and values *)
	  
	val profiler =
	  ProfileTool.create (applicationShell, user_preferences, 
			      mk_tooldata, get_current_user_context)

	val time_space_profile_manner =
	  MLWorks.Profile.make_manner
	  {time = true,
	   space = true,
	   calls = false,
	   copies = false,
	   depth = 0,
	   breakdown = []}
	  
	val time_space_profile_options =
	  MLWorks.Profile.Options {scan = 10,
				   selector = fn _ => time_space_profile_manner}

	(* This is a really dirty hack *)
	  
	val profiling = ref false
	  
	fun profile f a =
	  let
	    val (r,p) =
	      MLWorks.Profile.profile time_space_profile_options f a
	  in
	    (profiler p;
	     case r of
	       MLWorks.Profile.Result r => r
	     | MLWorks.Profile.Exception e => raise e)
	  end
	
	fun profiling_debugger_function f a =
	  if (!profiling) then
	    debugger_function (profile f) a
	  else
	    debugger_function f a
	  
	val shell_data =
	  ShellTypes.SHELL_DATA
	  {get_user_context =
	   fn () => GuiUtils.get_user_context (!local_context),
	   user_options = user_options,
	   user_preferences = user_preferences,
	   prompter = prompter,
	   debugger = profiling_debugger_function,
	   profiler = profiler,
	   exit_fn = fn n => raise Shell.Exit n,
	   x_running = true,	(* Can't start X interface from an X listener *)
	   mk_xinterface_fn = mk_xinterface_fn,
	   (* for starting X from a saved image *)
	   mk_tty_listener = TTYListener.listener
	   (* for starting saved images *)
	   }

	val quit_funs = ref [fn () => listener_tool := NONE]
	  
	fun do_quit_funs _ = Lists.iterate (fn f => f ()) (!quit_funs)
	  
	(* Text stuff *)
	val (scroll,text) = (Capi.make_scrolled_text ("textIO",mainWindow,[]))
	  
	val interrupt_button = 
	  if podiumExists then 
	    NONE
	  else 
	    let 
	      val i = Capi.make_managed_widget("interruptButton", Capi.Button, mainWindow, [])

	    in
	      Capi.Callback.add (i, Capi.Callback.Activate, fn _ => Capi.set_focus text);
	      SOME i
	    end

	val _ = Capi.transfer_focus (mainWindow,text)

	(* write_pos is the position new input should go in the buffer, usually
	 the end.  Also used as the position from which standard input is read.
         Output from the program should go before this position.  Input is read
         from after it.
	 prompt_pos is the position just after the most recent prompt.
	 The current compiler input lies between prompt_pos and get_last_pos
	 text. 
         *)
	  
	val write_pos = ref 0
	val prompt_pos = ref 0

	fun modification_ok pos =
	  (fdebug (fn () => "modification_ok: pos = " ^ Int.toString pos ^
		   ", prompt_pos = " ^ Int.toString (!prompt_pos));
	   not Capi.Text.read_only_before_prompt orelse pos >= !prompt_pos)
	  
	fun modification_at_current_ok () =
	  modification_ok
	  (Capi.Text.get_insertion_position text
	   - size (Capi.Text.get_selection text))
	  
	val text_info = (text,prompt_pos,write_pos)
	  
	fun insert_at_current s =
	  if modification_at_current_ok ()
	    then Capi.Text.insert (text, Capi.Text.get_insertion_position text, s)
	  else beep ()
	    
	val buttons_update_fn_ref = ref (fn () => ())
	fun buttons_update_fn () = (!buttons_update_fn_ref) ()
	  
	local
	  (* Insert at the current write_pos *)
	  fun insert_text str =
	    (* write_pos always after prompt_pos, so no check *)
	    let
	      val str = Capi.Text.check_insertion 
                           (text,str,!write_pos,[write_pos,prompt_pos])
	      val old_pos = !write_pos
	      val new_pos = old_pos + text_size str;
	    in
	      Capi.Text.insert (text, old_pos, str);
	      (* on motif, insert can call modifyVerify, which can diddle 
               * with write_pos so we need to only update it here
               *)
	      write_pos := new_pos;
	      Capi.Text.set_insertion_position (text, new_pos)
	    end
	  
	  val inbuff as (posref,strref) = (ref 0,ref "")
	    
	  fun input_fun () =
	    (input_flag := true;
	     buttons_update_fn ();
	     Capi.event_loop input_flag;
	     !input_string)
	    
	  fun refill_buff () =
	    let val new_string = input_fun ()
	    in
	      posref := 0;
	      strref := new_string
	    end
	  
	  val eof_flag = ref false
	    
	  fun get_input n =
	    let
	      val string = !strref
	      val pointer = !posref
	      val len = size string
	    in
	      if !eof_flag then
	""
	      else if pointer + n > len then
		(refill_buff ();
		 substring (* could raise Substring *) (string,pointer,len-pointer) ^
		 get_input (n - len + pointer))
		   else
		     let val result = substring (* could raise Substring *) (string,pointer,n)
		     in
		       posref := (!posref + n);
		       result
		     end
	    end
	  
	  fun do_lookahead () =
	    (if !eof_flag then
	       ""
	     else if !posref >= size (!strref) then
	       (refill_buff ();
		do_lookahead ())
		  else
		    substring (* could raise Substring *) (!strref, !posref, 1))
	       
	  fun close_in () = eof_flag := true
	  fun closed_in () = !eof_flag
	  fun clear_eof () = eof_flag := false
	    
            (* Note: all I/O must be controlled by the listener mutex
             * to overcome problems with thread interference.  See
             * <URI:spring://ML_Notebook/Design/GUI/Mutexes>.
             * This also explains the role of anyOutput.
             *)

	  val thisWindow = {output={descriptor=NONE,
				    put=
                                    lockWindow
                                       (fn {buf,i,sz} =>
                                        let val els = case sz of
                                          NONE=>size buf-i
                                        | (SOME s)=> s
                                        in insert_text (substring (buf,i,els));
                                           anyRecentOutput:=true;
                                          els
                                        end),
                                  get_pos=NONE,
                                  set_pos=NONE,
                                  can_output=NONE,
                                  close = fn()=>()},
	    error ={descriptor=NONE,
		    put=lockWindow
                      (fn {buf,i,sz} =>
                       let val els = case sz of
                         NONE=>size buf-i
                       | (SOME s)=> s
                       in insert_text (substring (buf,i,els));
                          anyRecentOutput:=true;
                         els
                       end),
		    
		  get_pos=NONE,
		  set_pos=NONE,
		  can_output=NONE,
		  close=fn()=>()},
	    input ={descriptor=NONE,
		    get= lockWindow (fn _ => input_fun()),
		    get_pos=SOME(lockWindow (fn()=> !posref)),
		    set_pos=SOME(lockWindow (fn i=>posref:=i)),
		    can_input=SOME(lockWindow (fn()=>
                                                  (!posref<size (!strref)))),
		    close=lockWindow(close_in)}
            ,
            (* The access field is used solely to provide a hook for the
             * pervasive library fn Threads.Internal.Preemption.stop,
             * so that this fun can actually claim the window before it
             * shuts down preemption.  See
             * <URI:spring://ML_Notebook/Design/GUI/Mutexes>.
             *)
            access = fn f => lockWindow f ()}
	    
	(*NB, in the above, perhaps #input#get shouldn't ignore
	 its argument...?  *)
	    
	in
	  fun inThisWindow () =
	    MLWorks.Internal.StandardIO.redirectIO thisWindow
	    
	  val outstream = GuiUtils.make_outstream (lockWindow insert_text)
	    
          val clear_input = lockWindow (fn ()=>
             (debug "Clearing input";
              posref := 0;
              strref := "";
              eof_flag := false))
	    
(*
	  val instream =
	    MLWorks.IO.instream {input = lockWindow get_input,
				 lookahead = lockWindow do_lookahead,
				 end_of_stream = lockWindow
				 (fn () => do_lookahead () = ""),
				 clear_eof = lockWindow clear_eof,
				 close_in = lockWindow close_in,
				 closed_in = lockWindow closed_in}
*)	    
	end
      
	fun delete_current_line text_info _ =
	  if modification_at_current_ok () then
	    replace_current_input (text_info,"")
	  else
	    beep ()
	    
	fun eof_or_delete (text,prompt_pos,write_pos) () =
	  let
	    val pos = Capi.Text.get_insertion_position text
	    val last_pos = Capi.Text.get_last_position text
	  in
	    if pos = last_pos andalso pos = !write_pos then
	      (debug "eof";
	       if !input_flag then
		 ((*MLWorks.IO.close_in instream;*)
		  buttons_update_fn ();
		  input_flag := false)
	       else
		 beep ())
	    else
	      if modification_ok pos then
		Capi.Text.replace (text, pos, pos + 1, "")
	      else beep ()
	  end
	
	(* Although edit_error and edit_error_sens are not used at the moment, 
	 * they should be kept as they may be introduced in future to support
	 * a menu item. 
	 *)
	fun edit_error _ =
	  (let
	     (* Get a location string from the current line *)
	     val line = get_current_line text
	     val locstring = 
	       let val lstring = get_location line
	       in 
		 (* NoLocation exception should never be raised here - if so,
		  * either the edit_error_sens function is not working or it 
		  * has not been applied to the menu item.
		  *)
		 if isSome lstring then valOf lstring 
		 else raise NoLocation
	       end
	     val quit_fun =
	       ShellUtils.edit_source
	       (locstring, ShellTypes.get_current_preferences shell_data)
	   in
	     quit_funs := quit_fun :: (!quit_funs)
	   end
	 handle ShellUtils.EditFailed s => message_fun ("Edit failed: " ^ s)
	      | NoLocation => message_fun "Edit failed: no location info found"
	      | Location.InvalidLocation => message_fun "Edit failed: no location info found")

	(* This function should be used as the sensitivity function of the 
         * Listener->EditError menu option if this menu item is to be brought
	 * back again. 
	 *)
	fun edit_error_sens _ = isSome (get_location (get_current_line text))
	     
	(* SYMBOL COMPLETION *)
	(* Necessary for popping down completion window *)
	local
	  val actions_after_input = ref []
	in
	  fun after_input _ =
	    (Lists.iterate (fn f => f ()) (!actions_after_input);
	     actions_after_input := [])
	  fun add_after_input_action action =
	    actions_after_input := action :: !actions_after_input
	end
      
	(* name completion *)
	fun do_completion start_pos =
	  let
	    (* The current line up to pos *)
	    val subline = get_current_subline (text,start_pos)
	    val use_completion_menu =
	      let
		val preferences = ShellTypes.get_current_preferences shell_data
		val Preferences.PREFERENCES
		  {environment_options =
		   Preferences.ENVIRONMENT_OPTIONS {completion_menu,...},
		   ...} =
		  preferences
	      in
		!completion_menu
	      end
	    val options = ShellTypes.get_current_options shell_data
	    val (sofar,completions) =
	      ShellUtils.get_completions
	      (subline, options,
	       UserContext.get_context
	       (GuiUtils.get_user_context (!local_context)))
	      
	    (* Completions are replaced here because on Win32 if the user used single
	     * slashes to separate directory names the completion of the filename was 
	     * out of synch and completions resulting in filenames which did not exist.
	     * On Motif, replacing is necessary to avoid the case that the user types 
	     * more than one slash at the end of a directory name in which case a value
	     * passed to subscript (no longer used here) was negative, resulting in 
	     * raising an exception.  The behaviour is now to remove the extra slash
	     * if one exists (this is done by replacing with a greater length of text) *) 
	    fun replace_at(pos,str) =
	      if modification_ok pos then
		let
		  val npos = pos - size sofar
		in
		  if ((size sofar) > (size str)) then 
		    (Capi.Text.replace (text, npos, npos + size sofar, str);
		     Capi.Text.set_insertion_position (text, npos + size sofar))
		  else
		    (Capi.Text.replace (text, npos, npos + size str, str);
		     Capi.Text.set_insertion_position (text, npos + size str))
		end
	      else
		beep ()
		
	    fun replace_fun a = replace_at (start_pos, a)

	  in
	    case completions of
	      [] => beep ()
	    | [a] => replace_fun a
	    | l =>
		let val c = ShellUtils.find_common_completion l
		in
		  if c = sofar then
		    if (use_completion_menu) then
		      let
			val popdown =
			  Capi.list_select
                          (shell, "completions",
			   fn c => replace_at (start_pos, sofar ^ c))
                          (l,replace_fun, fn x => x)
		      in
			Capi.set_focus text;
			add_after_input_action popdown
		      end
		    else beep ()
		  else replace_fun c
		end
	  end
	
	val replace_current_input = fn s => replace_current_input (text_info,s)
	  
	fun get_input_from_stdin () =
	  get_input_line (text, !write_pos, write_pos)
	  
	(* get_input_to_evaluate first calls get_input_line; if the cursor
	 is before the prompt, this copies the current line to the end of
	 the buffer.  Then it calls get_current_input, which returns all
	 the text between the prompt and the end of the buffer.
	 *)

	fun get_input_to_evaluate () =
          (ignore(get_input_line (text, !prompt_pos, write_pos));
           get_current_input (text, !prompt_pos, write_pos))


	val input_disabled = ref false
	  
	fun with_input_disabled f =
	  (input_disabled := true;
	   let
	     val result = f () handle exn => (input_disabled := false;raise exn)
	   in
	     input_disabled := false;
	     result
	   end)
	  
	val flush_rest = ref false
	(* This function is called if a syntax error is detected in the input *)
	fun flush_stream () = flush_rest := true
	  
	fun get_preferences () = ShellTypes.get_current_preferences shell_data
	  
	fun use_error_browser () =
	  case get_preferences ()
	    of Preferences.PREFERENCES
	      {environment_options =
	       Preferences.ENVIRONMENT_OPTIONS {use_error_browser, ...},
	       ...} =>
	      !use_error_browser
	      
	val (handler'', make_prompt) =
	  Shell.shell (shell_data,location_title,flush_stream)
	  
	(* If using the error browser, we don't want the errors to be printed. *)
	fun handler' s =
	  if use_error_browser () then
	    let
	      (* output warnings to std_out *)
	      fun report_warnings (error as Info.ERROR (severity,location,_)) =
		if severity = Info.WARNING orelse Info.< (severity, Info.WARNING)
		  then TextIO.output (outstream, Info.string_error error ^ "\n")
		else ()
	    in
	      Info.with_report_fun
	      (Info.make_default_options ())
	      report_warnings
	      handler''
	      s
	    end
	  else
	    handler'' (Info.make_default_options ()) s
	    
	fun handler s =
	  (inThisWindow();                 (*redirects PrimIO stdIO to gui*)
	   (Capi.with_window_updates 	
	    (fn () =>
	     (with_input_disabled
	       (fn () =>
		Ml_Debugger.with_debugger_type
		debugger_type
		(fn _ =>
		 ShellTypes.with_toplevel_name location_title
		 (fn _ => handler' s)))))))
	  
	fun time_handler x =
	  let
	    val (start_cpu, start_real) =
	      (Timer.startCPUTimer(), Timer.startRealTimer())
	      
	    fun times_to_string(real_elapsed, {usr, sys}, gc) =
	      concat [Time.toString real_elapsed,
		      " (user: ",
		      Time.toString usr,
		      "(gc: ",
		      Time.toString gc,
		      "), system: ",
		      Time.toString sys,
		      ")"]
	    fun print_time () =
	      let
		val time =
		  (Timer.checkRealTimer start_real,
		   Timer.checkCPUTimer start_cpu,
		   Timer.checkGCTime start_cpu)
	      in
		TextIO.output (outstream, times_to_string time ^ "\n");
		TextIO.flushOut outstream
	      end
	    
	    val result =
	      handler x
	      handle
              exn => (print_time (); raise exn)
	  in
	    case result
	      of ([], _, Shell.OK _) => ()  (* Ignore uncompleted phrases *)
	    |  _ => print_time ();
		 result
	  end
	
	fun output_prompt () =
          (claimWindow();
           anyOutput:=false;
           anyRecentOutput:=false;
           TextIO.output
	   (outstream, make_prompt ("MLWorks", Shell.initial_state));
	   TextIO.flushOut outstream;
	   prompt_pos := !write_pos)


	fun force_prompt () =
	  (TextIO.output (outstream,"\n");
	   output_prompt ())
	  
	fun set_context_state (motif_context) =
	  case contextLabel of
	    SOME w =>
	      (local_context := motif_context;
	       Capi.set_label_string (w,"Context: " ^ GuiUtils.get_context_name motif_context))
	  | NONE => ()
	      
	val _ = set_context_state motif_context
	  
	fun set_state context = (set_context_state context; force_prompt ())
	  
	val context_key =
	  ToolData.add_context_fn
          (current_context, (set_state, get_user_options, ToolData.WRITABLE))
	  
	val _ =
	  quit_funs :=
	  (fn () => ToolData.remove_context_fn (current_context, context_key))
	  :: !quit_funs
	  
	fun select_context motif_context =
	  (set_state motif_context;
	   ToolData.set_current
           (current_context, context_key, user_options, motif_context))

	val {update_history, prev_history, next_history, history_start,
	     history_end, history_menu} =
	  GuiUtils.make_history
	  (user_preferences, 
 	   fn line => (replace_current_input line; buttons_update_fn ())) 

	val update_history = fn x => (inputBuffer:="";
                                      update_history x)
          (*<URI:spring://ML_Notebook/Design/Mutexes#input-over-several-lines>
           *)

	fun finish_up str =
	  (output_prompt ();
	   TextIO.output (outstream, str);
	   TextIO.flushOut outstream;
	   buttons_update_fn ();
	   (* Clear waiting input from std_in. *)
	   clear_input ())
	  
	(* For interface with inspector *)
	val do_select_fn = ref (fn () => ())
	  
	(* str is the input string, loc is the location of the erroneous
	 statement in that string, offset is the position where the last
	 topdec begins in str, and b specifies whether to highlight or
	 unhighlight. *)
	fun highlight (str, loc, b, offset) =
	  let
	    val (s_pos, e_pos) = Info.Location.extract (loc, str)
	  in
	    Capi.Text.set_highlight
            (text,
	     s_pos + !prompt_pos - offset,
	     e_pos + !prompt_pos - offset,
	     b)
	  end
        handle Info.Location.InvalidLocation => ()
	  
	fun error_handler
	  (error_list, redo_action, close_action, input, offset) =
	  let
	    fun edit_action location =
	      if ShellUtils.editable location then
		{quit_fn = ShellUtils.edit_location (location, get_preferences()),
		 clean_fn = fn () => ()}
	      else
		(highlight (input, location, true, offset);
		 {quit_fn = fn () => (),
		  clean_fn = fn () => highlight (input, location, false, offset)})
	    val location_file = case error_list of
	      [] => location_title
	    | Info.ERROR(_, location, _) :: _ =>
		case Location.file_of_location location of
		  "" => location_title
		| s => s
	  in
	    ErrorBrowser.create
            {parent = shell,
             errors = rev error_list,
             file_message = location_file,
             edit_action = edit_action,
             editable = fn _ => true,
	     close_action = close_action,
             redo_action = redo_action,
	     mk_tooldata = mk_tooldata,
	     get_context = get_current_user_context}
	  end
	
	(* The evaluating flag disables GUI controls during an evaluation. *)
	val evaluating = ref false;
	  
	local
	  val error_browser_ref = ref NONE
	    
	  fun kill_error_browser () =
	    case !error_browser_ref
	      of NONE => ()
	    |  SOME f =>
		 (f ();
		  error_browser_ref := NONE)

        in
	  

	  fun do_evaluate time_it =
	    let
	      val _ = kill_error_browser ()
		
              val input = get_input_to_evaluate ()

              (* Next, if a concurrent thread has output data in between
               * lines of a multi-line input, then remember previous
               * part.  If any. *)

              val input = if !anyOutput then !inputBuffer ^ input 
                          else input

              val _ = releaseWindow()

	      val _ = fdebug (fn () => "input: " ^ input);
		
	      val end_pos = !write_pos
	      val prev_capi_eval = !Capi.evaluating
	      val _ = evaluating := true
	      val _ = Capi.evaluating := true
	      val _ = buttons_update_fn ()
		
	      val result =
		(if time_it then
		   time_handler (input, Shell.initial_state)
		 else
		   handler (input, Shell.initial_state))
		   handle exn => (evaluating := false;
				  Capi.evaluating := prev_capi_eval;
                                  buttons_update_fn ();
				  raise exn)
		     
	    in
	      evaluating := false;
	      Capi.evaluating := prev_capi_eval;
	      buttons_update_fn ();
	      clean_debugger ();
	      case result
		of ([], str, Shell.OK _) =>
                  (claimWindow();
                   if !anyRecentOutput then 
                     (anyOutput:=true;
                      inputBuffer:= input;     
                      anyRecentOutput:=false;
                      prompt_pos:= !write_pos)
                       (* don't want to reread old input if 
                        * had intervening output. *)
                     else ()) 
                       (* NOTE that the other cases of this switch
                        *  all call finish_up, which in turn calls
                        *  output_prompt, which claims the window.
                        * See <URI:spring://ML_Notebook/Design/GUI/Mutexes#
                        *                           input-over-several-lines>
                        *)

	      |  (_, _, Shell.TRIVIAL) =>
		   finish_up ""
	      |  (l, str, Shell.INTERRUPT) =>
		   (update_history l;
		    case l of
		      [] => ()
		    | _ => (!do_select_fn) ();
			TextIO.output (outstream, "Interrupt\n");
			TextIO.flushOut outstream;
			finish_up str)
	      |  (l, str, Shell.DEBUGGER_TRAPPED) =>
		   (update_history l;
		    case l of
		      [] => ()
		    | _ => (!do_select_fn) ();
			finish_up str)
	      |  (l, str, Shell.OK _) =>
		   (* OK *)
		   (update_history l;
		    (!do_select_fn) ();
		    finish_up str)
	      |  (l, str, Shell.ERROR (_, error_list)) =>
		   (* Error *)
		   (update_history l;
		    case l of
		      [] => ()
		    | _ => (!do_select_fn) ();
			if use_error_browser () then
			  let
			    (* If any topdecs have been successfully evaluated, then
			     the code below will output a new prompt followed by
			     the remainder of the input.  Any highlighting must
			     be relative to the remaining input, so we have to
			     adjust the location information by the amount of
			     code that we have removed. *)
			    val offset = Lists.reducel (fn (i, s) => i + size s) (0, l)
			      
			    fun print_error () =
			      case rev error_list
				of [] => ()
			      |  (err::_) =>
				   TextIO.output
				   (outstream, ErrorBrowser.error_to_string err ^ "\n")
			  in
			    (* If the evaluation has caused anything to be written,
		              then output a new prompt, with the offending input
		              after.  This means that the input to be evaluated
		              is always at the end of the Widget.
		
		              If users close the error browser in this situation,
			      they are left with the current input at the prompt.
			      Deleting the current input gives the cleanest record
			      of activity, but users may have started to edit the
			      input.  Another alternative is to output a new prompt,
			      but that looks weird.
			      *)
			    if end_pos <> !write_pos then
			      (print_error ();
			       finish_up str;
			       error_browser_ref :=
			       SOME
			       (error_handler
				(error_list,
				 fn () =>
				 do_evaluate time_it,
				 fn () =>
				 (update_history [str];
				  buttons_update_fn ();
				  clear_input ()),
				 input,
				 offset)))
			    else
			      error_browser_ref :=
			      SOME
			      (error_handler
			       (error_list,
				fn () =>
				do_evaluate time_it,
				fn () =>
				(update_history [str];
				 print_error ();
				 finish_up ""),
				input,
				offset))
			  end
			else
			  (update_history [str];
			   finish_up ""))
	    end
	  handle
	  Shell.Exit _ => Capi.destroy shell
	end

	fun do_return () =
	  if !input_flag then
	    let
	      val input = get_input_from_stdin ()
	    in
	      (input_string := input;
	       buttons_update_fn ();
	       input_flag := false;
               releaseWindow())
	    end
	  else if !input_disabled then
	    beep ()
	       else
                  do_evaluate false
		 
	(* More text stuff *)
	(* A flag to indicate whether escape has just been pressed *)
	val escape_pressed = ref false
	  
	fun do_escape () = escape_pressed := true

(*
      fun check_copy_selection _ =
	 Capi.Text.copy_selection text

      fun check_paste_selection _ =
	 if modification_at_current_ok ()
          then Capi.Text.paste_selection text
        else beep ()

      fun check_cut_selection _ =
        if modification_at_current_ok ()
          then Capi.Text.cut_selection text
        else beep ()

      fun check_delete_selection _ =
        if modification_at_current_ok ()
          then Capi.Text.delete_selection text
        else beep ()
*)

	(* These ones attempt to use the capi clipboard *)
	fun check_copy_selection _ =
	  Capi.clipboard_set (text,Capi.Text.get_selection text)

	fun check_paste_selection _ =
	  if modification_at_current_ok ()
	    then
	      Capi.clipboard_get (text,
				  fn s =>
				  Capi.Text.insert (text,
						    Capi.Text.get_insertion_position text,
						    s))
	  else beep ()

	fun check_cut_selection _ =
	  if modification_at_current_ok ()
	    then
	      let
		val s = Capi.Text.get_selection text
	      in
		Capi.Text.delete_selection text;
		Capi.clipboard_set (text,s)
	      end
	  else beep ()

	fun check_delete_selection _ =
	  if modification_at_current_ok ()
	    then Capi.Text.delete_selection text
	  else beep ()

	fun abandon (text, prompt_pos, write_pos) () =
	  (lockWindow update_history
                          [get_current_input (text, !prompt_pos, write_pos)];
           finish_up "")

	val meta_bindings =
	  [("p", prev_history),
	   ("n", next_history)]

	fun delete_to_end () =
	  let
	    val ppos = !prompt_pos
	    val pos = Capi.Text.get_insertion_position text
	    val end_pos =
	      if pos < ppos
		then Capi.Text.end_line (text,pos)
	      else Capi.Text.get_last_position text
	  in
	    if modification_ok pos then
	      (Capi.Text.set_selection (text,pos,end_pos);
	       check_cut_selection ())
	    else
	      beep ()
	  end

	fun do_delete _ = 
	  let 
	    val sel = Capi.Text.get_selection text
	    val pos = Capi.Text.get_insertion_position text
	  in
	    if modification_at_current_ok() then
	      if sel = "" then 
	        Capi.Text.replace(text, pos, pos + 1, "")
	      else
		check_delete_selection()
	    else beep()
	  end

	val common_bindings =
	  [("\t" , fn _ => do_completion (Capi.Text.get_insertion_position text)),
	   ("\r" , do_return),
	   ("\027", do_escape)]

	(* These functions are not used by Windows now as the default 
	 * functionality offered by Windows for the keys: 'HOME', 'END', 
	 * the cursor keys, etc, is at least sufficient if not better.
	 * The main reason for using the standard Windows actions is 
	 * that they allow selection through the keyboard by holding 
	 * down the shift and/or control keys while using the cursor
	 * and other navigation keys. 
	 *)
	val key_handlers = 
	  {startOfLine =    start_of_line text_info,
	   endOfLine = 	    end_of_line text_info,
	   backwardChar =   backward_char text_info,
	   forwardChar =    forward_char text_info,
	   previousLine =   previous_line text_info,
	   nextLine =       next_line text_info,
	   abandon =        abandon text_info,
	   eofOrDelete =    eof_or_delete text_info,
	   deleteToEnd =    delete_to_end,
	   newLine = 	    fn _ => insert_at_current "\n",
	   delCurrentLine = delete_current_line text_info,
	   checkCutSel =    check_cut_selection,
	   checkPasteSel =  check_paste_selection}

	val normal_bindings = 
	  common_bindings @ (Capi.Text.get_key_bindings key_handlers)

	fun despatch_key bindings key =
	  let
	    fun loop [] = false
	      | loop ((key',action)::rest) =
		if key = key' then (ignore(action ()); true)
		else loop rest
	  in
	    loop bindings
	  end

	val despatch_meta = despatch_key meta_bindings
	val despatch_normal = despatch_key normal_bindings

	(* This part needs to be sorted out and bits moved into capi *)
 	(* This is only used for Motif, so no need to call check_insertion. *)
	fun do_insert_text ((text,prompt_pos,write_pos),start_pos,end_pos,str) =
	   (fdebug (fn _ =>
		   "Verify: start_pos is " ^ Int.toString start_pos ^
		   ", end_pos is " ^ Int.toString end_pos ^
		   ", write_pos is " ^ Int.toString (!write_pos) ^
		   ", prompt_pos is " ^ Int.toString (!prompt_pos) ^
		   ", string is '" ^ str ^ "'");
	  if end_pos < !write_pos
	    then write_pos := (!write_pos) - end_pos + start_pos + text_size str
	  else if start_pos < !write_pos then
	    write_pos := start_pos + text_size str
	       else ();
		 if end_pos < !prompt_pos
		   then prompt_pos := (!prompt_pos) - end_pos + start_pos + text_size str
		 else if start_pos < !prompt_pos
			then prompt_pos := start_pos + text_size str
		      else ())

	(* Motif only *)
	fun modifyVerify (start_pos,end_pos,str,set_fn) =
	  let
	    val _ = after_input ()
	  in
	    if !escape_pressed andalso size str = 1
	      then
		(escape_pressed := false;
		 set_fn false;
                 ignore(despatch_meta str);
		 ())
	    else if not Capi.Text.read_only_before_prompt orelse
	      start_pos >= !prompt_pos then
	      (do_insert_text (text_info,start_pos,end_pos,str);
	       set_fn true)
		 else
		   (beep ();
		    set_fn false)
	  end
	
	fun bad_key key =
	  not (("\000" <= key andalso key <= "\007") orelse
	       ("\009" <= key andalso key <= "\031")) andalso
	  Capi.Text.read_only_before_prompt andalso
	  let
	    val pos = if key = "\008" then !prompt_pos+1 else !prompt_pos
	  in
	    Capi.Text.get_insertion_position text < pos
	  end
	
	(* The checking for bad_key etc. is for the benefit of Windows *)
	(* This code is only called for the keys with activate actions in Motif *)
	fun text_handler (key,modifiers) =
	  (debug ("Text handler: " ^ MLWorks.String.ml_string (key,100));
	   after_input ();
	   if bad_key key then
	     (beep (); true)
	   else if !escape_pressed then
	     (* handle escape characters first *)
	     (escape_pressed := false; despatch_meta key)
		else if Lists.member (Capi.Event.meta_modifier, modifiers) then
		  despatch_meta key
		     else
		       despatch_normal key)
  
	fun close_window _ =
	  if not (!evaluating) then
	    (do_quit_funs ();
	     Capi.destroy shell)
	  else
	    ()
	    
	fun get_user_context () = GuiUtils.get_user_context (!local_context)
	  
	fun get_value () =
	  let
	    val user_context = get_user_context ()
	  in
	    ShellUtils.value_from_user_context (user_context,user_options)
	  end
	
	val inspect_fn = InspectorTool.inspect_value (shell,false,mk_tooldata())
	  
	val _ =
	  do_select_fn :=
	  (fn () =>
	   case get_value () of
	     SOME x => inspect_fn true x
	   | _ => ())
	  
	val searchButtonSpec =
	  GuiUtils.search_button
	  (shell, fn _ => !local_context, insert_at_current, true)
	  
	val value_menu =
	  GuiUtils.value_menu
	  {parent = shell,
	   user_preferences = user_preferences,
	   inspect_fn = SOME (inspect_fn false),
           get_value = get_value,
	   enabled = true,
	   tail = []}
	  
	val view_options =
	  GuiUtils.view_options
	  {parent = shell, title = title, user_options = user_options,
	   user_preferences = user_preferences,
	   caller_update_fn = fn _ => (),
	   view_type =
	   [GuiUtils.SENSITIVITY,
	    GuiUtils.VALUE_PRINTER,
	    GuiUtils.INTERNALS]}
	  
	fun use_action _ =
	  case Capi.open_file_dialog (shell, ".sml", false)
	    of NONE => ()
	  |  SOME [] => ()
	  |  SOME (s::rest) =>
	       (replace_current_input ("use");
		insert_at_current (" \"" ^ MLWorks.String.ml_string (s, ~1) ^ "\";");
		do_evaluate false)
	       
	fun evaluate_fn () = (Capi.set_focus text;
			      do_evaluate false)
	fun step_fn () = (Trace.set_stepping true;
			  Capi.set_focus text;
			  do_evaluate false;
			  Trace.set_stepping false)
	fun time_fn () = (Capi.set_focus text;
			  do_evaluate true)
	fun profile_fn () = (profiling := true;
			     Capi.set_focus text;
			     do_evaluate false;
			     profiling := false)
	fun clear_fn () = (delete_current_line text_info ();
			   Capi.set_focus text)
	fun abandon_fn () = (abandon text_info ();
			     Capi.set_focus text)
	fun previous_fn () = (prev_history ();
			      Capi.set_focus text)
	fun next_fn () = (next_history ();
			  Capi.set_focus text)

	val file_menu = ToolData.file_menu 
           [("use", use_action, fn _ => not (!evaluating)),
	    ("save", fn _ =>
		       GuiUtils.save_history (false, get_user_context (), applicationShell),
		     fn _ =>
		       not (UserContext.null_history (get_user_context ()))
		       andalso UserContext.saved_name_set (get_user_context ())),
	    ("saveAs", fn _ => GuiUtils.save_history
			     (true, get_user_context (), applicationShell),
		       fn _ => not (UserContext.null_history (get_user_context ()))),
	    ("close", close_window, fn _ => not (!evaluating) andalso podiumExists)]

	val view = ToolData.extract view_options
	val values = ToolData.extract value_menu
	val search = ToolData.extract 
			(Menus.CASCADE ("dummy", [searchButtonSpec], fn () => false))

	val usage = view @ values @ search

	val menuspec =
	  [file_menu,
	   ToolData.edit_menu (shell,
            {cut = SOME (check_cut_selection),
             paste = SOME (check_paste_selection),
             copy = SOME (check_copy_selection),
             delete = SOME (check_delete_selection),
	     edit_possible = fn _ => modification_at_current_ok (),
             selection_made = fn _ => Capi.Text.get_selection text <> "",
	     edit_source = [value_menu],
	     delete_all = SOME ("deleteAll", fn _ => (prompt_pos := 0;
				       write_pos := 0;
				       Capi.Text.set_string (text, "");
				       finish_up "";
				       Capi.set_focus text),
				     fn _ => not (!evaluating)) }),
	   ToolData.tools_menu (mk_tooldata, get_current_user_context),
	   ToolData.usage_menu (usage, []),
	   Menus.CASCADE ("listener_menu", 
	     [Menus.PUSH ("evaluate",  evaluate_fn, fn _ => not (!evaluating)),
	      Menus.PUSH ("stepEval",  step_fn,     fn _ => not (!evaluating)),
	      Menus.PUSH ("time",      time_fn,     fn _ => not (!evaluating)),
	      Menus.PUSH ("profile",   profile_fn,  fn _ => not (!evaluating)),
	      Menus.SEPARATOR,
	      Menus.PUSH ("clear_def", clear_fn,    fn _ => not (!evaluating)),
	      Menus.PUSH ("abandon",   abandon_fn,  fn _ => not (!evaluating)),
	      Menus.PUSH ("previous_def", previous_fn,
				fn () => not (!evaluating) andalso not (history_start ())),
	      Menus.PUSH ("next_def", next_fn,
				fn () => not (!evaluating) andalso not (history_end ())),
	      GuiUtils.listener_properties (shell, fn _ => (!local_context))],
			fn _ => true),
	   ToolData.debug_menu values]
	  @ (if full_menus then
	       [GuiUtils.context_menu
	        {set_state = select_context,
                 get_context = fn _ => !local_context,
                 writable = GuiUtils.WRITABLE,
                 applicationShell = applicationShell,
                 shell = shell,
                 user_preferences = user_preferences}]
	     else
	       [])
	  @ [history_menu]

	val {update, ...} =
	  Menus.make_buttons
	  (buttonPane,
	   [Menus.PUSH ("evaluateButton", evaluate_fn, fn _ => not (!evaluating)),
	    Menus.PUSH ("stepButton",     step_fn,     fn _ => not (!evaluating)),
	    Menus.PUSH ("timeButton",     time_fn,     fn _ => not (!evaluating)),
	    Menus.PUSH ("profileButton",  profile_fn,  fn _ => not (!evaluating)),
	    Menus.PUSH ("clearButton",    clear_fn,    fn _ => not (!evaluating)),
	    Menus.PUSH ("abandonButton",  abandon_fn,  fn _ => not (!evaluating)),
	    Menus.PUSH ("prevButton",     previous_fn, 
			fn _ => not (!evaluating) andalso not (history_start ())),
	    Menus.PUSH ("nextButton",     next_fn, 
			fn _ => not (!evaluating) andalso not (history_end ()))]);

	fun with_no_listener f arg1 arg2 =
	  let 
	    val listener = !listener_tool
	    val currentIO = MLWorks.Internal.StandardIO.currentIO()
	  in
	    listener_tool := NONE;
	    MLWorks.Internal.StandardIO.resetIO();
	    ignore(
              f arg1 arg2 handle exn => (listener_tool := listener; 
  				         MLWorks.Internal.StandardIO.redirectIO currentIO;
				         raise exn));
	    listener_tool := listener;
	    MLWorks.Internal.StandardIO.redirectIO currentIO
	  end

	fun store_size_pos () = 
	  (sizeRef := SOME (Capi.widget_size shell);
	   posRef := SOME (Capi.widget_pos shell))

      in
	quit_funs := store_size_pos :: (!quit_funs);
	SaveImage.add_with_fn with_no_listener;
	Capi.Text.add_del_handler(text, do_delete);
	listener_tool := SOME shell;
	buttons_update_fn_ref := update;
	quit_funs := Menus.quit :: (!quit_funs);
	Menus.make_submenus (menuBar,menuspec);
	Capi.Layout.lay_out
	(mainWindow, !sizeRef, 
	 [Capi.Layout.MENUBAR menuBar] @
	 (case contextLabel of
	    SOME w => [Capi.Layout.FIXED w]
	  | _ => [Capi.Layout.SPACE]) @
	    (if podiumExists then [] else 
		[Capi.Layout.FIXED (valOf interrupt_button),
		 Capi.Layout.SPACE]) @
	    [Capi.Layout.FLEX scroll,
	     Capi.Layout.SPACE,
	     Capi.Layout.FIXED buttonPane,
	     Capi.Layout.SPACE]);
	Capi.Text.add_handler (text, text_handler);
	Capi.Text.add_modify_verify (text, modifyVerify);
	Capi.set_close_callback(mainWindow, close_window);
	Capi.Callback.add (shell, Capi.Callback.Destroy,do_quit_funs);
	Capi.initialize_toplevel shell;
	buttons_update_fn ();
	if podiumExists then 
	  () 
	else 
	  Capi.register_interrupt_widget (valOf interrupt_button);
 	Capi.set_focus text;
	output_prompt ()
      end

    fun create podium tooldata = 
      if isSome (!listener_tool) then
 	Capi.to_front (valOf (!listener_tool))
      else
	create_listener podium tooldata

  end;





