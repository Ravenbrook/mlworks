(* __messages.sml the structure *)
(*
 * $Log: __messages.sml,v $
 * Revision 1.2  1998/02/19 13:57:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Copyright (c) 1998 Harlequin Group plc
 *)

require "messages";

structure Messages : MESSAGES =
  struct
    fun env s = MLWorks.Internal.Value.cast(MLWorks.Internal.Runtime.environment s)
    val output = env"stream message output"
    val flush = env"stream message flush"
  end;
