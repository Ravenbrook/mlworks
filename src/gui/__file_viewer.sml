(*
 * Copyright (c) 1996 Harlequin Ltd.
 *
 * $Log: __file_viewer.sml,v $
 * Revision 1.1  1996/04/22 12:56:57  daveb
 * new unit
 * File Viewer Tool.
 *
*)

require "../utils/__lists";
require "../utils/__btree";
require "../basics/__location";
require "../winsys/__capi";
require "../winsys/__menus";
require "__gui_utils";
require "__tooldata";
require "_file_viewer";

structure FileViewer_ = FileViewer (
  structure Capi = Capi_
  structure Lists = Lists_
  structure Map = BTree_
  structure Location = Location_
  structure GuiUtils = GuiUtils_
  structure ToolData = ToolData_
  structure Menus = Menus_
)

  
