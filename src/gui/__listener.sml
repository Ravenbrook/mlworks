(*
listener.sml the structure.

$Log: __listener.sml,v $
Revision 1.8  1997/10/16 09:10:16  johnh
[Bug #30284]
Add SaveImage.

 * Revision 1.7  1997/01/24  17:47:23  andreww
 * [Bug #1667]
 * adding mutexes to listener.
 *
 * Revision 1.6  1996/06/24  17:03:59  andreww
 * extracting standard IO for GUI listener.
 *
 * Revision 1.5  1996/06/18  16:06:36  daveb
 * Added Trace parameter.
 *
 * Revision 1.4  1996/01/18  11:27:33  daveb
 * Added ErrorBrowser parameter.
 *
 * Revision 1.3  1996/01/17  12:25:56  matthew
 * Adding Inspector Tool structure
 *
 * Revision 1.2  1995/10/18  13:48:35  nickb
 * Add profiler to the shelldata made here.
 *
 * Revision 1.1  1995/07/26  14:42:03  matthew
 * new unit
 * New unit
 *
 *  Revision 1.20  1995/07/17  11:48:37  matthew
 *  Moved __entry.sml to interpreter
 *
 *  Revision 1.19  1995/07/05  11:55:11  io
 *  adding searching capability
 *

Revision 1.18  1995/06/29  09:39:16  matthew
Adding Capi structure

Revision 1.17  1995/03/31  13:49:15  daveb
Removed redundant parameters.

Revision 1.16  1994/08/01  10:57:28  daveb
Added Preferences argument.

Revision 1.15  1993/05/27  11:18:10  matthew
 Added ShellUtils structure

Revision 1.14  1993/05/18  17:29:46  jont
Removed integer parameter

Revision 1.13  1993/04/29  16:56:58  daveb
Added BrowserTool parameter.

Revision 1.12  1993/04/27  16:30:54  daveb
Added MotifUtils parameter.

Revision 1.11  1993/04/19  14:33:39  daveb
Added BrowserTool argument.

Revision 1.9  1993/04/16  11:07:13  matthew
Removed ShellTypes,FileSelect, added ToolData

Revision 1.8  1993/04/13  14:48:24  daveb
Added Lists parameter.

Revision 1.7  1993/04/06  16:12:15  jont
Moved user_options and version from interpreter to main

Revision 1.6  1993/04/01  17:12:56  matthew
Added FileSelect structure

Revision 1.5  1993/03/30  09:46:11  matthew
Added Crash structure

Revision 1.4  1993/03/25  13:05:35  matthew
Added debugger and inspector

Revision 1.3  1993/03/18  17:09:28  matthew
 Added UserOptions substructure

Revision 1.2  1993/03/17  13:16:28  matthew
Added Menus substructure

Revision 1.1  1993/03/02  17:15:22  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd.

*)

require "../winsys/__capi";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/__mutex";
require "../main/__user_options";
require "../main/__preferences";
require "../debugger/__ml_debugger";
require "../debugger/__newtrace";
require "../interpreter/__tty_listener";
require "../interpreter/__shell";
require "../interpreter/__shell_utils";
require "__tooldata";
require "__error_browser";
require "__debugger_window";
require "__profile_tool";
require "__inspector_tool";
require "../winsys/__menus";
require "__gui_utils";
require "../interpreter/__entry";
require "../interpreter/__save_image";
require "_listener";

structure Listener_ = Listener (
  structure Capi = Capi_
  structure Lists = Lists_
  structure Crash = Crash_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
  structure Ml_Debugger = Ml_Debugger_
  structure Trace = Trace_
  structure ProfileTool = ProfileTool_
  structure InspectorTool = InspectorTool_
  structure TTYListener = TTYListener_
  structure Shell = Shell_
  structure ShellUtils = ShellUtils_
  structure ToolData = ToolData_
  structure DebuggerWindow = DebuggerWindow_
  structure GuiUtils = GuiUtils_
  structure Menus = Menus_
  structure Entry = Entry_
  structure ErrorBrowser = ErrorBrowser_
  structure Mutex = Mutex
  structure SaveImage = SaveImage_
);
