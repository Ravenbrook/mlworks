(*
 * Bar Chart Widget
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *  $Log: __bar_chart.sml,v $
 *  Revision 1.1  1995/10/18 12:08:16  nickb
 *  new unit
 *  New bar chart widget.
 *
*)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__crash";
require "../utils/__lists";

require "_bar_chart";

structure BarChart_ = BarChart (structure Capi = Capi_
				structure Menus = Menus_
				structure Crash = Crash_
				structure Lists = Lists_);
  
