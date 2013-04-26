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
 *  Copyright (c) 1995 Harlequin Ltd.
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
