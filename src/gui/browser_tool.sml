(*
 * Copyright (c) 1993 Harlequin Ltd.
 *  $Log: browser_tool.sml,v $
 *  Revision 1.1  1995/05/19 15:33:59  matthew
 *  new unit
 *  New unit
 *
 *  Revision 1.4  1995/05/19  15:33:59  daveb
 *  Added create_initial.
 *
 *  Revision 1.3  1993/12/09  19:35:03  jont
 *  Added copyright message
 *
 *  Revision 1.2  1993/04/29  15:36:26  daveb
 *  Reorganised menus.
 *
 *  Revision 1.1  1993/04/19  11:46:21  daveb
 *  Initial revision
 *
 *
 *)

signature BROWSERTOOL =
  sig
    type ToolData
    val create : ToolData -> unit
    val create_initial : ToolData -> unit
  end

