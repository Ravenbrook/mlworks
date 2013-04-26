(*
 *  The console structure.
 *  
 *  $Log: __console.sml,v $
 *  Revision 1.1  1995/07/26 14:40:30  matthew
 *  new unit
 *  New unit
 *
 *  Revision 1.2  1995/07/04  14:38:48  matthew
 *  Further capification
 *
 *  Revision 1.1  1995/07/04  13:11:01  daveb
 *  new unit
 *  Std_in and std_out.
 *
 *  
 *  Copyright (c) 1995 Harlequin Ltd.
 *  
 *)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../interpreter/__shell_utils";
require "__gui_utils";
require "_console";

structure Console_ = Console (
  structure Capi = Capi_
  structure Lists = Lists_
  structure ShellUtils = ShellUtils_
  structure GuiUtils = GuiUtils_
  structure Menus = Menus_
);
