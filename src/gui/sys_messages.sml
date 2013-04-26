(*
 * $Log: sys_messages.sml,v $
 * Revision 1.2  1997/10/10 08:52:09  johnh
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 * Copyright (C) 1997. The Harlequin Group Ltd.  All rights reserved.
 *)

signature SYS_MESSAGES =
sig
  type ToolData

  val create : ToolData -> unit -> unit
end;
