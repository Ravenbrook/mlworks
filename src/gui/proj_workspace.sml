(*
 * $Log: proj_workspace.sml,v $
 * Revision 1.2  1998/02/06 15:58:44  johnh
 * new unit
 * [Bug #30071]
 * Replaces *comp_manager.sml for new Project Workspace tool.
 *
 *  Revision 1.1.1.2  1997/09/12  14:13:44  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.2  1995/12/07  17:03:42  daveb
 * Added header.
 *
 *  
 * Copyright (c) 1995 Harlequin Ltd.
 *)

signature PROJECT_WORKSPACE =
sig
  type ToolData

  val updateDisplay: unit -> unit

  val create: ToolData -> unit
end;

