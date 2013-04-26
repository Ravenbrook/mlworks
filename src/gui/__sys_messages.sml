(*
 * $Log: __sys_messages.sml,v $
 * Revision 1.2  1997/10/10 08:54:49  johnh
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 * Copyright (C) 1997 The Harlequin Group Ltd.  All rights reserved.
 *
 *)

require "../winsys/__capi";
require "__tooldata";
require "../winsys/__menus";
require "__gui_utils";

require "_sys_messages";

structure SysMessages_ = SysMessages (
  structure Capi = Capi_
  structure ToolData = ToolData_
  structure GuiUtils = GuiUtils_
  structure Menus = Menus_
);
