(*
 * Graphical Profiler Tool
 * 
 * Copyright (c) 1995 Harlequin Ltd.
 *  $Log: __profile_tool.sml,v $
 *  Revision 1.3  1997/05/16 15:36:20  johnh
 *  Implementing single menu bar on Windows.
 *  Re-organising menus for Motif.
 *
 * Revision 1.2  1995/10/18  13:39:36  nickb
 * Remove tooldata argument.
 *
 *  Revision 1.1  1995/10/18  12:06:26  nickb
 *  new unit
 *  New profile tool.
 *
 *)

require "../winsys/__capi";
require "../winsys/__menus";
require "../interpreter/__shell_utils";
require "../main/__preferences";
require "../utils/__lists";
require "../utils/__crash";
require "__bar_chart";
require "__tooldata";
require "__gui_utils";
require "_profile_tool";

structure ProfileTool_ =
  ProfileTool(structure Capi = Capi_
	      structure Menus = Menus_
	      structure Preferences = Preferences_
	      structure ShellUtils = ShellUtils_
	      structure Lists = Lists_
	      structure Crash = Crash_
	      structure BarChart = BarChart_
	      structure ToolData = ToolData_
	      structure GuiUtils = GuiUtils_
	      );
