(* podium.sml the functor.
 *  
 *  $Log: _podium.sml,v $
 *  Revision 1.80  1999/05/13 13:57:15  daveb
 *  [Bug #190553]
 *  Replaced use of basis/exit with utils/mlworks_exit.
 *
 *  Revision 1.79  1999/04/30  16:16:55  johnh
 *  [Bug #190552]
 *  Test return value of ProjProperties.new_project.
 *
 *  Revision 1.78  1998/11/23  12:51:24  johnh
 *  [Bug #70214]
 *  call ProjectWorkspace.updateDisplay before (and after) actions such as opening a different project.
 *
 *  Revision 1.77  1998/07/29  13:22:34  mitchell
 *  [Bug #30450]
 *  Replace broken dummy output routine in use of PrimIO writer
 *
 *  Revision 1.76  1998/07/14  09:33:15  jkbrook
 *  [Bug #30435]
 *  Remove license-prompting code
 *
 *  Revision 1.75  1998/07/09  14:01:12  johnh
 *  [Bug #30400]
 *  remove main_windows arg from exit_mlworks arg.
 *
 *  Revision 1.74  1998/06/22  13:54:06  mitchell
 *  [Bug #30429]
 *  Warn when saving sessions with debugging information enabled
 *
 *  Revision 1.73  1998/06/11  16:48:22  jkbrook
 *  [Bug #30411]
 *  Include Free edition
 *
 *  Revision 1.72  1998/06/11  15:17:36  johnh
 *  [Bug #30411]
 *  Call Capi.show_splash_screen.
 *
 *  Revision 1.71  1998/05/26  13:56:26  mitchell
 *  [Bug #30413]
 *  Use abstract exit status
 *
 *  Revision 1.70  1998/05/14  15:24:54  johnh
 *  [Bug #30384]
 *  Project Workspace should start up if MLWorks starts up with an open project.
 *
 *  Revision 1.69  1998/03/26  12:29:32  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.68  1998/03/16  11:06:44  mitchell
 *  [Bug #50061]
 *  Remove redundant call to make_history
 *
 *  Revision 1.67  1998/02/19  20:16:33  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.66  1998/02/18  17:11:31  jont
 *  [Bug #70070]
 *  Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 *  Revision 1.65  1998/02/10  15:40:52  jont
 *  [Bug #70065]
 *  Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 *  Revision 1.64  1998/01/27  16:52:02  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 *  Revision 1.63  1997/10/09  15:06:46  johnh
 *  [Bug #30193]
 *  Call SysMessages.create.
 *
 *  Revision 1.62.2.5  1998/01/07  16:55:14  johnh
 *  [Bug #30071]
 *  Display Project Workspace window asap.
 *
 *  Revision 1.62.2.4  1997/12/10  14:02:41  johnh
 *  [Bug #30071]
 *  Add save_project_as to file menu.
 *
 *  Revision 1.62.2.3  1997/11/24  12:11:27  johnh
 *  [Bug #30071]
 *  Add File->ChangeCurrentDirectory (PathTool function).
 *
 *  Revision 1.62.2.2  1997/09/12  14:44:13  johnh
 *  [Bug #30071]
 *  Implement new Project Workspace tool.
 *
 *  Revision 1.62  1997/07/17  16:24:58  johnh
 *  [Bug #20074]
 *  Improve license dialog.
 *
 *  Revision 1.61  1997/06/17  15:32:55  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.45  1997/06/09  15:09:20  johnh
 * [Bug #02030]
 * Removed Edit Error from the Listener menu.
 *
 * Revision 1.44  1997/06/09  10:26:58  johnh
 * [Bug #30068]
 * Making Break/Trace manager top level tool.
 *
 * Revision 1.43  1997/05/27  14:08:52  johnh
 * [Bug #20033]
 * Banner only displayed now if SaveImage.show_banner is true.
 *
 * Revision 1.42  1997/05/22  15:15:14  johnh
 * [Bug #20023]
 * Set Capi.evaluating to false when loading image.
 *
 * Revision 1.41  1997/05/21  09:02:06  johnh
 * Implementing toolbar on Windows.
 *
 * Revision 1.40  1997/05/16  15:34:42  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.39  1997/03/27  14:48:15  daveb
 * [Bug #1990]
 * Version.version_string is now Version.versionString, and a function instead
 * of a constant.
 *
 * Revision 1.38  1997/03/25  11:55:21  andreww
 * [Bug #1989]
 * Removing exn_name_string (giving functionality to exn_name).
 *
 * Revision 1.37  1997/03/17  11:39:40  andreww
 * [Bug #1677]
 * adding new access field to currentIO record.
 *
 * Revision 1.36  1996/11/20  18:46:09  daveb
 * [Bug #1796]
 * Corrected a bug introduced by the previous change: mainWindow must be
 * revealed before calling initialize_application_shell.
 *
 * Revision 1.35  1996/11/18  11:37:37  daveb
 * Added splash screen.
 *
 * Revision 1.34  1996/11/12  11:45:33  daveb
 * Revised licensing scheme to allow registration-style licensing.
 *
 * Revision 1.33  1996/11/01  14:42:56  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.32  1996/10/30  21:41:54  io
 * [Bug #1614]
 * remove toplevel String
 *
 * Revision 1.31  1996/10/17  12:55:49  jont
 * Add license server stuff
 *
 * Revision 1.30.1.2  1996/10/08  12:21:28  jont
 * Add call to initialise license
 *
 * Revision 1.30.1.1  1996/10/07  16:03:42  hope
 * branched from 1.30
 *
 * Revision 1.30  1996/09/23  14:01:18  matthew
 * Adding register_interrupt_window to capi
 *
 * Revision 1.29  1996/09/19  13:00:49  johnh
 * [Bug #1583]
 * passing has_controlling_tty to exit_mlworks instead of passed ing false.
 *
 * Revision 1.27  1996/07/15  12:47:22  andreww
 * propagating changes made to the GUI standard IO redirection mechanism
 * (see __pervasive_library.sml for the StandardIO structure)
 *
 * Revision 1.26  1996/07/02  15:14:15  andreww
 * Setting up the Gui StandardIO flag, so that system/__primio.sml
 * can detect the GUI even without a listener.
 *
 * Revision 1.25  1996/05/30  13:19:41  daveb
 * The Interrupt exception is no longer at top level.
 *
 * Revision 1.24  1996/05/29  14:39:21  daveb
 * DebuggerWindow.make_debugger_window now returns a clean-up function to call
 * at the end of each evaluation.
 *
 * Revision 1.23  1996/05/20  15:49:30  daveb
 * Added Save Image menu entry.
 *
 * Revision 1.22  1996/05/17  10:16:53  matthew
 * Improvng handling of uncaught exceptions at top level
 *
 * Revision 1.21  1996/05/16  13:16:51  stephenb
 * Update wrt MLWorks.Debugger -> MLWorks.Internal.Debugger change.
 *
 * Revision 1.20  1996/05/14  13:57:34  daveb
 * Reorganised menus to include File menu.
 *
 * Revision 1.19  1996/05/03  14:24:17  nickb
 * Add delivery wrapper around start_x_interface
 *
 * Revision 1.18  1996/05/01  11:25:52  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.17  1996/03/12  14:02:01  matthew
 * Adding Paths menu
 *
 * Revision 1.16  1996/02/29  14:25:28  matthew
 * Adding extra params to setup_menu
 *
 * Revision 1.15  1996/01/23  15:59:51  daveb
 * Added context menu, and changed names of break and trace buttons.
 *
 * Revision 1.14  1996/01/22  11:41:37  daveb
 * Removed evaluator from tools menu.  Moved Windows menu to correct position.
 *
 * Revision 1.13  1996/01/17  15:26:36  matthew
 * Removing inspector from top level
 *
 * Revision 1.12  1995/12/12  15:37:55  daveb
 * Removed File Tool.
 *
 * Revision 1.11  1995/12/04  15:31:07  daveb
 * Added project tool.
 *
 * Revision 1.10  1995/11/16  14:07:37  matthew
 * Changing interface to tool_data
 *
 * Revision 1.9  1995/11/15  14:01:38  matthew
 * Adding windows menu
 *
 * Revision 1.8  1995/10/04  11:24:41  daveb
 * Type of setup_menu has changed.
 *
 * Revision 1.7  1995/09/11  13:20:57  matthew
 * Changing top level window initialization
 *
 * Revision 1.6  1995/09/05  12:59:25  matthew
 * Using make_nonml_scrolled_text
 *
 * Revision 1.5  1995/08/31  12:02:29  matthew
 * Renaming layout constructors
 *
 * Revision 1.4  1995/08/14  10:33:50  matthew
 * Changes to make_main_subwindows
 *
 * Revision 1.3  1995/08/11  10:24:35  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:58:25  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:46:29  matthew
 * new unit
 * New unit
 *
 *  Revision 1.59  1995/07/18  13:37:21  matthew
 *  Changin listener interface.
 *
 *  Revision 1.58  1995/07/07  15:31:08  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.57  1995/07/04  14:18:07  matthew
 *  Capifying
 *
 *  Revision 1.56  1995/06/15  13:03:20  daveb
 *  Hid details of WINDOWING type in ml_debugger.
 *
 *  Revision 1.55  1995/06/08  13:50:57  daveb
 *  InspectorTool no longer contains a Widget type.
 *
 *  Revision 1.54  1995/06/08  09:56:01  daveb
 *  Types of the InspectorTool functions have changed.
 *
 *  Revision 1.53  1995/06/01  12:53:37  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.52  1995/05/23  08:45:38  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.51  1995/05/19  15:52:28  daveb
 *  Added "Browse Initial" entry to tools menu.
 *
 *  Revision 1.50  1995/05/15  15:58:01  matthew
 *  Improving X_system_error message
 *
 *  Revision 1.49  1995/05/04  09:44:06  matthew
 *  Using createMenuBar for creating menuBar
 *
 *  Revision 1.48  1995/04/28  15:03:29  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.47  1995/04/24  15:52:14  matthew
 *  Make subwindow parents not be menuBar
 *  
 *  Revision 1.46  1995/04/24  10:40:14  daveb
 *  Added handler for Xm.SubLoopTerminated to mainLoop.
 *  
 *  Revision 1.45  1995/04/18  15:33:28  daveb
 *  Changes to context_menu.
 *  
 *  Revision 1.44  1995/04/13  17:56:39  daveb
 *  Xm.mainLoop is back to taking unit.
 *  
 *  Revision 1.43  1995/04/13  10:27:55  daveb
 *  Added a context menu.
 *  
 *  Revision 1.42  1995/04/07  10:52:57  daveb
 *  Added AppContext type to Xm library.
 *  
 *  Revision 1.41  1995/03/30  14:03:42  daveb
 *  Added ContextWindow to list of tools.
 *  
 *  Revision 1.40  1995/03/27  13:46:15  io
 *  catch X exn when DISPLAY left unset
 *  
 *  Revision 1.39  1995/03/17  11:50:36  daveb
 *  Added Writable component to tool list.
 *  
 *  Revision 1.38  1995/03/16  16:27:08  daveb
 *  Made all created tools share the same current_context value.
 *  
 *  Revision 1.37  1995/03/15  16:50:27  daveb
 *  listener_args now has a new type.
 *  
 *  Revision 1.36  1995/03/10  15:54:18  daveb
 *  GuiUtils.options_menu now takes an extra argument.
 *  
 *  Revision 1.35  1995/01/13  16:56:07  daveb
 *  Removed obsolete sharing constraint.
 *  
 *  Revision 1.34  1994/07/14  14:50:29  daveb
 *  start_x_interface now takes a boolean parameter that indicates whether
 *  it was called from a TTY.  If not, it MLWorks must have called it on
 *  start up, so it prints the version message.  This flag is passed into
 *  the appdata field of the ToolData type.
 *  
 *  Revision 1.33  1994/07/12  16:22:48  daveb
 *  ToolData.works_menu takes different arguments.
 *  InspectorTool.ToolData.ShellTypes.Option replaced with InspectorTool.Option
 *  
 *  Revision 1.32  1994/06/30  08:56:42  nickh
 *  Provide for messages to appear in the podium window.
 *  (and remove some dead code).
 *  
 *  Revision 1.31  1994/06/20  13:03:25  daveb
 *  Added the evaluator.
 *  Replaced context refs with user_contexts.
 *  
 *  Revision 1.30  1994/04/07  12:07:37  daveb
 *  Added case for DebuggerTrapped.
 *  
 *  Revision 1.29  1994/03/21  17:23:35  matthew
 *  Added catchall around event loop
 *  
 *  Revision 1.28  1994/02/02  11:59:57  daveb
 *  Changed substructure of InterMake.
 *  
 *  Revision 1.27  1993/12/09  14:38:08  matthew
 *  Added call to register application shell for inter client comms.
 *  
 *  Revision 1.26  1993/11/18  18:01:09  daveb
 *  The argument to Ml_Debugger.with_debugger_type now takesa frame argument
 *  instead of unit.
 *  
 *  Revision 1.25  1993/11/09  15:55:37  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.24  1993/10/22  17:00:49  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.23  1993/09/07  14:04:22  daveb
 *  Merged in bug fix.
 *  
 *  26,28d16
 *  Revision 1.22  1993/09/07  11:18:09  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.21.1.5  1993/11/09  15:44:17  daveb
 *  Made mainLoop properly tail recursive.
 *  
 *  Revision 1.21.1.4  1993/10/21  14:04:43  daveb
 *  Changed ToolData.works_menu to take a (unit -> bool) function that
 *  controls whether the Close menu option is enabled.
 *  
 *  Revision 1.21.1.3  1993/09/07  13:54:22  daveb
 *  Changed argument to debugger_type to ensure that it always uses a window
 *  debugger, even if the user prefers a TTY debugger (that preference only
 *  affects the listener).
 *  
 *  Revision 1.21.1.2  1993/09/06  15:21:31  daveb
 *  Wrapped debugger around mainLoop.
 *  
 *  Revision 1.21  1993/08/11  13:12:46  matthew
 *  Changes for automatic option menu updating
 *  
 *  Revision 1.20  1993/08/06  15:23:55  nosa
 *  Pass debugger_window to Inspector.
 *  
 *  Revision 1.19  1993/06/02  14:12:04  daveb
 *  Changed title to "MLWorks", since "MLWorks Console" wasn't popular.
 *  
 *  Revision 1.18  1993/05/13  14:02:29  daveb
 *  All tools now set their own titles and pass them to their options menus.
 *  
 *  Revision 1.17  1993/05/05  19:20:25  daveb
 *  Added InspectorTool to the list of tools.
 *  
 *  Revision 1.16  1993/05/05  11:50:02  daveb
 *  Moved exit_mlworks from _podium to _tooldata.  Added tools argument to
 *   works_menu(), removed exitApplication from TOOLDATA.
 *  
 *  Revision 1.15  1993/04/30  14:43:52  daveb
 *  Reorganised menus.
 *  
 *  Revision 1.14  1993/04/28  14:19:57  richard
 *  The podium now has a text messages widget and a horizontal menu bar
 *  rather than being like the old LispWorks podium.
 *  
 *  Revision 1.13  1993/04/21  14:53:16  daveb
 *  Removed context browser item from tools menu.
 *  
 *  Revision 1.12  1993/04/16  14:52:27  matthew
 *  Changed interface to tools
 *  Added file browser
 *  
 *  Revision 1.11  1993/04/05  14:58:14  daveb
 *  Names of Callbacks have changed.
 *  
 *  Revision 1.10  1993/04/02  15:18:02  matthew
 *  Removed Incremental structure
 *  
 *  Revision 1.9  1993/03/30  14:46:38  matthew
 *  Menus.MENUSPEC is no more
 *  
 *  Revision 1.8  1993/03/30  12:29:02  matthew
 *  Removed "destroying..": message
 *  
 *  Revision 1.7  1993/03/26  14:19:00  matthew
 *  Changed menus for consistency with listener
 *  
 *  Revision 1.6  1993/03/23  14:10:22  matthew
 *  Used generic menu facility
 *  
 *  Revision 1.5  1993/03/17  15:22:08  matthew
 *  Tried doing CloseDisplay instead of destroy applicationShell
 *  Currently commented out.
 *  
 *  Revision 1.4  1993/03/15  17:50:19  matthew
 *  Simplified ShellTypes type
 *  
 *  Revision 1.3  1993/03/15  14:43:45  daveb
 *  Prevented the podium from being resized.
 *  Changed quit dialog to offer option of returning to TTY listener or
 *  quitting completely.
 *  
 *  Revision 1.2  1993/03/08  15:24:39  matthew
 *  Changes for ShellData type
 *  
 *  Revision 1.1  1993/03/02  17:54:38  daveb
 *  Initial revision
 *  
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
 *)

require "__os";
require "../basis/__string";
require "^.utils.__messages";
require "^.utils.__terminal";

require "../main/user_options";
require "../main/preferences";
require "../main/version";
require "../main/proj_file";
require "../debugger/ml_debugger";
require "../gui/capi";
require "../gui/menus";
require "../gui/debugger_window";
require "../gui/tooldata";
require "../gui/listener";
require "../gui/gui_utils";
require "../gui/break_trace";
require "../gui/browser_tool";
require "../gui/context";
require "../gui/sys_messages";
require "../gui/proj_workspace";
require "^.gui.proj_properties";
require "^.gui.path_tool";
require "../interpreter/save_image";
require "podium";

functor Podium (
  structure Capi: CAPI
  structure UserOptions : USER_OPTIONS
  structure Preferences : PREFERENCES
  structure Version : VERSION
  structure Debugger_Window : DEBUGGERWINDOW
  structure ToolData : TOOL_DATA
  structure Menus : MENUS
  structure Listener: LISTENER
  structure BrowserTool : BROWSERTOOL
  structure ProjectWorkspace : PROJECT_WORKSPACE
  structure ContextHistory : CONTEXT_HISTORY
  structure GuiUtils : GUI_UTILS
  structure Ml_Debugger : ML_DEBUGGER
  structure SaveImage : SAVE_IMAGE
  structure BreakTrace : BREAK_TRACE
  structure SysMessages : SYS_MESSAGES
  structure ProjProperties : PROJ_PROPERTIES
  structure PathTool : PATH_TOOL
  structure ProjFile : PROJ_FILE

  sharing Ml_Debugger.ValuePrinter.Options = ToolData.ShellTypes.Options
  sharing type Ml_Debugger.preferences = ToolData.ShellTypes.preferences
  sharing type Listener.ToolData = ToolData.ToolData = 
               ProjectWorkspace.ToolData =
	       BrowserTool.ToolData = 
	       ContextHistory.ToolData =
	       Debugger_Window.ToolData =
	       BreakTrace.ToolData = 
	       SysMessages.ToolData
  sharing type Menus.Widget = ToolData.Widget = ProjProperties.Widget =
	       GuiUtils.Widget = Debugger_Window.Widget = Capi.Widget = 
	       PathTool.Widget
  sharing type GuiUtils.ButtonSpec = ToolData.ButtonSpec = Menus.ButtonSpec
  sharing type GuiUtils.user_tool_options = ToolData.ShellTypes.user_options =
    	       UserOptions.user_tool_options
  sharing type GuiUtils.user_context_options =
               UserOptions.user_context_options =
	       ToolData.UserContext.user_context_options
  sharing type Preferences.user_preferences = GuiUtils.user_preferences =
	       ToolData.ShellTypes.user_preferences
  sharing type GuiUtils.user_context = ToolData.ShellTypes.user_context
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
  sharing type Ml_Debugger.debugger_window = Debugger_Window.debugger_window
  sharing type ToolData.ShellTypes.ShellData = SaveImage.ShellData

): PODIUM =
struct
  structure ShellTypes = ToolData.ShellTypes
  structure UserContext = ToolData.UserContext

  type ListenerArgs = ShellTypes.ListenerArgs

  val tool_list =
    [("listener", Listener.create false, ToolData.WRITABLE),
     ("projWorkspace", ProjectWorkspace.create, ToolData.WRITABLE),
     ("contextBrowser", BrowserTool.create, ToolData.ALL),
     ("initialBrowser", BrowserTool.create_initial, ToolData.ALL),
     ("contextWindow", ContextHistory.create, ToolData.ALL),
     ("breakTrace", BreakTrace.create, ToolData.ALL)]

  (*
   * Here, on Motif, although the podium no longer exists, an application
   * shell still needs to be created so that tooldata can be created and 
   * passed to all the tools, and the Listener uses this application shell 
   * as the shell for the Listener window rather than for the podium window.
   * On Windows, a new shell is created for the Listener.  
   *)
  fun start_x_interface args has_controlling_tty =
    let
      val print_message = Messages.output

      (* The following few lines set the StandardIO internal flag to 
         indicate the presence of the GUI, so that system/__primio.sml 
         can detect the GUI even when it is being loaded by the compilation
         manager in the presence of no listeners.  At the moment, the
         current window is set to junk; the listeners will  set the flag to
         point to the correct window. *)

      fun put_string {buf, i, sz} =
        let val s = String.extract(buf, i, sz) in print_message s; size s end

      val _ = MLWorks.Internal.StandardIO.redirectIO
        {output={descriptor=NONE,
                 put=put_string,
                 get_pos = NONE,
                 set_pos = NONE,
                 can_output=NONE,
                 close = fn()=>()},
         error={descriptor=NONE,
                 put=put_string,
                 get_pos = NONE,
                 set_pos = NONE,
                 can_output=NONE,
                 close=fn()=>()},
         input={descriptor=NONE,
                get=fn _ => "",
                get_pos=NONE,
                set_pos=NONE,
                can_input=NONE,
                close=fn()=>()},
         access=fn f=> f ()}
        (* see <URI:spring:/ML_Notebook/Design/GUI/Mutexes> for a
         * description of the access field.*)

      val applicationShell = Capi.initialize_application ("mlworks","MLWorks",
		has_controlling_tty)

      val ShellTypes.LISTENER_ARGS
	    {user_options, user_preferences, user_context, ...} = args

      val (full_menus, update_fns) =
	case user_preferences
	of Preferences.USER_PREFERENCES ({full_menus, ...}, update_fns) =>
	  (!full_menus, update_fns)

      fun get_user_options () = user_options

      val _ = GuiUtils.makeInitialContext
	        (applicationShell, user_preferences)

      val current_context =
	ToolData.make_current
	  (GuiUtils.make_context
	     (user_context, applicationShell, user_preferences))

      fun get_context () = ToolData.get_current current_context

      fun copy_args (ShellTypes.LISTENER_ARGS {user_context,
                                               user_options,
					       user_preferences,
                                               prompter,
                                               mk_xinterface_fn}) =
        ShellTypes.LISTENER_ARGS
	  {user_context =
           GuiUtils.get_user_context (get_context ()),
	   user_preferences = user_preferences,
           user_options = UserOptions.copy_user_tool_options user_options,
           prompter = prompter,
           mk_xinterface_fn = mk_xinterface_fn}

      val appdata =
	ToolData.APPLICATIONDATA
	  {applicationShell = applicationShell,
	   has_controlling_tty = has_controlling_tty}

      fun mk_tooldata () =
	ToolData.TOOLDATA
	  {args = copy_args args, appdata = appdata,
	   motif_context = get_context (),
	   current_context = current_context, tools = tool_list}
	  
      fun create_listener () = Listener.create false (mk_tooldata())

      fun get_current_user_context () =
        GuiUtils.get_user_context (get_context ())

      fun get_user_context_options () = 
        UserContext.get_user_options (get_current_user_context ())

      local
	fun handler_fn msg = Capi.send_message (applicationShell, msg)
      in
        fun save_image _ =
          ( let val UserOptions.USER_CONTEXT_OPTIONS
                     ({generate_debug_info, generate_variable_debug_info, ...},
                      _) =
                      get_user_context_options ()
             in if !generate_debug_info orelse !generate_variable_debug_info
                then Capi.send_message(applicationShell,
                     "Enabling the debug options " ^
                     "may result in large saved images")
                else () 
            end;
           
	    case Capi.save_as_dialog (applicationShell, ".img")
   	    of NONE => ()
	    |  SOME filename => 
	      SaveImage.saveImage
	        (false, handler_fn)
	        (filename, false) )
      end

      val messagesWindow = SysMessages.create (mk_tooldata())

      fun wrapUpdate condition_fn =
	(ProjectWorkspace.updateDisplay();
	 if condition_fn applicationShell then 
	   ProjectWorkspace.updateDisplay()
	 else ())

      fun new_project () = 
	let 
	  fun create_new appShell = 
	    let val wantNew = ProjProperties.new_project appShell
	    in
	      if wantNew then ProjectWorkspace.create (mk_tooldata()) else ();
	      wantNew
	    end
	in
	  wrapUpdate create_new
	end

      fun open_project () = 
	let 
	  fun open_it appShell = 
	    ProjProperties.open_project appShell
		(fn () => ProjectWorkspace.create (mk_tooldata()))
	in
	  wrapUpdate open_it
	end

      fun save_project () = wrapUpdate ProjProperties.save_project
      fun save_project_as () = wrapUpdate ProjProperties.save_project_as

      fun project_exists () = isSome (ProjFile.getProjectName())

      val file_menu = ToolData.set_global_file_items
	([("new_proj", new_project, fn _ => true),
	 ("open_proj", open_project, fn _ => true),
	 ("save_proj", save_project, project_exists),
	 ("save_proj_as", save_project_as, project_exists),
	 ("save",
            fn _ =>
              GuiUtils.save_history
                (false, get_current_user_context (), applicationShell),
            fn _ =>
	      not (UserContext.null_history (get_current_user_context ()))
                   andalso UserContext.saved_name_set
			     (get_current_user_context ())),
         ("saveAs",
            fn _ =>
              GuiUtils.save_history
                (true, get_current_user_context (), applicationShell),
            fn _ =>
              not (UserContext.null_history (get_current_user_context ()))),
	 ("saveImage", save_image, fn _ => true),
	 ("setWD", fn _ => PathTool.setWD applicationShell, fn _ => true),
	 ("exit",
	    fn _ => ToolData.exit_mlworks (applicationShell, appdata),
	    fn _ => not (!Capi.evaluating))])

      val usage_menu = 
	ToolData.set_global_usage_items 
	   ( (GuiUtils.setup_menu
		(applicationShell, get_context, user_preferences,get_user_context_options)) @ 
	    [("sysMessages", messagesWindow, fn _ => true)],
	   [])

      val (run_debugger, clean_debugger) =
        Debugger_Window.make_debugger_window
	  (applicationShell, "MLWorks Debugger", mk_tooldata ())

      val debugger_type =
	Ml_Debugger.WINDOWING
	  (run_debugger,
	   (* I don't know what is the best function to use for the next
	      parameter here. *)
	   print_message, false)

      fun delivery_hook deliverer args =
        let
          fun inDeliveredImage f = 
	    let
	      val oldIO = MLWorks.Internal.StandardIO.currentIO()
	      val _ = MLWorks.Internal.StandardIO.resetIO();
	      val result = (f() handle exn =>
			    (MLWorks.Internal.StandardIO.redirectIO oldIO; raise exn))
	    in
	      MLWorks.Internal.StandardIO.redirectIO oldIO;
	      result
	    end
         in
           (fn () => inDeliveredImage(fn () => deliverer args)) ()
        end
           
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
  
      fun mainLoop frame =
	let
	  val loop =
	    (Capi.main_loop (); false)
	    (* normal return, don't loop *)
	    handle 
            MLWorks.Interrupt => true	(* interrupt, continue X interface *)
          | ShellTypes.DebuggerTrapped => true (* continue X interface *)
	  | Capi.SubLoopTerminated => false  (* break *)
          | exn => 
              (debugger_function exn;
	      clean_debugger ();
              true)
	in
	  if loop then mainLoop frame else ()   (* else stop_messages()  *)
	(* tail recursive call *)
	end

    in 
        (Capi.show_splash_screen applicationShell;
         create_listener();
	 if isSome(ProjFile.getProjectName()) then 
	   ProjectWorkspace.create (mk_tooldata())
	 else ();
         Capi.initialize_application_shell applicationShell;
	 (* Set to false here so that any saved images saved with Shell.saveImage 
	  * have the exit menu item enabled when the image is loaded *)
	 Capi.evaluating := false;
         MLWorks.Deliver.with_delivery_hook delivery_hook
           (Ml_Debugger.with_debugger_type debugger_type) mainLoop;
	 ())
    end
    handle Capi.WindowSystemError s =>
       Terminal.output("Graphics interface problem: "^s^"\n")
end;
