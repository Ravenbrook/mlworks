(*
 * $Log: _proj_workspace.sml,v $
 * Revision 1.33  1999/04/30 16:17:01  johnh
 * [Bug #190552]
 * Test return value of ProjProperties.new_project.
 *
 * Revision 1.32  1999/04/29  16:01:02  johnh
 * [Bug #190557]
 * Clarify use or purpose of the list of files displayed in the Project Workspace.
 *
 * Revision 1.31  1999/03/23  17:37:55  mitchell
 * [Bug #190532]
 * Ensure update_dependencies is called on subprojects first
 *
 * Revision 1.30  1999/02/03  16:00:06  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.29  1999/02/02  15:59:41  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.28  1998/11/24  12:04:42  johnh
 * [Bug #70214]
 * Update the project workspace after closing the properties dialogs, not before.
 *
 * Revision 1.27  1998/11/11  10:15:00  johnh
 * [Bug #70213]
 * Pass in close function to ErrorBrowser to bring focus back to PW.
 *
 * Revision 1.26  1998/08/26  13:52:10  mitchell
 * [Bug #30483]
 * Remove close-project? dialog at end of session
 *
 * Revision 1.25  1998/08/14  15:20:22  johnh
 * [Bug #50102]
 * Update project workspace window when file list changes (update target info).
 *
 * Revision 1.24  1998/08/03  12:30:37  johnh
 * [Bug #30459]
 * optionsFromProjFile should look up current option settings not default.
 *
 * Revision 1.23  1998/07/31  11:25:32  mitchell
 * [Bug #30440]
 * Allow user to save project changes when gui environment terminates
 *
 * Revision 1.22  1998/07/15  14:52:08  johnh
 * [Bug #30445]
 * Bring dialog for selecting new or existing project to the front.
 *
 * Revision 1.21  1998/07/09  14:43:11  johnh
 * [Bug #30400]
 * Fix returning to and from tty mode.
 *
 * Revision 1.20  1998/07/09  14:13:07  johnh
 * [Bug #30431]
 * Remove spurious test code.
 *
 * Revision 1.19  1998/07/02  15:06:54  johnh
 * [Bug #30431]
 * Make some text fields read only.
 *
 * Revision 1.18  1998/06/18  15:33:00  johnh
 * [Bug #30426]
 * Remove library path from Project Workspace.
 *
 * Revision 1.17  1998/06/09  13:22:18  mitchell
 * [Bug #30405]
 * Fix bug in updateConfig
 *
 * Revision 1.16  1998/06/01  16:04:34  johnh
 * [Bug #30369]
 * Replace source path with a list of files.
 *
 * Revision 1.15  1998/05/19  11:47:04  mitchell
 * [Bug #50071]
 * Force recompilation by removing object file rather than touching source
 *
 * Revision 1.14  1998/05/15  11:21:42  johnh
 * [Bug #30384]
 * Project Workspace should be open if a project is open.
 *
 * Revision 1.13  1998/05/13  15:45:10  johnh
 * [Bug #30406]
 * Rename targets to target sources.
 *
 * Revision 1.12  1998/05/01  14:14:05  mitchell
 * [Bug #50071]
 * Close project window when there is no project, and redisplay window when project changes
 *
 * Revision 1.11  1998/04/27  07:23:23  mitchell
 * [Bug #50078]
 * Clear project_tool reference when saving a session
 *
 * Revision 1.10  1998/04/24  15:31:06  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.9  1998/04/07  16:59:02  jont
 * [Bug #30312]
 * Replacing OS.FileSys.modTime with system dependent version to sort out
 * MS time stamp problems.
 *
 * Revision 1.8  1998/04/02  11:45:38  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Revision 1.7  1998/03/31  16:24:18  johnh
 * [Bug #30346]
 * Call Capi.getNextWindowPos().
 *
 * Revision 1.6  1998/03/24  16:59:14  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.5  1998/02/24  15:21:34  johnh
 * [Bug #30362]
 * Setting current mode changes object file location.
 *
 * Revision 1.4  1998/02/19  19:53:04  mitchell
 * [Bug #30337]
 * Change uses of OS.Path.concat to take a string list, instead of a pair of strings.
 *
 * Revision 1.3  1998/02/13  15:57:30  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.2  1998/02/06  15:58:41  johnh
 * new unit
 * [Bug #30071]
 * Replaces *comp_manager.sml for new Project Workspace tool.
 *
 *  Revision 1.1.1.25  1998/01/23  16:02:22  johnh
 *  [Bug #30071]
 *  Introducing subprojects
 *
 *  Revision 1.1.1.24  1998/01/12  15:28:40  johnh
 *  [Bug #30071]
 *  Split project properties locations dialog in two
 *
 *  Revision 1.1.1.23  1998/01/09  09:27:56  johnh
 *  [Bug #30071]
 *  Remove occurences of objects from configurations spec.
 *
 *  Revision 1.1.1.22  1998/01/07  16:42:52  johnh
 *  [Bug #30071]
 *  Bring up PW window asap.
 *
 *  Revision 1.1.1.21  1997/12/15  14:39:14  johnh
 *  [Bug #30071]
 *  Indicate when dependencies might be out of date.
 *
 *  Revision 1.1.1.20  1997/12/12  15:22:00  johnh
 *  [Bug #30071]
 *  Enable project menu items only when not evaluating anything else.
 *  Removed paned layout as files list was too small on Windows.
 *  Display timestamps of source and object files.
 *  Add project commands to File menu to ensure that dialogs have PW as parent (motif).
 *
 *  Revision 1.1.1.19  1997/12/04  14:07:54  daveb
 *  [Bug #30017]
 *  Separated actions into those on a file and those on current targets.
 *  The former take a value; the latter don't.  Added load_targets commands.
 *  Made actions on targets call ShellUtils functions instead of TopLevel.
 *
 *  Revision 1.1.1.18  1997/12/02  12:19:10  johnh
 *  [Bug #30071]
 *  Change project menu.
 *
 *  Revision 1.1.1.17  1997/12/01  13:20:38  johnh
 *  [Bug #30071]
 *  Comment out reference to binaries at this stage.
 *
 *  Revision 1.1.1.16  1997/11/28  14:56:55  daveb
 *  [Bug #30071]
 *  ProjFile.getProjectName now returns an option.
 *
 *  Revision 1.1.1.15  1997/11/26  17:09:11  daveb
 *  [Bug #30071]
 *
 *  Revision 1.1.1.14  1997/11/26  14:37:07  daveb
 *  [Bug #30071]
 *  Removed old require for action_queue.
 *
 *  Revision 1.1.1.13  1997/11/25  14:01:44  daveb
 *  [Bug #30326]
 *
 *  Revision 1.1.1.12  1997/11/24  16:17:58  johnh
 *  [Bug #30071]
 *  Generalise open_file_dialog to take any masks.
 *
 *  Revision 1.1.1.11  1997/11/20  13:36:24  daveb
 *  [Bug #30017]
 *  Removed used of Action Queue, and old commands.
 *  Added optionsFromProjFile to extract the compiler options from the
 *  Project File info.
 *
 *  Revision 1.1.1.10  1997/11/18  16:18:42  johnh
 *  [Bug #30071]
 *  Improve layout.
 *
 *  Revision 1.1.1.9  1997/11/12  13:47:34  johnh
 *  [Bug #30071]
 *  Prompt for new or open project when first created.
 *
 *  Revision 1.1.1.8  1997/11/11  17:08:22  johnh
 *  [Bug #30244]
 *  Merging - changes to dependency graph (full menu structure).
 *
 *  Revision 1.1.1.7  1997/11/11  15:52:48  johnh
 *  [Bug #30203]
 *  Merging - checking files to be compiled.
 *
 *  Revision 1.1.1.6  1997/11/07  13:15:02  johnh
 *  [Bug #30071]
 *  Update PW when current config changes.
 *
 *  Revision 1.1.1.5  1997/11/06  15:59:35  daveb
 *  [Bug #30017]
 *  Added support for current configurations, modes and targets.
 *
 *  Revision 1.1.1.4  1997/10/29  15:38:51  daveb
 *  [Bug #30089]
 *  Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 *  Revision 1.1.1.3  1997/09/16  15:12:05  daveb
 *  [Bug #30071]
 *  Changed type of [sg]set_source_info.
 *
 *  Revision 1.1.1.2  1997/09/12  14:16:07  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.73  1997/09/30  12:46:08  johnh
 * [Bug #30244]
 * Giving the dependency graph the full menus.
 *
 * Revision 1.72  1997/09/18  15:00:07  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.71  1997/09/18  13:48:17  brucem
 * [Bug #30203]
 * Add graphs for checking files to be compiled.
 *
 * Revision 1.70  1997/09/05  09:52:25  johnh
 * [Bug #30241]
 * Implementing proper find dialog.
 *
 * Revision 1.69  1997/08/06  14:11:25  brucem
 * [Bug #30202]
 * Add functionality to dependency graphs.
 * Graph definitions now appear inside the main create_project_tool function,
 * Graph can be manipulated by the user (expand nodes, change root, search),
 * Code has been tidied up a bit,
 * Graphics have been tidied up a bit.
 *
 * Revision 1.68  1997/06/12  15:03:49  johnh
 * [Bug #30175]
 * Combine tools and windows menus.
 *
 * Revision 1.67  1997/06/10  11:19:04  johnh
 * [Bug #30075]
 * Allowing only one instance of tools.
 *
 * Revision 1.66  1997/05/28  11:18:01  johnh
 * [Bug #30155]
 * Remove 'action' and 'view' cascade menu items for Win32
 *
 * Revision 1.65  1997/05/16  15:35:16  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.64  1997/03/17  16:06:25  daveb
 * [Bug #1774]
 * Fixed minor compilation error in previous fix.
 *
 * Revision 1.63  1997/03/13  14:28:37  daveb
 * [Bug #1774]
 * Added Info.Stop handler to read_depend_file.
 *
 * Revision 1.62  1997/02/26  13:10:34  johnh
 * [Bug #1813]
 * update selection reference when units are deleted.
 *
 * Revision 1.61  1996/12/03  20:21:39  johnh
 * Putting clear_console in _console to set the write_pos.
 *
 * Revision 1.60  1996/11/06  11:15:42  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.59  1996/11/01  13:47:31  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.58  1996/10/31  10:19:21  johnh
 * Enabling interruption during compilation on Windows.
 *
 * Revision 1.57  1996/10/10  02:26:40  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.56  1996/08/20  13:48:10  daveb
 * [Bug #1480]
 * Implemented compile-and-load properly.
 *
 * Revision 1.55  1996/08/05  14:38:16  daveb
 * [Bug #1360]
 * Added a menu bar to the Graph window.
 *
 * Revision 1.54  1996/07/29  13:04:17  daveb
 * [Bug #1485]
 * Added handler for Info.Stop when raised by Incremental.match_source_path.
 * Split file_action into source_file_action and object_file_action.
 *
 * Revision 1.53  1996/07/29  11:30:01  daveb
 * [Bug #1493]
 * Added a "suffix" argument to the file_action function.
 *
 * Revision 1.52  1996/07/29  11:18:14  daveb
 * [Bug #1478]
 * Disabled Close menu item during evaluations.
 *
 * Revision 1.51  1996/07/09  12:37:05  daveb
 * [Bug #1260]
 * Changed the Capi layout datatype so that the PANED constructor takes the
 * layout info for its sub-panes.  This enables the Windows layout code to
 * calculate the minimum size of each window.
 *
 * Revision 1.50  1996/07/02  13:55:02  andreww
 * redirecting standard IO to the GUI within the compilation manager.
 *
 * Revision 1.49  1996/05/30  13:35:00  daveb
 * The Interrupt and Io exceptions are no longer at top level.
 *
 * Revision 1.48  1996/05/29  14:37:56  daveb
 * DebuggerWindow.make_debugger_window now returns a clean-up function to call
 * at the end of each evaluation.
 *
 * Revision 1.47  1996/05/28  14:29:46  matthew
 * Adding parent_title to GraphWidget.make
 *
 * Revision 1.46  1996/05/24  15:41:09  daveb
 * The extension passed to open_file_dialog does not need a preceding * .
 *
 * Revision 1.45  1996/05/24  13:43:13  daveb
 * Type of GuiUtils.view_option has changed.
 *
 * Revision 1.44  1996/05/22  16:29:20  daveb
 * Reordering menus.
 *
 * Revision 1.43  1996/05/16  14:21:07  daveb
 * Modified contents of labels to print <none> when appropriate.
 *
 * Revision 1.42  1996/05/15  16:00:21  daveb
 * Made the console be a permanent pane of the compilation manager.
 * Added an edit menu.
 *
 * Revision 1.40  1996/05/14  14:36:30  matthew
 * Fixing layout
 *
 * Revision 1.39  1996/05/08  15:14:35  daveb
 * ErrorBrowser.create now returns a quit function.  Used this to kill off
 * old error browsers.
 *
 * Revision 1.38  1996/05/08  12:20:49  daveb
 * ActionQueue.do_actions now takes an Info.options argument.
 *
 * Revision 1.37  1996/05/07  16:20:05  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.36  1996/05/02  17:34:52  daveb
 * Removed ActionQueue.Handled exception.
 *
 * Revision 1.35  1996/05/01  11:21:36  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.34  1996/04/30  10:03:26  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.33  1996/04/18  15:18:25  jont
 * initbasis moves to basis
 *
 * Revision 1.32  1996/04/09  20:28:27  daveb
 * ActionQueue.do_actions now takes a preferences argument (and a record
 * instead of a tuple).
 *
 * Revision 1.31  1996/04/04  11:29:02  matthew
 * Changes to graph interface
 *
 * Revision 1.30  1996/04/02  16:40:56  daveb
 * Implemented touch_all_modules command.
 * Made non-action commands print something on the console.
 * Moved the Graph menu item to the View menu.
 *
 * Revision 1.29  1996/04/02  16:14:12  daveb
 * Made all commands print something on the console.
 *
 * Revision 1.28  1996/04/02  14:59:14  daveb
 * Changed Project.load_dependencies to Incremental.read_dependencies.
 * Replaced "Main" and "Action" menus with "File" and "Module" menus.
 *
 * Revision 1.27  1996/04/02  12:32:52  daveb
 * Improved Layout.
 *
 * Revision 1.26  1996/03/28  13:43:10  stephenb
 * Mark any uses of Os as referring to the old Os interface.
 *
 * Revision 1.25  1996/03/26  09:52:41  daveb
 * Replaced Module.with_source_path with new Incremental.match_source_path.
 * Added delete function.
 *
 * Revision 1.24  1996/03/19  16:31:00  matthew
 * Removing duplicate structures from parameter
 *
 * Revision 1.23  1996/03/19  11:52:43  daveb
 * Implemented check_load.
 *
 * Revision 1.22  1996/03/15  12:35:48  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.21  1996/03/14  15:13:29  matthew
 * Adding compileAndLoad functionality
 *
 * Revision 1.20  1996/03/07  16:26:10  daveb
 * Changed sourceTitleLabel to sourceFileLabel.
 *
 * Revision 1.19  1996/03/04  16:57:35  daveb
 * Type of Project object info has changed.
 *
 * Revision 1.18  1996/02/27  14:38:26  daveb
 * Hid implementation of Project.Unit type.
 *
 * Revision 1.17  1996/02/23  18:02:51  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.16  1996/02/22  17:02:30  daveb
 * ErrorBrowser.create now takes a close_action field.
 *
 * Revision 1.15  1996/02/19  14:12:13  daveb
 * Ensured that current selection is more or less visible.
 *
 * Revision 1.14  1996/02/08  11:28:35  daveb
 * Capi.make_scrolllist now returns a record, with an add_items field.
 *
 *  Revision 1.13  1996/01/25  14:45:22  daveb
 *  Minor change to error browser interface.
 *
 *  Revision 1.12  1996/01/25  13:18:35  matthew
 *  Changed interface to graph widget
 *
 *  Revision 1.11  1996/01/23  16:09:58  daveb
 *  Minor changes to the menus.
 *
 *  Revision 1.10  1996/01/17  11:46:36  matthew
 *  Reordering top level menus.
 *
 *  Revision 1.9  1996/01/12  15:06:06  matthew
 *  Fixing layout parameters
 *
 *  Revision 1.8  1996/01/12  10:51:33  daveb
 *  The type of Capi.open_file_dialog has changed.
 *
 *  Revision 1.7  1996/01/10  12:31:29  daveb
 *  Replaced Capi.find_file with Capi.open_file_dialog.
 *
 *  Revision 1.6  1996/01/08  16:28:25  stephenb
 *  Correcting bug in edit action.
 *
 *  Revision 1.5  1995/12/13  12:10:31  daveb
 *  Replaced FileDialog.find_file with Capi.find_file; the type has changed too.
 *
 *  Revision 1.4  1995/12/12  11:50:02  daveb
 *  Module.with_source_path now takes a string describing the action undertaken.
 *
 *  Revision 1.3  1995/12/07  17:03:37  daveb
 *  Added header.
 *
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
 *)

require "$.basis.__string";
require "$.basis.__date";
require "$.basis.__text_io";
require "^.system.__file_time";

require "../system/__os";

require "../basics/module_id";
require "../utils/map";
require "../utils/crash";
require "../basis/list";
require "../editor/editor";
require "../main/preferences";
require "../main/user_options";
require "../main/project";
require "../main/proj_file";
require "../debugger/ml_debugger";
require "../interpreter/incremental";
require "../interpreter/save_image";
require "../interpreter/shell_utils";
require "capi";
require "menus";
require "graph_widget";
require "tooldata";
require "gui_utils";
require "console";
require "debugger_window";
require "error_browser";
require "proj_properties";
require "proj_workspace";

functor ProjectWorkspace (
  structure ModuleId: MODULE_ID
  structure DebuggerWindow : DEBUGGERWINDOW
  structure Ml_Debugger : ML_DEBUGGER
  structure ErrorBrowser : ERROR_BROWSER
  structure NewMap: MAP
  structure List: LIST
  structure UserOptions: USER_OPTIONS
  structure Preferences: PREFERENCES
  structure Crash: CRASH
  structure Editor: EDITOR
  structure Capi: CAPI
  structure Incremental: INCREMENTAL
  structure Project: PROJECT
  structure ProjFile: PROJ_FILE
  structure ShellUtils: SHELL_UTILS
  structure Menus: MENUS
  structure GraphWidget: GRAPH_WIDGET
  structure ToolData: TOOL_DATA
  structure GuiUtils: GUI_UTILS
  structure Console: CONSOLE
  structure ProjProperties: PROJ_PROPERTIES
  structure SaveImage : SAVE_IMAGE

  sharing Project.Info = ShellUtils.Info = 
	  Incremental.InterMake.Compiler.Info
  sharing Ml_Debugger.ValuePrinter.Options =
	  ShellUtils.Options = ToolData.ShellTypes.Options

  sharing type Capi.Widget = Menus.Widget =
	       GraphWidget.Widget = ToolData.Widget = GuiUtils.Widget =
	       Console.Widget = DebuggerWindow.Widget =
	       ErrorBrowser.Widget = ProjProperties.Widget
  sharing type Ml_Debugger.preferences = Preferences.preferences =
	       ShellUtils.preferences = Editor.preferences
  sharing type Preferences.user_preferences = GuiUtils.user_preferences =
               ToolData.ShellTypes.user_preferences = Console.user_preferences
  sharing type ToolData.ShellTypes.Context = ShellUtils.Context
  sharing type UserOptions.user_context_options =
               ToolData.UserContext.user_context_options =
               GuiUtils.user_context_options
  sharing type UserOptions.user_tool_options = ShellUtils.UserOptions =
	       ToolData.ShellTypes.user_options =
	       GuiUtils.user_tool_options 
  sharing type ToolData.ButtonSpec = Menus.ButtonSpec = GuiUtils.ButtonSpec
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
  sharing type GuiUtils.user_context = ToolData.ShellTypes.user_context =
	       ErrorBrowser.user_context = ShellUtils.user_context
  sharing type Project.Info.Location.T = ModuleId.Location = 
	       ErrorBrowser.location = Incremental.Datatypes.Ident.Location.T
  sharing type Project.ModuleId = ModuleId.ModuleId = Incremental.ModuleId
  sharing type NewMap.map = Project.Map
  sharing type GraphWidget.GraphicsPort = Capi.GraphicsPorts.GraphicsPort
  sharing type GraphWidget.Point = Capi.Point
  sharing type ToolData.ToolData = DebuggerWindow.ToolData = ErrorBrowser.ToolData
  sharing type Project.Project = Incremental.InterMake.Project
  sharing type Ml_Debugger.debugger_window = DebuggerWindow.debugger_window
  sharing type ErrorBrowser.error = Project.Info.error
  sharing type Menus.OptionSpec = GuiUtils.OptionSpec
  sharing type ShellUtils.Options.options = UserOptions.Options.options
): PROJECT_WORKSPACE = 
struct

  structure Info = Project.Info 
  structure Location = Info.Location
  structure ShellTypes = ToolData.ShellTypes
  structure Options = ShellUtils.Options
  structure UserContext = ToolData.UserContext

  type ToolData = ToolData.ToolData

  datatype Node =
    NODE of
      ModuleId.ModuleId * (string * int * int * int) option ref
    (* the module name, 
       optionally the name as a string, font ascent, font descent, width *)

  val nodeName = fn (NODE (m,_)) => ModuleId.string m
  
  (* Should be a util *)
  fun location_file (Info.ERROR(_,location,message)) =
    case location of
      Location.UNKNOWN => NONE
    | Location.FILE f => SOME f
    | Location.LINE(f,l) => SOME f
    | Location.POSITION (f,l,_) => SOME f
    | Location.EXTENT {name,...} => SOME name

  fun optionsFromProjFile 
	(Options.OPTIONS {listing_options, print_options, compat_options,
			  extension_options, compiler_options}) = 
    let 
      val (_, modeDetails, currentMode) = ProjFile.getModes ()

      val Options.COMPILEROPTIONS {print_messages, generate_moduler,
				   opt_handlers, local_functions, ...} = 
	    compiler_options

      val new_compiler_options =
        case currentMode of
          NONE => compiler_options
        | SOME name =>
          (case ProjFile.getModeDetails (name, modeDetails) of
             r =>
               Options.COMPILEROPTIONS
                 {interrupt = !(#generate_interruptable_code r),
                  intercept = !(#generate_interceptable_code r),
                  generate_debug_info = !(#generate_debug_info r),
                  debug_variables = !(#generate_variable_debug_info r),
                  opt_leaf_fns = !(#optimize_leaf_fns r),
                  opt_tail_calls = !(#optimize_tail_calls r),
                  opt_self_calls = !(#optimize_self_tail_calls r),
                  mips_r4000 = !(#mips_r4000 r),
                  sparc_v7 = !(#sparc_v7 r),
                  print_messages = print_messages,
                  generate_moduler = generate_moduler,
                  opt_handlers = opt_handlers,
                  local_functions = local_functions})
        (* XXX - handler needed for NoConfigDetailsFound -
          or put this functionality in ProjFile *)
    in
      Options.OPTIONS
        {listing_options = listing_options,
         print_options = print_options,
         compat_options = compat_options,
         extension_options = extension_options,
         compiler_options = new_compiler_options}
    end

  (* There should only be one project tool at a time *)
  val project_tool = ref NONE

  fun with_no_project_tool f arg1 arg2 =
    let 
      val pt = !project_tool
    in
      project_tool := NONE;
      ignore(f arg1 arg2 
             handle exn => (project_tool := pt; raise exn));
      project_tool := pt
    end


  (* The selection should persist if you close the tool and open a new
     instance later. So we declare selection out here. *)
  val selection = ref NONE : (string * ModuleId.ModuleId) option ref

  val updatePW = ref (fn () => ())
  fun updateDisplay () = (!updatePW) ()

  val originalProj = ref (Incremental.get_project())

  val sizeRef = ref NONE
  val posRef = ref NONE
  val graphSizeRef = ref NONE
  val graphPosRef = ref NONE

  (* This is the most important function.
     All other functions are contained inside this. *)
  fun create_project_tool (tooldata as ToolData.TOOLDATA
		{args, appdata, current_context, motif_context, tools}) =
    let
      val ToolData.APPLICATIONDATA {applicationShell,...} = appdata

      val ShellTypes.LISTENER_ARGS
            {user_options, user_preferences,
             mk_xinterface_fn, prompter, ...} = args

      val local_context = ref motif_context

      fun get_current_user_context () =
        GuiUtils.get_user_context (!local_context)

      fun get_user_context_options () =
        ToolData.UserContext.get_user_options (get_current_user_context ())

      val title = "Project Workspace"

      val (shell, frame, menubar, _) =
        Capi.make_main_window
	  {name = "projWorkspace",
	   title = title, 
	   parent = applicationShell, 
	   contextLabel = false, 
	   winMenu = false,
	   pos = getOpt(!posRef, Capi.getNextWindowPos())};

      val projNameLabel = Capi.make_managed_widget 
				("projNameLabel", Capi.Label, frame, [])

      val projCurTargetsText = Capi.make_managed_widget 
				("projCurTargetsText", Capi.Text, frame, 
				 [(Capi.ReadOnly true)])

      val projSubprojText = Capi.make_managed_widget 
				("projSubprojText", Capi.Text, frame, 
				 [(Capi.ReadOnly true)])

(*
      val projLibraryText = Capi.make_managed_widget 
				("projLibraryText", Capi.Text, frame, 
				 [(Capi.ReadOnly true)])
*)

      val relativeObj = 
	let val (_, obj, _) = ProjFile.getLocations()
	in 
	  ref (OS.Path.isRelative obj) 
	end

      val relativeBin =
	let val (_, _, bin) = ProjFile.getLocations()
	in 
	  ref (OS.Path.isRelative bin) 
	end

      val projObjectsLabel = Capi.make_managed_widget 
				("projObjectsLabel", Capi.Label, frame, [])

(*      val projBinariesLabel = Capi.make_managed_widget 
				("projBinariesLabel", Capi.Label, frame, [])
*)
      val projButtonsRC = Capi.make_managed_widget 
				("projButtonsRC", Capi.RowColumn, frame, [])

      fun list2string [] = ""
	| list2string (h::t) = h ^ "; " ^ list2string t

      fun updateName (SOME name) = 
	Capi.set_label_string (projNameLabel, "Project Name:  " ^ name)
      |   updateName NONE =
        Capi.set_label_string (projNameLabel, "Project Name:  ")

      val files_up_to_date = ref true

      val listLabel = 
        Capi.make_managed_widget ("listLabel", Capi.Label, frame, [])

      fun update_files_label () = 
	if (!files_up_to_date) then 
	  Capi.set_label_string (listLabel, "Files (information up to date):")
	else 
	  Capi.set_label_string (listLabel, "Files (information possibly out of date):")

      fun updateTargets targets = 
	(files_up_to_date := false;
	 update_files_label();
	 Capi.Text.set_string (projCurTargetsText, 
		"Current Targets (sources):  " ^ list2string targets))

      fun updateFiles newFiles = 
	 updateTargets (#1 (ProjFile.getTargets()))

      val (files_dialog, applyResetFiles) = 
	ProjProperties.mk_files_dialog (shell, updateFiles)

      fun updateSubprojs projs = 
	Capi.Text.set_string (projSubprojText,
		"Sub projects:  " ^ list2string projs)

      fun update_proj orig_proj = 
	(if orig_proj then 
	   (Incremental.set_project (!originalProj);
	    files_up_to_date := true;	
	    update_files_label())
	else ();
	updateDisplay())

      val (subproj_dialog, applyResetSubprojs) = 
	ProjProperties.mk_subprojects_dialog (shell, updateSubprojs, update_proj)

      val (targets_dialog, applyResetTargets) = 
	ProjProperties.mk_targets_dialog (shell, updateTargets)

(*
      fun updateLibPath libPath = 
	(files_up_to_date := false;
	 update_files_label();
	 Capi.Text.set_string 
	   (projLibraryText, "Library Path:  " ^ 
	      (OS.Path.fromUnixPath libPath)))
*)

      fun updateLibPath _ = ()

      fun updateLocs (obj, bin, lib) = 
	(files_up_to_date := false;
	 update_files_label();
	 Capi.set_label_string (projObjectsLabel, "Location for object files: " ^ 
	   (OS.Path.fromUnixPath obj));
(* BBB	 Capi.set_label_string (projBinariesLabel, "Location for binary files: " ^
	   (OS.Path.fromUnixPath bin)); *)
	 updateLibPath (list2string lib))

      fun updateObjLoc (obj', bin', lib) =
	let 
	  val (_, modeDetails, curMode) = ProjFile.getModes()
	  val (_, _, curConfig) = ProjFile.getConfigurations()
	  val modeLoc = 
	    if isSome(curMode) then
	      !(#location (ProjFile.getModeDetails (valOf(curMode), modeDetails)))
	    else ""
	  val cc = getOpt(curConfig, "")
	  val obj = OS.Path.mkCanonical (OS.Path.concat[obj', cc, modeLoc])
	  val bin = OS.Path.mkCanonical (OS.Path.concat[bin', cc, modeLoc])
	in
	  updateLocs (obj, bin, lib)
	end

      fun newObjDir objDir = 
	let val (lib, obj, bin) = ProjFile.getLocations()
	in
	  updateObjLoc (objDir, bin, lib)
	end

      fun newBinDir binDir = 
	let val (lib, obj, bin) = ProjFile.getLocations()
	in
	  updateObjLoc (obj, binDir, lib)
	end

      val relativeRC = Capi.make_managed_widget 
				("PW_relativeRC", Capi.RowColumn, frame, [])

      fun getRelObj () = (!relativeObj)
      fun getRelBin () = (!relativeBin)

      val changeObj = 
	ProjProperties.setRelObjBin (true, newObjDir, relativeObj)

(* BBB
      val changeBin = 
	ProjProperties.setRelObjBin (false, newBinDir, relativeBin)
*)

      val {update = updateRel, ...} = 
	  Menus.make_buttons (relativeRC, 
	    [Menus.TOGGLE ("PW_relativeObj", getRelObj, changeObj, fn _ => true)])
(* BBB	     Menus.TOGGLE ("PW_relativeBin", getRelBin, changeBin, fn _ => true)]) *)

      fun updateConfig () = 
	let 
	  val (lib, obj, bin) = ProjFile.getLocations()
	in
	  updateObjLoc (obj, bin, lib)
	end

      fun updateMode modes = 
	let 
	  val (lib, obj, bin) = ProjFile.getLocations()
	in
	  updateObjLoc (obj, bin, lib)
	end

      val (modes_dialog, applyResetModes) = 
	ProjProperties.mk_modes_dialog (shell, updateMode)

      val (configs_dialog, applyResetConfigs) = 
	ProjProperties.mk_configs_dialog (shell, updateConfig)

      val (library_dialog, applyResetLibPath) = 
	ProjProperties.mk_library_dialog (shell, updateLibPath)

      fun obj_dialog () = 
	ProjProperties.set_objects_dir (shell, relativeObj, newObjDir)

(* BBB
      fun bin_dialog () = 
	ProjProperties.set_binaries_dir (shell, relativeBin, newBinDir)
*)

      val (about_dialog, applyResetAboutInfo) = 
	ProjProperties.mk_about_dialog shell

      val modNameLabel = 
        Capi.make_managed_widget ("modNameLabel", Capi.Label, frame, [])
      val sourceFileLabel = 
        Capi.make_managed_widget ("sourceFileLabel", Capi.Label, frame, [])
      val objectFileLabel =
        Capi.make_managed_widget ("objectFileLabel", Capi.Label, frame, [])
  
      fun get_user_options () = user_options

      fun mk_tooldata () = tooldata

      val consoleLabel = 
        Capi.make_managed_widget ("console", Capi.Label, frame, [])

      val {outstream, console_widget, console_text,
           clear_console, set_window, ...} =
        Console.create (frame, title, user_preferences)

      fun message_fun s = Capi.send_message(shell,s)

      val (run_debugger, clean_debugger) =
        DebuggerWindow.make_debugger_window
          (shell, title ^ " Debugger", tooldata)

      val debugger_type =
        Ml_Debugger.WINDOWING (run_debugger, message_fun, false)

      fun debugger_function f x =
        Ml_Debugger.with_start_frame
          (fn base_frame =>
             (f x)
             handle
               exn as Capi.SubLoopTerminated => raise exn
             | exn as ToolData.ShellTypes.DebuggerTrapped => raise exn
             | exn as MLWorks.Interrupt => raise exn
             | exn as Info.Stop _ => raise exn
             | exn =>
                (Ml_Debugger.ml_debugger
                   (debugger_type,
                    ShellTypes.new_options
                      (user_options,
                       GuiUtils.get_user_context (!local_context)),
                    Preferences.new_preferences user_preferences)
                   (base_frame,
                    Ml_Debugger.EXCEPTION exn,
                    Ml_Debugger.POSSIBLE
                      ("quit (return to file tool)",
                       Ml_Debugger.DO_RAISE ShellTypes.DebuggerTrapped),
                    Ml_Debugger.NOT_POSSIBLE);
                 raise ShellTypes.DebuggerTrapped))

      local
	val error_browser_ref = ref NONE
      in
	fun kill_error_browser () =
	  case !error_browser_ref
	  of NONE => ()
	  |  SOME f =>
	    (f ();
	     error_browser_ref := NONE)

        fun error_handler
              (filename, error, error_list, header,
	       preferences_fn, redo_action) =
          let
              val action_message =
                header ^ ": " ^ filename
  
              val file_message =
                case location_file error of
                  NONE => ""
                | SOME s => s

              fun edit_action location =
                {quit_fn =
		   ShellUtils.edit_location (location, preferences_fn()),
                 clean_fn = fn () => ()}
          in
            TextIO.output
	      (outstream, header ^ ": Error in " ^ file_message ^ "\n");
	    error_browser_ref :=
	      SOME
                (ErrorBrowser.create
                   {parent = shell, errors = rev error_list,
                    file_message = file_message,
                    editable = fn _ => true,
	            edit_action = edit_action,
	            close_action = updateRel,
	            redo_action = redo_action,
		    mk_tooldata = fn () => tooldata,
		    get_context = get_current_user_context})
          end
      end

      (* update_labels changes the top of the manager window
         and the selection reference, but not the `entries' list *)
      fun update_labels NONE =
        (Capi.set_label_string (modNameLabel, "Selected Unit: <none>");
         Capi.set_label_string (sourceFileLabel, "Source: <none>");
         Capi.set_label_string (objectFileLabel, "Object: <none>"))
      |   update_labels (SOME (s, m)) =
        let
  	  val project = Incremental.get_project ()

	  val (source_file, source_file_time) =
  	    case Project.get_source_info (project, m) of
  	      NONE => ("<none>", "")
  	    | SOME (file, _) => 
		(OS.Path.fromUnixPath file, 
		 Date.toString (Date.fromTimeLocal (FileTime.modTime file)))

	  val (object_file, object_file_time) =
  	    case Project.get_object_info (project, m) of
  	      NONE => ("<none>", "")
  	    | SOME {file, ...} => 
		(OS.Path.fromUnixPath file, 
		 Date.toString (Date.fromTimeLocal (FileTime.modTime file)))

	  val loaded = 
	    case Project.get_loaded_info (project, m) of
	      NONE => false
	    | SOME _ => true

	  val visible = Project.is_visible (project, m)

	  val status_string =
	    case (loaded, visible)
	    of (false, false) => ""
	    |  (true, false) => " (loaded)"
	    |  (false, true) => " (visible)"
	    |  (true, true) => " (loaded, visible)"

        in
          selection := SOME (s, m);
          Capi.set_label_string
	    (modNameLabel, "Selected Unit: " ^ s ^ status_string);
          Capi.set_label_string
	    (sourceFileLabel, "Source: " ^ source_file ^ " \t" ^ source_file_time);
          Capi.set_label_string
	    (objectFileLabel, "Object: " ^ object_file ^ " \t" ^ object_file_time)
        end


      (* When you create a graph, supply a value
           layout : {style : layout_style, expanded : bool} *)
      datatype layout_style = CASCADE | TREE

      (* Graph windows will update the main window when an item is
         selected in them.  The following reference will be filled
         by a function for doing this (we can't define the function yet
         as we haven't defined the main list -- it requires the graph
         function) *)
      val selectFnForGraphRef = ref (fn _ => ())
      (* It would be nice if the user could turn this off (by the menu) *)

      exception EmptyGraph 

      (* Function to open a window displaying the graph for a given module *)
      (* Several graph windows can be open at any time
         fun project_graph_tool may throw EmptyGraph *)
      fun project_graph_tool
        {parent, project, module = module_id, title, filter, winNamePrefix, layout} =
        let
          val moduleName = ModuleId.string module_id

          val windowName = winNamePrefix ^ moduleName

          val (shell, frame, menuBar, _) =
            Capi.make_main_window
	       {name = "compManagerGraph",
	 	title = windowName, 
		parent = parent, 
		contextLabel = false, 
		winMenu = true,
		pos = getOpt (!graphPosRef, Capi.getNextWindowPos())};

          (* Node at the top when the graph was created *)
          val originalRoot = module_id
          (* Node currently at the top *)
          val currentRoot = ref module_id
          (* Node currently highlighted (or the root node if none) *)
          val graphSelection = ref module_id

          val userExpandedNode = ref false

          (* Function to generate the graph data,
             this has type :
                {ordering, get_children, mk_node, filter}
                 -> unit -> (NODES, ROOTS)
             as GraphWidget.make requires a function (make_graph)
             of type : unit -> (NODES, ROOTS)
           *)
          (* To implement different types of graph, e.g. graphs showing
             only files that need to be recompiled, add extra params to
             this function and stick with the same basic algorithm.
           *)
          fun map_to_graph_fn {ordering, eq, get_children, mk_node, filter} =
            let
              val nodesList = ref []
              val iref = ref 0
              val seen = ref (NewMap.empty (ordering, eq))

              fun do_node key =
                if filter key then
                  case NewMap.tryApply' (!seen, key)
                  of SOME index => SOME index
                  |  NONE =>
                   let
	              (* Warning: this could raise an exception *)
                      val children = get_children key
                      val index = !iref
                      val children_ref = ref []
                      val _ = seen := NewMap.define (!seen, key, index)
                      val _ = nodesList :=
                                (NODE (mk_node key, ref NONE), children_ref) ::
                                      !nodesList
                      val _ = iref := 1 + !iref
                      val children_ids = List.mapPartial do_node children
                    in
                      children_ref := children_ids;
                      SOME index
                    end (* of fun do_node *)
                  else
                    NONE

              val nodesArr = ref (MLWorks.Internal.Array.arrayoflist [])
                  
             fun recompute () = 
                  (nodesList := [] ;
                   iref := 0 ;
                   seen := (NewMap.empty (ordering, eq)) ;
                   ignore(do_node (!currentRoot));
                   (* The exception should never be raised.
                      As it means the filter has removed all nodes. *)
                   case !nodesList of [] => raise EmptyGraph | _ => ();
                   nodesArr := MLWorks.Internal.Array.arrayoflist
                               (rev (map 
                                    (fn (node,ref children) => (node,children))
                                    (!nodesList)))
                  )

              val _ = recompute ()

              val lastRoot = ref (!currentRoot)

           in
             fn () => ((if not(eq(!currentRoot, !lastRoot))
                        then (recompute () ; lastRoot := !currentRoot )
                        else () );
                       (!nodesArr, [0]) )
           end

           val layoutRef = ref layout
  
           val graph_spec =
             GraphWidget.GRAPH_SPEC
               {child_position = ref GraphWidget.CENTRE, 
               child_expansion = ref GraphWidget.TOGGLE,
               default_visibility = ref false, 
               show_root_children = ref true,
               indicateHiddenChildren = ref true,
               orientation = ref GraphWidget.VERTICAL,
               line_style = ref GraphWidget.STRAIGHT,
               horizontal_delta = ref 8,
               vertical_delta = ref 60,
               graph_origin = ref (8, 8),
               show_all = ref false
              }

          (* Following few values/functions are for drawing single nodes *)
          (* Ideally these should be in a separate structure and shared with
             other graph drawing code (e.g. inspector). *)
          (* Be VERY carefull if changing sizes, offsets, values etc.,
             it is difficult to get the calculations correct so it works
             on all platforms.  *)
          val baseline_height = 3
          fun max (x: int,y) = if x > y then x else y

          val boxMargin = 4

          (* This returns the data for drawing a node,
             excludes the boxMargin from the extents *)
          fun get_node_data (NODE (entry, extents),gp) =
            case !extents of
              SOME data => data
            | _ =>
                let
                  val s = ModuleId.string entry
                  val {font_ascent,font_descent,width,...} =
                    Capi.GraphicsPorts.text_extent (gp,s)
                  val data = (s,font_ascent,font_descent,width)
                in
                  extents := SOME data;
                  data
               end (* of fun get_node_data *)
  
          fun entry_draw_node (node, selected, gp, Capi.POINT{x,y}) =
            let
              val (s, font_ascent, font_descent, width) =
                get_node_data (node, gp)
              val left = width div 2
              val right = width - left
              val rectangle = Capi.REGION {x = x-left-boxMargin,
                                           y = y-baseline_height-font_ascent-
                                               boxMargin,
                                           width = width + 2 * boxMargin,
                                           height = font_ascent+font_descent+
                                                     2*boxMargin }
              fun canHighlight gp f x =
                if selected then Capi.GraphicsPorts.with_highlighting (gp,f,x)
                else f x
            in 
              if selected
              then Capi.GraphicsPorts.fill_rectangle (gp, rectangle)
              else (Capi.GraphicsPorts.clear_rectangle (gp, rectangle);
                    Capi.GraphicsPorts.draw_rectangle (gp, rectangle) );
              canHighlight
                gp
                 Capi.GraphicsPorts.draw_image_string
                 (gp,s,Capi.POINT{x=x - left, y=y - baseline_height} )
            end (* of fun entry_draw_node *)
          
          fun entry_extent (node,gp) =
            let
              val (s,font_ascent,font_descent,width) = get_node_data (node,gp)
              val left = width div 2
              val right = width - left
            in
              GraphWidget.EXTENT
                {left = left + boxMargin,
                 right = right + 2 + boxMargin,
                 up = baseline_height + font_ascent + 1 + boxMargin,
                 down = max (0, font_descent-baseline_height) + boxMargin}
            end (* of fun entry_extent *)
  
          (* Function to make the graph area within a window. *)
          fun make_project_graph
            {project, module = module_id, parent, title, filter} =
            let
              fun get_requires m = Project.get_requires (project, m)
              fun mk_node m = Project.get_name (project, m)
            in

              GraphWidget.make
                ("projectGraph", "ProjectGraph", "Dependency graph",
                 parent, graph_spec,
                 map_to_graph_fn
                   {ordering = ModuleId.lt, eq = ModuleId.eq, get_children = get_requires,
                    mk_node = mk_node, filter = filter}, 
                 entry_draw_node, entry_extent) 

           end (* of fun make_project_graph *)

          val {initialize, widget, popup_menu, update, initialiseSearch, ...} =
            make_project_graph
             {project = project, module = module_id, parent = frame,
              title = title, filter = filter}

          (* Function to check for substrings, used in the graph search *)
          fun isSubstring (s1, s2) =
            let
              val l1 = explode s1   val l2 = explode s2
              fun isSub l =
                   let
                     fun isPre ([], _) = true
                       | isPre (l, []) = false
                       | isPre ((h1::t1), (h2::t2)) =
                           (h1=h2) andalso (isPre (t1, t2))
                   in
                     (isPre (l1, l)) orelse
                     (case l of (h::t) => isSub t | _ => false)
                   end
            in
              isSub l2
            end

          (* Function to say if a module name contains a substring.  
             For searching the graph *)
          fun matchWeak key (NODE(m,_)) =
              isSubstring (key, (ModuleId.string m))

          (* Function to say if a module name is a string.
             For searching the graph.  *)
          fun matchStrong key (NODE(m,_)) = (ModuleId.string m)=key

          (* Next functions are the menu options *)

          (* Expand the graph completely or contract it.  Boolean parameter
             is new value for #show_all in graph spec *)
          fun setExpanded b = 
            (#show_all ((fn GraphWidget.GRAPH_SPEC gs => gs) graph_spec) := b ;
             userExpandedNode := false ;
             layoutRef := {style = #style (!layoutRef), expanded = b};
             update() )

          fun isExpanded () = #expanded (!layoutRef)

          (* Move a given node to the top of the screen and show only
             its descendants.  *)
          fun focus module () = 
           (currentRoot := module ;
            graphSelection := module;
            (!selectFnForGraphRef) module ;
            update () )

          (* Focus on the current selection *)
          val focusOnSelection = fn () => (focus (!graphSelection) ())

          (* Can we change focus to the current selection? *)
          fun canFocusOnSelection () = not(ModuleId.eq(!graphSelection, !currentRoot))

          (* Can we return focus to original root? *)
          fun canUnfocus () = not(ModuleId.eq(!currentRoot, originalRoot))

          (* Changing the style
             Only two styles are provided, rather than letting the
             user set graph_spec directly using the window from popup_menu *)

          (* Layout file-manager style *)
          fun setCascadeLayout () =
            let val (GraphWidget.GRAPH_SPEC gs) = graph_spec in
            ((#child_position gs) := GraphWidget.BELOW;
             (#orientation gs) := GraphWidget.HORIZONTAL;
             (#line_style gs) := GraphWidget.STEP;
             (#horizontal_delta gs) := 20; (#vertical_delta gs) := 8;
             layoutRef := {expanded = #expanded (!layoutRef), style = CASCADE};
             update () )
            end

          (* Layout in a tree *)
          fun setTreeLayout () =
            let val (GraphWidget.GRAPH_SPEC gs) = graph_spec in
            ((#child_position gs) := GraphWidget.CENTRE;
             (#orientation gs) := GraphWidget.VERTICAL;
             (#line_style gs) := GraphWidget.STRAIGHT;
             (#horizontal_delta gs) := 8; (#vertical_delta gs) := 60;
             layoutRef := {expanded = #expanded (!layoutRef), style = TREE};
             update () )
            end

          fun setLayoutStyle style =
            case style of TREE => setTreeLayout ()
                        | CASCADE => setCascadeLayout ()

          fun getLayoutStyle () =
            #style (!layoutRef)

          fun storeGraphSizePos () = 
	    (graphSizeRef := SOME (Capi.widget_size shell);
	     graphPosRef := SOME (Capi.widget_pos shell))

          val close_push = 
		("close", fn _ => (storeGraphSizePos (); 
				   Capi.destroy shell), fn _ => true)

	  val searchFn = 
	    initialiseSearch (fn _ => ModuleId.string (!graphSelection))
			     (matchStrong, matchWeak)

	  datatype expandType = ALL | ROOT
	  val expand = ref ROOT

	  val layoutStyle = ref TREE

	  val graphSettingsSpec = 
	    [Menus.OPTRADIO
		[GuiUtils.toggle_value ("expand_all", expand, ALL),
		 GuiUtils.toggle_value ("only_root", expand, ROOT)],
	     Menus.OPTSEPARATOR,
	     Menus.OPTLABEL "Layout Style",
	     Menus.OPTRADIO
		[GuiUtils.toggle_value ("cascading_layout", layoutStyle, CASCADE),
		 GuiUtils.toggle_value ("tree_layout", layoutStyle, TREE)]]

	  fun update_graph () = 
	    (if isExpanded() = ((!expand) = ROOT) then
		setExpanded ((!expand) = ALL)
	     else ();
	     if getLayoutStyle() <> (!layoutStyle) then 
		setLayoutStyle (!layoutStyle)
	     else ())

          val dep_graph_settings =
            #1 (Menus.create_dialog
	           (shell, "Graph Layout: " ^ moduleName, "depGraphLayout",
                    update_graph, graphSettingsSpec)
               )

	  val menuSpec = 
	    [ToolData.file_menu [close_push],
	     ToolData.edit_menu (frame,
              {cut = NONE,
               paste = NONE,
               copy = NONE,
               delete = NONE,
	       edit_possible = fn _ => false,
               selection_made = fn _ => false,
	       delete_all = NONE,
	       edit_source = []}),
	     ToolData.tools_menu (mk_tooldata, get_current_user_context),
	     ToolData.usage_menu ([("search", searchFn, fn _ => true),
				   ("graph", dep_graph_settings, fn _ => true),
				   ("make_root", 
					focusOnSelection, 
					canFocusOnSelection),
				   ("original_root",
                                        focus originalRoot,
                                        canUnfocus)]
				  ,[]),
	     ToolData.debug_menu []]

          val selectFn =  
            fn (a as (NODE(m,_),_)) => 
              ( graphSelection := m ;
                userExpandedNode := true;
                (!selectFnForGraphRef) m )

        in
          setLayoutStyle (#style layout); 
	  setExpanded (#expanded layout);
          Menus.make_submenus (menuBar, menuSpec);
          Capi.Layout.lay_out (frame, !graphPosRef, 
                               [Capi.Layout.MENUBAR menuBar,
                                Capi.Layout.SPACE,
                                Capi.Layout.FLEX widget,
                                Capi.Layout.SPACE]);
          Capi.initialize_toplevel shell;
          initialize selectFn
        end (* of fun project_graph_tool *)
  

      fun show_graph m =
        project_graph_tool
	  {parent = applicationShell,
           project =  Incremental.get_project (),
           module = m,
           title = title,
           winNamePrefix = "Dependency graph for ",
           layout = {style = TREE, expanded = false},
           filter = fn _ => true }

      fun selectFnForList _ (s, m) = update_labels (SOME (s, m))

      fun action_fn _ (_, m) = show_graph m

      fun print_item _ (s, _) = s;
  
      val {scroll, list, set_items, add_items} =
        Capi.make_scrolllist
          {parent = frame, name = "list", select_fn = selectFnForList,
           action_fn = action_fn, print_fn = print_item}

      fun redisplay selection_opt =
	let

	  val curProject = Incremental.get_project()

	  val items =
	    List.filter
	      (fn (s, _) => String.sub (s, 0) <> #" ") 
	      (Project.list_units curProject)

	  val offset = 2

	  fun index (m, n, []) = NONE
	  |   index (m, n, (s, m') :: rest) =
	    if ModuleId.eq(m, m') then
	      SOME n
	    else
	      index (m, n+1, rest)
	in
          set_items () items;
	  case selection_opt of
	    NONE =>
	      update_labels NONE
	  | SOME (_, m) =>
	      case index (m, 1, items) of
		SOME n =>
		  (Capi.List.select_pos (list, n, true);
		   (* We want to ensure that the selected item is visible.
		      Unfortunately Motif provides no way of finding the
		      current top position, so we redraw the list even if
		      the selected item is already visible.  We also can't
		      find the number of rows in the list (this is odd...),
		      so we assume that there are at least three.  *)
		   if n < offset+1 orelse List.length items < offset then
		     Capi.List.set_pos (list, 1)
		   else
		     Capi.List.set_pos (list, n - offset))
	      | NONE => ();
           
	  updateDisplay() (* redisplay and updateDisplay should be renamed, as
                             their purpose is not clear from the names at the
                             moment *)
	end (* of fun redisplay *)
  
      (* Now that we have defined redisplay, we can set the selection
         function for the graph(s) *)
      (* The only parameter for the function is ModuleId.module_id *)
      val setSelectFn =
        selectFnForGraphRef := (fn m => redisplay (SOME(ModuleId.string m, m)))

      val key =	Incremental.add_update_fn (fn () => redisplay (!selection))

      (* Functions to execute when closing the project tool *)
      val quit_funs = ref [fn () => Incremental.remove_update_fn key,
			   fn () => project_tool := NONE]

      fun do_quit_funs () =
	List.app (fn f => f ()) (!quit_funs)

      (* The evaluating flag disables GUI controls during an evaluation. *)
      val evaluating = ref false;
      fun with_evaluating f x =
	let
	  val prev_capi_eval = !Capi.evaluating;
	  val _ = Capi.evaluating := true;
	  val _ = evaluating := true;
	  val result =
	    f x
	    handle exn => (evaluating := false; 
			   Capi.evaluating := prev_capi_eval;
			   raise exn)
	in
	  evaluating := false;
	  Capi.evaluating := prev_capi_eval;
	  result
	end

      (* Functions for the menu *)

      fun reload module_id =
	Incremental.read_dependencies
	  title 
	  (Info.make_default_options ())
	  module_id
  
      fun graph _ =
	case !selection
	of NONE => ()
	|  SOME (_, m) => show_graph m

      fun touch_all _ =
	(TextIO.output (outstream, "Touch all loaded modules\n");
	 Incremental.delete_all_modules true;
	 redisplay (!selection))

      fun delete _ =
	case !selection
	of NONE => ()
	|  SOME (s, m) =>
	  (TextIO.output (outstream,
                              "Delete unit " ^ s ^ " from project\n");
	   Incremental.delete_from_project m;
	   selection := NONE;
	   redisplay NONE)

      fun clear_all _ =
	(TextIO.output (outstream, "Delete all units\n");
	 Incremental.reset_project ();
	 selection := NONE;
	 redisplay NONE)

      (* This reference is needed to make sure that close_window is not 
       * called 
       * from within itself accidentally, therefore causing ProjProperties.
       * test_save to continually pop up a dialog asking for confirmation 
       * to save the project.  This can happen without the use of the 
       * reference below because updateDisplay which is one of the quit
       * functions calls close_window.
       *)
      val closing = ref false

      fun close_window _ =
	if !evaluating orelse !closing orelse 
	   (not (ProjProperties.test_save (shell, true))) then 
	  ()
	else
	  (closing := true;
	   do_quit_funs ();
	   updatePW := (fn () => ());
	   Capi.destroy shell;
	   closing := false)
  
      fun updateProjWorkspace () = 
	let
	  val (curTargets, _, _) = ProjFile.getTargets()
	  val name = ProjFile.getProjectName()
	  val subprojs = ProjFile.getSubprojects()
	  val files = ProjFile.getFiles()
	  val (lib, obj, bin) = ProjFile.getLocations()
	  val old_ref = (!files_up_to_date);
	in
          if isSome name
          then
           (
	(* These applyReset functions give the user the option to apply any
	 * changes made to the properties dialogs before they are reset prior
	 * to performing actions such as compiling the project, reading 
	 * dependencies, saving and opening projects and creating a new one.
	 *)
	    applyResetFiles();
	    applyResetTargets();
	    applyResetSubprojs();
	    applyResetModes();
	    applyResetConfigs();
	    applyResetLibPath();
	    applyResetAboutInfo();

	    updateName name;
	    updateFiles files;
	    updateTargets curTargets;
	    updateSubprojs subprojs;
	    relativeObj := OS.Path.isRelative obj;
	    relativeBin := OS.Path.isRelative bin;
 	    updateRel();
	    updateObjLoc (obj, bin, lib);
	    files_up_to_date := old_ref;
	    update_files_label())
          else
           close_window()
	end

      val _ = updatePW := updateProjWorkspace

      fun mk_action f x =
	(kill_error_browser ();
	 set_window();
	 updateProjWorkspace();
	 with_evaluating
	 Capi.with_window_updates 
	 (fn () =>
	  ShellTypes.with_toplevel_name
	  title
	  (fn () =>
	   (Ml_Debugger.with_debugger_type
	    debugger_type
	    (fn _ => f x))))
	 handle
	   MLWorks.Interrupt => ()
	 | ShellTypes.DebuggerTrapped => ();
	     clean_debugger ())

      fun setProject () =
	(Incremental.set_project
          (Project.map_dag (* Recursively update dependencies for subprojects *)
            (Project.update_dependencies
	       (Info.make_default_options (), Location.FILE title))
	       (Incremental.get_project ()));
	files_up_to_date := true;
	update_files_label();
	message_fun "Finished Reading Dependencies")
        handle
          Info.Stop (error,error_list) =>
            error_handler
              ("initialisation", error, error_list, "Reading Dependencies",
               fn () => Preferences.new_preferences user_preferences,
               mk_action setProject)

      fun destroy_window _ = project_tool := NONE 

      (* the sensitivity functions here should operate on whether a project has
       * been loaded or not - see menu options below as well.
       *)
      val {update=updateProjButtons, ...} = 
	    Menus.make_buttons (projButtonsRC,
		[Menus.PUSH ("PW_files", files_dialog, fn _ => true),
		 Menus.PUSH ("PW_curTargets", targets_dialog, fn _ => true),
		 Menus.PUSH ("PW_subprojects", subproj_dialog, fn _ => true),
(* 		 Menus.PUSH ("PW_libraryPath", library_dialog, fn _ => true), *)
		 Menus.PUSH ("PW_objectsDir", obj_dialog, fn _ => true),
(* BBB		 Menus.PUSH ("PW_binariesDir", bin_dialog, fn _ => true), *)
		 Menus.PUSH
		   ("PW_readDependencies", mk_action setProject, fn _ => true)])

      (* checkGraph creates a menu callback which creates graphs
         displaying details about a selection of files.
         Parameters are
           commandMessage : string    e.g. `check modules to reload'
           function                   e.g. a Project function
                                           or a function with the
                                           same type as Project.check_load
           noUnitsMessage : string    e.g. `No units to reload'
           winNamePrefix : string     e.g. `files to reload for '
       *)
      fun checkGraph
        {commandMessage, function, noUnitsMessage, winNamePrefix} =
        let
          fun f (modName, module) =
             (Capi.set_busy shell;
              let
                val project = Incremental.get_project ()
                val errorInfo = Info.make_default_options ()
                val toplevelName = ShellTypes.get_current_toplevel_name ()
                val location = Location.FILE toplevelName
                val (newProject, _) = Project.read_dependencies
                                        (errorInfo, location)
                                        (project, module, Project.empty_map)
              in
                Incremental.set_project newProject;
                case function (errorInfo, location) (newProject, module) of
                  [] =>  message_fun noUnitsMessage
                | modList =>  project_graph_tool
                           {parent = applicationShell,
                            project = Incremental.get_project (),
                            module = module,
                            title = title,
                            winNamePrefix = winNamePrefix,
                            layout = {style = CASCADE, expanded = true},
                            filter =
                              (fn m => List.exists (fn m' => ModuleId.eq(m',m)) modList)}
              end;
              redisplay (SOME(modName, module));
              Capi.unset_busy shell )
             handle
               Info.Stop (error, error_list) =>
                 (error_handler
                    (modName, error, error_list, commandMessage,
                     fn () => Preferences.new_preferences user_preferences,
                     fn () => mk_action f (modName, module));
                  redisplay (SOME(modName, module));
                  Capi.unset_busy shell)
             | MLWorks.Interrupt =>
                 (redisplay (SOME(modName, module));
                  Capi.unset_busy shell)
        in
          mk_action f
        end

      val showCompileSelection =
        checkGraph
          {commandMessage = "Check compile",
           function = Project.check_compiled,
           noUnitsMessage = "No units require compilation.\n",
           winNamePrefix = "Units to compile for " }

      val showLoadSelection =
        checkGraph
          {commandMessage = "Check load",
           function = Project.check_load_objects,
           noUnitsMessage = "No units need loading.\n",
           winNamePrefix = "Units to load for " }

      val edit_file =
        mk_action
          (fn (s, m) =>
	   case Project.get_source_info (Incremental.get_project (), m) of
	     NONE => message_fun ("No source file for " ^ s)
	   | SOME (file, _) =>
	       (case Editor.edit
		       (Preferences.new_preferences user_preferences)
		       (file,0) of
		  (NONE,_) => ()
		| (SOME s,_) => message_fun s))

      fun get_options () = 
	UserOptions.new_options (user_options, get_user_context_options())

      val read_depend =
	let
	  fun f (s, m) =
	    Capi.with_message (shell, "Reading dependencies from " ^ s)
	      (fn () =>
	         (reload m; redisplay (SOME (s, m))))
            handle
              Info.Stop (error,error_list) =>
                error_handler
                (s, error, error_list, "Reading Dependencies",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f (s, m))
	in
	  mk_action f
	end

      val touch_loaded =
        let
          fun f (s, m) =
            let
              val error_info = Info.make_default_options()
            in
	      Incremental.delete_module
		error_info
		m;
              message_fun ("Touched loaded unit " ^ s)
            end
        in
          mk_action f
        end

      val loadSelection =
        let
          fun f (s, m) =
            let
              val error_info = Info.make_default_options()
            in
              Capi.with_message (shell, "Load Objects: " ^ s)
		(* XXX This should really compile files before loading them *)
                (fn () =>
		    ShellUtils.load_file
		      (GuiUtils.get_user_context (!local_context),
		       Location.FILE title,
		       optionsFromProjFile (get_options()),
		       Preferences.new_preferences user_preferences,
                       print)
		      error_info
		      s);
              message_fun ("Load of " ^ s ^ " finished")
            end
            handle
              Info.Stop (error,error_list) =>
                error_handler
                (s, error, error_list, "Load",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f (s, m))
        in
          mk_action f
        end

      val compileSelection =
        let
          fun f (s, m) =
            let
              val error_info = Info.make_default_options()
            in
              Capi.with_message
		(shell, "Compiling " ^ s)
                (fn () =>
		   ShellUtils.compile_file
		     (Location.FILE title, optionsFromProjFile (get_options()))
		     error_info
		     s);
              message_fun ("Compilation of " ^ s ^ " finished")
            end
            handle 
              Info.Stop (error, error_list) =>
                error_handler
                (s, error, error_list, "Compile",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f (s, m))
        in
          mk_action f
        end

      val compileTargets =
	let
	  fun f () =
            let
              val error_info = Info.make_default_options()
            in
              Capi.with_message (shell, "Compiling target sources")
                (fn () =>
		   ShellUtils.compile_targets
		     (Location.FILE title, optionsFromProjFile (get_options()))
		     error_info);
              message_fun ("Finished compiling target sources")
	    end
            handle
              Info.Stop (error,error_list) =>
                error_handler
                ("", error, error_list, "Compile Target Sources",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f ())
        in
          mk_action f
        end

      (* XXX This should use the graph stuff that John wrote *)
      val showCompileTargets =
	let
	  fun f () =
            let
              val error_info = Info.make_default_options()
            in
              Capi.with_message (shell, "Show files to compile target sources")
		(fn () =>
		   ShellUtils.show_compile_targets
		      (Location.FILE title, print)
		      error_info);
              message_fun ("Finished showing files to compile target sources")
	    end
            handle
              Info.Stop (error,error_list) =>
                error_handler
                ("", error, error_list, "Show Compile Target Sources",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f ())
        in
          mk_action f
        end

      val loadTargets =
	let
	  fun f () =
            let
              val error_info = Info.make_default_options()
            in
              Capi.with_message (shell, "Loading targets")
		(fn () => 
		   ShellUtils.load_targets
		     (GuiUtils.get_user_context (!local_context),
		      Location.FILE title,
		      optionsFromProjFile (get_options()),
		      Preferences.new_preferences user_preferences,
                      print)
		     error_info);
              message_fun ("Finished loading targets")
	    end
            handle
              Info.Stop (error,error_list) =>
                error_handler
                ("", error, error_list, "Load Targets",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f ())
        in
          mk_action f
        end

      (* XXX This should use the graph stuff that John wrote *)
      val showLoadTargets =
	let
	  fun f () =
            let
              val error_info = Info.make_default_options()
            in
              Capi.with_message (shell, "Show files to load targets")
		(fn () =>
		   ShellUtils.show_load_targets
		     (Location.FILE title, print)
		     error_info);
              message_fun ("Finished showing files to load targets")
	    end
            handle
              Info.Stop (error,error_list) =>
                error_handler
                ("", error, error_list, "Show Load Targets",
                 fn () => Preferences.new_preferences user_preferences,
                 fn () => mk_action f ())
        in
          mk_action f
        end


      val remove_object =
	let
	  fun f (s, m) =
            let val path = ShellUtils.object_path (s, Location.FILE title)
             in OS.FileSys.remove path handle OS.SysErr (s,e) => ();
                Project.set_object_info(Incremental.get_project (), m, NONE)
            end
	in
	  mk_action f
	end

      datatype action =
        EDIT of (string * ModuleId.ModuleId)
      | COMPILE_SELECTION of (string * ModuleId.ModuleId)
      | COMPILE_TARGETS
      | LOAD_SELECTION of (string * ModuleId.ModuleId)
      | LOAD_TARGETS
      | SHOW_COMPILE_SELECTION of (string * ModuleId.ModuleId)
      | SHOW_COMPILE_TARGETS
      | SHOW_LOAD_SELECTION of (string * ModuleId.ModuleId)
      | SHOW_LOAD_TARGETS
      | REMOVE_OBJECT of (string * ModuleId.ModuleId)
      | TOUCH_LOADED of (string * ModuleId.ModuleId)

      fun get_action (EDIT (s, m)) = edit_file (s, m)
        | get_action (COMPILE_SELECTION (s, m)) = compileSelection (s, m)
	| get_action COMPILE_TARGETS = compileTargets ()
        | get_action (LOAD_SELECTION (s, m)) = loadSelection (s, m)
        | get_action LOAD_TARGETS = loadTargets ()
        | get_action (SHOW_COMPILE_SELECTION (s, m)) =
	    showCompileSelection (s, m)
	| get_action SHOW_COMPILE_TARGETS = showCompileTargets ()
	| get_action (SHOW_LOAD_SELECTION (s, m)) =
	    showLoadSelection (s, m)
	| get_action SHOW_LOAD_TARGETS = showLoadTargets ()
        | get_action (REMOVE_OBJECT (s, m)) = remove_object (s, m)
        | get_action (TOUCH_LOADED (s, m)) = touch_loaded (s, m)

      fun eq_action (EDIT(s1,m1), EDIT(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (COMPILE_SELECTION(s1,m1), COMPILE_SELECTION(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (COMPILE_TARGETS,COMPILE_TARGETS) = true
        | eq_action (LOAD_SELECTION(s1,m1), LOAD_SELECTION(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (LOAD_TARGETS,LOAD_TARGETS) = true
        | eq_action (SHOW_COMPILE_SELECTION(s1,m1), SHOW_COMPILE_SELECTION(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (SHOW_COMPILE_TARGETS,SHOW_COMPILE_TARGETS)= true
        | eq_action (SHOW_LOAD_SELECTION(s1,m1), SHOW_LOAD_SELECTION(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (SHOW_LOAD_TARGETS,SHOW_LOAD_TARGETS)= true
        | eq_action (REMOVE_OBJECT(s1,m1), REMOVE_OBJECT(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (TOUCH_LOADED(s1,m1), TOUCH_LOADED(s2,m2)) =
            s1 = s2 andalso ModuleId.eq(m1,m2)
        | eq_action (_,_) = false

      val history = ref []: action list ref

      fun get_max_history () =
        let
          val Preferences.USER_PREFERENCES ({history_length,...},_) =
            user_preferences
        in
          !history_length
        end

      fun ministry_of_truth ([], _, _) = []
        | ministry_of_truth (s::l, new_factoid, finish) =
          if finish > 0 then
            if eq_action(s, new_factoid) then
              l
            else
              s :: ministry_of_truth (l, new_factoid, finish - 1)
          else []

      fun add_action a =
        history := a :: (ministry_of_truth (!history,a,get_max_history()))

      fun string_action action =
	let
	  fun add_name (str, s) = str ^ " " ^ s ^ "\n";
	in
        case action of
            EDIT (s, _) => add_name ("Edit source of", s)
          | COMPILE_SELECTION (s, _) => add_name ("Compile", s)
          | COMPILE_TARGETS => "Compile Target Sources\n"
          | LOAD_SELECTION (s, _) => add_name ("Load", s)
          | LOAD_TARGETS => "Load Targets\n"
          | SHOW_COMPILE_SELECTION (s, m) =>
	      add_name ("Show files to compile", s)
	  | SHOW_LOAD_SELECTION (s, m) =>
	      add_name ("Show files to load", s)
          | SHOW_COMPILE_TARGETS => "Show files to compile target sources\n"
          | SHOW_LOAD_TARGETS => "Show files to load targets\n"
          | REMOVE_OBJECT (s, _) => add_name ("Remove compiled object for", s)
          | TOUCH_LOADED (s, _) => add_name ("Touch loaded module", s)
	end

      fun do_action action =
	(TextIO.output (outstream, string_action action);
	 add_action action;
         get_action action)

      fun make_callback action _ =
	case !selection
	of NONE => ()
	|  SOME x => do_action (action x)

      fun get_history_menu () =
        let
	  fun mkItem action =
            Menus.PUSH (string_action action,
                        fn _ => do_action action,
                        fn _ => true)
	in
          map mkItem (!history)
	end

      fun is_selection _ =
	isSome (!selection)

      val view_menu =
        GuiUtils.view_options
          {parent = shell, title = title, user_options = user_options,
           user_preferences = user_preferences,
           caller_update_fn = fn _ => (),
           view_type =
	     [GuiUtils.SENSITIVITY,
	      GuiUtils.VALUE_PRINTER,
	      GuiUtils.INTERNALS]}

      (*
	I would like to add the following options to the view menu:

	all
	loaded
	compiled
	visible
	console

	Maybe the results of the check commands should be displayed in 
	the main list, which would affect this menu too.
     *)

      fun get_user_context () = GuiUtils.get_user_context (!local_context)

      fun storeSizePos () = 
        (sizeRef := SOME (Capi.widget_size shell);
         posRef := SOME (Capi.widget_pos shell))

      fun storeProj () = 
	(originalProj := Incremental.get_project();
	 updateDisplay())

      fun wrapUpdate condition_fn =
	(updateDisplay();
	 if condition_fn shell then
	   updateDisplay()
	 else ())

      fun new_project () = wrapUpdate ProjProperties.new_project

      fun open_project () = 
	(updateDisplay();
	 if ProjProperties.open_project shell (fn () => ()) then 
	   storeProj()
	 else ())

      fun save_project () = wrapUpdate ProjProperties.save_project
      fun save_project_as () = wrapUpdate ProjProperties.save_project_as

      fun closeProject () = 
	(ProjFile.close_proj();
	 Incremental.set_project (Incremental.get_project()))

      val file_menu = ToolData.file_menu
  	   [("new_proj", new_project, fn _ => true),
	    ("open_proj", open_project, fn _ => true),
	    ("save_proj", save_project, fn _ => true),
	    ("save_proj_as", save_project_as, fn _ => true),
	    ("save", fn _ =>
		       GuiUtils.save_history
                         (false, get_user_context (), applicationShell),
		     fn _ =>
		       not (UserContext.null_history (get_user_context ()))
		       andalso UserContext.saved_name_set
                                 (get_user_context ())),
	    ("saveAs", fn _ => GuiUtils.save_history
			     (true, get_user_context (), applicationShell),
		       fn _ => not (UserContext.null_history
                                      (get_user_context ()))),
	    ("close", close_window, fn () => not (!evaluating))]

      val view = ToolData.extract view_menu

      fun action_ () = ()
      fun sens_ () = isSome (ProjFile.getProjectName())

      fun eval_sel () = is_selection() andalso not (!evaluating)
      fun not_eval () = not (!evaluating)

      (* some of these actions will need to be modified as they may refer to 
       * either source or object files. 
       *) 
      val project_menu = Menus.CASCADE ("project_menu", 
	[Menus.PUSH ("compile",		(* Compile Selection *)
		     make_callback COMPILE_SELECTION, 
		     eval_sel),
	 Menus.PUSH ("compile_all", 	(* Compile Targets *)
		     fn () => do_action COMPILE_TARGETS,
		     not_eval),
	 Menus.PUSH ("load", 		(* Load Selection *)
		     make_callback LOAD_SELECTION,
		     eval_sel),
	 Menus.PUSH ("load_targets",    (* Load Targets *)
		     fn () => do_action LOAD_TARGETS,
		     not_eval),
	 Menus.PUSH ("recompile", 	(* Force Compile of Selection *)
		     make_callback REMOVE_OBJECT,
		     eval_sel),
	 Menus.PUSH ("reload", 		(* Force Load of Selection *)
		     make_callback TOUCH_LOADED,
		     eval_sel),
	 Menus.SEPARATOR,
	 Menus.PUSH ("check", 		(* Read Dependencies *)
		     mk_action setProject,
		     not_eval),
	 Menus.SEPARATOR,
	 Menus.CASCADE ("show", 	(* Show submenu *)
	    [Menus.PUSH ("check_compile",
			(* Show files to compile selection *)
			 make_callback SHOW_COMPILE_SELECTION,
			 eval_sel),
	     Menus.PUSH ("check_build", 
			(* Show files to compile targets *)
			 fn _ => do_action SHOW_COMPILE_TARGETS,
			 not_eval),
	     Menus.PUSH ("check_load", 	
			(* Show files to load selection *)
			 make_callback SHOW_LOAD_SELECTION,
			 eval_sel),
	     Menus.PUSH ("check_targets", 
			(* Show files to load targets *)
			 fn _ => do_action SHOW_LOAD_TARGETS,
			 not_eval),
	     Menus.PUSH ("show_graph", 	
			(* Show dependencies of selection *)
			 graph,
			 eval_sel)],
	    fn _ => true),

	 (* the sens_ function here should operate on whether a project (new or not)
	  * has been loaded.
	  *)
	 Menus.CASCADE ("proj_properties", 
		[Menus.PUSH ("prop_files", files_dialog, sens_),
		 Menus.PUSH ("prop_target", targets_dialog, sens_),
		 Menus.PUSH ("prop_subproj", subproj_dialog, sens_),
		 Menus.PUSH ("prop_mode", modes_dialog, sens_),
		 Menus.PUSH ("prop_config", configs_dialog, sens_),
		 Menus.PUSH ("prop_lib", library_dialog, sens_),
		 Menus.PUSH ("prop_obj_dir", obj_dialog, sens_),
(* 		 Menus.PUSH ("prop_bin_dir", bin_dialog, sens_), *)
		 Menus.PUSH ("prop_about", about_dialog, sens_)], 
		fn _ => true),
	 Menus.SEPARATOR,
	 Menus.PUSH ("deleteSelection", delete, eval_sel),
	 Menus.PUSH ("removeAllUnits", clear_all, not_eval),
	 Menus.PUSH ("clear_console", clear_console, fn _ => true)],
	fn () => true)

      val menuspec =
	[file_menu,
         ToolData.edit_menu
           (shell,
            {cut = NONE,
             paste = NONE,
             copy = SOME
              (fn _ => Capi.clipboard_set
                        (console_text, Capi.Text.get_selection console_text)),
             delete = NONE,
             selection_made = 
               fn _ => Capi.Text.get_selection console_text <> "",
             edit_possible = fn _ => false,
	     delete_all = NONE,
             edit_source = [Menus.PUSH ("editSource",
                            make_callback EDIT, is_selection)] }),
	 ToolData.tools_menu (mk_tooldata, get_current_user_context),
	 ToolData.usage_menu (view, []),
	 project_menu,
	 ToolData.debug_menu [],
         Menus.DYNAMIC ("history", get_history_menu, fn _ => true)]

      val textPaneLayout =
	 [Capi.Layout.FIXED consoleLabel,
	  Capi.Layout.FIXED console_widget,
	  Capi.Layout.SPACE]

      val listPaneLayout =
         [Capi.Layout.FIXED projNameLabel, 
	  Capi.Layout.FIXED projCurTargetsText,
	  Capi.Layout.FIXED projSubprojText,
(* 	  Capi.Layout.FIXED projLibraryText, *)
 	  Capi.Layout.FIXED relativeRC,
 	  Capi.Layout.FIXED projObjectsLabel,
(* 	  Capi.Layout.FIXED projBinariesLabel, *)
	  Capi.Layout.FIXED projButtonsRC,
	  Capi.Layout.SPACE,
	  Capi.Layout.FIXED modNameLabel,
          Capi.Layout.FIXED sourceFileLabel,
          Capi.Layout.FIXED objectFileLabel,
	  Capi.Layout.SPACE,
          Capi.Layout.FIXED listLabel,
          Capi.Layout.FLEX scroll,
          Capi.Layout.SPACE]

    in
      SaveImage.add_with_fn with_no_project_tool;
      project_tool := SOME shell;
      quit_funs := Menus.quit :: (!quit_funs);
      quit_funs := storeSizePos :: (!quit_funs);
      quit_funs := closeProject :: (!quit_funs);
      quit_funs := (fn () => ProjProperties.need_saved := false) :: (!quit_funs);
      Menus.make_submenus (menubar,menuspec);
      Capi.Layout.lay_out
	(frame, !sizeRef, 
	 [Capi.Layout.MENUBAR menubar,
	  Capi.Layout.SPACE] @ 
	listPaneLayout @ textPaneLayout);

      Capi.Callback.add (shell, Capi.Callback.Destroy, destroy_window);
      Capi.set_close_callback(frame, close_window);

      updateProjWorkspace();
      redisplay (!selection);
      Capi.initialize_toplevel shell
    end (* of create_project_tool *)

  val newOpenDialog = ref NONE

  fun newOpenProject (tooldata as ToolData.TOOLDATA
		{args, appdata, current_context, motif_context, tools}) = 
    let
      val ToolData.APPLICATIONDATA {applicationShell = parent,...} = appdata

      val (shell, form, menuBar, _) = 
	Capi.make_main_popup {name = "Project", 
			      title = "Project",
			      parent = parent, 
			      contextLabel = false, 
			      visibleRef = ref false,
			      pos = Capi.getNextWindowPos()}
      val _ = newOpenDialog := SOME shell

      val label = Capi.make_managed_widget ("PW_choiceLabel", Capi.Label, form, [])
      val rc = Capi.make_managed_widget ("projectRC", Capi.RowColumn, form, [])

      (* The shell needs to be hidden first so that it is taken away from the
       * users grasp as soon as possible so that a second Project Workspace tool
       * cannot be created (destroying a shell takes longer and also on Motif 
       * the shell was not being destroyed at all after choosing to open an 
       * existing project - reason unknown)
       *)
      fun new_project () = 
	(Capi.hide shell;
	 Capi.destroy shell;
	 if ProjProperties.new_project parent then 
	   (create_project_tool tooldata;
	    updateDisplay())
	 else ())

      fun open_project () = 
	(Capi.hide shell;
	 Capi.destroy shell;
	 if ProjProperties.open_project parent 
	   (fn () => create_project_tool tooldata) then
	     updateDisplay()
	 else ())

      fun closeCB () = newOpenDialog := NONE

    in
      (* A dummy menu is needed on Windows so that the window handle is
       * set causing this dialog to be brought to the front when the project
       * workspace tool is selected.
       *)
      Menus.make_submenus (menuBar, []);
      Capi.remove_menu menuBar;
      Capi.Callback.add(shell, Capi.Callback.Destroy, closeCB);

      (* Unmap callback on Windows does nothing, on Motif make_main_popup is 
       * unmapped when user closes window, so add an unmap callback to explicitly
       * destroy the window.
       *)
      Capi.Callback.add(form, Capi.Callback.Unmap, fn _ => Capi.destroy shell);
      ignore(Menus.make_buttons (rc,
	[Menus.PUSH ("PW_new", new_project, fn _ => true),
	 Menus.PUSH ("PW_open", open_project, fn _ => true)]));
      Capi.Layout.lay_out (form, NONE, 
	[Capi.Layout.FIXED label,
	 Capi.Layout.FIXED rc]);
      Capi.reveal form;
      Capi.reveal shell;
      Capi.to_front shell;
      shell
    end

  fun create tooldata = 
    if isSome (!project_tool) then
      Capi.to_front (valOf (!project_tool))
    else
      if isSome (ProjFile.getProjectName()) then 
        create_project_tool tooldata
      else
	let 
	  val shell =
	    if not(isSome(!newOpenDialog)) then 
	      newOpenProject tooldata
	    else
	      valOf(!newOpenDialog)
	in
	  Capi.reveal shell;
	  Capi.to_front shell
	end
end





