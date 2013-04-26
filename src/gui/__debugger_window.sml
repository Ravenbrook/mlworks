(*
 *  $Log: __debugger_window.sml,v $
 *  Revision 1.6  1997/05/06 09:29:00  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 * Revision 1.5  1996/08/07  11:25:20  andreww
 * [Bug #1521]
 * propagating changes made to _debugger_window.sml (i.e.,
 * adding userOptions as an argument to the functor).
 *
 * Revision 1.4  1996/04/16  16:37:35  daveb
 * Added FileViewer parameter.
 *
 * Revision 1.3  1996/02/26  14:12:42  stephenb
 * Add StackFrame.
 *
 * Revision 1.2  1996/01/26  09:37:51  daveb
 * Added Types parameter.
 *
 * Revision 1.1  1995/07/26  14:41:23  matthew
 * new unit
 * New unit
 *
 *  Revision 1.11  1995/07/03  09:57:22  matthew
 *  Capification
 *
 *  Revision 1.10  1995/06/15  11:11:23  daveb
 *  Added ShellUtils parameter.
 *
 *  Revision 1.9  1995/06/08  09:50:25  daveb
 *  Corrected spelling of InspectorTool (from Inspector_Tool).
 *
 *  Revision 1.8  1995/05/26  13:31:41  daveb
 *  Replaced UserOptions parameter with Preferences.
 *  
 *  Revision 1.7  1995/04/07  11:11:56  matthew
 *  Adding Trace structure
 *  
 *  Revision 1.6  1994/07/27  10:14:54  daveb
 *  Added ToolData and UserOptions arguments.
 *  
 *  Revision 1.5  1993/08/06  14:06:05  nosa
 *  Pass Inspector_tool to debugger-window for inspecting values of
 *  local and closure variables.
 *  
 *  Revision 1.4  1993/05/07  17:21:57  matthew
 *  Added Option structure
 *  
 *  Revision 1.3  1993/04/30  12:11:37  matthew
 *  Added Lists structure
 *  
 *  Revision 1.2  1993/04/23  15:58:15  daveb
 *  Added MotifUtils parameter.
 *  
 *  Revision 1.1  1993/03/25  13:02:45  matthew
 *  Initial revision
 *  
 *)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../debugger/__newtrace";
require "../debugger/__ml_debugger";
require "../main/__preferences";
require "../interpreter/__shell_utils";
require "../typechecker/__types";
require "__tooldata";
require "__inspector_tool";
require "__file_viewer";
require "../debugger/__stack_frame";
require "__gui_utils";
require "../main/__user_options";

require "_debugger_window";

structure DebuggerWindow_ = 
  DebuggerWindow
    (structure Capi = Capi_
     structure Lists = Lists_
     structure UserOptions = UserOptions_
     structure Types = Types_
     structure Trace = Trace_
     structure Ml_Debugger = Ml_Debugger_
     structure Preferences = Preferences_
     structure ToolData = ToolData_
     structure InspectorTool = InspectorTool_
     structure FileViewer = FileViewer_
     structure GuiUtils = GuiUtils_
     structure ShellUtils = ShellUtils_
     structure Menus = Menus_
     structure StackFrame = StackFrame_)
