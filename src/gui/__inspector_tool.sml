(*
 * Copyright (c) 1993 Harlequin Ltd.
 $Log: __inspector_tool.sml,v $
 Revision 1.4  1996/01/17 17:23:53  matthew
 Removing Ident

 * Revision 1.3  1995/10/14  00:31:35  brianm
 * Adding LispUtils_ structure ...
 *
 * Revision 1.2  1995/07/27  10:32:59  matthew
 * Moved graph_widget to gui directory
 *
 * Revision 1.1  1995/07/26  14:42:13  matthew
 * new unit
 * New unit
 *
Revision 1.18  1995/07/20  15:28:48  matthew
Adding graphs

Revision 1.17  1995/07/13  11:56:01  matthew
Replaced Compiler with Ident

Revision 1.16  1995/07/04  09:51:39  matthew
Capification

Revision 1.15  1995/06/08  09:14:27  daveb
Removed Output parameter and replaced Ml_Debugger with Compiler.

Revision 1.14  1995/03/16  11:55:54  daveb
Added Lists parameter.

Revision 1.13  1994/08/01  10:34:32  daveb
Added Preferences argument.

Revision 1.12  1994/05/17  14:42:03  daveb
Added Output argument.

Revision 1.11  1993/12/09  19:34:14  jont
Added copyright message

Revision 1.10  1993/08/06  12:17:16  nosa
Inspector_tool is now passed debugger-window in podium.

Revision 1.9  1993/05/12  10:58:12  matthew
Removed some structures

Revision 1.8  1993/05/05  18:53:43  daveb
Removed Incremental and ValuePrinter arguments.
Added DebuggerWindow, Ml_Debugger and ToolData arguments.

Revision 1.7  1993/05/05  11:59:17  matthew
Added Completion structure

Revision 1.6  1993/04/23  14:51:17  matthew
Added MotifUtils structure

Revision 1.5  1993/04/20  10:25:38  matthew
Renamed Inspector_Values to InspectorValues

Revision 1.4  1993/04/06  16:11:57  jont
Moved user_options and version from interpreter to main

Revision 1.3  1993/04/02  17:39:34  matthew
Added Parser and ShellTypes structures.

Revision 1.2  1993/04/01  12:06:34  matthew
Removed some structures

Revision 1.1  1993/03/26  16:49:57  matthew
Initial revision

*)

require "../winsys/__capi";
require "../winsys/__menus";
require "../main/__user_options";
require "../main/__preferences";
require "../utils/__lists";
require "../utils/__lisp";
require "../interpreter/__inspector_values";
require "../interpreter/__shell_utils";
require "__gui_utils";
require "__graph_widget";
require "__tooldata";

require "_inspector_tool";

structure InspectorTool_ = InspectorTool (
  structure Capi = Capi_
  structure GraphWidget = GraphWidget_
  structure ShellUtils = ShellUtils_
  structure Lists = Lists_
  structure LispUtils = LispUtils_
  structure InspectorValues = InspectorValues_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
  structure GuiUtils = GuiUtils_
  structure ToolData = ToolData_
  structure Menus = Menus_
)

  
