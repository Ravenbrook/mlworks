(*
__error_browser.sml the structure.

$Log: __error_browser.sml,v $
Revision 1.2  1997/05/16 15:36:13  johnh
Implementing single menu bar on Windows.
Re-organising menus for Motif.

 * Revision 1.1  1995/07/26  14:41:28  matthew
 * new unit
 * New unit
 *
# Revision 1.2  1995/07/03  10:28:14  matthew
# Capification
#
# Revision 1.1  1994/05/13  15:54:50  daveb
# new file
#

Copyright (c) 1994 Harlequin Ltd.

*)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../interpreter/__shell_utils";
require "__gui_utils";
require "__tooldata";
require "_error_browser";

structure ErrorBrowser_ = ErrorBrowser (
  structure Capi = Capi_
  structure Lists = Lists_
  structure ShellUtils = ShellUtils_
  structure GuiUtils = GuiUtils_
  structure Menus = Menus_
  structure ToolData = ToolData_
);
