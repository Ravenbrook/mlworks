(*
 * Graphical Profiler Tool
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
