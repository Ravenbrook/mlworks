(*  The Break and Trace Manager combined top level tool.  Signature file.
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 * 
 * $Log: break_trace.sml,v $
 * Revision 1.2  1997/06/09 14:34:35  johnh
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

signature BREAK_TRACE = 
sig
  type ToolData

  val create : ToolData -> unit
end