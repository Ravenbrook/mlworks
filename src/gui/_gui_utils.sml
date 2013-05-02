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
 * $Log: _gui_utils.sml,v $
 * Revision 1.83  1999/02/02 15:59:21  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.82  1998/08/17  09:23:03  mitchell
 * [Bug #50103]
 * Evaluate search function after processing check boxes controlling search
 *
 * Revision 1.81  1998/04/24  16:40:00  johnh
 * [Bug #30229]
 * Group compiler options to allow more flexibility.
 *
 * Revision 1.80  1998/03/24  17:30:37  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.78  1998/03/02  15:07:22  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.77  1998/02/19  20:15:28  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.76  1998/02/18  16:59:21  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.75  1998/01/27  16:09:50  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.74  1997/10/30  13:13:52  johnh
 * [Bug #30233]
 * Make editor interface (dialog) clearer.
 *
 * Revision 1.73  1997/10/01  16:54:04  jkbrook
 * [Bug #20088]
 * Merging from MLWorks_11:
 * SML'96 should be SML'97
 *
 * Revision 1.72.2.3  1997/11/24  11:43:38  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.72.2.1  1997/09/11  20:52:13  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.72  1997/06/09  10:26:49  johnh
 * [Bug #30068]
 * Make Breakpoint and Trace Managers top level tools.
 *
 * Revision 1.71  1997/05/27  11:12:16  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.70  1997/05/16  15:35:03  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.69  1997/05/02  17:24:13  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.68  1997/03/25  11:26:29  matthew
 * Platform specific compiler options changes
 *
 * Revision 1.67  1997/03/19  16:56:49  matthew
 * Adding Types structure
 *
 * Revision 1.66  1997/03/13  12:21:13  johnh
 * [Bug #1854]
 * Added a call to Capi.set_close_callback.
 *
 * Revision 1.65  1996/11/06  11:16:10  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.64  1996/11/05  12:42:55  johnh
 * [Bug #1724]
 * Changing toggles to radio buttons in preferences->editor.
 *
 * Revision 1.63  1996/10/30  21:32:28  io
 * moving String from toplevel
 *
 * Revision 1.62  1996/08/15  13:55:02  daveb
 * [Bug #1519]
 * The type of UserContext.ITEM has changed.
 *
 * Revision 1.61  1996/08/09  15:25:20  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.60  1996/08/06  16:21:45  andreww
 * [Bug #1521]
 * Propagating changes made to interpreter/_entry.sml
 *
 * Revision 1.59  1996/08/05  13:07:49  daveb
 * Removed object path entry from the Paths menu.
 *
 * Revision 1.58  1996/07/30  14:39:00  jont
 * Use a system dependent line terminator when saving history
 *
 * Revision 1.57  1996/06/25  09:57:30  daveb
 * Made button buttons have different names from menu buttons, so that
 * Windows can distinguish between them, and so let us put mnemonics on
 * the menu items but not the buttons.
 *
 * Revision 1.56  1996/06/24  12:01:06  daveb
 * Removed SaveImage.preference_file_name, because Getenv.get_preferences_filename
 * now does this job.
 *
 * Revision 1.55  1996/06/18  16:38:30  daveb
 * Removed Step Mode menu item (replaced with a button on the listener).
 *
 * Revision 1.54  1996/06/13  17:00:27  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.53  1996/05/31  16:10:47  daveb
 * Bug 1074: Capi.list_select now takes a function to be called on any key
 * press handled by the list widget itself.  In the listener, this pops the
 * completions widget down as if the key had been typed at the listener.
 *
 * Revision 1.52  1996/05/30  14:28:32  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.51  1996/05/28  15:13:33  daveb
 * Fixed bug 1328: the user_tool_options were hanging on to old update functions.
 * These referenced deleted widgets, and therefore caused SEGVs.
 *
 * Revision 1.49  1996/05/24  11:20:14  daveb
 * Ensure that blank entries never get added to the history.
 *
 * Revision 1.48  1996/05/22  16:32:51  daveb
 * Added a separator to the Languages dialog.
 *
 * Revision 1.47  1996/05/22  15:09:12  daveb
 * Reorganised the options menus.
 *
 * Revision 1.46  1996/05/21  16:13:07  daveb
 * Renamed mode options.
 *
 * Revision 1.45  1996/05/20  15:07:17  daveb
 * UserOptions now defines functions for setting and testing modes.
 *
 * Revision 1.44  1996/05/15  16:25:27  daveb
 * Corrected the titles of some dialog boxes, which were hangovers from the
 * days of multiple contexts.
 *
 * Revision 1.43  1996/05/10  12:22:26  daveb
 * Fixed bug in history_menu.  The history_index was being set after the
 * call to use_entry, which meant that the buttons on the listener were
 * being updated using the old value.  Also, the index was off by one.
 *
 * Revision 1.42  1996/05/07  11:32:32  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.41  1996/05/01  10:46:28  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.40  1996/04/30  09:28:27  matthew
 * Changing to new basis
 *
 * Revision 1.39  1996/03/19  10:30:36  matthew
 * Removing some options
 *
 * Revision 1.38  1996/03/12  15:13:33  matthew
 * Adding path menu
 *
 * Revision 1.37  1996/02/29  14:21:44  matthew
 * Adding "Save preferences" menu item
 *
 * Revision 1.36  1996/02/26  16:38:33  matthew
 * Improving layout of string list manager
 *
 * Revision 1.35  1996/02/19  10:38:10  stephenb
 * Updated wrt Trace.step_status -> Trace.stepping name change.
 *
 * Revision 1.34  1996/02/08  11:35:38  daveb
 * Capi.make_scrolllist now returns a record, with an add_items field.
 * Removed sensitivity type.
 *
 * Revision 1.33  1996/01/23  14:38:43  daveb
 * Minor changes to menu interfaces.
 *
 * Revision 1.32  1996/01/19  17:03:21  daveb
 * Added make_history function.
 *
 * Revision 1.31  1996/01/18  14:44:17  matthew
 * Disable Inspect option in Value menu.
 *
 * Revision 1.30  1996/01/17  14:13:03  matthew
 * Adding Inspect to value menu
 *
 * Revision 1.29  1996/01/16  15:39:27  matthew
 * Changing uses of full_menus
 *
 * Revision 1.28  1996/01/12  12:06:14  daveb
 * Added ".sml" mask to save_as_dialog.
 *
 * Revision 1.27  1996/01/10  13:35:45  daveb
 * Replaced Capi.find_file with Capi.save_as_dialog.
 *
 * Revision 1.26  1996/01/10  13:14:50  matthew
 * Changes to search facility
 *
 * Revision 1.25  1996/01/09  13:57:15  matthew
 * Doing something with list_select
 *
 * Revision 1.24  1996/01/08  17:00:15  matthew
 * Fixing problem with deleting single items.
 *
 * Revision 1.23  1996/01/08  16:27:33  matthew
 * Moving list_select into architecture specific code.
 *
 * Revision 1.22  1995/12/13  14:55:53  jont
 * Add call to ml_debugger to update debugger table when setting break points
 *
 * Revision 1.21  1995/12/13  10:23:02  daveb
 * Added Path Tool to setup_menu.
 * Replaced FileDialog.find_file with Capi.find_file; the type has changed too.
 *
 * Revision 1.20  1995/12/07  14:32:40  matthew
 * Changing interface to clipboard functions
 *
 * Revision 1.19  1995/12/04  14:21:34  daveb
 * Corrected previous fix: the initial context wasn't being set.
 *
 * Revision 1.18  1995/11/30  15:31:41  jont
 * Modification to allow gui to be restarted when restarting an
 * image saved from the GUI.
 *
 * Revision 1.17  1995/11/21  17:30:32  matthew
 * Changing names for search resources.
 *
 * Revision 1.16  1995/11/16  14:01:20  matthew
 * Changing button resources
 *
 * Revision 1.15  1995/11/15  15:32:01  matthew
 * Changing clipboard mechanism
 *
 * Revision 1.14  1995/10/26  15:35:52  daveb
 * Removed "search in structure" option from the search dialog because we
 * always want to search substructures.
 * Changed list_select to destroy the widget on exit.  Tools should create a
 * new list widget each time they need one.  This is so that it pops up with
 * the correct size under TWM.  (The search dialog already does this.).
 *
 * Revision 1.13  1995/10/25  17:47:39  daveb
 * Hid the local variables debugging options unless full_menus is set.
 *
 * Revision 1.12  1995/10/17  13:56:53  matthew
 * Simplifying tracing interface.
 *
 * Revision 1.11  1995/10/13  14:43:13  brianm
 * Another Menu utility ...
 *
 * Revision 1.10  1995/10/13  12:24:25  brianm
 * Adding some PopUp Menu utility functions : (int_value, etc.)
 *
 * Revision 1.9  1995/10/09  11:46:23  daveb
 * Made context_menu include "Save" and "Save As..." options only if the
 * context is writable.
 *
 * Revision 1.8  1995/10/06  14:11:00  daveb
 * Minor improvements to search mechanism.
 *
 * Revision 1.7  1995/10/04  14:43:33  daveb
 * Moved mode options to preference menu until we have proper support for
 * contexts-as-files.
 *
 * Revision 1.6  1995/10/03  16:26:28  daveb
 * Menus.make_buttons now returns a record of functions.
 *
 * Revision 1.5  1995/09/22  15:27:13  daveb
 * Make options visible when full_menus is not set.  The default implementation
 * now hides all mention of multiple contexts, but makes everything else visible.
 *
 * Revision 1.4  1995/08/30  13:23:41  matthew
 * Doesn't work under windows
 *
 * Revision 1.3  1995/08/10  12:15:00  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:57:30  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:40:39  matthew
 * new unit
 * New unit
 *
 *  Revision 1.66  1995/07/17  12:40:56  matthew
 *  Correcting layout of list_select pane
 *
 *  Revision 1.65  1995/07/13  14:12:11  matthew
 *  Adding some debugger utilities
 *
 *  Revision 1.64  1995/07/04  15:58:39  matthew
 *  Capification
 *
 *  Revision 1.63  1995/06/30  16:22:09  daveb
 *  Added float_precision option to ValuePrinter options.
 *
 *  Revision 1.62  1995/06/20  12:39:25  daveb
 *  Added variable info mode.
 *
 *  Revision 1.61  1995/06/14  14:09:39  daveb
 *  ShellUtils.edit_* functions no longer require a context argument.
 *  Added entries for new preferences to setup_menu.
 *
 *  Revision 1.60  1995/06/13  14:30:05  daveb
 *  Removed show_id_class and show_eq_info value printer options from interface.
 *
 *  Revision 1.59  1995/06/05  13:20:48  daveb
 *  Added NO_SENSE_SELECTION option for Sensitivity type.
 *
 *  Revision 1.58  1995/06/01  10:44:27  daveb
 *  Added new type MotifContext, which combines a user_context with
 *  dialog boxes for context-specific options.  Changed context_menu to
 *  incorporate entries for popping up the options dialogs for the current
 *  context.  Put the remaining options dialogs, for tool-specific options,
 *  in the view_options function, which returns items for use in "view"
 *  menus.
 *
 *  Revision 1.57  1995/05/23  14:07:27  matthew
 *  Changing interface to list_select.
 *
 *  Revision 1.56  1995/05/22  18:27:13  daveb
 *  Removed erroneous call to debug_output
 *
 *  Revision 1.55  1995/05/15  15:03:21  matthew
 *  Renaming nj_semicolons
 *
 *  Revision 1.54  1995/05/01  15:40:29  matthew
 *  Removing exception EditObject
 *
 *  Revision 1.53  1995/04/28  12:39:32  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.52  1995/04/24  15:54:06  daveb
 *  Removed stepper option, commented out poly_variable and moduler options.
 *  Also commented out default_overloads option.
 *
 *  Revision 1.51  1995/04/24  14:50:38  matthew
 *  Refinements to list manager widgets
 *
 *  Revision 1.50  1995/04/20  12:30:16  matthew
 *  Added list managers
 *  New break/trace menu
 *
 *  Revision 1.49  1995/04/19  10:20:42  daveb
 *  Added rename option to context menu.
 *
 *  Revision 1.48  1995/03/30  18:01:52  daveb
 *  Made make_scrolllist handle empty lists specially.
 *
 *  Revision 1.47  1995/03/16  18:27:05  daveb
 *  Merged ShellTypes.get_context_name and ShellTypes.string_context_name.
 *
 *  Revision 1.46  1995/03/13  21:31:22  daveb
 *  Added support for propagating changes of context.
 *
 *  Revision 1.45  1995/03/10  15:20:59  daveb
 *  Added support for selections to the options menu.
 *
 *  Revision 1.44  1994/11/30  16:43:35  daveb
 *  Ensured that if full_menus is false, only the required menus and
 *  dialogs are created.
 *
 *  Revision 1.43  1994/09/26  09:42:44  matthew
 *  Change to Basis.lookup_val
 *
 *  Revision 1.42  1994/09/21  16:11:38  brianm
 *  Adding value menu implementation ...
 *
 *  Revision 1.41  1994/08/02  10:57:14  daveb
 *  Revised editor preference dialog.
 *
 *  Revision 1.40  1994/07/27  12:57:56  daveb
 *  Cut down menus for novices.
 *
 *  Revision 1.39  1994/06/20  11:13:34  daveb
 *  Replaced ContextRef with user_context.
 *
 *  Revision 1.38  1994/05/06  10:22:01  daveb
 *  Added default_overloads option.
 *
 *  Revision 1.37  1994/04/06  11:50:58  daveb
 *  Added breakpoints menu.
 *
 *  Revision 1.36  1994/02/22  00:50:13  nosa
 *  Step and Modules Debugger compiler options.
 *
 *  Revision 1.35  1993/12/17  18:15:49  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.34  1993/12/10  16:57:25  daveb
 *  Added context_menu function.
 *
 *  Revision 1.33  1993/12/01  16:15:33  io
 *  *** empty log message ***
 *
 *  Revision 1.32  1993/12/01  15:33:57  io
 *  Added max_num_errors
 *
 *  Revision 1.31  1993/11/29  13:20:35  matthew
 *  Added handler for SubLoopTerminated in with_message -- otherwise we try and
 *  set the cursor of a window after Motif has exitted.
 *  Changed outstreams so a line at a time is printed.  Scrolling behaviour is bas
 *   bad otherwise.
 *
 *  Revision 1.30  1993/11/18  11:50:06  nickh
 *  Change to outstream arguments.
 *
 *  Revision 1.29  1993/11/08  16:08:35  jont
 *  Added menu iterm for generating interruptable code
 *  .\
 *
 *  Revision 1.28  1993/10/13  11:58:38  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.27  1993/10/08  16:43:29  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.26  1993/09/17  14:05:13  nosa
 *  New compiler option debug_polyvariables for polymorphic debugger.
 *
 *  Revision 1.25  1993/09/13  09:16:33  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.24.1.4  1993/10/12  14:41:15  daveb
 *  Changed print options.
 *
 *  Revision 1.24.1.3  1993/10/08  10:29:28  matthew
 *  Added beep & cut buffer utilities
 *  Fixed problem with generate_variable_debug_info and debugging mode
 *
 *  Revision 1.24.1.2  1993/09/10  11:12:21  daveb
 *  Added name parameter to GuiUtils.list_select.
 *
 *  Revision 1.24.1.1  1993/08/24  12:16:17  jont
 *  Fork for bug fixing
 *
 *  Revision 1.24  1993/08/24  12:16:17  matthew
 *  Rationalized mode option functions
 *
 *  Revision 1.23  1993/08/19  17:25:43  daveb
 *  Removed core-only and functional options, since they didn't do anything.
 *
 *  Revision 1.22  1993/08/11  11:01:50  matthew
 *  Changes for automatic option menu updating
 *
 *  Revision 1.21  1993/08/09  16:21:53  matthew
 *  Extended environment menu
 *
 *  Revision 1.20  1993/08/05  11:52:42  nosa
 *  New compiler option generateVariableDebugInfo in options menu.
 *
 *  Revision 1.19  1993/08/04  09:09:19  matthew
 *  Changed strict option to standard
 *
 *  Revision 1.18  1993/07/29  14:55:37  matthew
 *  Added (unworking and deleted) with_message function
 *  Added working with_message function that sets the cursor to busy
 *
 *  Revision 1.17  1993/06/10  16:02:42  matthew
 *  Added open_fixity and fixity_specs options
 *
 *  Revision 1.16  1993/06/03  16:54:53  daveb
 *  Removed cancel and help buttons from message boxes.
 *
 *  Revision 1.15  1993/05/28  15:52:21  matthew
 *  Added environment options to preferences
 *
 *  Revision 1.14  1993/05/27  16:19:19  matthew
 *  Return exit function from list_select
 *  Added bool ref to control destruction of list select widget
 *
 *  Revision 1.13  1993/05/19  13:58:19  daveb
 *  Revised some exceptions and added Mode dialog box.
 *
 *  Revision 1.12  1993/05/13  18:44:15  daveb
 *  Changed names of scrolllist widgets to simplify the specification
 *  of resources.
 *
 *  Revision 1.11  1993/05/13  14:26:19  daveb
 *  options_menu now takes a string to use for the title of the options
 *  dialogs.
 *
 *  Revision 1.10  1993/05/12  13:59:13  daveb
 *  Added comment about profligracy in creation of options menus.
 *
 *  Revision 1.9  1993/05/06  13:40:45  daveb
 *  Added make_outstream.
 *
 *  Revision 1.8  1993/05/04  16:59:24  matthew
 *  Added fileselect function
 *
 *  Revision 1.7  1993/04/30  15:53:35  daveb
 *  Moved Editor options dialog to new setup menu.
 *
 *  Revision 1.6  1993/04/28  12:10:42  richard
 *  Unified profiling and tracing options into `intercept'.
 *  Removed poly_makestring option.
 *
 *  Revision 1.5  1993/04/28  10:05:53  daveb
 *  Changes to make_scrolllist.
 *
 *  Revision 1.4  1993/04/27  12:48:50  daveb
 *  Added options_menu code from _listener and _fileselect.
 *
 *  Revision 1.3  1993/04/23  15:11:21  matthew
 *  Added send message function
 *
 *  Revision 1.2  1993/04/21  15:51:07  daveb
 *  Whoops.  Gave myself a fright there.  Checked in an old version.
 *
 *  Revision 1.1  1993/04/21  14:40:52  daveb
 *  Initial revision
 *  
 *
 *)

require "../basis/__text_io";
require "../basis/__io";
require "../basis/__text_prim_io";
require "^.utils.__terminal";

require "capi";
require "menus";
require "../utils/lists";
require "../main/user_options";
require "../utils/crash";
require "../utils/getenv";
require "../main/preferences";
require "../main/machspec";
require "../typechecker/types";
require "../interpreter/shell_utils";
require "../interpreter/user_context";
require "../interpreter/entry";
require "../editor/custom";
require "gui_utils";

functor GuiUtils (
  structure Capi: CAPI 
  structure Lists: LISTS
  structure Crash: CRASH
  structure UserOptions: USER_OPTIONS
  structure Preferences: PREFERENCES
  structure MachSpec : MACHSPEC
  structure Menus: MENUS
  structure UserContext: USER_CONTEXT
  structure Entry: ENTRY
  structure ShellUtils: SHELL_UTILS
  structure Getenv: GETENV
  structure Types : TYPES
  structure CustomEditor: CUSTOM_EDITOR

  sharing UserOptions.Options = ShellUtils.Options = UserContext.Options

  sharing type Menus.Widget = Capi.Widget

  sharing type ShellUtils.preferences = Preferences.preferences
  sharing type ShellUtils.user_preferences = Preferences.user_preferences
  sharing type ShellUtils.Context = UserContext.Context = Entry.Context

  sharing type UserOptions.user_tool_options = ShellUtils.UserOptions
  sharing type UserOptions.user_context_options =
	       UserContext.user_context_options
  sharing type ShellUtils.user_context = UserContext.user_context
  sharing type Entry.options = UserOptions.Options.options
): GUI_UTILS =
struct

  structure Options = UserOptions.Options

  type Widget = Capi.Widget
  type ButtonSpec = Menus.ButtonSpec
  type OptionSpec = Menus.OptionSpec
  type Type = ShellUtils.Type

  type user_tool_options = UserOptions.user_tool_options
  type user_context_options = UserOptions.user_context_options
  type user_preferences = Preferences.user_preferences
  type user_context = UserContext.user_context

  val print = Terminal.output

(*
  fun make_outstream insert_text =
    let
      val outbuff = ref [] : string list ref

      (* Motif text widgets don't scroll nicely with multi-line output *)
      (* So break up into nl-terminated lines *)
      (* This could probably all be made a lot more efficient *)

      fun make_strings sl =
        let 
          fun foo ([],[],acc) = rev acc
            | foo ([],l,acc) = rev (implode (rev l) :: acc)
            | foo (#"\n"::rest,l,acc) = foo (rest,[],(implode (rev (#"\n"::l)))::acc)
            | foo (c::rest,l,acc) = foo (rest,c::l,acc)
        in
          foo (explode (concat (rev sl)),[],[])
        end

      fun flush_buffer () =
        let val strings = (make_strings (!outbuff))
        in
          outbuff := [];
          app insert_text strings
        end

      fun output_fn s =
        let
          fun has_nl 0 = false
            | has_nl n =
              if MLWorks.String.ordof (s,n-1) = ord #"\n"
                then true
              else
                has_nl (n-1)
        in
          outbuff := s :: !outbuff;
          if has_nl (size s) then
            flush_buffer()
          else ()
        end
    in
      MLWorks.IO.outstream {output = output_fn,
                            flush_out = flush_buffer,
                            close_out = fn () => (),
			    closed_out = fn () => false}
    end
*)

  fun make_outstream insert_text =
    let
      fun writeVec{buf, i, sz} =
	let
	  val len = case sz of
	    NONE => size buf - i
	  | SOME i => i
	  val _ = insert_text(if i = 0 andalso len = size buf then buf else substring(buf, i, len));
	in
	  len
	end

      val prim_writer =
	TextPrimIO.WR{name = "console writer", 
		      chunkSize = 1, 
		      writeVec = SOME writeVec, 
		      writeArr = NONE,
		      writeVecNB = NONE,
		      writeArrNB = NONE,
		      block = NONE, 
		      canOutput = SOME(fn _ => true), 
		      getPos = NONE, 
		      setPos = NONE, 
		      endPos = NONE,
		      verifyPos = NONE,
		      close = fn _ => (),
		      ioDesc = NONE}

    in
      TextIO.mkOutstream(TextIO.StreamIO.mkOutstream(TextPrimIO.augmentWriter prim_writer, IO.NO_BUF))
    end

  datatype Writable = WRITABLE | ALL

  val title_for_global_dialogs = "MLWorks Preferences"

  (* A MotifContext combines options dialogs with a user_context *)
  abstype MotifContext =
      SHORT_MOTIF_CONTEXT of		(* was used when full_menus = false *)
        {user_context: user_context,
         mode_dialog: unit -> unit,
         update_fn: unit -> unit}
    | FULL_MOTIF_CONTEXT of		(* currently always used *)
        {user_context: user_context,
         mode_dialog: unit -> unit,
         compiler_dialog: unit -> unit,
         language_dialog: unit -> unit,
         update_fn: unit -> unit}
  with
    fun get_user_context (SHORT_MOTIF_CONTEXT r) = #user_context r
    |   get_user_context (FULL_MOTIF_CONTEXT r) = #user_context r;

    fun get_context_name m =
      UserContext.get_context_name (get_user_context m)

    val context_list = ref []

    fun get_mode_dialog (FULL_MOTIF_CONTEXT r) = #mode_dialog r
    |   get_mode_dialog (SHORT_MOTIF_CONTEXT r) = #mode_dialog r

    fun get_compiler_dialog (FULL_MOTIF_CONTEXT r) = #compiler_dialog r
    |   get_compiler_dialog (SHORT_MOTIF_CONTEXT r) =
      Crash.impossible "get_compiler_dialog"

    fun get_language_dialog (FULL_MOTIF_CONTEXT r) =
      #language_dialog r
    |   get_language_dialog (SHORT_MOTIF_CONTEXT r) =
      Crash.impossible "get_language_dialog"

    fun make_context (user_context, parent, user_preferences) =
        let
	  (* Each MotifContext contains a user_context, which contains a set
	     of user_context_options.  The MotifContext also contains a number
	     of dialog boxes.  When the options are updated, the dialog boxes
	     must be updated to match them.  This is done by storing update
	     functions in the user_context_options. *)
	  val user_context_options = UserContext.get_user_options user_context

	  val UserOptions.USER_CONTEXT_OPTIONS (options, update_fns) =
	    user_context_options

          fun set_context_option_fun f a =
            ((f options) := a;
	     true)
             
          fun get_context_option_fun f () =
            !(f options)
              
          fun int_context_widget (name, accessor) =
            Menus.OPTINT
	      (name,
	       get_context_option_fun accessor,
	       set_context_option_fun accessor)
              
          fun bool_context_widget (name, accessor) =
            Menus.OPTTOGGLE
	      (name,
	       get_context_option_fun accessor,
	       set_context_option_fun accessor)

          fun do_update () = app (fn f => f ()) (!update_fns);

	  fun is_sml'97 _ = 
	     UserOptions.is_sml'97 user_context_options

	  fun sml'97 true =
	    (UserOptions.select_sml'97 user_context_options;
             Types.real_tyname_equality_attribute := false;
	     true)
	    | sml'97 false = true

	  fun is_compatibility _ = 
	     UserOptions.is_compatibility user_context_options

	  fun compatibility true =
	    (UserOptions.select_compatibility user_context_options;
	     true)
	  |   compatibility false = true

	  fun is_sml'90 _ = 
	     UserOptions.is_sml'90 user_context_options

	  fun sml'90 true =
	    (UserOptions.select_sml'90 user_context_options;
             Types.real_tyname_equality_attribute := true;
	     true)
	    | sml'90 false = true

	  fun is_quick_compile _ = 
	     UserOptions.is_quick_compile user_context_options

	  fun quick_compile true = 
	    (UserOptions.select_quick_compile user_context_options;
	     true)
	    | quick_compile false = true

	  fun is_optimizing _ = 
	     UserOptions.is_optimizing user_context_options

	  fun optimizing true =
	    (UserOptions.select_optimizing user_context_options;
	     true)
	    | optimizing false = true

	  fun is_debugging _ = 
	    UserOptions.is_debugging user_context_options

	  fun debugging true =
	    (UserOptions.select_debugging user_context_options;
	     true)
	    | debugging false = true

	  val Preferences.USER_PREFERENCES (user_preferences, _) =
	    user_preferences

	  val full_menus = !(#full_menus user_preferences)

          fun popup_mode_options parent =
            Menus.create_dialog
            (parent,
	     title_for_global_dialogs,
             "modeOptions",
             do_update,
             [Menus.OPTLABEL "modeOptionsLabel",
              Menus.OPTSEPARATOR,
	      Menus.OPTRADIO
	        [Menus.OPTTOGGLE ("sml_97", is_sml'97, sml'97),
                 Menus.OPTTOGGLE ("sml_90", is_sml'90, sml'90),
                 Menus.OPTTOGGLE
		   ("compatibilityMode", is_compatibility, compatibility)],
              Menus.OPTSEPARATOR,
	      Menus.OPTRADIO
		[Menus.OPTTOGGLE ("debugging", is_debugging, debugging),
		 Menus.OPTTOGGLE ("quick_compile", is_quick_compile, quick_compile),
		 Menus.OPTTOGGLE ("optimizing", is_optimizing, optimizing)]])

          val (mode_dialog,mode_dialog_update) =
	    popup_mode_options parent

        in
	    let
              fun popup_compiler_options parent =
                Menus.create_dialog
                (parent,
	         title_for_global_dialogs,
                 "compilerOptions",
                 do_update,
                 [Menus.OPTLABEL "compilerOptionsLabel",
                  Menus.OPTSEPARATOR,
	          bool_context_widget
	  	  ("generateInterruptableCode", #generate_interruptable_code),
                  bool_context_widget
	  	  ("generateInterceptableCode", #generate_interceptable_code),
                  bool_context_widget
	  	  ("generateDebugInfo", #generate_debug_info),
                  bool_context_widget
                  ("generateVariableDebugInfo",#generate_variable_debug_info)]
	  	(*
                  bool_context_widget
	  	  ("generatePolyVariableDebugInfo",
	  	   #generate_polyvariable_debug_info),
                  bool_context_widget("generateModuler", #generate_moduler),
	  	*)
                 @ [Menus.OPTSEPARATOR,
                    bool_context_widget("optimizeLeafFns", #optimize_leaf_fns),
                    bool_context_widget
		      ("optimizeTailCalls", #optimize_tail_calls),
                    bool_context_widget
	  	      ("optimizeSelfTailCalls",#optimize_self_tail_calls)]
                 @ 
                 (case MachSpec.mach_type of
                    MachSpec.MIPS => 
                      [Menus.OPTSEPARATOR,
                       bool_context_widget("mipsR4000", #mips_r4000)]
                  | MachSpec.SPARC => 
                      [Menus.OPTSEPARATOR,
                       bool_context_widget("sparcV7", #sparc_v7)]
                  | MachSpec.I386 => 
                      []))
              fun popup_language_options parent =
                Menus.create_dialog
                (parent,
	         title_for_global_dialogs,
                 "languageOptions",
                 do_update,
                 [Menus.OPTLABEL "compatibilityOptionsLabel",
                  Menus.OPTSEPARATOR,
                  (* Need to set the tyname attribute appropriately *)
                  Menus.OPTTOGGLE ("oldDefinition",
                                   get_context_option_fun #old_definition,
                                   fn b =>
                                   (Types.real_tyname_equality_attribute := b;
                                    set_context_option_fun #old_definition b)),
                  bool_context_widget("abstractions",#abstractions),
                  bool_context_widget("opInDatatype", #nj_op_in_datatype),
                  bool_context_widget("njSignatures", #nj_signatures),
                  bool_context_widget("weakTyvars", #weak_type_vars),
                  bool_context_widget("fixitySpecs", #fixity_specs),
                  bool_context_widget("openFixity", #open_fixity),
                  Menus.OPTSEPARATOR,
                  Menus.OPTLABEL "extensionsOptionsLabel",
                  Menus.OPTSEPARATOR,
                  bool_context_widget("requireKeyword",#require_keyword),
                  bool_context_widget("typeDynamic",#type_dynamic)
	  	(*
                  bool_context_widget("defaultOverloads", #default_overloads)
	  	*)
                  ])
                
              val (compiler_dialog,compiler_dialog_update) =
	        popup_compiler_options parent

              val (language_dialog,language_dialog_update) =
	        popup_language_options parent

              fun update_dialogues () =
                app
                (fn f => f ()) 
                [mode_dialog_update,
                 compiler_dialog_update,
                 language_dialog_update]

	      val result = 
                FULL_MOTIF_CONTEXT
                  {user_context = user_context,
	           mode_dialog = mode_dialog,
	  	   compiler_dialog = compiler_dialog,
	  	   language_dialog = language_dialog,
	           update_fn = update_dialogues}
	    in
	      context_list := result :: !context_list;
	      update_fns := [update_dialogues];
	      result
	    end
        end
  end (* abstype MotifContext *)
       
  (* The code for managing the initial MotifContext is similar to that for
     managing the initial UserContext (in the structure of that ilk). *)
  val initialContext = ref NONE

  fun makeInitialContext (parent, user_preferences) =
    let
      val user_context = UserContext.getInitialContext ()

      val motif_context =
	make_context (user_context, parent, user_preferences)
    in
      initialContext := SOME motif_context;
      context_list := [motif_context]
    end

  fun getInitialContext () =
    case !initialContext
    of SOME c => c
    |  _ => Crash.impossible "Bad initial motif context!"

  fun save_history (prompt, user_context, applicationShell) =
    let
      val filename_opt =
        if prompt then
          Capi.save_as_dialog (applicationShell, ".sml")
        else
          case UserContext.get_saved_file_name user_context
          of NONE =>
            Capi.save_as_dialog (applicationShell, ".sml")
          |  x => x
    in
      case filename_opt of
        NONE => ()
      | SOME filename =>
        let
          val file = TextIO.openOut filename

          (* examine_source checks whether the source ends with a
             semi-colon, and if so whether the semicolon is followed
             by a newline.  It skips trailing white space. *)
          fun examine_source (s, ~1, seen_newline) =
            (false, false)
          |   examine_source (s, n, seen_newline) =
            let
              val c = MLWorks.String.ordof (s, n)
            in
              if c = ord #";" then
                (true, seen_newline)
              else if c = ord #"\n" then
                examine_source (s, n-1, true)
              else if c = ord #" " orelse c = ord #"\t" then
                examine_source (s, n-1, seen_newline)
              else
                (false, false)
            end

          fun massage_source s =
            let
              val (has_semicolon, has_newline) =
                examine_source (s, size s - 1, false)
            in
              s ^ (if has_semicolon then "" else ";")
                ^ (if has_newline then "" else Capi.terminator)
            end

          fun write_hist (UserContext.ITEM {source, ...}) =
	    case source
	    of UserContext.STRING str =>
              TextIO.output (file, massage_source str)
	    |  _ => ()

          val context_name = UserContext.get_context_name user_context

          val hist = UserContext.get_history user_context
        in
          app write_hist (rev hist);
          TextIO.flushOut file;
          TextIO.closeOut file;
          Capi.send_message
		(applicationShell, "Saved " ^ context_name ^ " to " ^ filename);
          UserContext.set_saved_file_name (user_context, filename)
        end
        handle IO.Io _ => ()
    end

  fun null_history user_context =
    let
	  val hist = UserContext.get_history user_context
    in
	  length hist = 0
    end

  fun save_name_set user_context =
    case UserContext.get_saved_file_name user_context
    of NONE => false
    |  SOME _ => true

  fun make_search_dialog (shell, get_context, action_fn, choose_contexts) =
    let
      fun flat (x::xs) = (concat x ^ "\n") :: (flat xs)
        | flat [] = []
              
      val searchOptions =
        {showSig = ref true,
         showStr = ref true,
         showFun = ref true,
         searchInitial = ref choose_contexts,
         searchContext = ref choose_contexts,
         showType = ref false}
      
      fun mkSearchOptions
            {showSig, showStr, showFun, searchInitial,
	     searchContext, showType} =
	Entry.SEARCH_OPTIONS
	  {showSig = !showSig,
	   showStr = !showStr,
	   showFun = !showFun,
	   searchInitial = !searchInitial,
	   searchContext = !searchContext,
	   showType = !showType}

      val searchString = ref ""
	
         
      fun search s =
        let
          fun getItemsFromContext c =
	    let
              val context = UserContext.get_delta (get_user_context c)
            in
              Entry.context2entry context
            end
                            
          fun grep regexp line =
            let
              fun startsWith [] ys = true
                | startsWith xs [] = false
                | startsWith (x::xs) (y::ys) = (x=y) andalso (startsWith xs ys)
              fun check [] ys = false
                | check xs [] = false
                | check xs (y::ys) = startsWith xs (y::ys) orelse check xs ys
            in
              check (explode regexp) (explode line)
            end (* grep *)
        
          val _ = searchString := s
	  
          val context_list =
            if !(#searchInitial searchOptions) then
	      if !(#searchContext searchOptions) then
                getItemsFromContext(getInitialContext())
                @ getItemsFromContext (get_context ())
	      else
                getItemsFromContext(getInitialContext())
            else
              getItemsFromContext (get_context ())

          val options = Options.default_options

          (* datatype Entry is a linear structure, munge to tree like form *)
          val entrys = map Entry.massage context_list
          val entrys' =
	    Entry.printEntry1
	      (mkSearchOptions searchOptions, options, entrys)

          val found = map #1 (Lists.filterp (fn (_,name) => grep s name) entrys')
          val _ =
	    Capi.list_select
              (shell, "searchList", fn _ => ())
              (found, action_fn, fn x => x)
        in
	  ()
        end (* search *)

      fun getter r () = !r
      fun setter r b = (r := b; true)
      fun toggle (s, r) = Menus.OPTTOGGLE(s, getter r, setter r)

      val tail = 
	if choose_contexts then
          [Menus.OPTSEPARATOR,
           toggle ("searchPervasives",#searchInitial searchOptions),
           toggle ("searchUserContext",#searchContext searchOptions)]
	else
	  []

      val search_for = ref NONE

      val searchSpec =
        [Menus.OPTTEXT
         ("itemSearch", fn () => !searchString , 
                        fn s  => (search_for := SOME s; true)),
         Menus.OPTSEPARATOR,
         Menus.OPTLABEL "Search inside...",
         Menus.OPTSEPARATOR,
         toggle ("signatures", #showSig searchOptions),
         toggle ("functors", #showFun searchOptions),
	 Menus.OPTSEPARATOR,
         toggle ("displayEntryTypes", #showType searchOptions)]
	@ tail
    in
      Menus.create_dialog
        (shell, "Search Dialog", "browserDialog", 
         fn () => (case !search_for of NONE => () | SOME s => (search s; ())), 
         searchSpec)
    end


  fun search_button (shell, get_context, action_fn, choose_contexts) =
    let
      val (searchPopup, _) =
        make_search_dialog (shell, get_context, action_fn, choose_contexts)
    in
      Menus.PUSH ("search", searchPopup, fn _ => true)
    end

  (* All option dialogs for context-specific options are created once for
     each context.  The context menu must get the correct dialogs. (Currently
     the options are on the setup menu instead.  This is temporary). *)
  fun context_menu
	{set_state, get_context, writable, applicationShell,
         shell, user_preferences} =
    let
      val Preferences.USER_PREFERENCES (preferences_record, _) =
	user_preferences

      fun get_current_user_context () =
        get_user_context (get_context ())
      
      (* If full_menus is set, then users can create multiple contexts
	 and select between them.  *)
      val tail_menu =
        if !(#full_menus preferences_record) then
	  let
            fun select_menu () =
	      let
	        fun make_item c =
                  let
	            val name = get_context_name c
                  in
	            Menus.PUSH (name, fn _ => set_state c, fn _ => true)
                  end
      
	        val contexts =
	          if writable = WRITABLE then
	            Lists.filter_outp
	              (UserContext.is_const_context o get_user_context)
		      (!context_list)
	          else
                    !context_list
	      in
                map make_item contexts
	      end
      
            fun push_state _ =
	      set_state
	        (make_context
	           (UserContext.copyUserContext (get_current_user_context ()),
	            applicationShell, user_preferences))
      
            fun initialContext _ =
	            set_state
	        (make_context
	          (UserContext.getNewInitialContext (),
	           applicationShell, user_preferences))
      
            val is_constant =
    	      UserContext.is_const_context o get_current_user_context

	    val sub_tail =
              [Menus.SEPARATOR,
               Menus.DYNAMIC ("contextSelect", select_menu, fn _ => true)]
	  in
	    (* A tool can only create new contexts if it can write to them. *)
            if writable = WRITABLE then
              [Menus.SEPARATOR,
	       Menus.PUSH ("pushContext", push_state, fn _ => true),
               Menus.PUSH ("initialContext", initialContext, fn _ => true)]
	      @ sub_tail
	    else
	      sub_tail
	  end
	else
	  []

      val save_items =
	if UserContext.is_const_context (get_current_user_context ()) then
	  []
	else
          [Menus.PUSH
             ("save",
              fn _ =>
	        save_history
		  (false, get_current_user_context (), shell),
              fn _ => not (null_history (get_current_user_context ()))
		          andalso save_name_set (get_current_user_context ())),
           Menus.PUSH
             ("saveAs",
              fn _ =>
                save_history
	          (true, get_current_user_context (), shell),
              fn _ => not (null_history (get_current_user_context ())))]
    in
      Menus.CASCADE
        ("context", save_items @ tail_menu, fn _ => true)
    end

    fun listener_properties (parent, get_context) = 
      let
        fun popup_mode_dialog _ =
	  (get_mode_dialog (get_context ())) ()
          
        fun popup_compiler_dialog _ =
	  (get_compiler_dialog (get_context ())) ()
          
        fun popup_language_dialog _ =
	  (get_language_dialog (get_context ())) ()
      in
	Menus.CASCADE ("listen_props", 
	  [Menus.PUSH("mode", popup_mode_dialog, fn _ => true),
	   Menus.PUSH("compiler", popup_compiler_dialog, fn _ => true),
	   Menus.PUSH("language", popup_language_dialog, fn _ => true)],
	  fn _ => true)
      end

    fun setup_menu (parent, get_context, user_preferences, get_user_context_options) =
      let
        (* When the preferences are updated, the dialog boxes must be
           updated to match them.  This is done by storing update
           functions in the user_preferences. *)
        val Preferences.USER_PREFERENCES (preferences, update_fns) =
          user_preferences

        fun preference_update () = () 

        fun set_preference_fun f a =
          ((f preferences) := a;
	   true)

        fun get_preference_fun f () =
          !(f preferences)

        fun popup_editor_options parent =
          Menus.create_dialog
          (parent,
           title_for_global_dialogs,
	   "editorOptions",
           preference_update,
           [Menus.OPTLABEL "editorOptionsLabel",
            Menus.OPTSEPARATOR,
	    Menus.OPTRADIO 
                [Menus.OPTTOGGLE ("select_external_editor",
                             fn () => case get_preference_fun (#editor) () of
  			                "External" => true
  			              | _ => false,
                             fn true => set_preference_fun (#editor) "External"
                              | false => true),
                 Menus.OPTTOGGLE ("select_one_way_editor",
                             fn () => case get_preference_fun (#editor) () of
  			                "OneWay" => true
  			              | _ => false,
                             fn true => set_preference_fun (#editor) "OneWay"
                              | false => true),
		 Menus.OPTTOGGLE ("select_two_way_editor",
				  fn () => case get_preference_fun (#editor) () of
					"TwoWay" => true
				      | _ => false,
				  fn true => set_preference_fun (#editor) "TwoWay"
				   | false => true)],
	    Menus.OPTTEXT ("external_editor_command",
			   get_preference_fun (#externalEditorCommand),
			   set_preference_fun (#externalEditorCommand)),
	    Menus.OPTLABEL "editorOneWayLabel",
	    Menus.OPTCOMBO ("one_way_editor_name",
			   fn () => (
			      get_preference_fun (#oneWayEditorName) (),
			      CustomEditor.commandNames()),
			   set_preference_fun (#oneWayEditorName)),
	    Menus.OPTLABEL "editorTwoWayLabel",
	    Menus.OPTCOMBO ("two_way_editor_name",
			   fn () => (
			      get_preference_fun (#twoWayEditorName) (),
			      CustomEditor.dialogNames()),
			   set_preference_fun (#twoWayEditorName))])

        fun popup_environment_options parent =
            Menus.create_dialog
              (parent,
               title_for_global_dialogs,
	       "environmentOptions",
               preference_update,
               [Menus.OPTLABEL "environmentOptionsLabel",
                Menus.OPTSEPARATOR,
                Menus.OPTINT ("maximumHistoryLength",
                              get_preference_fun (#history_length),
                              fn x =>
			      x > 0 andalso
			      (set_preference_fun (#history_length) x)),
                Menus.OPTINT ("maximumNumberErrors",
                              get_preference_fun (#max_num_errors),
                              fn x  =>
			      x > 0 andalso
			      (set_preference_fun (#max_num_errors) x)),
                Menus.OPTTOGGLE ("useRelativePathname",
                                 get_preference_fun (#use_relative_pathname),
                                 set_preference_fun (#use_relative_pathname)),
                Menus.OPTTOGGLE ("completionMenu",
                                 get_preference_fun (#completion_menu),
                                 set_preference_fun (#completion_menu)),
                Menus.OPTTOGGLE ("useDebugger",
                                 get_preference_fun (#use_debugger),
                                 set_preference_fun (#use_debugger)),
                Menus.OPTTOGGLE ("useErrorBrowser",
                                 get_preference_fun (#use_error_browser),
                                 set_preference_fun (#use_error_browser)),
                Menus.OPTTOGGLE ("windowDebugger",
                                 get_preference_fun (#window_debugger),
                                 set_preference_fun (#window_debugger))])

        val (editor_dialog,editor_update) =
          popup_editor_options parent

        val (environment_dialog,environment_update) =
          popup_environment_options parent

        fun save_preferences _ =
          case Getenv.get_preferences_filename () of
            NONE => ()
          | SOME pathname =>
              let
                val outstream = TextIO.openOut pathname
              in
                (Preferences.save_to_stream (user_preferences,outstream);
                 UserOptions.save_to_stream (get_user_context_options(),outstream))
                handle exn => (TextIO.closeOut outstream; raise exn);
                TextIO.closeOut outstream
              end

      in
	update_fns := editor_update :: environment_update :: !update_fns;

	[("editor", fn _ => editor_dialog (), fn _ => true),
	 ("environment", fn _ => environment_dialog (), fn _ => true),
	 ("savePreferences", save_preferences, fn _ => true)]
      end

    datatype ViewOptions = SENSITIVITY | VALUE_PRINTER | INTERNALS

    (* This function creates the dialogs when the menu is created.
       This prevents the same dialog being created twice for each window. *)
    (* The caller_update_fn allows the calling tool to be updated as a
       result of setting an option - e.g. making a tool newly sensitive 
       to the current selection. *)
    fun view_options
	  {parent, title, user_options, user_preferences,
	   caller_update_fn, view_type} =
      let
        val UserOptions.USER_TOOL_OPTIONS (options, update_fns) =
          user_options

        val Preferences.USER_PREFERENCES (preferences, _) =
	  user_preferences

        fun set_tool_option_fun f a =
          ((f options) := a;
	   true)
           
        fun get_tool_option_fun f () =
          !(f options)
            
        fun int_tool_widget (name, accessor) =
          Menus.OPTINT
	    (name,
	     get_tool_option_fun accessor,
	     set_tool_option_fun accessor)
            
        fun bool_tool_widget (name, accessor) =
          Menus.OPTTOGGLE
	    (name,
	     get_tool_option_fun accessor,
	     set_tool_option_fun accessor)

        fun do_update () =
          (app
	     (fn f => f ())
	     (!update_fns);
	   caller_update_fn user_options)

        fun popup_valueprinter_options parent =
          Menus.create_dialog
          (parent,
	   title,
           "valuePrinterOptions",
           do_update,
           [Menus.OPTLABEL "valuePrinterOptionsLabel",
            Menus.OPTSEPARATOR,
            bool_tool_widget("showFnDetails",#show_fn_details),
            bool_tool_widget("showExnDetails",#show_exn_details),
            int_tool_widget("floatPrecision",#float_precision),
            int_tool_widget("maximumSeqSize",#maximum_seq_size),
            int_tool_widget("maximumStringSize",#maximum_string_size),
            int_tool_widget("maximumDepth",#maximum_depth),
            int_tool_widget("maximumRefDepth",#maximum_ref_depth),
            int_tool_widget("maximumSigDepth",#maximum_sig_depth),
            int_tool_widget("maximumStrDepth",#maximum_str_depth)
            ])
              
        fun popup_sensitivity_options parent =
          Menus.create_dialog
          (parent,
	   title,
           "sensitivityOptions",
           do_update,
           [Menus.OPTLABEL "sensitivityOptionsLabel",
            Menus.OPTSEPARATOR]
	   @ (if !(#full_menus preferences) then
                [bool_tool_widget("senseContext",#sense_context),
                 bool_tool_widget("setContext",#set_context)]
	      else
	        []))

        fun popup_internals_options parent =
          Menus.create_dialog
          (parent,
           title,
           "internalsOptions",
           do_update,
           [Menus.OPTLABEL "internalsOptionsLabel",
            Menus.OPTSEPARATOR,
            bool_tool_widget("showAbsyn",#show_absyn),
            bool_tool_widget("showLambda",#show_lambda),
            bool_tool_widget("showOptLambda",#show_opt_lambda),
            bool_tool_widget("showEnviron",#show_environ),
            bool_tool_widget("showMir",#show_mir),
            bool_tool_widget("showOptMir",#show_opt_mir),
            bool_tool_widget("showMach",#show_mach)])

	fun add_item (menu_spec, SENSITIVITY) =
	  if !(#full_menus preferences) then
	    let
              val (sensitivity_dialog, sensitivity_dialog_update) =
	        popup_sensitivity_options parent
	    in
	      update_fns := sensitivity_dialog_update :: !update_fns;
              Menus.PUSH
	        ("sensitivity", fn _ => sensitivity_dialog (), fn _ => true) ::
		menu_spec
	    end
	  else
	    menu_spec
	|   add_item (menu_spec, VALUE_PRINTER) =
	  let
            val (valueprinter_dialog, valueprinter_dialog_update) =
	      popup_valueprinter_options parent
	  in
	    update_fns := valueprinter_dialog_update :: !update_fns;
            Menus.PUSH
	      ("valueprinter", fn _ => valueprinter_dialog (), fn _ => true) ::
	      menu_spec
	  end
	|   add_item (menu_spec, INTERNALS) =
	  let
            val (internals_dialog, internals_dialog_update) =
              popup_internals_options parent
	  in
	    update_fns := internals_dialog_update :: !update_fns;
            Menus.PUSH
	      ("internals", fn _ => internals_dialog (), fn _ => true) ::
	      menu_spec
	  end
      in
	update_fns := [];
	Menus.CASCADE ("dummy", Lists.reducel add_item ([], rev view_type), fn () => false)
      end
              
  local

    val do_debug = false
    fun debug s = if do_debug then Terminal.output(s ^ "\n") else ()

  in
    fun value_menu {parent, user_preferences, inspect_fn, get_value, enabled, tail} =
	let
	  val current_item = ref NONE : (string * (MLWorks.Internal.Value.T * Type)) option ref

	  fun message_fun s =
            Capi.send_message (parent, s)

          fun set_current_item () =
	    current_item := get_value ()

          fun is_current_item _ =
            case !current_item of
              NONE => false
            | _ => true

          fun get_current_item _ =
            case !current_item of
              NONE => Crash.impossible "get_current_item"
            | SOME x => x

          fun get_current_value _ = #1 (#2 (get_current_item ()))
          (* This happens to be the first function called *)
          (* Really there should be a separate "popdown" function *)
	  fun object_editable _ =
	     (set_current_item ();
              is_current_item () andalso enabled andalso
              ShellUtils.object_editable (get_current_value ()))

	  fun object_traceable _ =
            (set_current_item (); is_current_item () andalso enabled andalso
            ShellUtils.object_traceable (get_current_value()))

	  fun edit_object _ =
	    let
              val preferences = Preferences.new_preferences user_preferences
	    in
	      (ignore(ShellUtils.edit_object (get_current_value (), preferences));())
	      handle ShellUtils.EditFailed s => message_fun ("Edit failed: " ^ s)
	    end

	  fun trace_object _ = ShellUtils.trace (get_current_value())

	  fun untrace_object _ = ShellUtils.untrace(get_current_value())

          val (inspect_object,object_inspectable) =
            case inspect_fn of
              SOME f => (f o get_current_item,
			fn () => (set_current_item(); is_current_item() andalso enabled))
            | _ => (fn _ => Crash.impossible "inspect_fn",fn _ => false)
	in
	   Menus.CASCADE ("value",
			  [Menus.PUSH ("editSource",
				       edit_object,
				       object_editable),
                           Menus.PUSH ("inspect",
                                       inspect_object,
                                       object_inspectable),
			   Menus.PUSH ("trace",
				       trace_object,
				       object_traceable),
			   Menus.PUSH ("untrace",
				       untrace_object,
				       object_traceable)]
			  @ (case tail
			     of [] => []
			     |  l => Menus.SEPARATOR :: l),
			  fn _ => true)
	end
  end



  local
     fun test_val (r,v) = (fn _ => (!r = v))
     fun set_val  (r,v) = (fn b => ((if b then (r := v) else ());
				    true))

     fun test_ref (r) = (fn _ => !r)
     fun set_ref (r) = (fn n => (r := n;
				 true))
  in
     fun toggle_value (s,r,v)  = Menus.OPTTOGGLE  (s, test_val(r,v), set_val(r,v))
     fun bool_value (s,r)      = Menus.OPTTOGGLE  (s,test_ref r, set_ref r)
     fun text_value (s,r)      = Menus.OPTTEXT    (s,test_ref r, set_ref r)
     fun int_value (s,r)       = Menus.OPTINT     (s,test_ref r, set_ref r)
  end

  (* local functions for the make_history function *)
  local
    (* One day we will have an option for this *)
    fun get_max_history_width user_options = 30

    fun contains_nasty_chars s =
      let
        fun aux n =
          if n = 0 then false
            else
              let val chr = MLWorks.String.ordof(s,n-1)
              in
                if chr = ord #"\n" orelse chr = ord #"\t"
                  then true
                else aux (n-1)
              end
      in
        aux (size s)
      end
  
    fun remove_nasty_chars s =
      let fun subst #"\n" = #" "
            | subst #"\t" = #" "
            | subst c = c
      in
        implode (map subst (explode s))
      end

    fun trim_history_string (s,user_options) =
      let
        val max_width = get_max_history_width user_options
        val trim_string =
          if size s > max_width
            then substring (* could raise Substring *)(s,0,max_width - 2) ^ ".."
          else s
      in
        if contains_nasty_chars trim_string
          then remove_nasty_chars trim_string
        else trim_string
      end
    
    (* There is no need to go throught an options structure for this. *)
    fun get_max_history_length user_preferences =
      let
        val Preferences.USER_PREFERENCES ({history_length,...}, _) =
          user_preferences
      in
        !history_length
      end
        
    fun whitespacep x =
      case x of
        #" " => true
      | #"\n" => true
      | #"\t" => true
      | #"\012" => true
      | #"\013" => true
      | _ => false

    fun strip_whitespace s =
      let
        fun strip [] = []
          | strip (l as (a::b)) =
            if whitespacep a then strip b else l
      in
        implode (rev (strip (rev (strip (explode s))))) (* Yuk Yuk *)
      end
  
  in
    (* tool-specific input history *)
    fun make_history (user_preferences, use_entry) =
      let
        (* The history is a list of string * int pairs, where the int is an
	   index number.  The index is used to set the current_index ref when
	   a string is selected from the menu.  The current_index ref is also
	   adjusted by the next_history and prev_history commands, which step
	   forward and back through the history list. *)
  
        val history = ref []: (string * int) list ref;
        val history_size = ref 0;
        val initial_index = ~1;
        val history_index = ref initial_index;

        fun add_history_entry "" = ()
        |   add_history_entry item =
          let
            fun aux ([], _) = ([], 0)
            |   aux ((s,i)::l, ix) =
              if ix <= 1 then
	        ([], 0)
              else if s = item then
		(l, i)
              else
		let
		  val (l, i) = aux (l, ix - 1)
		in
                  ((s, i) :: l, i + 1)
		end

	    val (new_history, new_size) =
              aux (!history, get_max_history_length user_preferences)
          in
	    history := (item, new_size) :: new_history;
	    history_size := new_size + 1
          end

        fun update_history l =
          (app (add_history_entry o strip_whitespace) l;
 	   history_index := initial_index)
  
        fun prev_history () =
          let val _ = history_index := !history_index + 1
              val line = #1 (Lists.nth (!history_index, !history))
          in
	    use_entry line
          end
          handle Lists.Nth => history_index := !history_index - 1;
  
        fun next_history () =
          let val _ = history_index := !history_index - 1;
              val line = #1 (Lists.nth (!history_index, !history))
                         handle
                           Lists.Nth =>
                             (history_index := initial_index;
                              ""  (* empty input *))
          in
	    use_entry line
          end
  
        fun history_end () = !history_index = initial_index
        fun history_start () = !history_index = !history_size - 1
  
        fun warp_history string =
          trim_history_string (string, user_preferences)
  
        val history_menu =
           Menus.DYNAMIC
	     ("history",
              fn () =>
		map
		  (fn (s,i) =>
		     Menus.PUSH
		       (warp_history s,
                        fn _ =>
			  (history_index := !history_size - i - 1;
			   use_entry s),
                        fn _ => true))
                  (!history),
              fn _ => !history <> [])
  
      in
        {update_history = update_history,
         prev_history = prev_history,
         next_history = next_history,
         history_end = history_end,
         history_start = history_start,
         history_menu = history_menu}
      end
  end

end

