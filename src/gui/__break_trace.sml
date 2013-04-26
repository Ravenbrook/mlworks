(*  The Break and Trace Manager combined top level tool.  Structure file.
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 * 
 * $Log: __break_trace.sml,v $
 * Revision 1.2  1997/06/09 14:37:14  johnh
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../main/__user_options";
require "../debugger/__newtrace";
require "__tooldata";
require "__gui_utils";

require "_break_trace";

structure BreakTrace_ = 
  BreakTrace (
    structure Capi = Capi_
    structure Lists = Lists_
    structure UserOptions = UserOptions_
    structure Trace = Trace_
    structure Menus = Menus_
    structure GuiUtils = GuiUtils_
    structure ToolData = ToolData_
  );
