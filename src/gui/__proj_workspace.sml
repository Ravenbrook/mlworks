(*
 * $Log: __proj_workspace.sml,v $
 * Revision 1.3  1998/04/27 07:23:39  mitchell
 * [Bug #50078]
 * Clear project_tool reference when saving a session
 *
*Revision 1.2  1998/02/06  15:58:38  johnh
*new unit
*[Bug #30071]
*Replaces *comp_manager.sml for new Project Workspace tool.
*
 *  Revision 1.1.1.6  1997/11/26  15:11:02  daveb
 *  [Bug #30071]
 *  Removed Module structure.
 *
 *  Revision 1.1.1.5  1997/11/26  11:19:35  daveb
 *  [Bug #30071]
 *  Removed ActionQueue.
 *
 *  Revision 1.1.1.4  1997/11/20  18:17:53  daveb
 *  [Bug #30326]
 *  Removed MLWorksIo_ parameter.
 *
 *  Revision 1.1.1.3  1997/10/29  15:48:38  daveb
 *  [Bug #30089]
 *  Removed OldOs.
 *
 *  Revision 1.1.1.2  1997/09/12  14:18:08  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.7  1996/05/07  16:19:55  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.6  1996/04/18  15:18:17  jont
 * initbasis moves to basis
 *
 * Revision 1.5  1996/03/26  12:45:23  stephenb
 * Mark any uses of Os as referring to the old Os interface.
 *
 * Revision 1.4  1996/01/19  15:19:39  stephenb
 * OS reorganisation: the editor structure is now OS specific
 * so it is to be found in system and not editor.
 *
 *  Revision 1.3  1995/12/13  10:17:45  daveb
 *  Removed FileDialog argument.
 *
 *  Revision 1.2  1995/12/07  17:03:30  daveb
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

require "../basics/__module_id";
require "../main/__preferences";
require "../main/__user_options";
require "../main/__project";
require "../main/__toplevel";
require "../main/__proj_file";
require "../system/__editor";
require "../utils/__btree";
require "../utils/__crash";
require "../basis/__list";
require "../interpreter/__incremental";
require "../interpreter/__shell_utils";
require "../interpreter/__save_image";
require "../debugger/__ml_debugger";
require "../winsys/__capi";
require "../winsys/__menus";
require "__graph_widget";
require "__gui_utils";
require "__tooldata";
require "__console";
require "__debugger_window";
require "__error_browser";
require "__proj_properties";

require "_proj_workspace";

structure ProjectWorkspace_ =
  ProjectWorkspace (
    structure ModuleId = ModuleId_
    structure Preferences = Preferences_
    structure UserOptions = UserOptions_
    structure Editor = Editor_
    structure TopLevel = TopLevel_
    structure ProjFile = ProjFile_
    structure Incremental = Incremental_
    structure ShellUtils = ShellUtils_
    structure Ml_Debugger = Ml_Debugger_
    structure NewMap = BTree_
    structure Crash = Crash_
    structure List = List
    structure Project = Project_
    structure Capi = Capi_
    structure Menus = Menus_
    structure GraphWidget = GraphWidget_
    structure GuiUtils = GuiUtils_
    structure ToolData = ToolData_
    structure Console = Console_
    structure ErrorBrowser = ErrorBrowser_
    structure DebuggerWindow = DebuggerWindow_
    structure ProjProperties = ProjProperties_
    structure SaveImage = SaveImage_
  )

