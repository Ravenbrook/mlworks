(*
 *  Copyright (c) 1995 Harlequin Ltd.
 *
 *  $Log: context.sml,v $
 *  Revision 1.1  1995/06/01 16:32:21  matthew
 *  new unit
 *  New unit
 *
 *  Revision 1.2  1995/06/01  16:32:21  matthew
 *  Changing signature name to CONTEXT_HISTORY
 *
 *  Revision 1.1  1995/03/31  09:09:04  daveb
 *  new unit
 *  Context history window.
 *
 *)

signature CONTEXT_HISTORY =
  sig
    type ToolData
    val create : ToolData -> unit
  end

