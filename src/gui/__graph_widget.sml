(*
 * Copyright (c) 1995 Harlequin Ltd.
 *  $Log: __graph_widget.sml,v $
 *  Revision 1.3  1995/10/14 21:19:09  brianm
 *  Adding GuiUtils_ dependency ...
 *
 * Revision 1.2  1995/08/02  12:40:22  matthew
 * Adding Menus
 *
 * Revision 1.1  1995/07/27  10:38:43  matthew
 * new unit
 * Moved from library
 *
 *  Revision 1.2  1995/07/26  14:25:12  matthew
 *  Restructuring directories
 *
 *  Revision 1.1  1995/07/20  14:25:16  matthew
 *  new unit
 *  New graph unit
 *
*)

require "../utils/__lists";
require "../winsys/__capi";
require "../winsys/__menus";
require "__gui_utils";

require "_graph_widget";

structure GraphWidget_ = GraphWidget (structure Lists = Lists_
                                      structure Capi = Capi_
                                      structure Menus = Menus_
                                      structure GuiUtils = GuiUtils_
                                        )
