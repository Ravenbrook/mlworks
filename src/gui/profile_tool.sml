(*
 * Graphical Profiler Tool
 * 
 * Copyright (c) 1995 Harlequin Ltd.
 *  $Log: profile_tool.sml,v $
 *  Revision 1.4  1999/02/02 15:59:49  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.3  1997/05/16  15:36:16  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.2  1995/10/18  13:41:30  nickb
 * Change argument types to remove dependency on tooldata.
 *
 *  Revision 1.1  1995/10/18  12:07:22  nickb
 *  new unit
 *  New profile tool.
 *
 *)

signature PROFILE_TOOL =
  sig
    type ToolData
    type user_context
    type Widget
    type user_preferences

    val create : Widget * user_preferences * 
		 (unit -> ToolData) * 
		 (unit -> user_context)    -> MLWorks.Profile.profile -> unit
  end;
