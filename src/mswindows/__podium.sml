(*
podium.sml the structure.

$Log: __podium.sml,v $
Revision 1.4  1998/01/28 12:29:50  johnh
[Bug #30071]
Merge in Project Workspace changes.

 *  Revision 1.3  1997/10/09  15:11:25  johnh
 *  [Bug #30193]
 *  Add call to SysMessages.create.
 *
 *  Revision 1.2.2.4  1997/12/10  13:50:58  johnh
 *  [Bug #30071]
 *  Add ProjFile structure.
 *
 *  Revision 1.2.2.3  1997/11/24  12:14:54  johnh
 *  [Bug #30071]
 *  Add PathTool structure for setting current directory.
 *
 *  Revision 1.2.2.2  1997/09/12  14:48:42  johnh
 *  [Bug #30071]
 *  Redesign Compilation Manager -> Project Workspace.
 *
 *  Revision 1.2  1997/06/17  15:32:51  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.7  1996/11/06  12:08:26  daveb
 * Addeded Licesnnse parameter.
 *
 * Revision 1.6  1996/05/17  14:37:50  daveb
 * Added SaveImage parameter.
 *
 * Revision 1.5  1996/01/22  11:46:27  daveb
 * Removed Evaluator argument.
 *
 * Revision 1.4  1996/01/17  15:26:44  matthew
 * Removing InspectorTool structure
 *
 * Revision 1.3  1995/12/12  17:31:03  daveb
 * Removed dependency on __fileselect.
 *
 * Revision 1.2  1995/11/30  16:24:00  daveb
 * Added Project Tool.
 *
 * Revision 1.1  1995/07/26  14:46:48  matthew
 * new unit
 * New unit
 *
Revision 1.13  1995/06/29  11:37:33  matthew
Capifying

Revision 1.12  1995/06/01  12:53:24  daveb
Added Preferences parameter.

Revision 1.11  1995/03/30  14:00:35  daveb
Added ContextWindow to list of tools.

Revision 1.10  1994/07/14  15:25:24  daveb
Added Version parameter.

Revision 1.9  1994/05/17  17:10:41  daveb
Added the evaluator.

Revision 1.8  1993/09/07  11:26:38  daveb
Checked in bug fix.

Revision 1.7.1.2  1993/09/06  15:04:21  daveb
Added Ml_Debugger parameter.

Revision 1.7  1993/08/11  13:15:09  matthew
Added UserOptions structure

Revision 1.6  1993/08/06  14:55:33  nosa
Podium now requires debugger-window.

Revision 1.5  1993/05/05  19:22:21  daveb
Added InspectorTool to the list of tools.

Revision 1.4  1993/04/30  11:35:24  daveb
 Added BrowserTool and GuiUtils parameters.

Revision 1.3  1993/04/16  14:32:56  matthew
Removed ShellTypes, added FileSelect and ToolData

Revision 1.2  1993/03/19  16:20:34  matthew
Added Menus structure

Revision 1.1  1993/02/09  11:32:55  daveb
Initial revision


Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*)

require "../main/__user_options";
require "../main/__preferences";
require "../main/__version";
require "../main/__proj_file";
require "../winsys/__capi";
require "../debugger/__ml_debugger";
require "^.gui.__debugger_window";
require "^.gui.__listener";
require "^.gui.__tooldata";
require "^.gui.__gui_utils";
require "^.gui.__browser_tool";
require "^.gui.__proj_workspace";
require "^.gui.__context";
require "^.gui.__break_trace";
require "^.gui.__sys_messages";
require "^.gui.__proj_properties";
require "^.gui.__path_tool";
require "../interpreter/__save_image";
require "../winsys/__menus";

require "_podium";

structure Podium_ = Podium (
  structure Capi = Capi_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
  structure Version = Version_
  structure Debugger_Window = DebuggerWindow_
  structure ToolData = ToolData_
  structure Menus = Menus_
  structure Listener = Listener_
  structure BrowserTool = BrowserTool_
  structure ProjectWorkspace = ProjectWorkspace_
  structure ContextHistory = ContextHistory_
  structure Ml_Debugger = Ml_Debugger_
  structure GuiUtils = GuiUtils_
  structure SaveImage = SaveImage_
  structure BreakTrace = BreakTrace_
  structure SysMessages = SysMessages_
  structure ProjProperties = ProjProperties_
  structure PathTool = PathTool_
  structure ProjFile = ProjFile_
);
