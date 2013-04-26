(*
 *  $Log: __context.sml,v $
 *  Revision 1.5  1998/03/16 11:23:55  mitchell
 *  [Bug #50061]
 *  Fix tools so they restart in a saved image
 *
 * Revision 1.4  1996/05/23  10:37:26  daveb
 * Replace Evaluator with File Viewer.
 *
 * Revision 1.3  1996/02/08  15:17:09  daveb
 * Added Evaluator parameter.
 *
 * Revision 1.2  1996/01/17  17:21:36  matthew
 * Adding InspectorTool.
 *
 * Revision 1.1  1995/07/26  14:39:06  matthew
 * new unit
 * New unit
 *
 *  Revision 1.4  1995/07/13  10:23:54  matthew
 *  Removing Incremental structure
 *
 *  Revision 1.3  1995/06/29  10:05:30  matthew
 *  Adding Capi structure
 *
 *  Revision 1.2  1995/06/01  12:57:37  daveb
 *  Added Preferences parameter.
 *
 *  Revision 1.1  1995/03/31  09:16:56  daveb
 *  new unit
 *  Context history window.
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

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../main/__user_options";
require "../main/__preferences";
require "__tooldata";
require "__inspector_tool";
require "__file_viewer";
require "__gui_utils";

require "../interpreter/__shell_utils";
require "../interpreter/__save_image";

require "_context";

structure ContextHistory_ = ContextHistory (
  structure Capi = Capi_
  structure Lists = Lists_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
  structure ToolData = ToolData_
  structure InspectorTool = InspectorTool_
  structure FileViewer = FileViewer_
  structure GuiUtils = GuiUtils_
  structure Menus = Menus_
  structure SaveImage = SaveImage_

  structure ShellUtils = ShellUtils_
);
