(*
 *  $Log: __browser_tool.sml,v $
 *  Revision 1.4  1998/03/16 10:58:09  mitchell
 *  [Bug #50061]
 *  Fix tools so they restart in a saved image
 *
 * Revision 1.3  1996/01/17  12:37:38  matthew
 * Adding InspectorTool
 *
 * Revision 1.2  1995/07/27  10:32:36  matthew
 * Moved graph_widget to gui directory
 *
 * Revision 1.1  1995/07/26  14:40:22  matthew
 * new unit
 * New unit
 *
 *  Revision 1.12  1995/07/20  14:25:06  matthew
 *  Adding Graph Widget structure
 *
 *  Revision 1.11  1995/07/17  11:57:20  matthew
 *  Removing Xm structure
 *
 *  Revision 1.10  1995/07/05  12:08:16  io
 *  added search capability
 *
 *  Revision 1.9  1995/06/27  14:01:13  matthew
 *  Adding Capi structure
 *
 *  Revision 1.8  1995/05/26  15:10:44  daveb
 *  Added Preferences parameter.
 *
 *  Revision 1.7  1995/02/14  14:19:01  matthew
 *  Removing redundant structures
 *
 *  Revision 1.6  1993/12/09  19:33:44  jont
 *  Added copyright message
 *
 *  Revision 1.5  1993/10/08  16:27:17  matthew
 *  Mergin in bug fixes
 *
 *  Revision 1.4.1.2  1993/10/07  14:03:16  matthew
 *  Added ShellUtils structure
 *
 *  Revision 1.4.1.1  1993/05/18  19:05:52  jont
 *  Fork for bug fixing
 *
 *  Revision 1.4  1993/05/18  19:05:52  jont
 *  Removed integer parameter
 *
 *  Revision 1.3  1993/04/29  16:51:06  daveb
 *  Added ToolData parameter.
 *
 *  Revision 1.2  1993/04/29  11:20:28  daveb
 *  Added Crash parameter.
 *
 *  Revision 1.1  1993/04/21  12:48:35  daveb
 *  Initial revision
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../utils/__crash";
require "../main/__user_options";
require "../main/__preferences";
require "../interpreter/__shell_utils";
require "../interpreter/__save_image";
require "../interpreter/__entry";
require "__inspector_tool";
require "__gui_utils";
require "__graph_widget";
require "__tooldata";
require "_browser_tool";

structure BrowserTool_ =
  BrowserTool (
    structure Capi = Capi_
    structure GraphWidget = GraphWidget_
    structure Lists = Lists_
    structure Crash = Crash_
    structure UserOptions = UserOptions_
    structure Preferences = Preferences_
    structure Menus = Menus_
    structure ToolData = ToolData_
    structure InspectorTool = InspectorTool_
    structure GuiUtils = GuiUtils_
    structure ShellUtils = ShellUtils_
    structure Entry = Entry_
    structure SaveImage = SaveImage_
)
