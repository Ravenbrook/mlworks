(*
 * Copyright (c) 1995 Harlequin Ltd.
 *
 * $Log: path_tool.sml,v $
 * Revision 1.2  1996/03/12 15:12:06  matthew
 * Adding setWD function
 *
 * Revision 1.1  1995/12/13  12:52:05  daveb
 * new unit
 * Extracted relevant source from the old File Tool.
 *
 * 
 *)

signature PATH_TOOL =
  sig
    type Widget
    (* This should just create a dialog *)
    val sourceCreate : Widget -> unit
    val objectCreate : Widget -> (unit -> unit)
    val setWD : Widget -> unit
  end;
